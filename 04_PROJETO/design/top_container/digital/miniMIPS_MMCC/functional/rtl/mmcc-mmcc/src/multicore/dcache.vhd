-- =================================================================================
-- Project          :  MIPS Multi-core
-- FileName         :  dcache.vhd
-- FileType         :  VHDL - Source code
-- Author           :  Jorge Tortato Junior, UFPR
-- Reviewer         :  -x-x-x-x-
-- Version          :  0.1 from 28/oct/2008
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
   use work.coherence_pkg.all;

-- Entity declaration
entity dcache is
   generic (
      CACHE_SIZE : integer := 2048;                                         -- Size of cache - in bytes 
      LINE_SIZE  : integer := 8;                                            -- Line size - in bytes
      DATA_WIDTH : integer := 32;                                           -- Read data widht - in bits
      ADDR_WIDTH : integer := 32                                            -- Number of cached memory address bits
   );
   port (
      -- System Interface
      RST_i               : in    std_logic;                               -- Reset - active high

      -- Bus interface
      BUS_CLK_i            : in    std_logic;                               -- Bus control clock
      BUS_REQ_o            : out   std_logic;                               -- Bus request
      BUS_RGRANT_o         : out   std_logic;                               -- Bus grant request
      BUS_GRANT_i          : in    std_logic;                               -- Bus grant ack
      BUS_MATCH_i          : in    std_logic_vector(1 downto 0);            -- Bus match type
      BUS_LAST_o           : out   std_logic;                               -- Bus last request indication
      BUS_ACK_i            : in    std_logic;                               -- Bus acknowledge
      BUS_VAL_i            : in    std_logic;                               -- Bus data valid
      BUS_RD_o             : out   std_logic;                               -- Bus read
      BUS_RDX_o            : out   std_logic;                               -- Bus read exclusive
      BUS_WR_o             : out   std_logic;                               -- Bus write
      BUS_ADDR_o           : out   std_logic_vector(ADDR_WIDTH-1 downto 0); -- Bus address
      BUS_DATA_i           : in    std_logic_vector(DATA_WIDTH-1 downto 0); -- Bus data input
      BUS_DATA_o           : out   std_logic_vector(DATA_WIDTH-1 downto 0); -- Bus data output

      -- Core interface
      CORE_CLK2X_i         : in    std_logic;                               -- Core clock 2x
      CORE_CLK_i           : in    std_logic;                               -- Core clock
      CORE_REQ_i           : in    std_logic;                               -- Core data request
      CORE_RW_i            : in    std_logic;                               -- Core read/write strobe
      CORE_ADDR_i          : in    std_logic_vector(ADDR_WIDTH-1 downto 0); -- Core address
      CORE_DATA_o          : out   std_logic_vector(DATA_WIDTH-1 downto 0); -- Core data - read
      CORE_DATA_i          : in    std_logic_vector(DATA_WIDTH-1 downto 0); -- Core data - write
      CORE_STOP_o          : out   std_logic;                               -- Core stop
      CORE_CLR_o           : out   std_logic;                               -- Core clear
      CORE_CACHE_EN_i      : in    std_logic;                               -- Core cache enable

      -- Snoop interface
      SNOOP_GRANT_i        : in    std_logic;                              -- Snoop granted indication
      SNOOP_SEL_o          : out   std_logic;                              -- Snoop selection
      SNOOP_MATCH_o        : out   std_logic_vector(1 downto 0);           -- Snoop match type
      SNOOP_REQ_i          : in    std_logic;                              -- Snoop request
      SNOOP_LAST_i         : in    std_logic;                              -- Snoop last request indication
      SNOOP_ACK_o          : out   std_logic;                              -- Snoop acknowledge
      SNOOP_VAL_o          : out   std_logic;                              -- Snoop data valid
      SNOOP_RD_i           : in    std_logic;                              -- Snoop read
      SNOOP_RDX_i          : in    std_logic;                              -- Snoop read exclusive
      SNOOP_WR_i           : in    std_logic;                              -- Snoop write
      SNOOP_ADDR_i         : in    std_logic_vector(31 downto 0);          -- Snoop address
      SNOOP_DATA_o         : out   std_logic_vector(31 downto 0);          -- Snoop data input
      SNOOP_DATA_i         : in    std_logic_vector(31 downto 0)           -- Snoop data output

   );
end dcache;

architecture Behavioral of dcache is

-- Attributes

-- Types and definitions
constant gnd            : std_logic  := '0';
constant vcc            : std_logic  := '1';

-- Internal signals
signal   rtagdata       : std_logic_vector(ADDR_WIDTH-log2_ceil(CACHE_SIZE)+1 downto 0);
signal   wtagaddr       : std_logic_vector(ADDR_WIDTH-1 downto 0);
signal   rdata_cache    : std_logic_vector(DATA_WIDTH-1 downto 0);
signal   wupdate        : std_logic;
signal   wstatus        : std_logic_vector(COHER_TAGWIDTH-1 downto 0);
signal   rstatus        : std_logic_vector(COHER_TAGWIDTH-1 downto 0);
signal   snoop_match    : std_logic;
signal   hit            : std_logic;
signal   miss           : std_logic;
signal   loadx          : std_logic;
signal   load           : std_logic;
signal   flush          : std_logic;
signal   bus_req        : std_logic;
signal   wdataaddr      : std_logic_vector(ADDR_WIDTH-1 downto 0);
signal   wen            : std_logic;
signal   wdata          : std_logic_vector(DATA_WIDTH-1 downto 0);
signal   rdata          : std_logic_vector(DATA_WIDTH-1 downto 0);

signal   core_wen       : std_logic;
signal   miss_d         : std_logic;
signal   miss_mask      : std_logic;

