-- =================================================================================
-- Project          :  MIPS Multi-core
-- FileName         :  memory.vhd
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

-- Entity declaration
entity memory is
   generic (
      CLK_A_EDGE : std_logic  := '0';
      CLK_B_EDGE : std_logic  := '0';
      DATA_WIDTH : integer    := 32;                                        -- Number of data bits
      ADDR_WIDTH : integer    := 10                                         -- Number of address bits
   );
   port (
      -- Interface A
      CLK_A_i              : in    std_logic;                               -- Read and write clock
      ADDR_A_i             : in    std_logic_vector(ADDR_WIDTH-1 downto 0); -- Read and write address
      EN_A_i               : in    std_logic;                               -- Port enable
      RDATA_A_o            : out   std_logic_Vector(DATA_WIDTH-1 downto 0); -- Read data
      WREN_A_i             : in    std_logic;                               -- Write enable
      WDATA_A_i            : in    std_logic_Vector(DATA_WIDTH-1 downto 0); -- Write data

      -- Interface B
      CLK_B_i              : in    std_logic;                               -- Read and write clock
      ADDR_B_i             : in    std_logic_vector(ADDR_WIDTH-1 downto 0); -- Read and write address
      EN_B_i               : in    std_logic;                               -- Port enable
      RDATA_B_o            : out   std_logic_Vector(DATA_WIDTH-1 downto 0); -- Read data
      WREN_B_i             : in    std_logic;                               -- Write enable
      WDATA_B_i            : in    std_logic_Vector(DATA_WIDTH-1 downto 0)  -- Write data
   );
end memory;

architecture Behavioral of memory is

-- Attributes

-- Types and definitions
constant gnd            : std_logic := '0';
constant vcc            : std_logic := '1';

type data_array is array (natural range<>) of std_logic_vector(DATA_WIDTH-1 downto 0);

-- Internal signals
                                                                     -- Memory array
shared variable memory  : data_array(2**ADDR_WIDTH-1 downto 0) := (others => (others => '0')); 

begin


   process (CLK_A_i)
   begin
      if CLK_A_i'event and CLK_A_i = CLK_A_EDGE then
         if EN_A_i = '1' then
            RDATA_A_o <= memory(conv_integer(ADDR_A_i));
            if WREN_A_i = '1' then
               memory(conv_integer(ADDR_A_i)) := WDATA_A_i;
            end if;
         end if;
      end if;
   end process;

   process (CLK_B_i)
   begin
      if CLK_B_i'event and CLK_B_i = CLK_B_EDGE then
         if EN_B_i = '1' then
            RDATA_B_o <= memory(conv_integer(ADDR_B_i));
            if WREN_B_i = '1' then
               memory(conv_integer(ADDR_B_i)) := WDATA_B_i;
            end if;
          end if;
       end if;
   end process;

end Behavioral;
