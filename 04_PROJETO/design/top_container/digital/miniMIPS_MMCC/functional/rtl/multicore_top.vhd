-- =================================================================================
-- Project          :  MIPS Multi-core
-- FileName         :  multicore_top.vhd
-- FileType         :  VHDL - Source code
-- Author           :  Jorge Tortato Junior, UFPR
-- Reviewer         :  -x-x-x-x-
-- Version          :  0.1 from 25/nov/2008
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
   use work.multicore_cfg.all;

-- Entity declaration
entity multicore_top is
   generic (
      SRAM_CTRL_GEN        : boolean := true;
      PER_BUS_GEN          : boolean := true;
      SEM_CTRL_GEN         : boolean := true
   );
   port (
      -- System Interface
      RST_i                : in     std_logic;                       -- Reset - active high
      CLOCK2X_i            : in     std_logic;
      CLOCK_i              : in     std_logic;

      -- Memory interface
      BUS_CLK_i            : in     std_logic;                       -- Bus control clock

      -- Peripherals
      PER_CSn_o            : out    std_logic;                       -- Chip select
      PER_RWn_o            : out    std_logic;                       -- 0 = Write, 1 = Read
      PER_ADDR_o           : out    std_logic_vector(31 downto 0);   -- Address
      PER_DATA_i           : in     std_logic_vector(31 downto 0);   -- Input data
      PER_DATA_o           : out    std_logic_vector(31 downto 0);   -- Output data

      -- ROM
      MEM_CSn_o            : out    std_logic;                       -- Chip select
      MEM_RWn_o            : out    std_logic;                       -- 0 = Write, 1 = Read
      MEM_ADDR_o           : out    std_logic_vector(31 downto 0);   -- Address
      --MEM_DATA_io          : inout  std_logic_vector(31 downto 0);   -- IO data
      MEM_DATA_i           : in     std_logic_vector(31 downto 0);   -- Input data
      MEM_DATA_o           : out    std_logic_vector(31 downto 0);   -- Output data

      -- RAM
      RAM_CSn_o            : out    std_logic;                       -- Chip select
      RAM_RWn_o            : out    std_logic;                       -- 0 = Write, 1 = Read
      RAM_ADDR_o           : out    std_logic_vector(31 downto 0);   -- Address
      RAM_DATA_o           : out    std_logic_vector(31 downto 0);   -- Output data
      RAM_DATA_i           : in     std_logic_vector(31 downto 0)    -- Input data
   );
end multicore_top;