signal   tag_valid      : std_logic;
signal   nocache_done   : std_logic;

begin

   CORE_STOP_o <= miss_mask or bus_req;
   CORE_DATA_o <= rdata_cache when CORE_CACHE_EN_i = '1' else
   		  wdata;

   bus_req <= '0';

   core_wen <= CORE_RW_i and CORE_REQ_i and CORE_CACHE_EN_i and (tag_valid) and not (miss);
   --core_wen <= CORE_RW_i and CORE_REQ_i and (not flush and tag_valid); -- se bus_clk < core_clk ?

   process(CORE_CLK2X_i)
   begin
      if CORE_CLK2X_i'event and CORE_CLK2X_i = '1' then
         if RST_i = '1' then
            tag_valid <= '1';
         else
            tag_valid <= not tag_valid;
         end if;
      end if;
   end process;

   dcache_tag_inst : entity work.dcache_tag
      generic map (
         CACHE_SIZE    => CACHE_SIZE,
         LINE_SIZE     => LINE_SIZE,
         ADDR_WIDTH    => ADDR_WIDTH
      )
      port map (
         RST_i         => RST_i,
         WCLK_i        => BUS_CLK_i,
         RTAGDATA_o    => rtagdata,
         WADDR_i       => wtagaddr,
         WUPDATE_i     => wupdate,
         WSTATUS_i     => wstatus,
         RSTATUS_o     => rstatus,
         CORE_CLK_i    => CORE_CLK_i,
         CORE_ADDR_i   => CORE_ADDR_i,
         CORE_REQ_i    => CORE_REQ_i,
         CORE_RW_i     => CORE_RW_i,
         SNOOP_MATCH_o => snoop_match,
         HIT_o         => hit,
         MISS_o        => miss,
         LOADX_o       => loadx,
         LOAD_o        => load,
         FLUSH_o       => flush
      );

   dcache_data_inst : entity work.dcache_data
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
         RDATA_o     => rdata,
         CORE_REQ_i  => CORE_REQ_i,
         CORE_WEN_i  => core_wen,
         CORE_DATA_i => CORE_DATA_i,
         CORE_CLK_i  => CORE_CLK2X_i,
         CORE_ADDR_i => CORE_ADDR_i,
         CORE_DATA_o => rdata_cache
   );

   dcache_loader_inst : entity work.dcache_loader
      generic map (
         CACHE_SIZE    => CACHE_SIZE,
         LINE_SIZE     => LINE_SIZE,
         DATA_WIDTH    => DATA_WIDTH,
         ADDR_WIDTH    => ADDR_WIDTH
      )
      port map (
         RST_i         => RST_i,
         BUS_CLK_i     => BUS_CLK_i,
         BUS_REQ_o     => BUS_REQ_o,
         BUS_RGRANT_o  => BUS_RGRANT_o,
         BUS_GRANT_i   => BUS_GRANT_i,
         BUS_MATCH_i   => BUS_MATCH_i,
         BUS_LAST_o    => BUS_LAST_o,
         BUS_ACK_i     => BUS_ACK_i,
         BUS_VAL_i     => BUS_VAL_i,
         BUS_RD_o      => BUS_RD_o,
         BUS_RDX_o     => BUS_RDX_o,
         BUS_WR_o      => BUS_WR_o,
         BUS_ADDR_o    => BUS_ADDR_o,
         BUS_DATA_i    => BUS_DATA_i,
         BUS_DATA_o    => BUS_DATA_o,
         SNOOP_MATCH_i => snoop_match,
         MISS_i        => miss_d,
         LOADX_i       => loadx,
         LOAD_i        => load,
         FLUSH_i       => flush,
         MISS_ADDR_i   => CORE_ADDR_i,
         MISS_DATA_i   => CORE_DATA_i,
         MISS_RW_i     => CORE_RW_i,
         CACHE_EN_i    => CORE_CACHE_EN_i,
         NOCACHE_DONE_o=> nocache_done,
         CACHE_DATA_i  => rdata,
         CACHE_ADDR_o  => wdataaddr,
         CACHE_WEN_o   => wen,
         CACHE_DATA_o  => wdata,
         RTAGDATA_i    => rtagdata,
         WTAGADDR_o    => wtagaddr,
         WUPDATE_o     => wupdate,
         WSTATUS_o     => wstatus,
         RSTATUS_i     => rstatus,
         SNOOP_GRANT_i => SNOOP_GRANT_i,
         SNOOP_SEL_o   => SNOOP_SEL_o,
         SNOOP_MATCH_o => SNOOP_MATCH_o,
         SNOOP_REQ_i   => SNOOP_REQ_i,
         SNOOP_LAST_i  => SNOOP_LAST_i,
         SNOOP_ACK_o   => SNOOP_ACK_o,
         SNOOP_VAL_o   => SNOOP_VAL_o,
         SNOOP_RD_i    => SNOOP_RD_i,
         SNOOP_RDX_i   => SNOOP_RDX_i,
         SNOOP_WR_i    => SNOOP_WR_i,
         SNOOP_ADDR_i  => SNOOP_ADDR_i,
         SNOOP_DATA_o  => SNOOP_DATA_o,
         SNOOP_DATA_i  => SNOOP_DATA_i
      );

   miss_mask <= miss and (not nocache_done);

   process(CORE_CLK_i)
   begin
      if CORE_CLK_i'event and CORE_CLK_i = '1' then
         --if CORE_CACHE_EN_i = '1' then
         --miss_d <= miss;
            miss_d <= miss_mask;
         --else
         --   miss_d <= not nocache_done;
         --end if;
      end if;
   end process;

end Behavioral;
