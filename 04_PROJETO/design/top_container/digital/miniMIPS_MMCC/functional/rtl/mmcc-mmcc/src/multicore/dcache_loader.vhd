-- =================================================================================
-- Project          :  MIPS Multi-core
-- FileName         :  dcache_loader.vhd
-- FileType         :  VHDL - Source code
-- Author           :  Jorge Tortato Junior, UFPR
-- Reviewer         :  -x-x-x-x-
-- Version          :  0.1 from 22/oct/2008
-- 
-- Information      :  Synthesis : ISE Foundation
--                     Simulator : ModelSim
-- 
-- ---------------------------------------------------------------------------------
-- >>>  Proprietary Information                                                  <<<
-- =================================================================================


-- Libraries
library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_arith.all;
   use ieee.std_logic_unsigned.all;

library work;
   use work.utils_pkg.all;
   use work.coherence_pkg.all;

-- Entity declaration
entity dcache_loader is
   generic (
      CACHE_SIZE : integer := 2048;                                         -- Size of cache - in bytes 
      LINE_SIZE  : integer := 8;                                            -- Line size - in bytes
      DATA_WIDTH : integer := 32;                                           -- Read data widht - in bits
      ADDR_WIDTH : integer := 32                                            -- Number of cached memory address bits
   );
   port (
      -- System Interface
      RST_i                : in    std_logic;                               -- Reset - active high

      -- Bus interface
      BUS_CLK_i            : in    std_logic;                               -- Bus control clock
      BUS_REQ_o            : out   std_logic;                               -- Bus request
      BUS_RGRANT_o         : out   std_logic;                               -- Bus grant request
      BUS_GRANT_i          : in    std_logic;                               -- Bus grant ack
      BUS_MATCH_i          : in    std_logic_vector(1 downto 0);            -- Bus match type
      BUS_LAST_o           : out   std_logic;                               -- Bus last request indication
      BUS_ACK_i            : in    std_logic;                               -- Bus acknowledge
      BUS_VAL_i            : in    std_logic;                               -- Bus data valid
      BUS_RD_o             : out   std_logic;                               -- Bus read
      BUS_RDX_o            : out   std_logic;                               -- Bus read exclusive
      BUS_WR_o             : out   std_logic;                               -- Bus write
      BUS_ADDR_o           : out   std_logic_vector(ADDR_WIDTH-1 downto 0); -- Bus address
      BUS_DATA_i           : in    std_logic_vector(DATA_WIDTH-1 downto 0); -- Bus data input
      BUS_DATA_o           : out   std_logic_vector(DATA_WIDTH-1 downto 0); -- Bus data output

      -- Cache status
      SNOOP_MATCH_i        : in    std_logic;                               -- Snoop match status
      MISS_i               : in    std_logic;                               -- Cache miss
      LOADX_i              : in    std_logic;                               -- Load cache exclusive - active high
      LOAD_i               : in    std_logic;                               -- Load cache - active high
      FLUSH_i              : in    std_logic;                               -- Flush cache - active high
      MISS_ADDR_i          : in    std_logic_vector(ADDR_WIDTH-1 downto 0); -- Miss address
      MISS_DATA_i          : in    std_logic_vector(DATA_WIDTH-1 downto 0); -- Miss data
      MISS_RW_i            : in    std_logic;                               -- Miss rw
      CACHE_EN_i           : in    std_logic;                               -- Cache enable
      NOCACHE_DONE_o       : out   std_logic;                               -- No cache acces done

      -- Core interface
      CACHE_DATA_i         : in    std_logic_vector(DATA_WIDTH-1 downto 0); -- Cache read data
      CACHE_ADDR_o         : out   std_logic_vector(ADDR_WIDTH-1 downto 0); -- Cache data address
      CACHE_WEN_o          : out   std_logic;                               -- Cache data enable
      CACHE_DATA_o         : out   std_logic_vector(DATA_WIDTH-1 downto 0); -- Cache write data
      RTAGDATA_i           : in    std_logic_vector(ADDR_WIDTH-log2_ceil(CACHE_SIZE)+1 downto 0); -- Cache tag read data
      WTAGADDR_o           : out   std_logic_vector(ADDR_WIDTH-1 downto 0); -- Write address for tag
      WUPDATE_o            : out   std_logic;                               -- Update entry
      WSTATUS_o            : out   std_logic_vector(COHER_TAGWIDTH-1 downto 0);
      RSTATUS_i            : in    std_logic_vector(COHER_TAGWIDTH-1 downto 0);

      -- Snoop interface
      SNOOP_GRANT_i        : in    std_logic;                              -- Snoop granted indication
      SNOOP_SEL_o          : out   std_logic;                              -- Snoop selection
      SNOOP_MATCH_o        : out   std_logic_vector(COHER_TAGWIDTH-1 downto 0);-- Snoop match type
      SNOOP_REQ_i          : in    std_logic;                              -- Snoop request
      SNOOP_LAST_i         : in    std_logic;                              -- Snoop last request indication
      SNOOP_ACK_o          : out   std_logic;                              -- Snoop acknowledge
      SNOOP_VAL_o          : out   std_logic;                              -- Snoop data valid
      SNOOP_RD_i           : in    std_logic;                              -- Snoop read
      SNOOP_RDX_i          : in    std_logic;                              -- Snoop read exclusive
      SNOOP_WR_i           : in    std_logic;                              -- Snoop write
      SNOOP_ADDR_i         : in    std_logic_vector(31 downto 0);          -- Snoop address
      SNOOP_DATA_o         : out   std_logic_vector(31 downto 0);          -- Snoop data output
      SNOOP_DATA_i         : in    std_logic_vector(31 downto 0)           -- Snoop data input
   );
