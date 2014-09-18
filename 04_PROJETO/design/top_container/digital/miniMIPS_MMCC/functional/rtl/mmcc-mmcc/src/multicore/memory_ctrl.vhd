-- =================================================================================
-- Project          :  MIPS Multi-core
-- FileName         :  memory_ctrl.vhd
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
entity memory_ctrl is
   generic (
      BASE_ADDRESS : integer := 16#00000000#;                                 -- Base address
      MEM_SIZE     : integer := 16#00000000#;                                 -- Memory size
      WAIT_STATES  : integer range 0 to 255 := 2;                             -- 2 wait states by default
      DATA_WIDTH   : integer := 32;                                           -- Data width - in bits
      ADDR_WIDTH   : integer := 32                                            -- Address width - in bits
   );
   port (
      -- System Interface
      RST_i                : in     std_logic;                                -- Reset - active high

      -- Memory interface
      MEM_CSn_o            : out    std_logic;                                -- Chip select
      MEM_RWn_o            : out    std_logic;                                -- 0 = Write, 1 = Read
      MEM_ADDR_o           : out    std_logic_vector(ADDR_WIDTH-1 downto 0);  -- Address
      MEM_DATA_io          : inout  std_logic_vector(DATA_WIDTH-1 downto 0);  -- IO data

      -- Bus interface
      BUS_CLK_i            : in     std_logic;                                -- Bus control clock
      BUS_REQ_i            : in     std_logic;                                -- Bus request
      BUS_LAST_i           : in     std_logic;                                -- Bus last request indication
      BUS_ACK_o            : out    std_logic;                                -- Bus acknowledge
      BUS_VAL_o            : out    std_logic;                                -- Bus data valid
      BUS_RD_i             : in     std_logic;                                -- Bus read
      BUS_WR_i             : in     std_logic;                                -- Bus write
      BUS_ADDR_i           : in     std_logic_vector(ADDR_WIDTH-1 downto 0);  -- Bus address
      BUS_DATA_o           : out    std_logic_vector(DATA_WIDTH-1 downto 0);  -- Bus data output
      BUS_DATA_i           : in     std_logic_vector(DATA_WIDTH-1 downto 0);  -- Bus data intput
      BUS_SEL_o            : out    std_logic
   );
end memory_ctrl;

architecture Behavioral of memory_ctrl is

-- Attributes

-- Types and definitions
constant gnd               : std_logic  := '0';
constant vcc               : std_logic  := '1';

type fsm_st is (IDLE_ST, RDREQ_ST, WRREQ_ST, WRREQ2_ST);                      -- Type definition

-- Internal signals
signal cur_st              : fsm_st;                                          -- Current fsm state
signal wait_cnt            : std_logic_vector(log2_ceil(WAIT_STATES+1) downto 0);-- Wait state counter
signal valid_addr          : std_logic;                                       -- Valid address indication
signal addr_reg            : std_logic_vector(ADDR_WIDTH-1 downto 0);         -- Registered address
signal data_reg            : std_logic_vector(DATA_WIDTH-1 downto 0);         -- Registered data
signal last_reg            : std_logic;                                       -- Registered last indication
signal req_reg             : std_logic;                                       -- Registered request indication
signal ack_int             : std_logic;                                       -- Internal acknowledge
signal last_d              : std_logic;                                       -- Delayed last indication

