-- =================================================================================
-- Project          :  MIPS Multi-core
-- FileName         :  bus_mux.vhd
-- FileType         :  VHDL - Source code
-- Author           :  Jorge Tortato Junior, UFPR
-- Reviewer         :  -x-x-x-x-
-- Version          :  0.1 from 10/nov/2008
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
entity bus_mux is
   generic (
      IF_NUM      : integer := 2;                                          -- Number of interfaces
      SNOOP_NUM   : integer := 1;                                          -- Number of snoop interfaces
      CTRL_NUM    : integer := 2                                           -- Number of controllers
   );
   port (
      -- System Interface
      RST_i                : in    std_logic;                              -- Reset - active high
      BUS_CLK_i            : in    std_logic;                              -- Bus control clock

      BUS_RLOCK_i          : in    std_logic_vector(IF_NUM/2-1 downto 0);  -- Bus lock request
      BUS_LOCK_o           : out   std_logic_vector(IF_NUM/2-1 downto 0);  -- Bus lock acknowledge

      -- Bus interfaces
      BUS_GRANT_o          : out   std_logic_vector(IF_NUM-1 downto 0);    -- Bus grant
      BUS_RGRANT_i         : in    std_logic_vector(IF_NUM-1 downto 0);    -- Bus grant request
      BUS_MATCH_o          : out   slv2vec(IF_NUM-1 downto 0);             -- Bus match type
      BUS_REQ_i            : in    std_logic_vector(IF_NUM-1 downto 0);    -- Bus request
      BUS_LAST_i           : in    std_logic_vector(IF_NUM-1 downto 0);    -- Bus last request indication
      BUS_ACK_o            : out   std_logic_vector(IF_NUM-1 downto 0);    -- Bus acknowledge
      BUS_VAL_o            : out   std_logic_vector(IF_NUM-1 downto 0);    -- Bus data valid
      BUS_RD_i             : in    std_logic_vector(IF_NUM-1 downto 0);    -- Bus read
      BUS_RDX_i            : in    std_logic_vector(IF_NUM-1 downto 0);    -- Bus read exclusive
      BUS_WR_i             : in    std_logic_vector(IF_NUM-1 downto 0);    -- Bus write
      BUS_ADDR_i           : in    slv32vec(IF_NUM-1 downto 0);            -- Bus address
      BUS_DATA_o           : out   slv32vec(IF_NUM-1 downto 0);            -- Bus data input
      BUS_DATA_i           : in    slv32vec(IF_NUM-1 downto 0);            -- Bus data output

      -- Controller interfaces
      CTRL_SEL_i           : in    std_logic_vector(CTRL_NUM-1 downto 0);  -- Controller selection
      CTRL_REQ_o           : out   std_logic_vector(CTRL_NUM-1 downto 0);  -- Controller request
      CTRL_LAST_o          : out   std_logic_vector(CTRL_NUM-1 downto 0);  -- Controller last request indication
      CTRL_ACK_i           : in    std_logic_vector(CTRL_NUM-1 downto 0);  -- Controller acknowledge
      CTRL_VAL_i           : in    std_logic_vector(CTRL_NUM-1 downto 0);  -- Controller data valid
      CTRL_RD_o            : out   std_logic_vector(CTRL_NUM-1 downto 0);  -- Controller read
      CTRL_WR_o            : out   std_logic_vector(CTRL_NUM-1 downto 0);  -- Controller write
      CTRL_ADDR_o          : out   slv32vec(CTRL_NUM-1 downto 0);          -- Controller address
      CTRL_DATA_i          : in    slv32vec(CTRL_NUM-1 downto 0);          -- Controller data input
      CTRL_DATA_o          : out   slv32vec(CTRL_NUM-1 downto 0);          -- Controller data output

      -- Snoop interfaces
      SNOOP_GRANT_o        : out   std_logic_vector(SNOOP_NUM-1 downto 0); -- Snoop granted indication
      SNOOP_SEL_i          : in    std_logic_vector(SNOOP_NUM-1 downto 0); -- Snoop selection
      SNOOP_MATCH_i        : in    slv2vec(SNOOP_NUM-1 downto 0);          -- Snoop match type
      SNOOP_REQ_o          : out   std_logic_vector(SNOOP_NUM-1 downto 0); -- Snoop request
      SNOOP_LAST_o         : out   std_logic_vector(SNOOP_NUM-1 downto 0); -- Snoop last request indication
      SNOOP_ACK_i          : in    std_logic_vector(SNOOP_NUM-1 downto 0); -- Snoop acknowledge
      SNOOP_VAL_i          : in    std_logic_vector(SNOOP_NUM-1 downto 0); -- Snoop data valid
      SNOOP_RD_o           : out   std_logic_vector(SNOOP_NUM-1 downto 0); -- Snoop read
      SNOOP_RDX_o          : out   std_logic_vector(SNOOP_NUM-1 downto 0); -- Snoop read exclusive
      SNOOP_WR_o           : out   std_logic_vector(SNOOP_NUM-1 downto 0); -- Snoop write
      SNOOP_ADDR_o         : out   slv32vec(SNOOP_NUM-1 downto 0);         -- Snoop address
      SNOOP_DATA_i         : in    slv32vec(SNOOP_NUM-1 downto 0);         -- Snoop data input
      SNOOP_DATA_o         : out   slv32vec(SNOOP_NUM-1 downto 0)          -- Snoop data output
   );
