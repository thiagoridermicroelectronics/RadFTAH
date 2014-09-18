-- =================================================================================
-- Project          :  MIPS Multi-core
-- FileName         :  dcache_tag.vhd
-- FileType         :  VHDL - Source code
-- Author           :  Jorge Tortato Junior, UFPR
-- Reviewer         :  -x-x-x-x-
-- Version          :  0.1 from 21/oct/2008
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
entity dcache_tag is
   generic (
      CACHE_SIZE : integer := 2048;                                         -- Size of cache - in bytes 
      LINE_SIZE  : integer := 8;                                            -- Line size - in bytes
      ADDR_WIDTH : integer := 32                                            -- Number of cached memory address bits
   );
   port (
      -- System Interface
      RST_i                : in    std_logic;                               -- Reset - active high

      -- Cache loader
      RTAGDATA_o           : out   std_logic_vector(ADDR_WIDTH-log2_ceil(CACHE_SIZE)+1 downto 0); -- Cache tag read data
      WCLK_i               : in    std_logic;                               -- Write clock
      WADDR_i              : in    std_logic_vector(ADDR_WIDTH-1 downto 0); -- Write address
      WUPDATE_i            : in    std_logic;                               -- Update entry
      WSTATUS_i            : in    std_logic_vector(COHER_TAGWIDTH-1 downto 0);-- Status to update entry = '0'-invalid, '1'-valid
      RSTATUS_o            : out   std_logic_vector(COHER_TAGWIDTH-1 downto 0);-- Status to update entry = '0'-invalid, '1'-valid

      -- Core requests
      CORE_CLK_i           : in    std_logic;                               -- Core clock
      CORE_ADDR_i          : in    std_logic_vector(ADDR_WIDTH-1 downto 0); -- Core address
      CORE_REQ_i           : in    std_logic;                               -- Core request
      CORE_RW_i            : in    std_logic;                               -- Core read or write strobe

      -- Cache status
      SNOOP_MATCH_o        : out   std_logic;                               -- Snoop match status
      HIT_o                : out   std_logic;                               -- Hit status - active high
      MISS_o               : out   std_logic;                               -- Miss status - active high
      LOADX_o              : out   std_logic;                               -- Load cache exclusive - active high
      LOAD_o               : out   std_logic;                               -- Load cache - active high
      FLUSH_o              : out   std_logic                                -- Flush cache - active high
   );
end dcache_tag;

architecture Behavioral of dcache_tag is

-- Attributes

-- Types and definitions
constant gnd            : std_logic  := '0';
constant vcc            : std_logic  := '1';

constant CACHE_LINES    : integer    := CACHE_SIZE/LINE_SIZE;
constant TAGADDR_WIDTH  : integer    := log2_ceil(CACHE_LINES);
constant LINE_BITS      : integer    := log2_ceil(LINE_SIZE);
constant ADDRTAG_BITS   : integer    := 32 - 8 - 3; --XXX: This account should result 32 - // ADDR_WIDTH - TAGADDR_WIDTH - LINE_BITS;
constant TAG_BITS       : integer    := ADDRTAG_BITS + COHER_TAGWIDTH;
constant ALL_ZERO       : std_logic_vector(TAG_BITS-1 downto 0) := (others => gnd);

-- Internal signals

signal bus_wdata        : std_logic_vector(TAG_BITS-1 downto 0) := (others => gnd);
signal bus_rdata        : std_logic_vector(TAG_BITS-1 downto 0) := (others => gnd);
signal core_rdata       : std_logic_vector(TAG_BITS-1 downto 0) := (others => gnd);
signal core_wdata       : std_logic_vector(TAG_BITS-1 downto 0) := (others => gnd);
signal core_write       : std_logic;