begin

   BUS_ACK_o <= ack_int;

   process(BUS_CLK_i)
   begin
      if BUS_CLK_i'event and BUS_CLK_i = '1'then
         if RST_i = '1' then
            MEM_CSn_o   <= '1';
            MEM_RWn_o   <= '0';
            MEM_ADDR_o  <= (others => '0');
            MEM_DATA_io <= (others => 'Z');
            ack_int     <= '0';
            BUS_VAL_o   <= '0';
            BUS_DATA_o  <= (others => '0');
            wait_cnt    <= (others => '0');
            cur_st      <= IDLE_ST;
         else
            case cur_st is
               when IDLE_ST   =>
                  MEM_CSn_o   <= '1';
                  MEM_RWn_o   <= '0';
                  MEM_ADDR_o  <= (others => '0');
                  MEM_DATA_io <= (others => 'Z');
                  ack_int     <= '0';
                  BUS_VAL_o   <= '0';
                  wait_cnt    <= (others => '0');
                  addr_reg    <= BUS_ADDR_i;
                  data_reg    <= BUS_DATA_i;
                  last_reg    <= BUS_LAST_i;
                  req_reg     <= BUS_REQ_i;
                  if BUS_REQ_i = '1' and BUS_RD_i = '1' and valid_addr = '1' then
                     MEM_CSn_o   <= '0';
                     MEM_RWn_o   <= '1';
                     MEM_ADDR_o  <= BUS_ADDR_i;
                     ack_int     <= '1';
                     cur_st      <= RDREQ_ST;
                  end if;
                  if BUS_REQ_i = '1' and BUS_WR_i = '1' and valid_addr = '1' then
                     MEM_CSn_o   <= '0';
                     MEM_RWn_o   <= '0';
                     MEM_ADDR_o  <= BUS_ADDR_i;
                     MEM_DATA_io <= BUS_DATA_i;
                     ack_int     <= '1';
                     last_d      <= BUS_LAST_i;
                     cur_st      <= WRREQ_ST;
                  end if;
               when RDREQ_ST    =>
                  if conv_integer(wait_cnt) < WAIT_STATES then
                     wait_cnt    <= wait_cnt + 1;
                     ack_int     <= '0';
                     BUS_VAL_o   <= '0';
                  else
                     BUS_DATA_o  <= MEM_DATA_io;
                     if WAIT_STATES > 0 then
                        MEM_ADDR_o  <= addr_reg;
                     else
                        MEM_ADDR_o  <= BUS_ADDR_i;
                     end if;
                     wait_cnt    <= (others => '0');
                     if BUS_REQ_i = '0' or valid_addr = '0' then
                        MEM_CSn_o   <= '1';
                        MEM_RWn_o   <= '0';
                        ack_int     <= '0';
                        BUS_VAL_o   <= not ack_int;
                        cur_st      <= IDLE_ST;
                     else
                        ack_int     <= '1';
                        BUS_VAL_o   <= '1';
                     end if;
                  end if;
                  if ack_int = '1' then
                     addr_reg <= BUS_ADDR_i;
                  end if;
               when WRREQ_ST    =>
                  if conv_integer(wait_cnt) < WAIT_STATES then
                     wait_cnt    <= wait_cnt + 1;
                     ack_int     <= '0';
                  else
                     wait_cnt    <= (others => '0');
                     ack_int     <= '0';
                     MEM_CSn_o   <= '1';
                     MEM_RWn_o   <= '0';
                     cur_st      <= WRREQ2_ST;
                  end if;
                  if ack_int = '1' then
                     addr_reg <= BUS_ADDR_i;
                     data_reg <= BUS_DATA_i;
                     last_reg <= BUS_LAST_i;
                  end if;
                  BUS_VAL_o   <= '0';
               when WRREQ2_ST    =>
                  if conv_integer(wait_cnt) < WAIT_STATES then
                     wait_cnt    <= wait_cnt + 1;
                     ack_int     <= '0';
                     MEM_CSn_o   <= '1';
                  else
                     if req_reg = '0' or valid_addr = '0' then
                        MEM_CSn_o   <= '1';
                        MEM_RWn_o   <= '0';
                        MEM_DATA_io <= (others => 'Z');
                        ack_int     <= '1';
                        if BUS_REQ_i = '0' then
                           cur_st      <= IDLE_ST;
                           wait_cnt    <= (others => '0');
                        end if;
                     else
                        MEM_CSn_o   <= '0';
                        MEM_RWn_o   <= '0';
                        MEM_ADDR_o  <= addr_reg;
                        MEM_DATA_io <= data_reg;
                        ack_int     <= '1';
                        last_d      <= last_reg;
                        req_reg     <= BUS_REQ_i and not last_d;
                        cur_st      <= WRREQ_ST;
                        wait_cnt    <= (others => '0');
                     end if;
                  end if;
                  BUS_VAL_o   <= '0';
               when others =>
                  cur_st      <= IDLE_ST;
            end case;
         end if;
      end if;
   end process;

   valid_addr <=  '1' when conv_integer(BUS_ADDR_i) >= BASE_ADDRESS and conv_integer(BUS_ADDR_i) < BASE_ADDRESS + MEM_SIZE else
                  '0';

   BUS_SEL_o  <= valid_addr;

end Behavioral;