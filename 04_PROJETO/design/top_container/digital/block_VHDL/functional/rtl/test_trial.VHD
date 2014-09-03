library ieee;
use ieee.std_logic_1164.all;

entity test_trial is
end test_trial;

architecture tb_arch of test_trial is

component trial
port (
	request_data : in std_logic;
	ttl_clock_n : in std_logic;
	count0 : out std_logic
);

end component;

signal request_data : std_logic;
signal ttl_clock_n : std_logic ;
signal count0 : std_logic ;

begin

UUT : trial
	port map
		(
 		request_data => request_data,
		ttl_clock_n => ttl_clock_n,
		count0 => count0
                );

--Add your stimulus here..

request_data <= '1' after 10 ns, '0' after 100 ns, '1' after 250 ns;
ttl_clock_n <= '1' after 25 ns, '0' after 50 ns, '1' after 80 ns, '0' after 300 ns;

end tb_arch;
