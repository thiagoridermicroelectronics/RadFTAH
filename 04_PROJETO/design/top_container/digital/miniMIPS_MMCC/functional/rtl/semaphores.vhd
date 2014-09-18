-- Libraries
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library work;
use work.utils_pkg.all;

-- Entity declaration
entity semaphores is
  generic (
    BASE_ADDRESS : integer := 16#00000000#;                                 -- Base address
    LIM_ADDRESS  : integer := 16#00000000#;                                 -- Top  address
    ADDR_WIDTH   : integer := 32;       				    -- Input address width
    DATA_WIDTH   : integer := 32;					    -- Output data width
    max_semaphores: integer := 1024;					    -- Maximum number of semaphores
    sem_size : integer := 9						    -- Size of each semaphore in bits
    );
  port (
    -- System Interface
    RST_i                : in     std_logic;                                -- Reset - active high

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
end semaphores;

architecture Behavioral of semaphores is

-- Attributes

-- Types and definitions
  constant gnd               : std_logic  := '0';
  constant vcc               : std_logic  := '1';

  type fsm_st is (IDLE_ST, RDREQ_ST, RDREQ2_ST, WAIT_ST);                                 -- Type definition

-- Internal signals
  signal cur_st              : fsm_st;                                          -- Current fsm state
  signal valid_addr          : std_logic;                                       -- Valid address indication

  signal addr_reg            : std_logic_vector(ADDR_WIDTH-1 downto 0);         -- Registered address
  signal data_reg            : std_logic_vector(DATA_WIDTH-1 downto 0);         -- Registered data
  signal last_reg            : std_logic;                                       -- Registered last indication
  signal rd_reg              : std_logic;                                       -- Registered read indication
  signal req_reg             : std_logic;                                       -- Registered request indication
  signal req_d               : std_logic;                                       -- Delayed request indication

  signal ack_int             : std_logic;                                       -- Internal acknowledge
  signal val_int             : std_logic;                                       -- Internal valid
  signal last_d              : std_logic;                                       -- Delayed last indication
  signal index_size: natural := log2_ceil(max_semaphores)-1;

  subtype index_register is std_logic_vector(index_size downto 0);
  signal internal_index : index_register;
  signal semaphores_table : table_type;
  signal operation : std_logic_vector(1 downto 0);
  signal sem_index : index_register;
  signal zero : std_logic_vector(sem_size downto 0):= (others => '0');
begin

  BUS_ACK_o <= ack_int;
  BUS_VAL_o <= val_int;

  process(BUS_CLK_i)
  begin
    if BUS_CLK_i'event and BUS_CLK_i = '1'then
      if RST_i = '1' then
        ack_int     <= gnd;
        val_int     <= gnd;
        BUS_DATA_o  <= (others => gnd);
        cur_st      <= IDLE_ST;
        -- Reset index and clean table
        internal_index <= (others => gnd);
        for i in 0 to num_sem-1 loop
          semaphores_table(i).valid <= gnd;
          semaphores_table(i).sem_value <= (others => gnd);
        end loop;
      else
        case cur_st is
          when IDLE_ST   =>
            if BUS_REQ_i = vcc and BUS_RD_i = vcc then
              cur_st <= RDREQ_ST;
            end if;
            ack_int <= gnd;
            val_int <= gnd;
          when RDREQ_ST  =>
            if (req_reg = vcc and rd_reg = vcc) and
              (last_reg = gnd or last_d = gnd) then
              ack_int    <= vcc;
              sem_index <= addr_reg(index_size downto 0);
              operation <= addr_reg(index_size+2 downto index_size+1);
              cur_st <= RDREQ2_ST;
            else
              operation <= (others => gnd);
              ack_int    <= gnd;
              cur_st      <= IDLE_ST;
            end if;
            val_int <= gnd;
          when RDREQ2_ST =>
            val_int <= vcc;
            if operation = SEM_CREATE then
              if conv_integer(unsigned(internal_index)) < max_semaphores then
                -- It's possible to create a new semaphore
                semaphores_table(conv_integer(unsigned(internal_index))).valid <= vcc;
                semaphores_table(conv_integer(unsigned(internal_index))).sem_value <= sem_type(addr_reg(SEM_SIZE downto 0));
                BUS_DATA_o(31 downto index_size+1) <= (others => gnd);
                BUS_DATA_o(index_size downto 0) <= internal_index;
                internal_index <= index_register(unsigned(internal_index))+1;
              else
                --Table is full, return NIL
                BUS_DATA_o(31 downto 0) <= (others => vcc);
              end if;
            end if;

            if operation = SEM_P  then
              if semaphores_table(conv_integer(unsigned(sem_index))).valid = vcc then
                if semaphores_table(conv_integer(unsigned(sem_index))).sem_value > zero then
                  semaphores_table(conv_integer(unsigned(sem_index))).sem_value <= sem_type(unsigned(semaphores_table(conv_integer(unsigned(sem_index))).sem_value))-1;
                  BUS_DATA_o(31 downto 0) <= (others => gnd);
                else
                  BUS_DATA_o <= (others => vcc);
                end if;
              else
                BUS_DATA_o <= (others => vcc);
              end if;
            end if;

            if operation = SEM_V then
              if semaphores_table(conv_integer(unsigned(sem_index))).valid = vcc then
                semaphores_table(conv_integer(unsigned(sem_index))).sem_value <= sem_type(unsigned(semaphores_table(conv_integer(unsigned(sem_index))).sem_value))+1;
                BUS_DATA_o <= (others => gnd);
              else
                BUS_DATA_o <= (others => vcc);
              end if;
            end if;
            cur_st     <= WAIT_ST;
            ack_int <= gnd;
          when others    =>
            operation <= (others => gnd);
            cur_st <= IDLE_ST;
        end case;
      end if;
    end if;
  end process;

  process(BUS_CLK_i)
  begin
    if BUS_CLK_i'event and BUS_CLK_i = vcc then
      if RST_i = vcc then
        addr_reg <= (others => gnd);
        data_reg <= (others => gnd);
        last_reg <= gnd;
        rd_reg   <= gnd;
        req_reg  <= gnd;
        req_d    <= gnd;
        last_d   <= gnd;
      else
        req_d <= BUS_REQ_i;
        if (BUS_REQ_i = vcc and req_d = gnd) or
          ack_int = vcc then
          addr_reg <= BUS_ADDR_i;
          data_reg <= BUS_DATA_i;
          last_reg <= BUS_LAST_i;
          rd_reg   <= BUS_RD_i;
          req_reg  <= BUS_REQ_i;
          last_d   <= last_reg;
        end if;
      end if;
    end if;
  end process;

  valid_addr  <=  vcc when conv_integer(BUS_ADDR_i(ADDR_WIDTH-2 downto 0)) >= BASE_ADDRESS and conv_integer(BUS_ADDR_i(ADDR_WIDTH-2 downto 0)) < LIM_ADDRESS else
                  gnd;

  BUS_SEL_o   <= valid_addr;

end Behavioral;
