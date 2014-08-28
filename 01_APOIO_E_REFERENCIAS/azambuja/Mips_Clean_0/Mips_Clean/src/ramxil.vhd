
-- synopsys translate_off
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.all;

Library XilinxCoreLib;
ENTITY ramxil IS
	port (
	addr: IN std_logic_VECTOR(23 downto 0);
	clk: IN std_logic;
	din: IN std_logic_VECTOR(31 downto 0);
	dout: OUT std_logic_VECTOR(31 downto 0);
	we: IN std_logic);
END ramxil;

ARCHITECTURE ramxil_a OF ramxil IS


component wrapped_ramxil
	port (
	addr: IN std_logic_VECTOR(23 downto 0);
	clk: IN std_logic;
	din: IN std_logic_VECTOR(31 downto 0);
	dout: OUT std_logic_VECTOR(31 downto 0);
	we: IN std_logic);
end component;

-- Configuration specification 
	for all : wrapped_ramxil use entity XilinxCoreLib.blkmemsp_v5_0(behavioral)
		generic map(
			c_sinit_value => "0",
			c_reg_inputs => 0,
			c_yclk_is_rising => 0,
			c_has_en => 0,
			c_ysinit_is_high => 1,
			c_ywe_is_high => 1,
			c_ytop_addr => "1024",
			c_yprimitive_type => "4kx1",
			c_yhierarchy => "hierarchy1",
			c_has_rdy => 0,
			c_has_limit_data_pitch => 0,
			c_write_mode => 0,
			c_width => 32,
			c_yuse_single_primitive => 0,
			c_has_nd => 0,
			c_enable_rlocs => 0,
			c_has_we => 1,
			c_has_rfd => 0,
			c_has_din => 1,
			c_ybottom_addr => "0",
			c_pipe_stages => 0,
			c_yen_is_high => 1,
			c_depth => 4194304,--16777216,--,
			c_has_default_data => 0,
			c_limit_data_pitch => 8,
			c_has_sinit => 0,
			c_mem_init_file => "quick_mips.coe",
			c_default_data => "0",
			c_ymake_bmm => 0,
			c_addr_width => 24);
BEGIN


U0 : wrapped_ramxil
		port map (
			addr => addr,
			clk => clk,
			din => din,
			dout => dout,
			we => we);
END ramxil_a;

-- synopsys translate_on
