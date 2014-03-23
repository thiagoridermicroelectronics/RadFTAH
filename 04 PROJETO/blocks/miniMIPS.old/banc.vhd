--                                                                      --
--               miniMIPS Processor : Register bank                     --

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.pack_mips.all;

entity banc is
port (
       clock : in bus1;
       reset : in bus1;

       -- Register addresses to read
       reg_src1 : in bus5;
       reg_src2 : in bus5;

       -- Register address to write and its data
       reg_dest : in bus5;
       donnee   : in bus32;

       -- Write signal
       cmd_ecr  : in bus1;

       -- Bank outputs
       data_src1 : out bus32;
       data_src2 : out bus32
     );
end banc;


architecture rtl of banc is

    -- The register bank
    type tab_reg is array (1 to 31) of bus32;
    signal registres, registres_input : tab_reg;
    signal adr_src1 : integer range 0 to 31;
    signal adr_src2 : integer range 0 to 31;
    signal adr_dest : integer range 0 to 31;
begin

    adr_src1 <= to_integer(unsigned(reg_src1));
    adr_src2 <= to_integer(unsigned(reg_src2));
    adr_dest <= to_integer(unsigned(reg_dest));


    data_src1 <= (others => '0') when adr_src1=0 else
                 registres(adr_src1);
    data_src2 <= (others => '0') when adr_src2=0 else
                 registres(adr_src2);

process (clock)
	begin
	  if clock = '1' and clock'event then
            if reset='1' then
			 for i in 1 to 31 loop
                    registres_input(i) <= (others => '0');
                end loop;
			else
				for i in 1 to 31 loop
                registres_input(i) <= registres(i);
				end loop;
				if  cmd_ecr = '1' and adr_dest /= 0 then
				registres_input(adr_dest) <= donnee;
				end if;
			end if;
	 end if;
	 for i in 1 to 31 loop
        registres(i) <= registres_input(i);
     end loop;
	end process; 

end rtl;
