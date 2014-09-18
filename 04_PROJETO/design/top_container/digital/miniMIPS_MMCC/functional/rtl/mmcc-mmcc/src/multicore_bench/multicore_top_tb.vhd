-- =================================================================================
-- Project          :  MIPS Multi-core testbench
-- FileName         :  multicore_top_tb.vhd
-- FileType         :  VHDL - Source code
-- Author           :  Jorge Tortato Junior, UFPR
-- Reviewer         :  -x-x-x-x-
-- Version          :  0.1 from 25/nov/2008
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
   use ieee.std_logic_textio.all;

library std;
   use std.textio.all;

library work;
   use work.utils_pkg.all;

entity multicore_top_tb is
end;

architecture multicore_top_tb of multicore_top_tb is

   signal CLOCK_i     : std_logic := '0';
   signal CLOCK2X_i   : std_logic := '0';
   signal RST_i       : std_logic;

   -- Memory controller
   signal BUS_CLK_i   : std_logic := '0';                 -- Bus control clock
   signal PER_CSn_o   : std_logic;                        -- Chip select
   signal PER_RWn_o   : std_logic;                        -- 0 = Write, 1 = Read
   signal PER_ADDR_o  : std_logic_vector(31 downto 0);    -- Address
   signal PER_DATA_o  : std_logic_vector(31 downto 0);    -- Output data
   signal PER_DATA_i  : std_logic_vector(31 downto 0);    -- Input data
   signal MEM_CSn_o   : std_logic;                        -- Chip select
   signal MEM_RWn_o   : std_logic;                        -- 0 = Write, 1 = Read
   signal MEM_ADDR_o  : std_logic_vector(31 downto 0);    -- Address
   signal MEM_DATA_io : std_logic_vector(31 downto 0);    -- IO data
   signal MEM_DATA_o  : std_logic_vector(31 downto 0);    -- Output data
   signal MEM_DATA_i  : std_logic_vector(31 downto 0);    -- Input data
   signal ZBT_DQ_io   : std_logic_vector(31 downto 0);
   signal ZBT_DQ_z    : std_logic_vector(3 downto 0) := X"0";
   signal ZBT_ADDR_o  : std_logic_vector(31 downto 0);
   signal ZBT_LBOn_o  : std_logic;
   signal ZBT_CLK_o   : std_logic;
   signal ZBT_CKEn_o  : std_logic;
   signal ZBT_LDn_o   : std_logic;
   signal ZBT_BWn_o   : std_logic_vector(3 downto 0);
   signal ZBT_RWn_o   : std_logic;
   signal ZBT_CEn_o   : std_logic;
   signal ZBT_OEn_o   : std_logic;
   signal ZBT_CE2_o   : std_logic;
   signal ZBT_CE2n_o  : std_logic;
   signal ZBT_ZZ_o    : std_logic;
   signal RAM_CSn_o   : std_logic;                        -- Chip select
   signal RAM_RWn_o   : std_logic;                        -- 0 = Write, 1 = Read
   signal RAM_ADDR_o  : std_logic_vector(31 downto 0);    -- Address
   signal RAM_DATA_io : std_logic_vector(31 downto 0);    -- IO data
   signal RAM_DATA_o  : std_logic_vector(31 downto 0);    -- Output data
   signal RAM_DATA_i  : std_logic_vector(31 downto 0);    -- Input data

   signal string_out  : string(1024 downto 1);

begin

   multicore_inst : entity work.multicore_top
      port map (
         CLOCK2X_i   => CLOCK2X_i,
         CLOCK_i     => CLOCK_i,
         RST_i       => RST_i,
         BUS_CLK_i   => BUS_CLK_i,
         PER_CSn_o   => PER_CSn_o,
         PER_RWn_o   => PER_RWn_o,
         PER_ADDR_o  => PER_ADDR_o ,
         PER_DATA_o  => PER_DATA_o,
         PER_DATA_i  => PER_DATA_i,
         MEM_CSn_o   => MEM_CSn_o,
         MEM_RWn_o   => MEM_RWn_o,
         MEM_ADDR_o  => MEM_ADDR_o ,
         MEM_DATA_o  => MEM_DATA_o,
         MEM_DATA_i  => MEM_DATA_i,
         RAM_CSn_o   => RAM_CSn_o,
         RAM_RWn_o   => RAM_RWn_o,
         RAM_ADDR_o  => RAM_ADDR_o,
         RAM_DATA_o  => RAM_DATA_o,
         RAM_DATA_i  => RAM_DATA_i
   );

   flash_inst : entity work.flash_mem
      generic map (
         SIZE        => 16#10000#,
         START_ADDR  => 0,
         DATA_WIDTH  => 32,
         ADDR_WIDTH  => 32,
         LATENCY     => 5 ns,
         INIT_FILE   => "program.bin"
      )
      port map (
         RST_i       => RST_i,
         MEM_CSn_i   => MEM_CSn_o,
         MEM_RWn_i   => MEM_RWn_o,
         MEM_ADDR_i  => MEM_ADDR_o,
         MEM_DATA_io => MEM_DATA_io
   );

   MEM_DATA_io <= (others => 'Z') when MEM_RWn_o = '1' else
                  MEM_DATA_o;

   MEM_DATA_i  <= MEM_DATA_io;

   sram_inst : entity work.sram_mem
      generic map (
         SIZE        => 16#12000#,
         START_ADDR  => 16#10000#,
         DATA_WIDTH  => 32,
         ADDR_WIDTH  => 32,
         LATENCY     => 5 ns
      )
      port map (
         RST_i       => RST_i,
         MEM_CSn_i   => RAM_CSn_o,
         MEM_RWn_i   => RAM_RWn_o,
         MEM_ADDR_i  => RAM_ADDR_o,
         MEM_DATA_io => RAM_DATA_io
   );

   RAM_DATA_io <= (others => 'Z') when RAM_RWn_o = '1' else
                  RAM_DATA_o;

   RAM_DATA_i  <= RAM_DATA_io;

   CLOCK_i   <= not CLOCK_i after 20 ns;
   CLOCK2X_i <= not CLOCK2X_i after 10 ns;
   BUS_CLK_i <= not BUS_CLK_i after 20 ns;

   process
   begin
      RST_i <= '1';
      wait for 100 ns;
      wait until CLOCK2X_i'event and CLOCK2X_i = '1';
      RST_i <= '0';
      wait;
   end process;

end multicore_top_tb;
