-- =================================================================================
-- Project          :  MIPS Multi-core
-- FileName         :  icache_loader.vhd
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

-- Entity declaration
entity icache_loader is
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
      BUS_LAST_o           : out   std_logic;                               -- Bus last request indication
      BUS_ACK_i            : in    std_logic;                               -- Bus acknowledge
      BUS_VAL_i            : in    std_logic;                               -- Bus data valid
      BUS_RD_o             : out   std_logic;                               -- Bus read
      BUS_WR_o             : out   std_logic;                               -- Bus write
      BUS_ADDR_o           : out   std_logic_vector(ADDR_WIDTH-1 downto 0); -- Bus address
      BUS_DATA_i           : in    std_logic_vector(DATA_WIDTH-1 downto 0); -- Bus data input
      BUS_DATA_o           : out   std_logic_vector(DATA_WIDTH-1 downto 0); -- Bus data output

      -- Cache status
      MISS_i               : in    std_logic;                               -- Cache miss
      MISS_ADDR_i          : in    std_logic_vector(ADDR_WIDTH-1 downto 0); -- Miss address

      -- Core interface
      WDATAADDR_o          : out   std_logic_vector(ADDR_WIDTH-1 downto 0); -- Write address for data
      WEN_o                : out   std_logic;                               -- Write enable for data
      WDATA_o              : out   std_logic_vector(DATA_WIDTH-1 downto 0); -- Write data
      WTAGADDR_o           : out   std_logic_vector(ADDR_WIDTH-1 downto 0); -- Write address for tag
      WUPDATE_o            : out   std_logic;                               -- Update entry
      WSTATUS_o            : out   std_logic                                -- Status to update entry = '0'-invalid, '1'-valid
   );
end icache_loader;

architecture Behavioral of icache_loader is

-- Attributes

-- Types and definitions
constant gnd            : std_logic  := '0';
constant vcc            : std_logic  := '1';
constant LINE_BITS      : integer := log2_ceil(LINE_SIZE);                 -- Number of address bits for one line
constant WORD_BYTES     : integer := DATA_WIDTH/8;                         -- Number of bytes in one words

type fsm_st is (IDLE_ST, GRANTED_ST, REQ_ST, END_ST, UPTAG_ST, WAIT_GRANT_ST); -- Type definition

-- Internal signals
signal cur_st           : fsm_st;                                          -- Current fsm state
signal miss_int         : std_logic_vector(1 downto 0);                    -- Internal miss status
signal mem_cnt          : std_logic_vector(LINE_BITS+1 downto 0);          -- Number of memory accesses
signal cache_cnt        : std_logic_vector(LINE_BITS downto 0);            -- Number of cache accesses
signal first            : std_logic;                                       -- First clock after a memory request
signal clr_cnt          : std_logic_vector(log2_ceil(CACHE_SIZE) downto 0) := (others => '0');

