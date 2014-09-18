library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity sram_mem is
   generic (
      SIZE        : integer := 1024;                                 -- Size of the memory in words
      START_ADDR  : integer := 0;                                    -- Start addres
      DATA_WIDTH  : integer := 32;                                   -- Data width
      ADDR_WIDTH  : integer := 32;                                   -- Address width
      LATENCY     : time    := 0 ns                                  -- Memory latency
   );
   port(
      RST_i       : in     std_logic;                                -- Input reset
      MEM_CSn_i   : in     std_logic;                                -- Chip select
      MEM_RWn_i   : in     std_logic;                                -- 0 = Write, 1 = Read
      MEM_ADDR_i  : in     std_logic_vector(ADDR_WIDTH-1 downto 0);  -- Address
      MEM_DATA_io : inout  std_logic_vector(DATA_WIDTH-1 downto 0)   -- IO data
   );
end;


architecture bench of sram_mem is
    type sram_array is array(natural range START_ADDR to START_ADDR+4*SIZE - 1) of std_logic_vector(7 downto 0);
    signal sram : sram_array := (others => (others => '0'));         -- The memory
begin

   -- Request for reading the sram_mem
   process(MEM_CSn_i, MEM_RWn_i, MEM_ADDR_i, RST_i, MEM_DATA_io)
   variable adr : integer;
   begin
      if RST_i = '1' then
         MEM_DATA_io <= (others => 'Z');
         sram        <= (others => (others => '0'));
      else
         if MEM_CSn_i = '0' then
            adr := conv_integer(MEM_ADDR_i(30 downto 0));
            if MEM_RWn_i = '1'then
               if (adr >= sram'low) and (adr<=sram'high) then
                  for i in 0 to 3 loop
                     MEM_DATA_io(8*(i+1)-1 downto 8*i) <= sram(adr+3-i) after LATENCY;
                  end loop;
               else
                  MEM_DATA_io <= (others => 'Z');
               end if;
            else
               MEM_DATA_io    <= (others => 'Z');
               if (adr >= sram'low) and (adr<=sram'high) then
                  for i in 0 to 3 loop
                     sram(adr+3-i)  <= MEM_DATA_io(8*(i+1)-1 downto 8*i) after LATENCY;
                  end loop;
               end if;
            end if;
         else
            MEM_DATA_io <= (others => 'Z');
         end if;
      end if;
   end process;

end bench;

