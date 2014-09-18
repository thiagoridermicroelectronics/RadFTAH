-- =================================================================================
-- Project          :  MIPS Multi-core
-- FileName         :  dcache_data.vhd
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
entity dcache_data is
   generic (
      CACHE_SIZE : integer := 2048;                                         -- Size of cache - in bytes 
      LINE_SIZE  : integer := 8;                                            -- Line size - in bytes
      DATA_WIDTH : integer := 32;                                           -- Read data widht - in bits
      ADDR_WIDTH : integer := 32                                            -- Number of cached memory address bits
   );
   port (
      -- System Interface
      RST_i                : in    std_logic;                               -- Reset - active high

      -- Cache loader interface
      WCLK_i               : in    std_logic;                               -- Write clock
      WADDR_i              : in    std_logic_vector(ADDR_WIDTH-1 downto 0); -- Write address
      WEN_i                : in    std_logic;                               -- Write enable
      WDATA_i              : in    std_logic_vector(DATA_WIDTH-1 downto 0); -- Write data
      RDATA_o              : out   std_logic_vector(DATA_WIDTH-1 downto 0); -- Read data

      -- Core interface
      CORE_REQ_i           : in    std_logic;                               -- Core request
      CORE_WEN_i           : in    std_logic;                               -- Core write enable
      CORE_DATA_i          : in    std_logic_vector(DATA_WIDTH-1 downto 0); -- Core write data
      CORE_CLK_i           : in    std_logic;                               -- Core clock
      CORE_ADDR_i          : in    std_logic_vector(ADDR_WIDTH-1 downto 0); -- Core address
      CORE_DATA_o          : out   std_logic_vector(DATA_WIDTH-1 downto 0)  -- Core read data
   );
end dcache_data;

architecture Behavioral of dcache_data is

-- Attributes

-- Types and definitions
constant gnd            : std_logic  := '0';
constant vcc            : std_logic  := '1';

constant CACHE_WORDS    : integer    := 8*CACHE_SIZE/DATA_WIDTH;
constant CACHE_ADDRBITS : integer    := log2_ceil(CACHE_WORDS);
constant WORD_ADDRBITS  : integer    := log2_ceil(DATA_WIDTH/8);
constant CACHE_LINES    : integer    := CACHE_SIZE/LINE_SIZE;
constant TAGADDR_WIDTH  : integer    := log2_ceil(CACHE_LINES);
constant LINE_BITS      : integer    := log2_ceil(LINE_SIZE);
constant ADDRTAG_BITS   : integer    := ADDR_WIDTH - TAGADDR_WIDTH - LINE_BITS;

-- Internal signals
signal raddr            : std_logic_vector(CACHE_ADDRBITS-1 downto 0) := (others => gnd);
signal waddr            : std_logic_vector(CACHE_ADDRBITS-1 downto 0) := (others => gnd);

begin

   -- Data memory instantiation
   dcache_data_inst : entity work.memory
      generic map (
         CLK_A_EDGE   => '1',
         CLK_B_EDGE   => '1',
         DATA_WIDTH   => DATA_WIDTH,
         ADDR_WIDTH   => CACHE_ADDRBITS
      )
      port map (
         CLK_A_i      => WCLK_i,
         ADDR_A_i     => waddr,
         EN_A_i       => '1',
         RDATA_A_o    => RDATA_o,
         WREN_A_i     => WEN_i,
         WDATA_A_i    => WDATA_i,
         CLK_B_i      => CORE_CLK_i,
         ADDR_B_i     => raddr,
         EN_B_i       => CORE_REQ_i,
         RDATA_B_o    => CORE_DATA_o,
         WREN_B_i     => CORE_WEN_i,
         WDATA_B_i    => CORE_DATA_i
   );

   raddr <= CORE_ADDR_i(ADDR_WIDTH-ADDRTAG_BITS-1 downto LINE_BITS) & CORE_ADDR_i(LINE_BITS-1 downto WORD_ADDRBITS);
   waddr <= WADDR_i(ADDR_WIDTH-ADDRTAG_BITS-1 downto LINE_BITS) & WADDR_i(LINE_BITS-1 downto WORD_ADDRBITS);

end Behavioral;
