--                                                                      --
--        miniMIPS Processor : Instruction extraction stage             --

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.pack_mips.all;

entity pps_ei is
port (
  clock : in std_logic;
  reset : in std_logic;
  clear : in std_logic;    -- Clear the pipeline stage
  stop_all : in std_logic; -- Evolution locking signal
  
  -- Asynchronous inputs
  stop_ei : in std_logic;  -- Lock the EI_adr and Ei_instr registers

  -- Bus controler interface
  CTE_instr : in bus32;    -- Instruction from the memory
  ETC_adr : out bus32;     -- Address to read in memory

  -- Synchronous inputs from PF stage
  PF_pc : in bus32;        -- Current value of the pc

  -- Synchronous outputs to DI stage
  EI_instr : out bus32;    -- Read interface
  EI_adr : out bus32;      -- Address from the read instruction
  EI_it_ok : out std_logic -- Allow hardware interruptions
);
end pps_ei;

architecture rtl of pps_ei is

	signal t_EI_instr :  bus32;    -- Read interface
  signal t_EI_adr :  bus32;      -- Address from the read instruction
  signal t_EI_it_ok :  std_logic; -- Allow hardware interruptions

begin

  ETC_adr <= PF_pc; -- Connexion of the PC to the memory address bus

  -- Set the results
  process (clock)
  begin
    if (clock='1' and clock'event) then
      if reset='1' then
        t_EI_instr <= INS_NOP;
        t_EI_adr <= (others => '0');
        t_EI_it_ok <= '0';
      elsif stop_all='0' then
        if clear='1' then
          -- Clear the stage
          t_EI_instr <= INS_NOP;
          t_EI_it_ok <= '0';
        elsif stop_ei='0' then
          -- Normal evolution
          t_EI_adr <= PF_pc;
          t_EI_instr <= CTE_instr;
          t_EI_it_ok <= '1';
        else
           t_EI_instr  <= t_EI_instr; 
           t_EI_adr 	 <= t_EI_adr;  
           t_EI_it_ok  <= t_EI_it_ok; 
        end if;
      else
         t_EI_instr  <= t_EI_instr; 
         t_EI_adr 	 <= t_EI_adr;  
         t_EI_it_ok  <= t_EI_it_ok; 
      end if;
    end if;
  end process;
  
  EI_instr  <= t_EI_instr;
  EI_adr 	  <= t_EI_adr;
  EI_it_ok  <= t_EI_it_ok;  
  
end rtl;