end dcache_loader;

architecture Behavioral of dcache_loader is

-- Attributes

-- Types and definitions
constant gnd            : std_logic  := '0';
constant vcc            : std_logic  := '1';
constant WORD_BYTES     : integer    := DATA_WIDTH/8;                      -- Number of bytes in one words
constant CACHE_LINES    : integer    := CACHE_SIZE/LINE_SIZE;
constant TAGADDR_WIDTH  : integer    := log2_ceil(CACHE_LINES);
constant LINE_BITS      : integer    := log2_ceil(LINE_SIZE);
constant ADDRTAG_BITS   : integer    := ADDR_WIDTH - TAGADDR_WIDTH - LINE_BITS;
constant TAG_BITS       : integer    := ADDRTAG_BITS + COHER_TAGWIDTH;

type fsm_st is (IDLE_ST, SNOOP_ST, GRANTED_ST, LOAD_START_ST, UPTAG_ST, FLUSH_START_ST, FLUSH_ST, LOAD_ST, NOCACHE_ST); -- Type definition

-- Internal signals
signal cur_st           : fsm_st;                                          -- Current fsm state
signal miss_int         : std_logic_vector(1 downto 0);                    -- Internal miss status
signal mem_cnt          : std_logic_vector(LINE_BITS+1 downto 0);          -- Number of memory accesses
signal cache_cnt        : std_logic_vector(LINE_BITS downto 0);            -- Number of cache accesses
signal first            : std_logic;                                       -- First clock after a memory request
signal mem_cnt_plus     : std_logic_vector(LINE_BITS+1 downto 0);          -- Number of memory accesses + WORD_BYTES
signal snoop_last_int   : std_logic;                                       -- Delayed last indication
signal snoop_match_reg  : std_logic;                                       -- Registered match indication
signal snoop_rdx_reg    : std_logic;                                       -- Registered exclusive read indication
signal rstatus_reg      : std_logic_vector(COHER_TAGWIDTH-1 downto 0);     -- Registered read status
signal snoop_req_reg    : std_logic;
signal snoop_req_regg   : std_logic;
signal snoop_match_int  : std_logic_vector(COHER_TAGWIDTH-1 downto 0);
signal clr_cnt          : std_logic_vector(log2_ceil(CACHE_SIZE) downto 0) := (others => '0');