architecture Behavioral of multicore_top is

   -- Attributes

   -- Types and definitions
   -- Internal signals
   -- Internal resets
   signal rst_int         : std_logic_vector(CPU_NUM-1 downto 0);
   signal rst_vec         : slv32vec(CPU_NUM-1 downto 0);

   -- TODO: this signal should be removed.
   -- I didn't remove it to keep the logic
   signal zbt_lck         : std_logic := '0';

   -- Bus cache interface
   signal bus_req         : std_logic_vector(2*CPU_NUM-1 downto 0);
   signal bus_rgrant      : std_logic_vector(2*CPU_NUM-1 downto 0);
   signal bus_grant       : std_logic_vector(2*CPU_NUM-1 downto 0);
   signal bus_match       : slv2vec(2*CPU_NUM-1 downto 0);
   signal bus_last        : std_logic_vector(2*CPU_NUM-1 downto 0);
   signal bus_ack         : std_logic_vector(2*CPU_NUM-1 downto 0);
   signal bus_val         : std_logic_vector(2*CPU_NUM-1 downto 0);
   signal bus_rd          : std_logic_vector(2*CPU_NUM-1 downto 0);
   signal bus_rdx         : std_logic_vector(2*CPU_NUM-1 downto 0);
   signal bus_wr          : std_logic_vector(2*CPU_NUM-1 downto 0);
   signal bus_addr        : slv32vec(2*CPU_NUM-1 downto 0);
   signal bus_wdata       : slv32vec(2*CPU_NUM-1 downto 0);
   signal bus_rdata       : slv32vec(2*CPU_NUM-1 downto 0);
   signal bus_rlock       : std_logic_vector(CPU_NUM-1 downto 0);
   signal bus_lock        : std_logic_vector(CPU_NUM-1 downto 0);

   -- Memory controller interfaces
   signal ctrl_sel        : std_logic_vector(3 downto 0);
   signal ctrl_req        : std_logic_vector(3 downto 0);
   signal ctrl_last       : std_logic_vector(3 downto 0);
   signal ctrl_ack        : std_logic_vector(3 downto 0);
   signal ctrl_val        : std_logic_vector(3 downto 0);
   signal ctrl_rd         : std_logic_vector(3 downto 0);
   signal ctrl_wr         : std_logic_vector(3 downto 0);
   signal ctrl_addr       : slv32vec(3 downto 0);
   signal ctrl_wdata      : slv32vec(3 downto 0);
   signal ctrl_rdata      : slv32vec(3 downto 0);

   -- Snoop interfaces
   signal snoop_grant     : std_logic_vector(CPU_NUM-1 downto 0);
   signal snoop_sel       : std_logic_vector(CPU_NUM-1 downto 0);
   signal snoop_match     : slv2vec(CPU_NUM-1 downto 0);
   signal snoop_req       : std_logic_vector(CPU_NUM-1 downto 0);
   signal snoop_last      : std_logic_vector(CPU_NUM-1 downto 0);
   signal snoop_ack       : std_logic_vector(CPU_NUM-1 downto 0);
   signal snoop_val       : std_logic_vector(CPU_NUM-1 downto 0);
   signal snoop_rd        : std_logic_vector(CPU_NUM-1 downto 0);
   signal snoop_rdx       : std_logic_vector(CPU_NUM-1 downto 0);
   signal snoop_wr        : std_logic_vector(CPU_NUM-1 downto 0);
   signal snoop_addr      : slv32vec(CPU_NUM-1 downto 0);
   signal snoop_wdata     : slv32vec(CPU_NUM-1 downto 0);
   signal snoop_rdata     : slv32vec(CPU_NUM-1 downto 0);
   signal startup_cnt     : std_logic_vector(15 downto 0);

