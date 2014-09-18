------------------------------------------------------------------------------------
--                                                                                --
--    Copyright (c) 2004, Hangouet Samuel                                         --
--                  , Jan Sebastien                                               --
--                  , Mouton Louis-Marie                                          --
--                  , Schneider Olivier     all rights reserved                   --
--                                                                                --
--    This file is part of miniMIPS.                                              --
--                                                                                --
--    miniMIPS is free software; you can redistribute it and/or modify            --
--    it under the terms of the GNU Lesser General Public License as published by --
--    the Free Software Foundation; either version 2.1 of the License, or         --
--    (at your option) any later version.                                         --
--                                                                                --
--    miniMIPS is distributed in the hope that it will be useful,                 --
--    but WITHOUT ANY WARRANTY; without even the implied warranty of              --
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the               --
--    GNU Lesser General Public License for more details.                         --
--                                                                                --
--    You should have received a copy of the GNU Lesser General Public License    --
--    along with miniMIPS; if not, write to the Free Software                     --
--    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA   --
--                                                                                --
------------------------------------------------------------------------------------


-- If you encountered any problem, please contact :
--
--   lmouton@enserg.fr
--   oschneid@enserg.fr
--   shangoue@enserg.fr
--


--------------------------------------------------------------------------
--                                                                      --
--                                                                      --
--           miniMIPS Processor : miniMIPS processor                    --
--                                                                      --
--                                                                      --
--                                                                      --
-- Authors : Hangouet  Samuel                                           --
--           Jan       Sébastien                                        --
--           Mouton    Louis-Marie                                      --
--           Schneider Olivier                                          --
--                                                                      --
--                                                          june 2004   --
--------------------------------------------------------------------------

library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_arith.all;
   use ieee.std_logic_unsigned.all;

library work;
   use work.pack_mips.all;
   use work.utils_pkg.all;
   use work.multicore_cfg.all;
   use work.coherence_pkg.all;

entity minimips is
   generic (
      cpu_id               : in     integer := 0
   );
   port (
      -- System signals
      clock2x              : in     std_logic;
      clock                : in     std_logic;
      reset                : in     std_logic;
      ref_reset_i          : in     std_logic;
      
      -- Multi-core reset control
      rst_vec_o            : out    std_logic_vector(31 downto 0);

      -- Bus cache interface
      bus_clk_i            : in     std_logic;
      bus_rlock_o          : out    std_logic;
      bus_lock_i           : in     std_logic;
      bus_req_o            : out    std_logic_vector(1 downto 0);
      bus_rgrant_o         : out    std_logic_vector(1 downto 0);
      bus_grant_i          : in     std_logic_vector(1 downto 0);
      bus_match_i          : in     slv2vec(1 downto 0);
      bus_last_o           : out    std_logic_vector(1 downto 0);
      bus_ack_i            : in     std_logic_vector(1 downto 0);
      bus_val_i            : in     std_logic_vector(1 downto 0);
      bus_rd_o             : out    std_logic_vector(1 downto 0);
      bus_rdx_o            : out    std_logic_vector(1 downto 0);
      bus_wr_o             : out    std_logic_vector(1 downto 0);
      bus_addr_o           : out    slv32vec(1 downto 0);
      bus_wdata_o          : out    slv32vec(1 downto 0);
      bus_rdata_i          :        slv32vec(1 downto 0);

      -- Snoop interfaces
      snoop_grant_i        : in     std_logic;
      snoop_sel_o          : out    std_logic;
      snoop_match_o        : out    std_logic_vector(1 downto 0);
      snoop_req_i          : in     std_logic;
      snoop_last_i         : in     std_logic;
      snoop_ack_o          : out    std_logic;
      snoop_val_o          : out    std_logic;
      snoop_rd_i           : in     std_logic;
      snoop_rdx_i          : in     std_logic;
      snoop_wr_i           : in     std_logic;
      snoop_addr_i         : in     std_logic_vector(31 downto 0);
      snoop_wdata_o        : out    std_logic_vector(31 downto 0);
      snoop_rdata_i        : in     std_logic_vector(31 downto 0);

      -- Hardware interruption
      it_mat               : in std_logic
   );
