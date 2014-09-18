library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity flash_mem is
   generic (
      SIZE        : integer := 1024;            -- Size of the memory in words
      START_ADDR  : integer := 0;               -- Start addres
      DATA_WIDTH  : integer := 32;              -- Data width
      ADDR_WIDTH  : integer := 32;              -- Address width
      LATENCY     : time    := 0 ns;            -- Memory latency
      INIT_FILE   : string  := "program.bin"        -- Init file
   );
   port(
      RST_i       : in     std_logic;                                -- Input reset
      MEM_CSn_i   : in     std_logic;                                -- Chip select
      MEM_RWn_i   : in     std_logic;                                -- 0 = Write, 1 = Read
      MEM_ADDR_i  : in     std_logic_vector(ADDR_WIDTH-1 downto 0);  -- Address
      MEM_DATA_io : inout  std_logic_vector(DATA_WIDTH-1 downto 0)   -- IO data
   );
end;


architecture bench of flash_mem is
    type flash_array is array(natural range START_ADDR to START_ADDR+4*SIZE - 1) of std_logic_vector(7 downto 0);
    signal flash : flash_array := (others => (others => '0'));       -- The memory
begin

   process (RST_i)
   type bin is file of integer;                                      -- Binary type file
   file load_file      : bin;                                        -- flash_mem load file handler
   variable c          : integer ;                                   -- Integer (32 bits) read in the file
   variable index      : integer range flash'range;                  -- Index for loading
   variable word       : std_logic_vector(31 downto 0);              -- Word read in the file
   variable status     : file_open_status;                           -- File open status
   begin

      if RST_i'event and RST_i = '0' then
         file_open(status, load_file, INIT_FILE, read_mode);
         if status=open_ok then
            while not endfile(load_file) loop
               index := 0;
               while not endfile(load_file) and (index<=flash'high) loop
                  read(load_file, c);
                  word := conv_std_logic_vector(c,32);
                  for i in 0 to 3 loop
                     flash(index+i) <= word(8*(i+1)-1 downto 8*i);
                  end loop;
                  index := index + 4;
               end loop;
            end loop;
            file_close(load_file);
         else
            assert false
               report "Not possible to open file"
               severity failure;
         end if;
      end if;
   end process;

   -- Request for reading the flash_mem
   process(MEM_CSn_i, MEM_RWn_i, MEM_ADDR_i, RST_i)
   variable adr : integer;
   begin
      if MEM_CSn_i = '0' and RST_i = '0' then
         adr := conv_integer(MEM_ADDR_i(30 downto 0));
         if MEM_RWn_i = '1'then
            if (adr >= flash'low) and (adr<=flash'high) then
               for i in 0 to 3 loop
                  MEM_DATA_io(8*(i+1)-1 downto 8*i) <= flash(adr+3-i) after LATENCY;
               end loop;
            else
               MEM_DATA_io <= (others => 'Z');
            end if;
         else
            MEM_DATA_io <= (others => 'Z');
         end if;
      else
         MEM_DATA_io <= (others => 'Z');
      end if;
   end process;

end bench;