begin

   rst_int(0) <= (not zbt_lck) or RST_i;
   process(CLOCK_i, zbt_lck)
   begin
      if zbt_lck = '0' then
         startup_cnt <= (others => '0');
         rst_int     <= (others => '1');
      elsif CLOCK_i'event and CLOCK_i = '1'then
         if startup_cnt(2) = '0' then
            startup_cnt <= startup_cnt + 1;
            rst_int <= (others => '1');
         else
            rst_int(0) <= '0';
            for i in 1 to CPU_NUM-1 loop
               rst_int(i) <= rst_vec(0)(i);
            end loop;
         end if;
      end if;
   end process;

   rst_gen : for i in 1 to CPU_NUM-1 generate
      rst_int(i) <= (not zbt_lck) or RST_i or rst_vec(0)(i);
   end generate;

   cpu_gen : for i in 0 to CPU_NUM-1 generate
      cpu_core : entity work.minimips
         generic map (
            cpu_id            => i
         )
         port map (
            clock2x           => CLOCK2X_i,
            clock             => CLOCK_i,
            reset             => rst_int(i),
            ref_reset_i       => rst_int(0),
            rst_vec_o         => rst_vec(i),
            bus_clk_i         => bus_clk_i,
            bus_rlock_o       => bus_rlock(i),
            bus_lock_i        => bus_lock(i),
            bus_req_o         => bus_req(2*i+1 downto 2*i),
            bus_rgrant_o      => bus_rgrant(2*i+1 downto 2*i),
            bus_grant_i       => bus_grant(2*i+1 downto 2*i),
            bus_match_i       => bus_match(2*i+1 downto 2*i),
            bus_last_o        => bus_last(2*i+1 downto 2*i),
            bus_ack_i         => bus_ack(2*i+1 downto 2*i),
            bus_val_i         => bus_val(2*i+1 downto 2*i),
            bus_rd_o          => bus_rd(2*i+1 downto 2*i),
            bus_rdx_o         => bus_rdx(2*i+1 downto 2*i),
            bus_wr_o          => bus_wr(2*i+1 downto 2*i),
            bus_addr_o        => bus_addr(2*i+1 downto 2*i),
            bus_wdata_o       => bus_wdata(2*i+1 downto 2*i),
            bus_rdata_i       => bus_rdata(2*i+1 downto 2*i),
            snoop_grant_i     => snoop_grant(i),
            snoop_sel_o       => snoop_sel(i),
            snoop_match_o     => snoop_match(i),
            snoop_req_i       => snoop_req(i),
            snoop_last_i      => snoop_last(i),
            snoop_ack_o       => snoop_ack(i),
            snoop_val_o       => snoop_val(i),
            snoop_rd_i        => snoop_rd(i),
            snoop_rdx_i       => snoop_rdx(i),
            snoop_wr_i        => snoop_wr(i),
            snoop_addr_i      => snoop_addr(i),
            snoop_wdata_o     => snoop_wdata(i),
            snoop_rdata_i     => snoop_rdata(i),
            it_mat            => '0'
   );
   end generate;

   peripheral_gen : if PER_BUS_GEN generate
      peripheral_ctrl_inst : entity work.asyncmem_ctrl
         generic map (
            BASE_ADDRESS => PER_BASE_ADDRESS,
            MEM_SIZE     => PER_MEM_SIZE,
            WAIT_STATES  => PER_WAIT_STATES,
            DATA_WIDTH   => PER_DATA_WIDTH,
            ADDR_WIDTH   => PER_ADDR_WIDTH
         )
         port map (
            RST_i        => rst_int(0),
            MEM_CSn_o    => PER_CSn_o,
            MEM_RWn_o    => PER_RWn_o,
            MEM_ADDR_o   => PER_ADDR_o,
            MEM_DATA_i   => PER_DATA_i,
            MEM_DATA_o   => PER_DATA_o,
            BUS_CLK_i    => BUS_CLK_i,
            BUS_REQ_i    => ctrl_req(2),
            BUS_LAST_i   => ctrl_last(2),
            BUS_ACK_o    => ctrl_ack(2),
            BUS_VAL_o    => ctrl_val(2),
            BUS_RD_i     => ctrl_rd(2),
            BUS_WR_i     => ctrl_wr(2),
            BUS_ADDR_i   => ctrl_addr(2),
            BUS_DATA_o   => ctrl_rdata(2),
            BUS_DATA_i   => ctrl_wdata(2),
            BUS_SEL_o    => ctrl_sel(2)
        );
   end generate;

   rom_memctrl_inst : entity work.asyncmem_ctrl
      generic map (
         BASE_ADDRESS => ROM_BASE_ADDRESS,
         MEM_SIZE     => ROM_MEM_SIZE,
         WAIT_STATES  => ROM_WAIT_STATES,
         DATA_WIDTH   => ROM_DATA_WIDTH,
         ADDR_WIDTH   => ROM_ADDR_WIDTH
      )
      port map (
         RST_i        => rst_int(0),
         MEM_CSn_o    => MEM_CSn_o,
         MEM_RWn_o    => MEM_RWn_o,
         MEM_ADDR_o   => MEM_ADDR_o,
         --MEM_DATA_io  => MEM_DATA_io,
         MEM_DATA_i   => MEM_DATA_i,
         MEM_DATA_o   => MEM_DATA_o,
         BUS_CLK_i    => BUS_CLK_i,
         BUS_REQ_i    => ctrl_req(0),
         BUS_LAST_i   => ctrl_last(0),
         BUS_ACK_o    => ctrl_ack(0),
         BUS_VAL_o    => ctrl_val(0),
         BUS_RD_i     => ctrl_rd(0),
         BUS_WR_i     => ctrl_wr(0),
         BUS_ADDR_i   => ctrl_addr(0),
         BUS_DATA_o   => ctrl_rdata(0),
         BUS_DATA_i   => ctrl_wdata(0),
         BUS_SEL_o    => ctrl_sel(0)
   );

   sram_ctrlgen : if SRAM_CTRL_GEN = true generate
      ram_memctrl_inst : entity work.asyncmem_ctrl
         generic map (
            BASE_ADDRESS => SRAM_BASE_ADDRESS,
            MEM_SIZE     => SRAM_MEM_SIZE,
            WAIT_STATES  => SRAM_WAIT_STATES,
            DATA_WIDTH   => SRAM_DATA_WIDTH,
            ADDR_WIDTH   => SRAM_ADDR_WIDTH
         )
         port map (
            RST_i        => rst_int(0),
            MEM_CSn_o    => RAM_CSn_o,
            MEM_RWn_o    => RAM_RWn_o,
            MEM_ADDR_o   => RAM_ADDR_o,
            MEM_DATA_i   => RAM_DATA_i,
            MEM_DATA_o   => RAM_DATA_o,
            BUS_CLK_i    => BUS_CLK_i,
            BUS_REQ_i    => ctrl_req(1),
            BUS_LAST_i   => ctrl_last(1),
            BUS_ACK_o    => ctrl_ack(1),
            BUS_VAL_o    => ctrl_val(1),
            BUS_RD_i     => ctrl_rd(1),
            BUS_WR_i     => ctrl_wr(1),
            BUS_ADDR_i   => ctrl_addr(1),
            BUS_DATA_o   => ctrl_rdata(1),
            BUS_DATA_i   => ctrl_wdata(1),
            BUS_SEL_o    => ctrl_sel(1)
      );
      zbt_lck <= '1';
   end generate;

  sem_ctrlgen: if SEM_CTRL_GEN = true generate
     sem_inst : entity work.semaphores
       generic map (
         BASE_ADDRESS => 16#00038000#,
         LIM_ADDRESS  => 16#00040000#,
         ADDR_WIDTH   => 32,
         DATA_WIDTH   => 32,
         max_semaphores => NUM_SEM,
         sem_size => SEM_SIZE
         )
       port map (
         RST_i        => rst_int(0),
         BUS_CLK_i    => BUS_CLK_i,
         BUS_REQ_i    => ctrl_req(3),
         BUS_LAST_i   => ctrl_last(3),
         BUS_ACK_o    => ctrl_ack(3),
         BUS_VAL_o    => ctrl_val(3),
         BUS_RD_i     => ctrl_rd(3),
         BUS_WR_i     => ctrl_wr(3),
         BUS_ADDR_i   => ctrl_addr(3),
         BUS_DATA_o   => ctrl_rdata(3),
         BUS_DATA_i   => ctrl_wdata(3),
         BUS_SEL_o    => ctrl_sel(3)
         );
   end generate;

   bus_mux_inst : entity work.bus_mux
      generic map (
         IF_NUM         => 2*CPU_NUM,
         CTRL_NUM       => 4,
         SNOOP_NUM      => CPU_NUM
      )
      port map (
         RST_i          => rst_int(0),
         BUS_CLK_i      => BUS_CLK_i,
         BUS_RLOCK_i    => bus_rlock,
         BUS_LOCK_o     => bus_lock,
         BUS_REQ_i      => bus_req,
         BUS_GRANT_o    => bus_grant,
         BUS_RGRANT_i   => bus_rgrant,
         BUS_MATCH_o    => bus_match,
         BUS_LAST_i     => bus_last,
         BUS_ACK_o      => bus_ack,
         BUS_VAL_o      => bus_val,
         BUS_RD_i       => bus_rd,
         BUS_RDX_i      => bus_rdx,
         BUS_WR_i       => bus_wr,
         BUS_ADDR_i     => bus_addr,
         BUS_DATA_o     => bus_rdata,
         BUS_DATA_i     => bus_wdata,
         CTRL_SEL_i     => ctrl_sel,
         CTRL_REQ_o     => ctrl_req,
         CTRL_LAST_o    => ctrl_last,
         CTRL_ACK_i     => ctrl_ack,
         CTRL_VAL_i     => ctrl_val,
         CTRL_RD_o      => ctrl_rd,
         CTRL_WR_o      => ctrl_wr,
         CTRL_ADDR_o    => ctrl_addr,
         CTRL_DATA_i    => ctrl_rdata,
         CTRL_DATA_o    => ctrl_wdata,
         SNOOP_GRANT_o  => snoop_grant,
         SNOOP_SEL_i    => snoop_sel, 
         SNOOP_MATCH_i  => snoop_match,
         SNOOP_REQ_o    => snoop_req, 
         SNOOP_LAST_o   => snoop_last,
         SNOOP_ACK_i    => snoop_ack, 
         SNOOP_VAL_i    => snoop_val, 
         SNOOP_RD_o     => snoop_rd,
         SNOOP_RDX_o    => snoop_rdx,
         SNOOP_WR_o     => snoop_wr,
         SNOOP_ADDR_o   => snoop_addr,
         SNOOP_DATA_i   => snoop_wdata,
         SNOOP_DATA_o   => snoop_rdata
      );

end Behavioral;
