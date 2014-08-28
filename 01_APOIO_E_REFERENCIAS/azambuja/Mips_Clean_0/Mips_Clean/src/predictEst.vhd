library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.pack_mips.all;


entity predictEst is
port (

    -- Datas from EX pipeline stage
    EX_bra_confirm : in std_logic;                  -- Confirm if the branch test is ok
    EX_adresse : in std_logic_vector(31 downto 0);  -- Result of the branch
   
    -- Outputs to PF pipeline stage
    PR_bra_bad : out std_logic;                     -- Defined a branch to restore from a bad prediction
    PR_bra_adr : out std_logic_vector(31 downto 0); -- New PC

   
    -- Clear the three pipeline stage : EI, DI   -- Não limpa EX (delay  slot)
    PR_clear : out std_logic
);
end entity;

architecture rtl of predictEst is
       
begin

    process( EX_adresse, EX_bra_confirm)
	
    begin
        if EX_bra_confirm = '1' then 
           PR_bra_bad <= '1';
           PR_bra_adr <= EX_adresse;
           PR_clear <= '1';
		else
			PR_bra_bad <= '0';
        	PR_clear <= '0';
        end if;
	end process;
       
end rtl;

