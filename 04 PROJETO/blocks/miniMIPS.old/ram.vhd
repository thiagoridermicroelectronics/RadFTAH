library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.pack_mips.all;


entity ram is
   generic (mem_size : natural := 8192;  -- Size of the memory in words
            latency : time := 10 ns);
   port(
       req         	: in std_logic;
       adr         	: in bus32;
       data_inout  	: inout bus32;
       
        -- Caco
        mem_data_in  : in bus32;
--        mem_data_out : out bus32;
        --       
       
       r_w         	: in std_logic;
       ready       	: out std_logic;
       reset		: in std_logic;
       clock		: in std_logic
   );
end;


architecture bench of ram is

   component ramxil
       port (
       addr: IN std_logic_VECTOR(23 downto 0);
       clk: IN std_logic;
       din: IN std_logic_VECTOR(31 downto 0);
       dout: OUT std_logic_VECTOR(31 downto 0);
       we: IN std_logic);
   end component;
   
   signal addr_temp : std_logic_vector (23 downto 0);
   signal teste : std_logic_vector(31 downto 0);
--   signal clock_not : std_logic;

begin

--clock_not <= NOT clock;

addr_temp(23 downto 0) <= "00" & adr(23 downto 2);

ram_xilinx : ramxil
        port map (
            addr => addr_temp(23 downto 0),
            clk => clock, --clock_not,
            din => mem_data_in, --data_inout(31 downto 0),
            dout => data_inout,
            we => r_w);

--with r_w select 
--data_inout <= "000000000000000000000000" & data_out_temp(7 downto 0) when '0',
--data_inout when others;

--process (reset,adr, r_w) --, clock)
--begin
      ready <= '1'; -- , '1';  after latency;
--end process;

end bench;

