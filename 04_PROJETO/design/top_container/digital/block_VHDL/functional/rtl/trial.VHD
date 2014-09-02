library IEEE;
use IEEE.std_logic_1164.all;

entity trial is
  port(
	request_data : in std_logic;
	ttl_clock_n : in std_logic;

	count0 : out std_logic
      );
end trial;

architecture trial_rtl of trial is

begin

count0 <= not(request_data and ttl_clock_n);

end trial_rtl;
