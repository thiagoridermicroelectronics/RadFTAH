-- =================================================================================
-- Project          :  MIPS Multi-core
-- FileName         :  icache.vhd
-- FileType         :  VHDL - Source code
-- Author           :  Jorge Tortato Junior, UFPR
-- Reviewer         :  -x-x-x-x-
-- Version          :  0.1 from 22/oct/2008
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

library work;
   use work.utils_pkg.all;

-- Entity declaration
entity icache is
   generic (
      CACHE_SIZE : integer := 2048;                                         -- Size of cache - in bytes 
      LINE_SIZE  : integer := 8;                                            -- Line size - in bytes
      DATA_WIDTH : integer := 32;                                           -- Read data widht - in bits
      ADDR_WIDTH : integer := 32                                            -- Number of cached memory address bits
   );
   port (
      -- System Interface
      RST_i                : in    std_logic;                               -- Reset - active high

      -- Bus interface
      BUS_CLK_i            : in    std_logic;                               -- Bus control clock
      BUS_REQ_o            : out   std_logic;                               -- Bus request
      BUS_RGRANT_o         : out   std_logic;                               -- Bus grant request
      BUS_GRANT_i          : in    std_logic;                               -- Bus grant ack
      BUS_LAST_o           : out   std_logic;                               -- Bus last request indication
      BUS_ACK_i            : in    std_logic;                               -- Bus acknowledge
      BUS_VAL_i            : in    std_logic;                               -- Bus data valid
      BUS_RD_o             : out   std_logic;                               -- Bus read
      BUS_WR_o             : out   std_logic;                               -- Bus write
      BUS_ADDR_o           : out   std_logic_vector(ADDR_WIDTH-1 downto 0); -- Bus address
      BUS_DATA_i           : in    std_logic_vector(DATA_WIDTH-1 downto 0); -- Bus data input
      BUS_DATA_o           : out   std_logic_vector(DATA_WIDTH-1 downto 0); -- Bus data output

      -- Core interface
      CORE_CLK_i           : in    std_logic;                               -- Core clock
      CORE_ADDR_i          : in    std_logic_vector(ADDR_WIDTH-1 downto 0); -- Core address
      CORE_DATA_o          : out   std_logic_vector(DATA_WIDTH-1 downto 0); -- Core data
      CORE_STOP_o          : out   std_logic;                               -- Core stop
      CORE_CLR_o           : out   std_logic;                               -- Core clear
      cache_miss_o         : out   std_logic
   );
end icache;

architecture Behavioral of icache is

-- Attributes

-- Types and definitions
constant gnd            : std_logic  := '0';
constant vcc            : std_logic  := '1';

-- Internal signals
signal   wtagaddr       : std_logic_vector(ADDR_WIDTH-1 downto 0);
signal   wupdate        : std_logic;
signal   wstatus        : std_logic;
signal   hit            : std_logic;
signal   miss           : std_logic;
signal   wdataaddr      : std_logic_vector(ADDR_WIDTH-1 downto 0);
signal   wen            : std_logic;
signal   wdata          : std_logic_vector(DATA_WIDTH-1 downto 0);

begin

   CORE_STOP_o <= miss;

   cache_miss_o <= miss;

   icache_tag_inst : entity work.icache_tag
      generic map (
         CACHE_SIZE  => CACHE_SIZE,
         LINE_SIZE   => LINE_SIZE,
         ADDR_WIDTH  => ADDR_WIDTH
      )
      port map (
         RST_i       => RST_i,
         WCLK_i      => BUS_CLK_i,
         WADDR_i     => wtagaddr,
         WUPDATE_i   => wupdate,
         WSTATUS_i   => wstatus,
         RCLK_i      => CORE_CLK_i,
         RADDR_i     => CORE_ADDR_i,
         HIT_o       => hit,
         MISS_o      => miss
      );

   icache_data_inst : entity work.icache_data
      generic map (
         CACHE_SIZE  => CACHE_SIZE,
         LINE_SIZE   => LINE_SIZE,
         DATA_WIDTH  => DATA_WIDTH,
         ADDR_WIDTH  => ADDR_WIDTH
      )
      port map (
         RST_i       => RST_i,
         WCLK_i      => BUS_CLK_i,
         WADDR_i     => wdataaddr,
         WEN_i       => wen,
         WDATA_i     => wdata,
         RCLK_i      => CORE_CLK_i,
         RADDR_i     => CORE_ADDR_i,
         RDATA_o     => CORE_DATA_o
   );

   icache_loader_inst : entity work.icache_loader
      generic map (
         CACHE_SIZE  => CACHE_SIZE,
         LINE_SIZE   => LINE_SIZE,
         DATA_WIDTH  => DATA_WIDTH,
         ADDR_WIDTH  => ADDR_WIDTH
      )
      port map (
         RST_i       => RST_i,
         BUS_CLK_i   => BUS_CLK_i,
         BUS_REQ_o   => BUS_REQ_o,
         BUS_RGRANT_o=> BUS_RGRANT_o,
         BUS_GRANT_i => BUS_GRANT_i,
         BUS_LAST_o  => BUS_LAST_o,
         BUS_ACK_i   => BUS_ACK_i,
         BUS_VAL_i   => BUS_VAL_i,
         BUS_RD_o    => BUS_RD_o,
         BUS_WR_o    => BUS_WR_o,
         BUS_ADDR_o  => BUS_ADDR_o,
         BUS_DATA_i  => BUS_DATA_i,
         BUS_DATA_o  => BUS_DATA_o,
         MISS_i      => miss,
         MISS_ADDR_i => CORE_ADDR_i,
         WDATAADDR_o => wdataaddr,
         WEN_o       => wen,
         WDATA_o     => wdata,
         WTAGADDR_o  => wtagaddr,
         WUPDATE_o   => wupdate,
         WSTATUS_o   => wstatus
      );

end Behavioral;
