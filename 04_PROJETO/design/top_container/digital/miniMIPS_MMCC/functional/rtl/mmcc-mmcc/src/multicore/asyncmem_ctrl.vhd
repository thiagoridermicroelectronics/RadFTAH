-- =================================================================================
-- Project          :  MIPS Multi-core
-- FileName         :  asyncmem_ctrl.vhd
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
entity asyncmem_ctrl is
   generic (
      BASE_ADDRESS : integer := 16#00000000#;                                 -- Base address
      MEM_SIZE     : integer := 16#00000000#;                                 -- Memory size
      IF_NUM       : integer := 16#00000000#;                                 -- Number of interfaces
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
      --MEM_DATA_io          : inout  std_logic_vector(DATA_WIDTH-1 downto 0);  -- IO data
      MEM_DATA_i           : in     std_logic_vector(DATA_WIDTH-1 downto 0);  -- Input data
      MEM_DATA_o           : out    std_logic_vector(DATA_WIDTH-1 downto 0);  -- Input data

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
end asyncmem_ctrl;

architecture Behavioral of asyncmem_ctrl is

-- Attributes

-- Types and definitions
constant gnd               : std_logic  := '0';
constant vcc               : std_logic  := '1';

type fsm_st is (IDLE_ST, RDREQ_ST, RDREQ2_ST, WRREQ_ST, WRREQ2_ST);                                 -- Type definition

-- Internal signals
signal cur_st              : fsm_st;                                          -- Current fsm state
signal wait_cnt            : std_logic_vector(log2_ceil(WAIT_STATES+1) downto 0);-- Wait state counter
signal valid_addr          : std_logic;                                       -- Valid address indication

signal addr_reg            : std_logic_vector(ADDR_WIDTH-1 downto 0);         -- Registered address
signal data_reg            : std_logic_vector(DATA_WIDTH-1 downto 0);         -- Registered data
signal mem_data_out_int    : std_logic_vector(DATA_WIDTH-1 downto 0);         -- Internal outpu data
signal last_reg            : std_logic;                                       -- Registered last indication
signal rd_reg              : std_logic;                                       -- Registered read indication
signal wr_reg              : std_logic;                                       -- Registered write indication
signal req_reg             : std_logic;                                       -- Registered request indication
signal req_d               : std_logic;                                       -- Delayed request indication

signal ack_int             : std_logic;                                       -- Internal acknowledge
signal val_int             : std_logic;                                       -- Internal valid
signal last_d              : std_logic;                                       -- Delayed last indication
signal tri_state           : std_logic;                                       -- Tri-state control

begin

   BUS_ACK_o <= ack_int;
   BUS_VAL_o <= val_int;

   process(BUS_CLK_i)
   begin
      if BUS_CLK_i'event and BUS_CLK_i = '1'then
         if RST_i = '1' then
            MEM_CSn_o   <= '1';
            MEM_RWn_o   <= '0';
            MEM_ADDR_o  <= (others => '0');
            --MEM_DATA_io <= (others => 'Z');
            --tri_state   <= '1';
            ack_int     <= '0';
            val_int     <= '0';
            BUS_DATA_o  <= (others => '0');
            wait_cnt    <= (others => '0');
            tri_state   <= '1';
            cur_st      <= IDLE_ST;
         else
            case cur_st is
               when IDLE_ST   =>
                  --MEM_DATA_io <= (others => 'Z');
                  --tri_state   <= '1';
                  if BUS_REQ_i = '1' and BUS_RD_i = '1' then
                     cur_st <= RDREQ_ST;
                  end if;
                  if BUS_REQ_i = '1' and BUS_WR_i = '1' then
                     cur_st <= WRREQ_ST;
                  end if;
                  ack_int <= '0';
                  val_int <= '0';
               when RDREQ_ST  =>
                  --MEM_DATA_io <= (others => 'Z');
                  --tri_state   <= '1';
                  wait_cnt    <= (others => '0');
                  if (req_reg = '1' and rd_reg = '1') and 
                     (last_reg = '0' or last_d = '0') then
                     ack_int    <= '1';
                     MEM_CSn_o  <= '0';
                     MEM_RWn_o  <= '1';
                     MEM_ADDR_o <= addr_reg;
                     cur_st     <= RDREQ2_ST;
                  else
                     ack_int    <= '0';
                     MEM_CSn_o  <= '1';
                     MEM_RWn_o  <= '1';
                     cur_st      <= IDLE_ST;
                  end if;
                  val_int <= '0';
               when RDREQ2_ST =>
                  if wait_cnt >= WAIT_STATES then
                     BUS_DATA_o <= MEM_DATA_i;
                     MEM_CSn_o  <= '1';
                     val_int    <= '1';
                     cur_st     <= RDREQ_ST;
                  else
                     wait_cnt   <= wait_cnt + 1;
                  end if;
                  ack_int <= '0';
               when WRREQ_ST  =>
                  wait_cnt    <= (others => '0');
                  if (req_reg = '1' and wr_reg = '1') and 
                     (last_reg = '0' or last_d = '0') then
                     ack_int    <= '1';
                     MEM_CSn_o  <= '0';
                     MEM_RWn_o  <= '0';
                     MEM_ADDR_o <= addr_reg;
                     --MEM_DATA_io<= data_reg;
                     mem_data_out_int <= data_reg;
                     --tri_state  <= '0';
                     cur_st     <= WRREQ2_ST;
                  else
                     ack_int    <= '0';
                     MEM_CSn_o  <= '1';
                     MEM_RWn_o  <= '1';
                     cur_st      <= IDLE_ST;
                  end if;
                  val_int <= '0';
               when WRREQ2_ST =>
                  if wait_cnt >= WAIT_STATES then
                     --MEM_DATA_io<= (others => 'Z');
                     --tri_state   <= '1';
                     MEM_CSn_o  <= '1';
                     cur_st     <= WRREQ_ST;
                  else
                     wait_cnt   <= wait_cnt + 1;
                  end if;
                  ack_int <= '0';
                  val_int <= '0';
               when others    =>
                  cur_st <= IDLE_ST;
            end case;
         end if;
      end if;
   end process;

   process(BUS_CLK_i)
   begin
      if BUS_CLK_i'event and BUS_CLK_i = '1'then
         if RST_i = '1' then
            addr_reg <= (others => '0');
            data_reg <= (others => '0');
            last_reg <= '0';
            rd_reg   <= '0';
            wr_reg   <= '0';
            req_reg  <= '0';
            req_d    <= '0';
            last_d   <= '0';
         else
            req_d <= BUS_REQ_i;
            if (BUS_REQ_i = '1' and req_d = '0') or 
               ack_int = '1' then
               addr_reg <= BUS_ADDR_i;
               data_reg <= BUS_DATA_i;
               last_reg <= BUS_LAST_i;
               rd_reg   <= BUS_RD_i;
               wr_reg   <= BUS_WR_i;
               req_reg  <= BUS_REQ_i;
               last_d   <= last_reg;
            end if;
         end if;
      end if;
   end process;

   valid_addr  <=  '1' when conv_integer(BUS_ADDR_i(30 downto 0)) >= BASE_ADDRESS
                            and conv_integer(BUS_ADDR_i(30 downto 0)) < BASE_ADDRESS + MEM_SIZE else
                   '0';

   BUS_SEL_o   <= valid_addr;

   --MEM_DATA_io <= (others => 'Z') when tri_state = '1' else
   --               mem_data_out_int;

   MEM_DATA_o  <= mem_data_out_int;

end Behavioral;