begin

   -- Tag memory instantiation
   dcache_tag_inst : entity work.memory
      generic map (
         CLK_A_EDGE   => '0',
         CLK_B_EDGE   => '0',
         DATA_WIDTH   => TAG_BITS,
         ADDR_WIDTH   => TAGADDR_WIDTH
      )
      port map (
         CLK_A_i      => WCLK_i,
         ADDR_A_i     => WADDR_i(ADDR_WIDTH-ADDRTAG_BITS-1 downto LINE_BITS),
         EN_A_i       => '1',
         RDATA_A_o    => bus_rdata,
         WREN_A_i     => WUPDATE_i,
         WDATA_A_i    => bus_wdata,
         CLK_B_i      => CORE_CLK_i,
         ADDR_B_i     => CORE_ADDR_i(ADDR_WIDTH-ADDRTAG_BITS-1 downto LINE_BITS),
         EN_B_i       => vcc,
         RDATA_B_o    => core_rdata,
         WREN_B_i     => core_write,
         WDATA_B_i    => core_wdata
   );

   bus_wdata  <= WADDR_i(ADDR_WIDTH-1 downto ADDR_WIDTH-ADDRTAG_BITS) & WSTATUS_i;
   core_wdata <= CORE_ADDR_i(ADDR_WIDTH-1 downto ADDR_WIDTH-ADDRTAG_BITS) & COHER_MODIFIED;
   RTAGDATA_o <= bus_rdata;

   process(core_rdata, CORE_ADDR_i, CORE_REQ_i, RST_i, CORE_RW_i)
   begin
      if RST_i = '1' then
         MISS_o    <= '0';
         HIT_o     <= '0';
         LOADX_o   <= '0';
         LOAD_o    <= '0';
         FLUSH_o   <= '0';
         core_write <= '0';
      else
         if CORE_REQ_i = '1' then
            if core_rdata(TAG_BITS-1 downto COHER_TAGWIDTH) = CORE_ADDR_i(ADDR_WIDTH-1 downto ADDR_WIDTH-ADDRTAG_BITS) then
               case core_rdata(1 downto 0) is
                  when COHER_MODIFIED  =>
                     MISS_o     <= '0';
                     HIT_o      <= '1';
                     LOADX_o    <= '0';
                     LOAD_o     <= '0';
                     FLUSH_o    <= '0';
                     core_write <= '0';
                  when COHER_EXCLUSIVE =>
                     MISS_o     <= '0';
                     HIT_o      <= '1';
                     LOADX_o    <= '0';
                     LOAD_o     <= '0';
                     FLUSH_o    <= '0';
                     core_write <= CORE_RW_i;
                  when COHER_SHARED    =>
                     MISS_o     <= CORE_RW_i;
                     HIT_o      <= not CORE_RW_i;
                     LOADX_o    <= CORE_RW_i;
                     LOAD_o     <= CORE_RW_i;
                     FLUSH_o    <= '0';
                     core_write <= '0';
                  when COHER_INVALID   =>
                     MISS_o     <= '1';
                     HIT_o      <= '0';
                     LOADX_o    <= CORE_RW_i;
                     LOAD_o     <= '1';
                     FLUSH_o    <= '0';
                     core_write <= '0';
                  when others          =>
                     MISS_o     <= '1';
                     HIT_o      <= '0';
                     LOADX_o    <= '0';
                     LOAD_o     <= '0';
                     FLUSH_o    <= '0';
                     core_write <= '0';
               end case;
            else
               MISS_o     <= '1';
               HIT_o      <= '0';
               core_write <= '0';
               if core_rdata(COHER_TAGWIDTH-1 downto 0) = COHER_MODIFIED then
                  LOADX_o   <= CORE_RW_i;
                  LOAD_o    <= '1';
                  FLUSH_o   <= '1';
               else
                  LOADX_o   <= CORE_RW_i;
                  LOAD_o    <= '1';
                  FLUSH_o   <= '0';
               end if;
            end if;
         else
            MISS_o     <= '0';
            HIT_o      <= '0';
            LOADX_o    <= '0';
            LOAD_o     <= '0';
            FLUSH_o    <= '0';
            core_write <= '0';
         end if;
      end if;
   end process;

   process(bus_rdata, WADDR_i, RST_i)
   begin
      if RST_i = '1' then
         RSTATUS_o <= COHER_INVALID;
         SNOOP_MATCH_o <= '0';
      else
         if bus_rdata(TAG_BITS-1 downto COHER_TAGWIDTH) = WADDR_i(ADDR_WIDTH-1 downto ADDR_WIDTH-ADDRTAG_BITS) then
            RSTATUS_o <= bus_rdata(1 downto 0);
            SNOOP_MATCH_o <= '1';
         else
            RSTATUS_o <= COHER_INVALID;
            SNOOP_MATCH_o <= '0';
         end if;
      end if;
   end process;

end Behavioral;