end bus_mux;

architecture Behavioral of bus_mux is

-- Attributes

-- Types and definitions
constant gnd            : std_logic  := '0';
constant vcc            : std_logic  := '1';

-- Internal signals
signal sel_integer      : integer range 0 to max_int(CTRL_NUM, SNOOP_NUM)-1;
signal grant_integer    : integer range 0 to IF_NUM-1;
signal grant_int        : std_logic_vector(IF_NUM-1 downto 0);
signal granted          : std_logic;
signal ctrl_sel         : std_logic;
signal snoop_sel        : std_logic;
signal bus_rgrant_int   : std_logic_vector(IF_NUM-1 downto 0);

signal bus_rlock_int    : std_logic_vector(IF_NUM/2-1 downto 0);
signal lock_int         : std_logic_vector(IF_NUM/2-1 downto 0);
signal locked           : std_logic;
signal lock_integer     : integer range 0 to IF_NUM/2-1;

begin

   bus_gen : for i in 0 to IF_NUM-1 generate
      BUS_ACK_o(i)  <= CTRL_ACK_i(sel_integer) when grant_int(i) = '1' and ctrl_sel = '1' else
                       SNOOP_ACK_i(sel_integer) when grant_int(i) = '1' and snoop_sel = '1' else
                       '0';
      BUS_VAL_o(i)  <= CTRL_VAL_i(sel_integer) when grant_int(i) = '1' and ctrl_sel = '1' else
                       SNOOP_VAL_i(sel_integer) when grant_int(i) = '1' and snoop_sel = '1' else
                       '0';
      BUS_DATA_o(i) <= CTRL_DATA_i(sel_integer) when ctrl_sel = '1' else
                       SNOOP_DATA_i(sel_integer) when snoop_sel = '1' else
                       (others => '0');
      BUS_MATCH_o(i)<= SNOOP_MATCH_i(sel_integer) when snoop_sel = '1' else
                       COHER_EXCLUSIVE;
   end generate;

   ctrl_gen : for i in 0 to CTRL_NUM-1 generate
      CTRL_REQ_o(i)  <= BUS_REQ_i(grant_integer) when CTRL_SEL_i(i) = '1' and ctrl_sel = '1' else
                        '0';
      CTRL_LAST_o(i) <= BUS_LAST_i(grant_integer) when CTRL_SEL_i(i) = '1' else
                        '0';
      CTRL_RD_o(i)   <= BUS_RD_i(grant_integer);
      CTRL_WR_o(i)   <= BUS_WR_i(grant_integer);
      CTRL_ADDR_o(i) <= BUS_ADDR_i(grant_integer);
      CTRL_DATA_o(i) <= BUS_DATA_i(grant_integer);
   end generate;

   BUS_GRANT_o <= grant_int;

   snoop_gen : for i in 0 to SNOOP_NUM-1 generate
      SNOOP_ADDR_o(i)  <= BUS_ADDR_i(grant_integer);
      SNOOP_DATA_o(i)  <= BUS_DATA_i(grant_integer);
      SNOOP_GRANT_o(i) <= granted;
      SNOOP_REQ_o(i)   <= BUS_REQ_i(grant_integer) when SNOOP_SEL_i(i) = '1' and snoop_sel = '1' else
                          '0';
      SNOOP_LAST_o(i)  <= BUS_LAST_i(grant_integer) when SNOOP_SEL_i(i) = '1' and snoop_sel = '1' else
                          '0';
      SNOOP_RD_o(i)    <= BUS_RD_i(grant_integer) when SNOOP_SEL_i(i) = '1' and snoop_sel = '1' else
                          '0';
      SNOOP_RDX_o(i)   <= BUS_RDX_i(grant_integer) when SNOOP_SEL_i(i) = '1' and snoop_sel = '1' else
                          '0';
      SNOOP_WR_o(i)    <= BUS_WR_i(grant_integer) when SNOOP_SEL_i(i) = '1' and snoop_sel = '1' else
                          '0';
   end generate;

   process(BUS_CLK_i)
   begin
      if BUS_CLK_i'event and BUS_CLK_i = '1' then
         if RST_i = '1' then
            grant_int     <= (others => '0');
            bus_rgrant_int<= (others => '0');
            sel_integer   <= 0;
            grant_integer <= 0;
            granted       <= '0';
            ctrl_sel      <= '0';
            snoop_sel     <= '0';
         else
            if granted = '0' then
               for i in 0 to IF_NUM-1 loop
                  if (bus_rgrant_int(i) = '1' and locked = '0') or
                     (bus_rgrant_int(i) = '1' and lock_int(i/2) = '1') then
                     grant_int     <= (others => '0');
                     grant_int(i)  <= '1';
                     grant_integer <= i;
                     granted       <= '1';
                  end if;
               end loop;
               bus_rgrant_int <= BUS_RGRANT_i;
               snoop_sel <= '0';
               ctrl_sel  <= '0';
            else
               if BUS_RGRANT_i(grant_integer) = '0' then
                  granted   <= '0';
                  grant_int <= (others => '0');
                  snoop_sel <= '0';
                  ctrl_sel  <= '0';
               else
                  snoop_sel <= '0';
                  ctrl_sel  <= '0';
                  for i in 0 to CTRL_NUM-1 loop
                     if CTRL_SEL_i(i) = '1' then
                        sel_integer <= i;
                        ctrl_sel    <= granted;
                     end if;
                  end loop;
                  for i in 0 to SNOOP_NUM-1 loop
                     if SNOOP_SEL_i(i) = '1' then
                        sel_integer <= i;
                        snoop_sel   <= granted;
                        ctrl_sel    <= '0';
                     end if;
                  end loop;
               end if;
               bus_rgrant_int<= (others => '0');
            end if;
         end if;
      end if;
   end process;


   process(BUS_CLK_i)
   begin
      if BUS_CLK_i'event and BUS_CLK_i = '1' then
         if RST_i = '1' then
            bus_rlock_int <= (others => '0');
            lock_int      <= (others => '0');
            locked        <= '0';
            lock_integer  <= 0;
            BUS_LOCK_o    <= (others => '0');
         else
            if locked = '0' then
               for i in 0 to IF_NUM/2-1 loop
                  if bus_rlock_int(i) = '1' then
                     lock_int     <= (others => '0');
                     lock_int(i)  <= '1';
                     locked       <= '1';
                     lock_integer <= i;
                  end if;
               end loop;
               bus_rlock_int <= BUS_RLOCK_i;
            else
               if BUS_RLOCK_i(lock_integer) = '0' then
                  locked    <= '0';
                  lock_int  <= (others => '0');
                  BUS_LOCK_o<= (others => '0');
               end if;
               if granted = '0' then
                  BUS_LOCK_o <= lock_int;
               end if;
            end if;
         end if;
      end if;
   end process;

end Behavioral;