begin

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
            BUS_WR_o    <= '0';
            BUS_ADDR_o  <= (others => '0');
            BUS_DATA_o  <= (others => '0');
            WTAGADDR_o  <= (others => '0');
            --WUPDATE_o   <= '0';
            --WSTATUS_o   <= '0';
            WTAGADDR_o(log2_ceil(CACHE_SIZE) downto 0)  <= clr_cnt;
            WUPDATE_o   <= '1';
            WSTATUS_o   <= '0';
            clr_cnt     <= clr_cnt + 1;
            mem_cnt     <= (others => '0');
            first       <= '0';
            WDATAADDR_o <= (others => '0');
            WDATAADDR_o(log2_ceil(CACHE_SIZE) downto 0)  <= clr_cnt;
            WEN_o       <= '1';
            WDATA_o     <= (others => '0');
            cache_cnt   <= (others => '0');
            cur_st      <= IDLE_ST;
         else
            case cur_st is                                                 -- Acc. to curren state ...
               when IDLE_ST   =>                                           -- ... if IDLE ..
                  BUS_WR_o    <= '0';                                      -- ... do not write anything.
                  BUS_DATA_o  <= (others => '0');
                  mem_cnt     <= (others => '0');                          -- Initialize read request counter ...
                  cache_cnt   <= (others => '0');                          -- ... and read valid counter.
                  WTAGADDR_o  <= (others => '0');                          -- Do nothing on cache or tags ...
                  WUPDATE_o   <= '0';                                      -- ... by default.
                  WSTATUS_o   <= '0';
                  WDATAADDR_o <= (others => '0');
                  WEN_o       <= '0';
                  WDATA_o     <= (others => '0');
                  first       <= '1';
                  BUS_RGRANT_o<= miss_int(1);
                  if BUS_GRANT_i = '1' then                                -- If granted access ...
                     cur_st      <= GRANTED_ST;                            -- ... go to request state ...
                     BUS_REQ_o   <= '0';                                   -- ... and make a read request.
                     BUS_RD_o    <= '1';
                  else                                                     -- If not a miss ...
                     BUS_REQ_o   <= '0';                                   -- ... do nothing.
                     BUS_RD_o    <= '0';
                  end if;
                  BUS_ADDR_o(LINE_BITS-1 downto 0)          <= mem_cnt(LINE_BITS-1 downto 0);
                  BUS_ADDR_o(ADDR_WIDTH-1 downto LINE_BITS) <= MISS_ADDR_i(ADDR_WIDTH-1 downto LINE_BITS);
               when GRANTED_ST      =>
                  BUS_WR_o    <= '0';                                      -- ... do not write anything.
                  BUS_DATA_o  <= (others => '0');
                  mem_cnt     <= (others => '0');                          -- Initialize read request counter ...
                  cache_cnt   <= (others => '0');                          -- ... and read valid counter.
                  WTAGADDR_o  <= (others => '0');                          -- Do nothing on cache or tags ...
                  WUPDATE_o   <= '0';                                      -- ... by default.
                  WSTATUS_o   <= '0';
                  WDATAADDR_o <= (others => '0');
                  WEN_o       <= '0';
                  WDATA_o     <= (others => '0');
                  first       <= '1';
                  BUS_RGRANT_o<= '1';--miss_int(1);
                  BUS_RGRANT_o<= miss_int(1);
                  --if BUS_GRANT_i = '1' then                                -- If granted access ...
                  if BUS_GRANT_i = '1' and miss_int(1) = '1' then                                -- If granted access ...
                  
                     cur_st      <= REQ_ST;                                -- ... go to request state ...
                     mem_cnt     <= mem_cnt + WORD_BYTES;                  -- ... increment request counter ...
                     BUS_REQ_o   <= '1';                                   -- ... and make a read request.
                     BUS_RD_o    <= '1';
                  else                                                     -- If not a miss ...
                     if miss_int(1) = '0' then
                      cur_st      <= IDLE_ST;
                     end if;
                     BUS_REQ_o   <= '0';                                   -- ... do nothing.
                     BUS_RD_o    <= '0';
                  end if;
                  BUS_ADDR_o(LINE_BITS-1 downto 0)          <= mem_cnt(LINE_BITS-1 downto 0);
                  BUS_ADDR_o(ADDR_WIDTH-1 downto LINE_BITS) <= MISS_ADDR_i(ADDR_WIDTH-1 downto LINE_BITS);
               when REQ_ST    =>                                           -- If requesting data ...
                  WTAGADDR_o  <= MISS_ADDR_i;                              -- ... leave tag address ready to update ...
                  WUPDATE_o   <= '0';                                      -- ... but do not update yet.
                  WSTATUS_o   <= '1';
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
                  end if;
                  if BUS_VAL_i = '1' then                                  -- If valid data from memory ...
                     WEN_o       <= '1';                                   -- ... write on cache ...
                     WDATA_o     <= BUS_DATA_i;                            -- ... at appr. position.
                     WDATAADDR_o <= MISS_ADDR_i(ADDR_WIDTH-1 downto LINE_BITS) & cache_cnt(LINE_BITS-1 downto 0);
                     cache_cnt   <= cache_cnt + WORD_BYTES;                -- Increment valid counter.
                  else                                                     -- If data is not ready ...
                     WDATAADDR_o <= (others => '0');                       -- ... do not write.
                     WEN_o       <= '0';
                     WDATA_o     <= (others => '0');
                  end if;
                  if cache_cnt > LINE_SIZE-WORD_BYTES then                 -- If all data read ...
                     WUPDATE_o   <= '1';                                   -- ... update cache tag ...
                     cur_st      <= UPTAG_ST;                              -- ... and wait for miss de-assertion.
                  end if;
               when UPTAG_ST =>                                            -- If all data already on cache ...
                  BUS_REQ_o   <= '0';                                      -- ... do nothing.
                  BUS_RD_o    <= '0';
                  BUS_WR_o    <= '0';
                  BUS_ADDR_o  <= (others => '0');
                  BUS_DATA_o  <= (others => '0');
                  BUS_RGRANT_o<= '0';
                  WTAGADDR_o  <= (others => '0');
                  WUPDATE_o   <= '0';
                  WSTATUS_o   <= '0';
                  WDATAADDR_o <= (others => '0');
                  WEN_o       <= '0';
                  WDATA_o     <= (others => '0');
                  cache_cnt   <= (others => '0');
                  if miss_int(0) = '0' and BUS_GRANT_i = '0' then          -- Wait for miss de-assertion ...
                     cur_st   <= IDLE_ST;                                  -- ... and back to idle if so.
                  end if;
                  if miss_int(0) = '0' and BUS_GRANT_i = '1' then          -- If miss de-assertion and bus grant still on ...
                     cur_st   <= WAIT_GRANT_ST;                            -- ... go to wait for grant de-assertion.
                  end if;
               when WAIT_GRANT_ST =>                                       -- If all data already on cache ...
                  BUS_REQ_o   <= '0';                                      -- ... do nothing.
                  BUS_RD_o    <= '0';
                  BUS_WR_o    <= '0';
                  BUS_ADDR_o  <= (others => '0');
                  BUS_DATA_o  <= (others => '0');
                  BUS_RGRANT_o<= '0';
                  WTAGADDR_o  <= (others => '0');
                  WUPDATE_o   <= '0';
                  WSTATUS_o   <= '0';
                  WDATAADDR_o <= (others => '0');
                  WEN_o       <= '0';
                  WDATA_o     <= (others => '0');
                  cache_cnt   <= (others => '0');
                  if BUS_GRANT_i = '0' then                                -- Wait for grant de-assertion ...
                     cur_st   <= IDLE_ST;                                  -- ... and back to idle if so.
                  end if;
               when others =>                                              -- In case of problems ...
                  cur_st   <= IDLE_ST;                                     -- ... reinitialize everything.
            end case;
         end if;
      end if;
   end process;

   BUS_LAST_o <= '1' when mem_cnt > LINE_SIZE else
                 '1' when mem_cnt = LINE_SIZE and BUS_ACK_i = '1' else
                 '0';

end Behavioral;