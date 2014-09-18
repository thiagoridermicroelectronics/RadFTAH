-- =================================================================================
-- Project          :  MIPS Multi-core
-- FileName         :  mmu.vhd
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
entity mmu is
   generic (
      PAGE_SIZE   : integer range 2**5 to 2**30:= 2**10;                   -- Virtual page size
      TLB_NUM     : integer  := 8;                                         -- Number of TLB entries
                                                                           -- TLB initial configuration
      TLB_INIT    : slv32vec := (X"00000000", X"00000000", X"00000000", X"00000000",
                                 X"00000000", X"00000000", X"00000000", X"00000000",
                                 X"00000000", X"00000000", X"00000000", X"00000000",
                                 X"00000000", X"00000000", X"00000000", X"00000000");
      ADDR_WIDTH  : integer  := 32;                                        -- Number of cached memory address bits
      DATA_WIDTH  : integer  := 32                                         -- Number of bits of TLB entry
   );
   port (
      -- System Interface
      RST_i                : in    std_logic;                              -- Reset - active high

      -- Configuration interface
      CFG_CLK_i            : in    std_logic;                              -- Configuration clock
      CFG_WR_i             : in    std_logic;                              -- Configuration write
      CFG_ADDR_i           : in    std_logic_vector(log2_ceil(TLB_NUM) downto 0); -- TLB entry number
      CFG_DATA_i           : in    std_logic_vector(ADDR_WIDTH-1 downto 0);-- TLB entry value - write
      CFG_DATA_o           : out   std_logic_vector(ADDR_WIDTH-1 downto 0);-- TLB entry value - read

      -- Address translation
      CORE_CLK_i           : in    std_logic;                              -- Core clock
      VIRTUAL_WR_i         : in    std_logic;                              -- Virtual address write
      VIRTUAL_RD_i         : in    std_logic;                              -- Virtual address rd
      VIRTUAL_EX_i         : in    std_logic;                              -- Virtual address execute
      VIRTUAL_ADDR_i       : in    std_logic_vector(ADDR_WIDTH-1 downto 0);-- Virtual address
      REAL_WR_o            : out   std_logic;                              -- Real address write
      REAL_RD_o            : out   std_logic;                              -- Real address rd
      REAL_EX_o            : out   std_logic;                              -- Real address execute
      REAL_CACHE_o         : out   std_logic;                              -- Real address cache nable
      REAL_ADDR_o          : out   std_logic_vector(ADDR_WIDTH-1 downto 0);-- Real address
      TLB_MISS_ADDR_o      : out   std_logic_vector(ADDR_WIDTH-1 downto 0);-- Miss address
      TLB_MISS_o           : out   std_logic                               -- TLB miss
   );
end mmu;

architecture Behavioral of mmu is

-- Attributes

-- Types and definitions
constant gnd            : std_logic  := '0';
constant vcc            : std_logic  := '1';

-- Internal signals

-- First register (even = 0, 2, 4, ...)
----------------------
--| Virtual addr tag |
----------------------

-- Second register (odd = 1, 3, 5, ...)
----------------------------------------------------------
--| VALID | WR_EN | RD_EN | EX_EN | CACHE_EN | Real addr |
----------------------------------------------------------
signal tlb_reg          : slv32vec(2*TLB_NUM-1 downto 0);
signal tlb_mux          : slv32vec(TLB_NUM-1 downto 0);

begin

   REAL_ADDR_o(log2_ceil(PAGE_SIZE)-1 downto 0) <= VIRTUAL_ADDR_i(log2_ceil(PAGE_SIZE)-1 downto 0);
   REAL_ADDR_o(ADDR_WIDTH-1 downto log2_ceil(PAGE_SIZE)) <= tlb_mux(TLB_NUM-1)(ADDR_WIDTH-log2_ceil(PAGE_SIZE)-1 downto 0);
   TLB_MISS_o   <= not tlb_mux(TLB_NUM-1)(31);
   REAL_WR_o    <= tlb_mux(TLB_NUM-1)(30) and VIRTUAL_WR_i;
   REAL_RD_o    <= tlb_mux(TLB_NUM-1)(29) and VIRTUAL_RD_i;
   REAL_EX_o    <= tlb_mux(TLB_NUM-1)(28) and VIRTUAL_EX_i;
   REAL_CACHE_o <= tlb_mux(TLB_NUM-1)(27);

   addr_translation_gen : for i in 1 to TLB_NUM-1 generate
      tlb_mux(i) <= 
            tlb_reg(2*i+1) when VIRTUAL_ADDR_i(ADDR_WIDTH-1 downto log2_ceil(PAGE_SIZE)) = tlb_reg(2*i)(ADDR_WIDTH-log2_ceil(PAGE_SIZE)-1 downto 0) and tlb_reg(2*i+1)(31) = '1' else
            tlb_mux(i-1);
   end generate;

   tlb_mux(0) <= 
         tlb_reg(1) when VIRTUAL_ADDR_i(ADDR_WIDTH-1 downto log2_ceil(PAGE_SIZE)) = tlb_reg(0)(ADDR_WIDTH-log2_ceil(PAGE_SIZE)-1 downto 0) and tlb_reg(1)(31) = '1' else
         X"00000000";

   process(CFG_CLK_i)
   begin
      if CFG_CLK_i'event and CFG_CLK_i = '1' then
         if RST_i = '1' then
            tlb_reg <= TLB_INIT;
         else
            if CFG_WR_i = '1' and conv_integer(CFG_ADDR_i) < 2*TLB_NUM then
               tlb_reg(conv_integer(CFG_ADDR_i)) <= CFG_DATA_i;
            end if;
            if conv_integer(CFG_ADDR_i) < 2*TLB_NUM then
               CFG_DATA_o <= tlb_reg(conv_integer(CFG_ADDR_i));
            end if;
         end if;
      end if;
   end process;

end Behavioral;