begin

   mem_cnt_plus <= mem_cnt + WORD_BYTES;

   -- Miss synchronization
   process(BUS_CLK_i)
   begin
      if BUS_CLK_i'event and BUS_CLK_i = '1' then
         if RST_i = '1' then
            miss_int <= (others => '0');
         else
            miss_int <= miss_int(0) & MISS_i;
         end if;
      end if;
   end process;

   process(BUS_CLK_i)
   begin
      if BUS_CLK_i'event and BUS_CLK_i = '1'then
         if RST_i = '1' then                                               -- On reset ...
            BUS_REQ_o   <= '0';                                            -- ... do nothing.
            BUS_RGRANT_o<= '0';
            BUS_RD_o    <= '0';
            BUS_RDX_o   <= '0';
            BUS_WR_o    <= '0';
            BUS_ADDR_o  <= (others => '0');
            BUS_DATA_o  <= (others => '0');
            WTAGADDR_o  <= (others => '0');
            --WUPDATE_o   <= '0';
            --WSTATUS_o   <= "00";
            WTAGADDR_o(log2_ceil(CACHE_SIZE) downto 0)  <= clr_cnt;
            WUPDATE_o   <= '1';
            WSTATUS_o   <= COHER_INVALID;
            clr_cnt     <= clr_cnt + 1;
            mem_cnt     <= (others => '0');
            snoop_last_int <= '0';
            first       <= '0';
            CACHE_ADDR_o<= (others => '0');
            CACHE_ADDR_o(log2_ceil(CACHE_SIZE) downto 0)  <= clr_cnt;
            CACHE_WEN_o <= '1';
            CACHE_DATA_o<= (others => '0');
            cache_cnt   <= (others => '0');
            cur_st      <= IDLE_ST;
         else
            snoop_last_int <= SNOOP_LAST_i;
            case cur_st is                                                 -- Acc. to curren state ...
               when IDLE_ST   =>                                           -- ... if IDLE ..
                  NOCACHE_DONE_o <= '0';
                  BUS_WR_o    <= '0';                                      -- ... do not write ...
                  BUS_RD_o    <= '0';                                      -- ... or read anything by default.
                  BUS_RDX_o   <= '0';
                  BUS_DATA_o  <= (others => '0');
                  BUS_REQ_o   <= '0';
                  mem_cnt     <= (others => '0');                          -- Initialize read request counter ...
                  cache_cnt   <= (others => '0');                          -- ... and read valid counter.
                  WTAGADDR_o  <= SNOOP_ADDR_i;                             -- Keep snoopping cache ...
                  WUPDATE_o   <= '0';                                      -- ... by default.
                  WSTATUS_o   <= (others => '0');
                  CACHE_ADDR_o<= SNOOP_ADDR_i;
                  CACHE_WEN_o <= '0';
                  CACHE_DATA_o<= (others => '0');
                  BUS_DATA_o  <= CACHE_DATA_i;
                  first       <= '1';
                  BUS_RGRANT_o<= miss_int(1);
                  if FLUSH_i = '0' then                                    -- ... and not a flush ...
                     BUS_ADDR_o(LINE_BITS-1 downto 0)          <= mem_cnt(LINE_BITS-1 downto 0);
                     BUS_ADDR_o(ADDR_WIDTH-1 downto LINE_BITS) <= MISS_ADDR_i(ADDR_WIDTH-1 downto LINE_BITS);
                  else                                                     -- If a flush ...
                     BUS_ADDR_o(LINE_BITS-1 downto 0)                        <= mem_cnt(LINE_BITS-1 downto 0);
                     BUS_ADDR_o(ADDR_WIDTH-ADDRTAG_BITS-1 downto LINE_BITS)  <= MISS_ADDR_i(ADDR_WIDTH-ADDRTAG_BITS-1 downto LINE_BITS);
                     BUS_ADDR_o(ADDR_WIDTH-1 downto ADDR_WIDTH-ADDRTAG_BITS) <= RTAGDATA_i(ADDR_WIDTH-log2_ceil(CACHE_SIZE)-1+COHER_TAGWIDTH downto COHER_TAGWIDTH);
                     CACHE_ADDR_o<= MISS_ADDR_i(ADDR_WIDTH-1 downto LINE_BITS) & conv_std_logic_vector(0,LINE_BITS);
                  end if;
                  if BUS_GRANT_i = '1' then                                -- If granted access ...
                     if CACHE_EN_i = '1' then                              -- ... if cache is enabled ...
                        cur_st <= GRANTED_ST;                              -- ... load or flush cache.
                     else
                        cur_st <= NOCACHE_ST;                              -- Just access memory.
                     end if;
                  else                                                     -- If not granted ...
                     if SNOOP_GRANT_i = '0' then                           -- ... if no one was granted ...
                        cur_st <= IDLE_ST;                                 -- ... keep here ...
                     else                                                  -- ... else ...
                        cur_st <= SNOOP_ST;                                -- ... snoop granted access.
                     end if;
                  end if;
                  SNOOP_ACK_o <= SNOOP_REQ_i;
                  SNOOP_VAL_o <= SNOOP_REQ_i;
                  SNOOP_DATA_o<= CACHE_DATA_i;
                  snoop_match_reg <= '0';
                  snoop_req_reg <= '0';
                  rstatus_reg <= (others => '0');
               when SNOOP_ST        =>
                  if SNOOP_MATCH_i = '1' and snoop_req_reg= '1' then --SNOOP_REQ_i = '1' then
                  --if SNOOP_MATCH_i = '1' and SNOOP_REQ_i = '1' then
                     --WUPDATE_o <= '1';
                     snoop_match_reg <= '1';
                     if snoop_match_reg = '0' then
                        snoop_rdx_reg   <= SNOOP_RDX_i;
                        rstatus_reg     <= RSTATUS_i;
                        WTAGADDR_o      <= SNOOP_ADDR_i;                      -- Keep snoopping cache.
                     end if;
                  end if;
                  WUPDATE_o <= snoop_match_reg;
                  NOCACHE_DONE_o <= '0';
                  if SNOOP_GRANT_i = '0' then                              -- If granted access is finished ...
                     cur_st    <= IDLE_ST;                                 -- ... back to idle ...
                  --   WUPDATE_o <= snoop_match_reg;--SNOOP_MATCH_i;                           -- ... and update flag.
                  --else
                  --   WUPDATE_o <= '0';                                     -- Do not update until finished.
                  --   WUPDATE_o <= snoop_match_reg;--SNOOP_MATCH_i;                           -- ... and update flag.
                  --else			
                  --   WUPDATE_o <= '0';                                     -- Do not update until finished.
                  end if;
                  --if SNOOP_RDX_i = '1' or RSTATUS_i = COHER_MODIFIED then
                  if snoop_rdx_reg = '1' or rstatus_reg = COHER_MODIFIED then
                     WSTATUS_o <= COHER_INVALID;
                  else
                     if rstatus_reg = COHER_EXCLUSIVE then
                        WSTATUS_o <= COHER_SHARED;
                     else
                        WSTATUS_o <= rstatus_reg;--RSTATUS_i; X
                        --WSTATUS_o <= RSTATUS_i;
                     end if;
                  end if;
                  --WTAGADDR_o  <= SNOOP_ADDR_i;                             -- Keep snoopping cache.
                  CACHE_ADDR_o<= SNOOP_ADDR_i;
                  CACHE_WEN_o <= '0';
                  CACHE_DATA_o<= (others => '0');
                  SNOOP_ACK_o <= SNOOP_REQ_i;
                  snoop_req_reg <= SNOOP_REQ_i;
                  snoop_req_regg <= snoop_req_reg;
                  if SNOOP_REQ_regg = '1' then
                  --SNOOP_VAL_o <= SNOOP_REQ_regg and not snoop_last_int;
                  SNOOP_VAL_o <= '1';--SNOOP_REQ_regg and not snoop_last_int;
                  end if;
                  SNOOP_DATA_o<= CACHE_DATA_i;
               when GRANTED_ST      =>
                  NOCACHE_DONE_o <= '0';
                  BUS_WR_o    <= '0';                                      -- ... do not write ...
                  BUS_RD_o    <= '0';                                      -- ... or read anything by default.
                  BUS_RDX_o   <= '0';
                  BUS_DATA_o  <= (others => '0');
                  mem_cnt     <= (others => '0');                          -- Initialize read request counter ...
                  cache_cnt   <= (others => '0');                          -- ... and read valid counter.
                  WTAGADDR_o  <= MISS_ADDR_i;                              -- Keep snoopping cache ...
                  WUPDATE_o   <= '0';                                      -- ... by default.
                  WSTATUS_o   <= "00";
                  CACHE_ADDR_o<= MISS_ADDR_i(ADDR_WIDTH-1 downto LINE_BITS) & cache_cnt(LINE_BITS-1 downto 0);
                  CACHE_WEN_o <= '0';
                  CACHE_DATA_o<= (others => '0');
                  BUS_DATA_o  <= CACHE_DATA_i;
                  first       <= '1';
                  if FLUSH_i = '0' then                                    -- ... and not a flush ...
                     cur_st      <= LOAD_ST;                               -- ... go to load state ...
                     mem_cnt     <= mem_cnt + WORD_BYTES;                  -- ... increment request counter ...
                     BUS_REQ_o   <= '1';                                   -- ... and make a read request.
                     BUS_RD_o    <= '1';
                     BUS_RDX_o   <= LOADX_i;
                     BUS_ADDR_o(LINE_BITS-1 downto 0)          <= mem_cnt(LINE_BITS-1 downto 0);
                     BUS_ADDR_o(ADDR_WIDTH-1 downto LINE_BITS) <= MISS_ADDR_i(ADDR_WIDTH-1 downto LINE_BITS);
                     CACHE_ADDR_o<= MISS_ADDR_i(ADDR_WIDTH-1 downto LINE_BITS) & mem_cnt(LINE_BITS-1 downto 0);
                  else                                                     -- If a flush ...
                     cur_st      <= FLUSH_START_ST;                        -- ... go to request state ...
                     cache_cnt   <= cache_cnt + 2*WORD_BYTES;              -- ... increment request counter ...
                     BUS_REQ_o   <= '0';                                   -- ... and make a read request.
                     BUS_WR_o    <= '0';
                     BUS_ADDR_o(LINE_BITS-1 downto 0)                        <= mem_cnt(LINE_BITS-1 downto 0);
                     BUS_ADDR_o(ADDR_WIDTH-ADDRTAG_BITS-1 downto LINE_BITS)  <= MISS_ADDR_i(ADDR_WIDTH-ADDRTAG_BITS-1 downto LINE_BITS);
                     BUS_ADDR_o(ADDR_WIDTH-1 downto ADDR_WIDTH-ADDRTAG_BITS) <= RTAGDATA_i(ADDR_WIDTH-log2_ceil(CACHE_SIZE)-1+COHER_TAGWIDTH downto COHER_TAGWIDTH);
                     CACHE_ADDR_o<= MISS_ADDR_i(ADDR_WIDTH-1 downto LINE_BITS) & conv_std_logic_vector(WORD_BYTES,LINE_BITS);
                  end if;
               when NOCACHE_ST      =>
                  NOCACHE_DONE_o <= '0';
                  BUS_REQ_o   <= '1';
                  --BUS_LAST_o  <= '1';
                  BUS_WR_o    <= MISS_RW_i;
                  BUS_RD_o    <= not(MISS_RW_i);
                  BUS_RDX_o   <= not(MISS_RW_i);
                  BUS_ADDR_o  <= MISS_ADDR_i;
                  BUS_DATA_o  <= MISS_DATA_i;
		  if MISS_RW_i = '1' then
                    if BUS_ACK_i = '1' then
                       BUS_RGRANT_o   <= '0';
                       BUS_REQ_o      <= '0';
                       CACHE_DATA_o   <= BUS_DATA_i;
                       NOCACHE_DONE_o <= '1';
                       cur_st         <= UPTAG_ST;
                    end if;
                  else
                    if BUS_VAL_i = '1' then
                       BUS_RGRANT_o   <= '0';
                       BUS_REQ_o      <= '0';
                       CACHE_DATA_o   <= BUS_DATA_i;
                       NOCACHE_DONE_o <= '1';
                       cur_st         <= UPTAG_ST;
                    end if;
                  end if;
               when FLUSH_START_ST  =>
                  NOCACHE_DONE_o <= '0';
                  cur_st      <= FLUSH_ST;                                 -- ... go to request state ...
                  mem_cnt     <= mem_cnt + WORD_BYTES;                     -- ... increment request counter ...
                  --cache_cnt   <= cache_cnt + WORD_BYTES;                   -- ... increment request counter ...
                  BUS_REQ_o   <= '1';                                      -- ... and make a read request.
                  BUS_WR_o    <= '1';
                  BUS_ADDR_o(LINE_BITS-1 downto 0)                        <= mem_cnt(LINE_BITS-1 downto 0);
                  BUS_ADDR_o(ADDR_WIDTH-ADDRTAG_BITS-1 downto LINE_BITS)  <= MISS_ADDR_i(ADDR_WIDTH-ADDRTAG_BITS-1 downto LINE_BITS);
                  BUS_ADDR_o(ADDR_WIDTH-1 downto ADDR_WIDTH-ADDRTAG_BITS) <= RTAGDATA_i(ADDR_WIDTH-log2_ceil(CACHE_SIZE)-1+COHER_TAGWIDTH downto COHER_TAGWIDTH);
                  CACHE_ADDR_o<= MISS_ADDR_i(ADDR_WIDTH-1 downto LINE_BITS) & cache_cnt(LINE_BITS-1 downto 0);
               when FLUSH_ST  =>
                  NOCACHE_DONE_o <= '0';
                  WTAGADDR_o  <= MISS_ADDR_i;                              -- ... leave tag address ready to update ...
                  WUPDATE_o   <= '0';                                      -- ... but do not update yet.
                  WSTATUS_o   <= COHER_INVALID;
                  first       <= '0';
                  if BUS_ACK_i = '1' or first = '1' then                   -- On ack or just after first request ...
                                                                           -- ... update request address ...
                     BUS_ADDR_o(LINE_BITS-1 downto 0) <= mem_cnt(LINE_BITS-1 downto 0);
                     BUS_DATA_o  <= CACHE_DATA_i;
                     cache_cnt   <= cache_cnt + WORD_BYTES;
                     mem_cnt <= mem_cnt + WORD_BYTES;                      -- ... and increment request counter.
                     CACHE_ADDR_o<= MISS_ADDR_i(ADDR_WIDTH-1 downto LINE_BITS) & cache_cnt(LINE_BITS-1 downto 0);
                  end if;
                  if (mem_cnt > LINE_SIZE and BUS_ACK_i = '1') then        -- If sent all data from memory ...
                     BUS_REQ_o   <= '0';                                   -- ... de-assert write request.
                     BUS_WR_o    <= '0';
                  end if;
                  if mem_cnt > LINE_SIZE + WORD_BYTES then                 -- If all data written ...
                     WUPDATE_o   <= '1';                                   -- ... update cache tag ...
                     mem_cnt     <= (others => '0');
                     cur_st      <= LOAD_START_ST;                         -- ... and restart load next state.
                     BUS_ADDR_o(LINE_BITS-1 downto 0)          <= mem_cnt(LINE_BITS-1 downto 0);
                     BUS_ADDR_o(ADDR_WIDTH-1 downto LINE_BITS) <= MISS_ADDR_i(ADDR_WIDTH-1 downto LINE_BITS);
                  end if;
               when LOAD_START_ST =>                                             -- If all data already on memory ...
                  NOCACHE_DONE_o <= '0';
                  WUPDATE_o   <= '0';
                  WSTATUS_o   <= "00";
                  first       <= '1';
                  CACHE_WEN_o <= '0';
                  cache_cnt   <= (others => '0');
                  cur_st      <= LOAD_ST;                                  -- ... go to request state ...
                  mem_cnt     <= mem_cnt + WORD_BYTES;                     -- ... increment request counter ...
                  BUS_REQ_o   <= '1';                                      -- ... and make a read request.
                  BUS_RD_o    <= '1';
                  BUS_RDX_o   <= LOADX_i;
                  BUS_ADDR_o(LINE_BITS-1 downto 0)          <= mem_cnt(LINE_BITS-1 downto 0);
                  BUS_ADDR_o(ADDR_WIDTH-1 downto LINE_BITS) <= MISS_ADDR_i(ADDR_WIDTH-1 downto LINE_BITS);
               when LOAD_ST    =>                                          -- If requesting data ...
                  NOCACHE_DONE_o <= '0';
                  WTAGADDR_o  <= MISS_ADDR_i;                              -- ... leave tag address ready to update ...
                  WUPDATE_o   <= '0';                                      -- ... but do not update yet.
                  if BUS_MATCH_i = COHER_MODIFIED or LOADX_i = '1'then
                     WSTATUS_o   <= COHER_MODIFIED;
                  else
                     WSTATUS_o   <= BUS_MATCH_i;
                  end if;
                  first       <= '0';
                  if BUS_ACK_i = '1' or first = '1' then                   -- On ack or just after first request ...
                                                                           -- ... update request address ...
                     BUS_ADDR_o(LINE_BITS-1 downto 0)          <= mem_cnt(LINE_BITS-1 downto 0);
                     BUS_ADDR_o(ADDR_WIDTH-1 downto LINE_BITS) <= MISS_ADDR_i(ADDR_WIDTH-1 downto LINE_BITS);
                     mem_cnt <= mem_cnt + WORD_BYTES;                      -- ... and increment request counter.
                  end if;
                  if (mem_cnt > LINE_SIZE and BUS_ACK_i = '1') then        -- If request all data from memory ...
                     BUS_REQ_o   <= '0';                                   -- ... de-assert read request.
                     BUS_RD_o    <= '0';
                     BUS_RDX_o   <= '0';
                  end if;
                  if BUS_VAL_i = '1' then                                  -- If valid data from memory ...
                     CACHE_WEN_o <= '1';                                   -- ... write on cache ...
                     CACHE_DATA_o<= BUS_DATA_i;                            -- ... at appr. position.
                     CACHE_ADDR_o<= MISS_ADDR_i(ADDR_WIDTH-1 downto LINE_BITS) & cache_cnt(LINE_BITS-1 downto 0);
                     cache_cnt   <= cache_cnt + WORD_BYTES;                -- Increment valid counter.
                  else                                                     -- If data is not ready ...
                     CACHE_ADDR_o<= (others => '0');                       -- ... do not write.
                     CACHE_WEN_o <= '0';
                     CACHE_DATA_o<= (others => '0');
                  end if;
                  if cache_cnt > LINE_SIZE-WORD_BYTES then                 -- If all data read ...
                     WUPDATE_o   <= '1';                                   -- ... update cache tag ...
                     cur_st      <= UPTAG_ST;                              -- ... and wait for miss de-assertion.
                     CACHE_WEN_o <= LOADX_i;                               -- ... write on cache ...
                     CACHE_DATA_o<= MISS_DATA_i;                           -- ... at appr. position.
                     CACHE_ADDR_o<= MISS_ADDR_i;
                  end if;
               when UPTAG_ST =>                                            -- If all data already on cache ...
                  NOCACHE_DONE_o <= '0';
                  BUS_REQ_o   <= '0';                                      -- ... do nothing.
                  BUS_RGRANT_o<= '0';
                  BUS_RD_o    <= '0';
                  BUS_RDX_o   <= '0';
                  BUS_WR_o    <= '0';
                  BUS_ADDR_o  <= (others => '0');
                  BUS_DATA_o  <= (others => '0');
                  WTAGADDR_o  <= (others => '0');
                  WUPDATE_o   <= '0';
                  WSTATUS_o   <= "00";
                  CACHE_ADDR_o<= (others => '0');
                  CACHE_WEN_o <= '0';
                  CACHE_DATA_o<= (others => '0');
                  cache_cnt   <= (others => '0');
                  mem_cnt     <= (others => '0');
                  if miss_int(0) = '0' and BUS_GRANT_i = '0' then          -- Wait for miss de-assertion ...
                     cur_st   <= IDLE_ST;                                  -- ... and back to idle if so.
                  end if;
               when others =>                                              -- In case of problems ...
                  cur_st   <= IDLE_ST;
            end case;
         end if;
      end if;
   end process;

   BUS_LAST_o <= '1' when CACHE_EN_i = '0'and BUS_ACK_i = '1' else
                 '1' when mem_cnt > LINE_SIZE else
                 '1' when mem_cnt = LINE_SIZE and BUS_ACK_i = '1' else
                 '0';

   SNOOP_SEL_o <= '1' when (RSTATUS_i /= COHER_INVALID or rstatus_reg /= COHER_INVALID) and SNOOP_MATCH_i = '1' and (cur_st = IDLE_ST or cur_st = SNOOP_ST) else
                  '0';

   SNOOP_MATCH_o <= rstatus_reg;--RSTATUS_i;

end Behavioral;