end minimips;

architecture rtl of minimips is

   -- General signals
   signal stop_all        : std_logic;      -- Lock the pipeline evolution
   signal it_mat_clk      : std_logic;      -- Synchronised hardware interruption

   -- interface PF - EI
   signal PF_pc           : bus32;          -- PC value

   -- interface Controler - EI
   signal CTE_instr       : bus32;          -- Instruction from the memory
   signal icache_instr    : bus32;
   signal ETC_adr         : bus32;          -- Virtual address to read in memory

   -- IMMU interface
   signal ireal_addr      : bus32;          -- Real address to read in code memory

   -- interface EI - DI
   signal EI_instr        : bus32;          -- Read interface
   signal EI_adr          : bus32;          -- Address from the read instruction
   signal EI_it_ok        : std_logic;      -- Allow hardware interruptions

   -- Asynchronous connexion with the bypass unit
   signal adr_reg1        : adr_reg_type;   -- Operand 1 address
   signal adr_reg2        : adr_reg_type;   -- Operand 2 address
   signal use1            : std_logic;      -- Operand 1 utilisation
   signal use2            : std_logic;      -- Operand 2 utilisation
   signal data1           : bus32;          -- First register value
   signal data2           : bus32;          -- Second register value
   signal alea            : std_logic;      -- Unresolved hazards detected

   -- interface DI - EX
   signal DI_bra          : std_logic;      -- Branch decoded
   signal DI_link         : std_logic;      -- A link for that instruction
   signal DI_op1          : bus32;          -- operand 1 for alu
   signal DI_op2          : bus32;          -- operand 2 for alu
   signal DI_code_ual     : alu_ctrl_type;  -- Alu operation
   signal DI_offset       : bus32;          -- Offset for the address calculation
   signal DI_adr_reg_dest : adr_reg_type;   -- Address of the destination register of the result
   signal DI_ecr_reg      : std_logic;      -- Effective writing of the result
   signal DI_mode         : std_logic;      -- Address mode (relative to pc or indexed to a register)
   signal DI_op_mem       : std_logic;      -- Memory operation request
   signal DI_r_w          : std_logic;      -- Type of memory operation (reading or writing)
   signal DI_adr          : bus32;          -- Address of the decoded instruction
   signal DI_exc_cause    : bus32;          -- Potential exception detected
   signal DI_level        : level_type;     -- Availability of the result for the data bypass
   signal DI_it_ok        : std_logic;      -- Allow hardware interruptions

   -- interface EX - MEM
   signal EX_adr          : bus32;          -- Instruction address
   signal EX_bra_confirm  : std_logic;      -- Branch execution confirmation
   signal EX_data_ual     : bus32;          -- Ual result
   signal EX_adresse      : bus32;          -- Address calculation result
   signal EX_adr_reg_dest : adr_reg_type;   -- Destination register for the result
   signal EX_ecr_reg      : std_logic;      -- Effective writing of the result
   signal EX_op_mem       : std_logic;      -- Memory operation needed
   signal EX_r_w          : std_logic;      -- Type of memory operation (read or write)
   signal EX_exc_cause    : bus32;          -- Potential cause exception
   signal EX_level        : level_type;     -- Availability stage of result for bypassing
   signal EX_it_ok        : std_logic;      -- Allow hardware interruptions

   -- interface Controler - MEM
   signal MTC_data        : bus32;          -- Data to write in memory
   signal MTC_adr         : bus32;          -- Address for memory
   signal MTC_r_w         : std_logic;      -- Read/Write in memory
   signal MTC_req         : std_logic;      -- Request access to memory
   signal CTM_data        : bus32;          -- Data from memory

   -- DMMU interface
   signal dreal_addr      : bus32;          -- Real address to read in data memory
   signal dreal_wr        : std_logic;      -- Real write enable
   signal dreal_rd        : std_logic;      -- Real read enable
   signal dreal_req       : std_logic;      -- Real request
   signal dreal_rw        : std_logic;      -- Real read/write strobe to dcache
   signal dvirtual_wr     : std_logic;      -- Virtual write enable
   signal dvirtual_rd     : std_logic;      -- Virtual read enable
   signal dvirtual_ex     : std_logic;      -- Virtual execute
   signal dtlb_miss       : std_logic;      -- Data TLB miss

   -- interface MEM - REG
   signal MEM_adr         : bus32;          -- Instruction address
   signal MEM_adr_reg_dest: adr_reg_type;   -- Destination register address
   signal MEM_ecr_reg     : std_logic;      -- Writing of the destination register
   signal MEM_data_ecr    : bus32;          -- Data to write (from alu or memory)
   signal MEM_exc_cause   : bus32;          -- Potential exception cause
   signal MEM_level       : level_type;     -- Availability stage for the result for bypassing
   signal MEM_it_ok       : std_logic;      -- Allow hardware interruptions

   -- connexion to the register banks
   -- Writing commands in the register banks
   signal write_data      : bus32;          -- Data to write
   signal write_adr       : bus5;           -- Address of the register to write
   signal write_GPR       : std_logic;      -- Selection in the internal registers
   signal write_SCP       : std_logic;      -- Selection in the coprocessor system registers

   -- Reading commands for Reading in the registers
   signal read_adr1       : bus5;           -- Address of the first register to read
   signal read_adr2       : bus5;           -- Address of the second register to read
   signal read_data1_GPR  : bus32;          -- Value of operand 1 from the internal registers
   signal read_data1_SCP  : bus32;          -- Value of operand 2 from the internal registers
   signal read_data2_GPR  : bus32;          -- Value of operand 1 from the coprocessor system registers
   signal read_data2_SCP  : bus32;          -- Value of operand 2 from the coprocessor system registers

   -- Interruption controls
   signal interrupt       : std_logic;      -- Interruption to take into account
   signal vecteur_it      : bus32;          -- Interruption vector

   -- Connexion with predict
   signal PR_bra_cmd      : std_logic;      -- Defined a branch
   signal PR_bra_bad      : std_logic;      -- Defined a branch to restore from a bad prediction
   signal PR_bra_adr      : std_logic_vector(31 downto 0); -- New PC
   signal PR_clear        : std_logic;      -- Clear the three pipeline stage : EI, DI, EX

   -- Clear asserted when interrupt or PR_clear are asserted
   signal clear           : std_logic;

   signal stop_all_res    : std_logic;
   signal icache_addr     : std_logic_vector(31 downto 0);
   signal icache_stop     : std_logic;
   signal dcache_stop     : std_logic;
   signal dcache_en       : std_logic;       -- Data cache enable

   signal cache_miss_i    : std_logic;

