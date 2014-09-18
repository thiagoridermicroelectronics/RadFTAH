-- =================================================================================
-- Project          :  MIPS Multi-core
-- FileName         :  icache_tag.vhd
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

-- Entity declaration
entity icache_tag is
   generic (
      CACHE_SIZE : integer := 2048;                                         -- Size of cache - in bytes 
      LINE_SIZE  : integer := 8;                                            -- Line size - in bytes
      ADDR_WIDTH : integer := 32                                            -- Number of cached memory address bits
   );
   port (
      -- System Interface
      RST_i                : in    std_logic;                               -- Reset - active high

      -- Core interface
      WCLK_i               : in    std_logic;                               -- Write clock
      WADDR_i              : in    std_logic_vector(ADDR_WIDTH-1 downto 0); -- Write address
      WUPDATE_i            : in    std_logic;                               -- Update entry
      WSTATUS_i            : in    std_logic;                               -- Status to update entry = '0'-invalid, '1'-valid

      RCLK_i               : in    std_logic;                               -- Read clock
      RADDR_i              : in    std_logic_vector(ADDR_WIDTH-1 downto 0); -- Read address
      HIT_o                : out   std_logic;                               -- Hit status - active high
      MISS_o               : out   std_logic                                -- Miss status - active high
   );
end icache_tag;

architecture Behavioral of icache_tag is

-- Attributes

-- Types and definitions
constant gnd            : std_logic  := '0';
constant vcc            : std_logic  := '1';

constant CACHE_LINES    : integer    := CACHE_SIZE/LINE_SIZE;
constant TAGADDR_WIDTH  : integer    := log2_ceil(CACHE_LINES);
constant LINE_BITS      : integer    := log2_ceil(LINE_SIZE);
constant ADDRTAG_BITS   : integer    := ADDR_WIDTH - TAGADDR_WIDTH - LINE_BITS;
constant TAG_BITS       : integer    := ADDRTAG_BITS + 1;
constant ALL_ZERO       : std_logic_vector(TAG_BITS-1 downto 0) := (others => gnd);

-- Internal signals

signal write_tag        : std_logic_vector(TAG_BITS-1 downto 0) := (others => gnd);
signal read_tag         : std_logic_vector(TAG_BITS-1 downto 0) := (others => gnd);

begin

   -- Tag memory instantiation
   icache_tag_inst : entity work.memory
      generic map (
         CLK_A_EDGE   => '0',
         CLK_B_EDGE   => '0',
         DATA_WIDTH   => TAG_BITS,
         ADDR_WIDTH   => TAGADDR_WIDTH
      )
      port map (
         CLK_A_i      => WCLK_i,
         ADDR_A_i     => WADDR_i(ADDR_WIDTH-ADDRTAG_BITS-1 downto LINE_BITS),
         EN_A_i       => WUPDATE_i,
         RDATA_A_o    => open,
         WREN_A_i     => WUPDATE_i,
         WDATA_A_i    => write_tag,
         CLK_B_i      => RCLK_i,
         ADDR_B_i     => RADDR_i(ADDR_WIDTH-ADDRTAG_BITS-1 downto LINE_BITS),
         EN_B_i       => vcc,
         RDATA_B_o    => read_tag,
         WREN_B_i     => gnd,
         WDATA_B_i    => ALL_ZERO
   );

   write_tag <= WADDR_i(ADDR_WIDTH-1 downto ADDR_WIDTH-ADDRTAG_BITS) & WSTATUS_i;

   process(read_tag, RADDR_i, RST_i)
   begin
      if RST_i = '1' then
         MISS_o <= '1';
         HIT_o  <= '0';
      else
         if read_tag(0) = '1' and
            read_tag(TAG_BITS-1 downto 1) = RADDR_i(ADDR_WIDTH-1 downto ADDR_WIDTH-ADDRTAG_BITS) then
            MISS_o <= '0';
            HIT_o  <= '1';
         else
            MISS_o <= '1';
            HIT_o  <= '0';
         end if;
      end if;
   end process;

end Behavioral;