begin

   clear <= interrupt or PR_clear;

   -- Take into account the hardware interruption on rising edge
   process (clock)
   begin
       if clock='1' and clock'event then
          it_mat_clk  <= it_mat;
          icache_addr <= ireal_addr;
       end if;
   end process;

   stop_all_res <= icache_stop or dcache_stop;

   U1_pf : pps_pf port map (
       clock      => clock,
       reset      => reset,
       stop_all   => stop_all_res,             -- Unconditionnal locking of the pipeline stage
       cache_miss => '0',--icache_stop,          -- Cache miss indication
       -- entrees asynchrones
       bra_adr    => PR_bra_adr,           -- Branch
       bra_cmd    => PR_bra_cmd,           -- Address to load when an effective branch
       bra_cmd_pr => PR_bra_bad,           -- Branch which have a priority on stop_pf (bad prediction branch)
       exch_adr   => vecteur_it,           -- Exception branch
       exch_cmd   => interrupt,            -- Exception vector
                                           -- Lock the stage
       stop_pf    => alea,
       -- Synchronous output to EI stage
       PF_pc      => PF_pc                 -- PC value
   );

   U2_ei : pps_ei port map (
       clock     => clock,
       reset     => reset,
       clear     => clear,                 -- Clear the pipeline stage
       stop_all  => stop_all_res,              -- Evolution locking signal
       -- Asynchronous inputs
       stop_ei   => alea,                  -- Lock the EI_adr and Ei_instr registers
       -- interface Controler - EI
       CTE_instr => icache_instr,-- CTE_instr,     -- Instruction from the memory
       ETC_adr   => ETC_adr,               -- Address to read in memory
       -- Synchronous inputs from PF stage
       PF_pc     => PF_pc,                 -- Current value of the pc
       -- Synchronous outputs to DI stage
       EI_instr  => EI_instr,              -- Read interface
       EI_adr    => EI_adr,                -- Address from the read instruction
       EI_it_ok  => EI_it_ok               -- Allow hardware interruptions
   );

   U3_di : pps_di port map (
      clock    => clock,
      reset    => reset,
      stop_all => stop_all_res,           -- Unconditionnal locking of the outputs
      clear    => clear,                  -- Clear the pipeline stage (nop in the outputs)
      -- Asynchronous connexion with the register management and data bypass unit
      adr_reg1 => adr_reg1,               -- Address of the first register operand
      adr_reg2 => adr_reg2,               -- Address of the second register operand
      use1     => use1,                   -- Effective use of operand 1
      use2     => use2,                   -- Effective use of operand 2
      stop_di  => alea,                   -- Unresolved detected : send nop in the pipeline
      data1    => data1,                  -- Operand register 1
      data2    => data2,                  -- Operand register 2
      -- Datas from EI stage
      EI_adr   => EI_adr,                 -- Address of the instruction
      EI_instr => EI_instr,               -- The instruction to decode
      EI_it_ok => EI_it_ok,               -- Allow hardware interruptions
      -- Synchronous output to EX stage
      DI_bra => DI_bra,                   -- Branch decoded 
      DI_link => DI_link,                 -- A link for that instruction
      DI_op1 => DI_op1,                   -- operand 1 for alu
      DI_op2 => DI_op2,                   -- operand 2 for alu
      DI_code_ual => DI_code_ual,         -- Alu operation
      DI_offset => DI_offset,             -- Offset for the address calculation
      DI_adr_reg_dest => DI_adr_reg_dest, -- Address of the destination register of the result
      DI_ecr_reg => DI_ecr_reg,           -- Effective writing of the result
      DI_mode => DI_mode,                 -- Address mode (relative to pc or indexed to a register)
      DI_op_mem => DI_op_mem,             -- Memory operation request
      DI_r_w => DI_r_w,                   -- Type of memory operation (reading or writing)
      DI_adr => DI_adr,                   -- Address of the decoded instruction
      DI_exc_cause => DI_exc_cause,       -- Potential exception detected
      DI_level => DI_level,               -- Availability of the result for the data bypass
      DI_it_ok => DI_it_ok                -- Allow hardware interruptions
   );

   U4_ex : pps_ex port map (
      clock => clock,
      reset => reset,
      stop_all => stop_all_res,           -- Unconditionnal locking of outputs
      clear => clear,                     -- Clear the pipeline stage
      -- Datas from DI stage
      DI_bra => DI_bra,                   -- Branch instruction
      DI_link => DI_link,                 -- Branch with link
      DI_op1 => DI_op1,                   -- Operand 1 for alu
      DI_op2 => DI_op2,                   -- Operand 2 for alu
      DI_code_ual => DI_code_ual,         -- Alu operation
      DI_offset => DI_offset,             -- Offset for address calculation
      DI_adr_reg_dest => DI_adr_reg_dest, -- Destination register address for the result
      DI_ecr_reg => DI_ecr_reg,           -- Effective writing of the result
      DI_mode => DI_mode,                 -- Address mode (relative to pc ou index by a register)
      DI_op_mem => DI_op_mem,             -- Memory operation
      DI_r_w => DI_r_w,                   -- Type of memory operation (read or write)
      DI_adr => DI_adr,                   -- Instruction address
      DI_exc_cause => DI_exc_cause,       -- Potential cause exception
      DI_level => DI_level,               -- Availability stage of the result for bypassing
      DI_it_ok => DI_it_ok,               -- Allow hardware interruptions
      -- Synchronous outputs to MEM stage
      EX_adr => EX_adr,                   -- Instruction address
      EX_bra_confirm => EX_bra_confirm,   -- Branch execution confirmation
      EX_data_ual => EX_data_ual,         -- Ual result
      EX_adresse => EX_adresse,           -- Address calculation result
      EX_adr_reg_dest => EX_adr_reg_dest, -- Destination register for the result
      EX_ecr_reg => EX_ecr_reg,           -- Effective writing of the result
      EX_op_mem => EX_op_mem,             -- Memory operation needed
      EX_r_w => EX_r_w,                   -- Type of memory operation (read or write)
      EX_exc_cause => EX_exc_cause,       -- Potential cause exception
      EX_level => EX_level,               -- Availability stage of result for bypassing
      EX_it_ok => EX_it_ok                -- Allow hardware interruptions
   );

   U5_mem : pps_mem port map (
      clock => clock,
      reset => reset,
      stop_all => stop_all_res,           -- Unconditionnal locking of the outputs
      clear => interrupt,                 -- Clear the pipeline stage
      -- Interface with the control bus
      MTC_data => MTC_data,               -- Data to write in memory
      MTC_adr => MTC_adr,                 -- Address for memory
      MTC_r_w => MTC_r_w,                 -- Read/Write in memory
      MTC_req => MTC_req,                 -- Request access to memory
      CTM_data => CTM_data,               -- Data from memory
      -- Datas from Execution stage
      EX_adr => EX_adr,                   -- Instruction address
      EX_data_ual => EX_data_ual,         -- Result of alu operation
      EX_adresse => EX_adresse,           -- Result of the calculation of the address
      EX_adr_reg_dest => EX_adr_reg_dest, -- Destination register address for the result
      EX_ecr_reg => EX_ecr_reg,           -- Effective writing of the result
      EX_op_mem => EX_op_mem,             -- Memory operation needed
      EX_r_w => EX_r_w,                   -- Type of memory operation (read or write)
      EX_exc_cause => EX_exc_cause,       -- Potential exception cause
      EX_level => EX_level,               -- Availability stage for the result for bypassing
      EX_it_ok => EX_it_ok,               -- Allow hardware interruptions
      -- Synchronous outputs for bypass unit
      MEM_adr => MEM_adr,                 -- Instruction address
      MEM_adr_reg_dest=>MEM_adr_reg_dest, -- Destination register address
      MEM_ecr_reg => MEM_ecr_reg,         -- Writing of the destination register
      MEM_data_ecr => MEM_data_ecr,       -- Data to write (from alu or memory)
      MEM_exc_cause => MEM_exc_cause,     -- Potential exception cause
      MEM_level => MEM_level,             -- Availability stage for the result for bypassing
      MEM_it_ok => MEM_it_ok              -- Allow hardware interruptions
   );

   U6_renvoi : renvoi port map (
      -- Register access signals
      adr1           => adr_reg1,         -- Operand 1 address
      adr2           => adr_reg2,         -- Operand 2 address
      use1           => use1,             -- Operand 1 utilisation
      use2           => use2,             -- Operand 2 utilisation
      data1          => data1,            -- First register value
      data2          => data2,            -- Second register value
      alea           => alea,             -- Unresolved hazards detected
      -- Bypass signals of the intermediary datas
      DI_level       => DI_level,         -- Availability level of the data
      DI_adr         => DI_adr_reg_dest,  -- Register destination of the result
      DI_ecr         => DI_ecr_reg,       -- Writing register request
      DI_data        => DI_op2,           -- Data to used
      EX_level       => EX_level,         -- Availability level of the data
      EX_adr         => EX_adr_reg_dest,  -- Register destination of the result
      EX_ecr         => EX_ecr_reg,       -- Writing register request
      EX_data        => EX_data_ual,      -- Data to used
      MEM_level      => MEM_level,        -- Availability level of the data
      MEM_adr        => MEM_adr_reg_dest, -- Register destination of the result
      MEM_ecr        => MEM_ecr_reg,      -- Writing register request
      MEM_data       => MEM_data_ecr,     -- Data to used
      interrupt      => interrupt,        -- Exceptions or interruptions
      -- Connexion to the differents bank of register
      -- Writing commands for writing in the registers
      write_data     => write_data,       -- Data to write
      write_adr      => write_adr,        -- Address of the register to write
      write_GPR      => write_GPR,        -- Selection in the internal registers
      write_SCP      => write_SCP,        -- Selection in the coprocessor system registers
      -- Reading commands for Reading in the registers
      read_adr1      => read_adr1,        -- Address of the first register to read
      read_adr2      => read_adr2,        -- Address of the second register to read
      read_data1_GPR => read_data1_GPR,   -- Value of operand 1 from the internal registers
      read_data1_SCP => read_data1_SCP,   -- Value of operand 2 from the internal registers
      read_data2_GPR => read_data2_GPR,   -- Value of operand 1 from the coprocessor system registers
      read_data2_SCP => read_data2_SCP    -- Value of operand 2 from the coprocessor system registers
   );

   U7_banc : banc port map(
      clock     => clock,
      reset     => reset,
      -- Register addresses to read
      reg_src1  => read_adr1,
      reg_src2  => read_adr2,
      -- Register address to write and its data
      reg_dest  => write_adr,
      donnee    => write_data,
      -- Write signal
      cmd_ecr   => write_GPR,
      -- Bank outputs
      data_src1 => read_data1_GPR,
      data_src2 => read_data2_GPR
   );

   U8_syscop : syscop port map (
      clock         => clock,
      reset         => reset,
      ref_reset_i   => ref_reset_i,
      cache_miss_i  => cache_miss_i,
      rst_vec       => rst_vec_o,
      cpu_num_i     => conv_std_logic_vector(cpu_id,32),
      bus_rlock     => bus_rlock_o,
      bus_lock      => bus_lock_i,
      -- Datas from the pipeline
      MEM_adr       => MEM_adr,           -- Address of the current instruction in the pipeline end -> responsible of the exception
      MEM_exc_cause => MEM_exc_cause,     -- Potential cause exception of that instruction
      MEM_it_ok     => MEM_it_ok,         -- Allow hardware interruptions
      -- Hardware interruption
      it_mat        => it_mat_clk,        -- Hardware interruption detected
      -- Interruption controls
      interrupt     => interrupt,         -- Interruption to take into account
      vecteur_it    => vecteur_it,        -- Interruption vector
      -- Writing request in register bank
      write_data    => write_data,        -- Data to write
      write_adr     => write_adr,         -- Address of the register to write
      write_SCP     => write_SCP,         -- Writing request
      -- Reading request in register bank
      read_adr1     => read_adr1,         -- Address of the first register
      read_adr2     => read_adr2,         -- Address of the second register
      read_data1    => read_data1_SCP,    -- Value of register 1
      read_data2    => read_data2_SCP     -- Value of register 2

   );

   U10_predict : predict port map (
      clock           => clock,
      reset           => reset,
      -- Datas from PF pipeline stage
      PF_pc           => PF_pc,          -- PC of the current instruction extracted
      -- Datas from DI pipeline stage
      DI_bra          => DI_bra,         -- Branch detected
      DI_adr          => DI_adr,         -- Address of the branch
      -- Datas from EX pipeline stage
      EX_bra_confirm  => EX_bra_confirm, -- Confirm if the branch test is ok
      EX_adr          => EX_adr,         -- Address of the branch
      EX_adresse      => EX_adresse,     -- Result of the branch
      EX_uncleared    => EX_it_ok,       -- Define if the EX stage is cleared               
      -- Outputs to PF pipeline stage
      PR_bra_cmd      => PR_bra_cmd,     -- Defined a branch
      PR_bra_bad      => PR_bra_bad,     -- Defined a branch to restore from a bad prediction
      PR_bra_adr      => PR_bra_adr,     -- New PC
      -- Clear the three pipeline stage : EI, DI, EX
      PR_clear        => PR_clear
   );

   immu_inst : entity work.mmu
      generic map (
         PAGE_SIZE      => IMMU_PAGE_SIZE,
         TLB_NUM        => IMMU_TLB_NUM,
         TLB_INIT       => ITLB_INIT(2*cpu_id*IMMU_TLB_NUM to (2*cpu_id+2)*IMMU_TLB_NUM-1),
         ADDR_WIDTH     => 32,
         DATA_WIDTH     => 32
      )
      port map (
         RST_i          => reset,
         CFG_CLK_i      => clock,
         CFG_WR_i       => '0',
         CFG_ADDR_i     => "000",
         CFG_DATA_i     => X"00000000",
         CFG_DATA_o     => open,
         CORE_CLK_i     => clock,
         VIRTUAL_WR_i   => '0',
         VIRTUAL_RD_i   => '0',
         VIRTUAL_EX_i   => '1',
         VIRTUAL_ADDR_i => ETC_adr,
         REAL_WR_o      => open,
         REAL_RD_o      => open,
         REAL_EX_o      => open,
         REAL_CACHE_o   => open,
         REAL_ADDR_o    => ireal_addr,
         TLB_MISS_ADDR_o=> open,
         TLB_MISS_o     => open
      );

   icache_inst : entity work.icache
      generic map (
         CACHE_SIZE  => ICACHE_SIZE,
         LINE_SIZE   => ICACHE_LINE_SIZE,
         DATA_WIDTH  => ICACHE_DATA_WIDTH,
         ADDR_WIDTH  => ICACHE_ADDR_WIDTH
      )
      port map (
         RST_i       => reset,
         BUS_CLK_i   => BUS_CLK_i,
         BUS_REQ_o   => bus_req_o(0),
         BUS_RGRANT_o=> bus_rgrant_o(0),
         BUS_GRANT_i => bus_grant_i(0),
         BUS_LAST_o  => bus_last_o(0),
         BUS_ACK_i   => bus_ack_i(0),
         BUS_VAL_i   => bus_val_i(0),
         BUS_RD_o    => bus_rd_o(0),
         BUS_WR_o    => bus_wr_o(0),
         BUS_ADDR_o  => bus_addr_o(0),
         BUS_DATA_i  => bus_rdata_i(0),
         BUS_DATA_o  => bus_wdata_o(0),
         CORE_CLK_i  => clock,
         CORE_ADDR_i => ireal_addr,
         CORE_DATA_o => icache_instr,
         CORE_STOP_o => icache_stop,
         cache_miss_o=> cache_miss_i,
         CORE_CLR_o  => open--?
      );
   bus_rdx_o(0) <= '0';

   dmmu_inst : entity work.mmu
      generic map (
         PAGE_SIZE      => DMMU_PAGE_SIZE,
         TLB_NUM        => DMMU_TLB_NUM,
         TLB_INIT       => DTLB_INIT(2*cpu_id*DMMU_TLB_NUM to (2*cpu_id+2)*DMMU_TLB_NUM-1),
         ADDR_WIDTH     => 32,
         DATA_WIDTH     => 32
      )
      port map (
         RST_i          => reset,
         CFG_CLK_i      => clock,
         CFG_WR_i       => '0',
         CFG_ADDR_i     => "0000",
         CFG_DATA_i     => X"00000000",
         CFG_DATA_o     => open,
         CORE_CLK_i     => clock,
         VIRTUAL_WR_i   => dvirtual_wr,
         VIRTUAL_RD_i   => dvirtual_rd,
         VIRTUAL_EX_i   => dvirtual_ex,
         VIRTUAL_ADDR_i => MTC_adr,
         REAL_WR_o      => dreal_wr,
         REAL_RD_o      => dreal_rd,
         REAL_EX_o      => open,
         REAL_CACHE_o   => dcache_en,
         REAL_ADDR_o    => dreal_addr,
         TLB_MISS_ADDR_o=> open,
         TLB_MISS_o     => dtlb_miss
      );

   dvirtual_wr <= MTC_r_w and MTC_req;
   dvirtual_rd <= (not MTC_r_w) and MTC_req;
   dvirtual_ex <= '0';
   dreal_req   <= MTC_req and (not dtlb_miss);
   dreal_rw    <= dreal_wr and (not dreal_rd);

   dcache_inst : entity work.dcache
      generic map (
         CACHE_SIZE   => DCACHE_SIZE,
         LINE_SIZE    => DCACHE_LINE_SIZE,
         DATA_WIDTH   => DCACHE_DATA_WIDTH,
         ADDR_WIDTH   => DCACHE_ADDR_WIDTH
      )
      port map (
         RST_i          => reset,
         BUS_CLK_i      => BUS_CLK_i,
         BUS_REQ_o      => bus_req_o(1),
         BUS_RGRANT_o   => bus_rgrant_o(1),
         BUS_GRANT_i    => bus_grant_i(1),
         BUS_MATCH_i    => bus_match_i(1),
         BUS_LAST_o     => bus_last_o(1),
         BUS_ACK_i      => bus_ack_i(1),
         BUS_VAL_i      => bus_val_i(1),
         BUS_RD_o       => bus_rd_o(1),
         BUS_RDX_o      => bus_rdx_o(1),
         BUS_WR_o       => bus_wr_o(1),
         BUS_ADDR_o     => bus_addr_o(1),
         BUS_DATA_i     => bus_rdata_i(1),
         BUS_DATA_o     => bus_wdata_o(1),
         CORE_CLK2X_i   => clock2x,
         CORE_CLK_i     => clock,
         CORE_REQ_i     => dreal_req,
         CORE_RW_i      => dreal_rw,
         CORE_ADDR_i    => dreal_addr,
         CORE_DATA_i    => MTC_data,
         CORE_DATA_o    => CTM_data,
         CORE_STOP_o    => dcache_stop,
         CORE_CLR_o     => open,--?
         CORE_CACHE_EN_i=> dcache_en,
         SNOOP_GRANT_i  => snoop_grant_i,
         SNOOP_SEL_o    => snoop_sel_o, 
         SNOOP_MATCH_o  => snoop_match_o,
         SNOOP_REQ_i    => snoop_req_i,
         SNOOP_LAST_i   => snoop_last_i,
         SNOOP_ACK_o    => snoop_ack_o,
         SNOOP_VAL_o    => snoop_val_o,
         SNOOP_RD_i     => snoop_rd_i,
         SNOOP_RDX_i    => snoop_rdx_i,
         SNOOP_WR_i     => snoop_wr_i,
         SNOOP_ADDR_i   => snoop_addr_i,
         SNOOP_DATA_o   => snoop_wdata_o,
         SNOOP_DATA_i   => snoop_rdata_i
      );

end rtl;
