onerror {resume}
virtual type { INVALID SHARED EXCLUSIVE MODIFIED} CoherType
quietly virtual function -install /multicore_top_tb/multicore_inst/bus_mux_inst -env /multicore_top_tb { (CoherType)/multicore_top_tb/multicore_inst/bus_mux_inst/bus_match_o(0)} bus_match_decoded
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Top
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/clock
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/reset
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/it_mat
add wave -noupdate -divider Pre-fetch
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u1_pf/clock
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u1_pf/reset
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u1_pf/stop_all
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u1_pf/bra_cmd
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u1_pf/bra_cmd_pr
add wave -noupdate -radix hexadecimal /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u1_pf/bra_adr
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u1_pf/exch_cmd
add wave -noupdate -radix hexadecimal /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u1_pf/exch_adr
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u1_pf/stop_pf
add wave -noupdate -radix hexadecimal /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u1_pf/pf_pc
add wave -noupdate -radix hexadecimal /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u1_pf/suivant
add wave -noupdate -radix hexadecimal /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u1_pf/pc_interne
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u1_pf/lock
add wave -noupdate -divider {EI stage}
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u2_ei/reset
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u2_ei/clear
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u2_ei/clock
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u2_ei/stop_all
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u2_ei/stop_ei
add wave -noupdate -radix hexadecimal /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u2_ei/cte_instr
add wave -noupdate -radix hexadecimal /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u2_ei/etc_adr
add wave -noupdate -radix hexadecimal /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u2_ei/pf_pc
add wave -noupdate -radix hexadecimal /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u2_ei/ei_instr
add wave -noupdate -radix hexadecimal /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u2_ei/ei_adr
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u2_ei/ei_it_ok
add wave -noupdate -radix hexadecimal /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/icache_instr
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/icache_stop
add wave -noupdate -divider DI
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u3_di/clock
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u3_di/reset
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u3_di/stop_all
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u3_di/clear
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u3_di/adr_reg1
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u3_di/adr_reg2
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u3_di/use1
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u3_di/use2
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u3_di/stop_di
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u3_di/data1
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u3_di/data2
add wave -noupdate -radix hexadecimal /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u3_di/ei_adr
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u3_di/ei_instr
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u3_di/ei_it_ok
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u3_di/di_bra
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u3_di/di_link
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u3_di/di_op1
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u3_di/di_op2
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u3_di/di_code_ual
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u3_di/di_offset
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u3_di/di_adr_reg_dest
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u3_di/di_ecr_reg
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u3_di/di_mode
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u3_di/di_op_mem
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u3_di/di_r_w
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u3_di/di_adr
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u3_di/di_exc_cause
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u3_di/di_level
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u3_di/di_it_ok
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u3_di/pre_bra
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u3_di/pre_link
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u3_di/pre_op1
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u3_di/pre_op2
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u3_di/pre_code_ual
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u3_di/pre_offset
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u3_di/pre_adr_reg_dest
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u3_di/pre_ecr_reg
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u3_di/pre_mode
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u3_di/pre_op_mem
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u3_di/pre_r_w
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u3_di/pre_exc_cause
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u3_di/pre_level
add wave -noupdate -divider EX
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u4_ex/clock
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u4_ex/reset
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u4_ex/stop_all
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u4_ex/clear
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u4_ex/di_bra
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u4_ex/di_link
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u4_ex/di_op1
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u4_ex/di_op2
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u4_ex/di_code_ual
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u4_ex/di_offset
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u4_ex/di_adr_reg_dest
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u4_ex/di_ecr_reg
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u4_ex/di_mode
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u4_ex/di_op_mem
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u4_ex/di_r_w
add wave -noupdate -radix hexadecimal /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u4_ex/di_adr
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u4_ex/di_exc_cause
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u4_ex/di_level
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u4_ex/di_it_ok
add wave -noupdate -radix hexadecimal /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u4_ex/ex_adr
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u4_ex/ex_bra_confirm
add wave -noupdate -radix hexadecimal /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u4_ex/ex_data_ual
add wave -noupdate -radix hexadecimal /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u4_ex/ex_adresse
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u4_ex/ex_adr_reg_dest
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u4_ex/ex_ecr_reg
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u4_ex/ex_op_mem
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u4_ex/ex_r_w
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u4_ex/ex_exc_cause
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u4_ex/ex_level
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u4_ex/ex_it_ok
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u4_ex/res_ual
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u4_ex/base_adr
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u4_ex/pre_ecr_reg
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u4_ex/pre_data_ual
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u4_ex/pre_bra_confirm
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u4_ex/pre_exc_cause
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u4_ex/overflow_ual
add wave -noupdate -divider Registers
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u7_banc/clock
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u7_banc/reset
add wave -noupdate -radix unsigned /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u7_banc/reg_src1
add wave -noupdate -radix unsigned /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u7_banc/reg_src2
add wave -noupdate -radix unsigned /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u7_banc/reg_dest
add wave -noupdate -radix hexadecimal /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u7_banc/donnee
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u7_banc/cmd_ecr
add wave -noupdate -radix hexadecimal /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u7_banc/data_src1
add wave -noupdate -radix hexadecimal /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u7_banc/data_src2
add wave -noupdate -radix hexadecimal /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u7_banc/registres_0
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u7_banc/adr_src1
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u7_banc/adr_src2
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u7_banc/adr_dest
add wave -noupdate -divider Memory
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u5_mem/clock
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u5_mem/reset
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u5_mem/stop_all
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u5_mem/clear
add wave -noupdate -radix hexadecimal /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u5_mem/mtc_data
add wave -noupdate -radix hexadecimal /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u5_mem/mtc_adr
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u5_mem/mtc_r_w
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u5_mem/mtc_req
add wave -noupdate -radix hexadecimal /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u5_mem/ctm_data
add wave -noupdate -radix hexadecimal /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u5_mem/ex_adr
add wave -noupdate -radix hexadecimal /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u5_mem/ex_data_ual
add wave -noupdate -radix hexadecimal /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u5_mem/ex_adresse
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u5_mem/ex_adr_reg_dest
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u5_mem/ex_ecr_reg
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u5_mem/ex_op_mem
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u5_mem/ex_r_w
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u5_mem/ex_exc_cause
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u5_mem/ex_level
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u5_mem/ex_it_ok
add wave -noupdate -radix hexadecimal /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u5_mem/mem_adr
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u5_mem/mem_adr_reg_dest
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u5_mem/mem_ecr_reg
add wave -noupdate -radix hexadecimal /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u5_mem/mem_data_ecr
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u5_mem/mem_exc_cause
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u5_mem/mem_level
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u5_mem/mem_it_ok
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u5_mem/tmp_data_ecr
add wave -noupdate -divider Dcache
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/rst_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/bus_clk_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/bus_req_o
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/bus_rgrant_o
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/bus_grant_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/bus_match_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/bus_last_o
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/bus_ack_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/bus_val_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/bus_rd_o
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/bus_rdx_o
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/bus_wr_o
add wave -noupdate -radix hexadecimal /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/bus_addr_o
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/bus_data_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/bus_data_o
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/snoop_match_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/miss_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/loadx_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/load_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/flush_i
add wave -noupdate -radix hexadecimal /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/miss_addr_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/miss_data_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/cache_data_i
add wave -noupdate -radix hexadecimal /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/cache_addr_o
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/cache_wen_o
add wave -noupdate -radix hexadecimal /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/cache_data_o
add wave -noupdate -radix hexadecimal /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/rtagdata_i
add wave -noupdate -radix hexadecimal /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/wtagaddr_o
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/wupdate_o
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/wstatus_o
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/rstatus_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/snoop_grant_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/snoop_sel_o
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/snoop_match_o
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/snoop_req_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/snoop_last_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/snoop_ack_o
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/snoop_val_o
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/snoop_rd_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/snoop_rdx_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/snoop_wr_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/snoop_addr_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/snoop_data_o
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/snoop_data_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/miss_mask
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/cur_st
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/miss_int
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/mem_cnt
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/cache_cnt
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/first
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/mem_cnt_plus
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/snoop_last_int
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_loader_inst/cache_en_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_data_inst/rst_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_data_inst/wclk_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_data_inst/waddr_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_data_inst/wen_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_data_inst/wdata_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_data_inst/rdata_o
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_data_inst/core_req_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_data_inst/core_wen_i
add wave -noupdate -radix hexadecimal /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_data_inst/core_data_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_data_inst/core_clk_i
add wave -noupdate -radix hexadecimal /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_data_inst/core_addr_i
add wave -noupdate -radix hexadecimal /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_data_inst/core_data_o
add wave -noupdate -radix hexadecimal /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_data_inst/raddr
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/dcache_data_inst/waddr
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/rst_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/bus_clk_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/bus_req_o
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/bus_rgrant_o
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/bus_grant_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/bus_match_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/bus_last_o
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/bus_ack_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/bus_val_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/bus_rd_o
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/bus_rdx_o
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/bus_wr_o
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/bus_addr_o
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/bus_data_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/bus_data_o
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/core_clk2x_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/core_clk_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/core_req_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/core_rw_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/core_addr_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/core_data_o
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/core_data_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/core_stop_o
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/core_clr_o
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/snoop_grant_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/snoop_sel_o
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/snoop_match_o
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/snoop_req_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/snoop_last_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/snoop_ack_o
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/snoop_val_o
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/snoop_rd_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/snoop_rdx_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/snoop_wr_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/snoop_addr_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/snoop_data_o
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/snoop_data_i
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/rtagdata
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/wtagaddr
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/wupdate
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/wstatus
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/rstatus
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/snoop_match
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/hit
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/miss
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/loadx
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/load
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/flush
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/bus_req
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/wdataaddr
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/wen
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/wdata
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/rdata
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/core_wen
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/miss_d
add wave -noupdate /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/dcache_inst/tag_valid
add wave -noupdate -divider {Per Bus}
add wave -noupdate -radix hexadecimal /multicore_top_tb/multicore_inst/per_addr_o
add wave -noupdate /multicore_top_tb/multicore_inst/per_csn_o
add wave -noupdate /multicore_top_tb/multicore_inst/per_data_i
add wave -noupdate /multicore_top_tb/multicore_inst/per_data_o
add wave -noupdate /multicore_top_tb/multicore_inst/per_rwn_o
add wave -noupdate -divider UART
add wave -noupdate /multicore_top_tb/uart_inst/cpu_csn_i
add wave -noupdate /multicore_top_tb/uart_inst/cpu_rwn_i
add wave -noupdate -radix ascii /multicore_top_tb/uart_inst/cpu_data_i
add wave -noupdate /multicore_top_tb/uart_inst/tx_full_o
add wave -noupdate /multicore_top_tb/uart_inst/tx_fifo_valid
add wave -noupdate -radix ascii /multicore_top_tb/uart_inst/tx_fifo_rdata
add wave -noupdate /multicore_top_tb/uart_inst/cur_tx_st
add wave -noupdate /multicore_top_tb/uart_inst/txd_o
add wave -noupdate /multicore_top_tb/string_out
add wave -noupdate -divider {Bus mux}
add wave -noupdate -radix unsigned /multicore_top_tb/multicore_inst/cpu_gen(0)/cpu_core/u8_syscop/clk_counter
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/bus_clk_i
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/bus_rlock_i
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/bus_lock_o
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/bus_rgrant_i
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/bus_grant_o
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/bus_match_o
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/bus_req_i
add wave -noupdate -radix hexadecimal /multicore_top_tb/multicore_inst/bus_mux_inst/bus_addr_i
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/bus_rd_i
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/bus_last_i
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/bus_ack_o
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/bus_val_o
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/bus_rdx_i
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/bus_wr_i
add wave -noupdate -radix hexadecimal /multicore_top_tb/multicore_inst/bus_mux_inst/bus_data_o
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/bus_data_i
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/ctrl_sel_i
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/ctrl_req_o
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/ctrl_last_o
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/ctrl_ack_i
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/ctrl_val_i
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/ctrl_rd_o
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/ctrl_wr_o
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/ctrl_addr_o
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/ctrl_data_i
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/ctrl_data_o
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/snoop_grant_o
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/snoop_sel_i
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/snoop_match_i
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/snoop_req_o
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/snoop_last_o
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/snoop_ack_i
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/snoop_val_i
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/snoop_rd_o
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/snoop_rdx_o
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/snoop_wr_o
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/snoop_addr_o
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/snoop_data_i
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/snoop_data_o
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/sel_integer
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/grant_integer
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/grant_int
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/granted
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/ctrl_sel
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/snoop_sel
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/bus_rgrant_int
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/bus_rlock_int
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/lock_int
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/locked
add wave -noupdate /multicore_top_tb/multicore_inst/bus_mux_inst/lock_integer
add wave -noupdate -divider ZBT
add wave -noupdate /multicore_top_tb/multicore_inst/zbt_ctrlgen/zbt_ctrl_inst/rst_i
add wave -noupdate /multicore_top_tb/multicore_inst/zbt_ctrlgen/zbt_ctrl_inst/lck_o
add wave -noupdate /multicore_top_tb/multicore_inst/zbt_ctrlgen/zbt_ctrl_inst/dq_io
add wave -noupdate /multicore_top_tb/multicore_inst/zbt_ctrlgen/zbt_ctrl_inst/addr_o
add wave -noupdate /multicore_top_tb/multicore_inst/zbt_ctrlgen/zbt_ctrl_inst/lbon_o
add wave -noupdate /multicore_top_tb/multicore_inst/zbt_ctrlgen/zbt_ctrl_inst/clk_o
add wave -noupdate /multicore_top_tb/multicore_inst/zbt_ctrlgen/zbt_ctrl_inst/cken_o
add wave -noupdate /multicore_top_tb/multicore_inst/zbt_ctrlgen/zbt_ctrl_inst/ldn_o
add wave -noupdate /multicore_top_tb/multicore_inst/zbt_ctrlgen/zbt_ctrl_inst/bwn_o
add wave -noupdate /multicore_top_tb/multicore_inst/zbt_ctrlgen/zbt_ctrl_inst/rwn_o
add wave -noupdate /multicore_top_tb/multicore_inst/zbt_ctrlgen/zbt_ctrl_inst/cen_o
add wave -noupdate /multicore_top_tb/multicore_inst/zbt_ctrlgen/zbt_ctrl_inst/oen_o
add wave -noupdate /multicore_top_tb/multicore_inst/zbt_ctrlgen/zbt_ctrl_inst/ce2_o
add wave -noupdate /multicore_top_tb/multicore_inst/zbt_ctrlgen/zbt_ctrl_inst/ce2n_o
add wave -noupdate /multicore_top_tb/multicore_inst/zbt_ctrlgen/zbt_ctrl_inst/zz_o
add wave -noupdate /multicore_top_tb/multicore_inst/zbt_ctrlgen/zbt_ctrl_inst/bus_clk_i
add wave -noupdate /multicore_top_tb/multicore_inst/zbt_ctrlgen/zbt_ctrl_inst/bus_req_i
add wave -noupdate /multicore_top_tb/multicore_inst/zbt_ctrlgen/zbt_ctrl_inst/bus_last_i
add wave -noupdate /multicore_top_tb/multicore_inst/zbt_ctrlgen/zbt_ctrl_inst/bus_ack_o
add wave -noupdate /multicore_top_tb/multicore_inst/zbt_ctrlgen/zbt_ctrl_inst/bus_val_o
add wave -noupdate /multicore_top_tb/multicore_inst/zbt_ctrlgen/zbt_ctrl_inst/bus_rd_i
add wave -noupdate /multicore_top_tb/multicore_inst/zbt_ctrlgen/zbt_ctrl_inst/bus_wr_i
add wave -noupdate /multicore_top_tb/multicore_inst/zbt_ctrlgen/zbt_ctrl_inst/bus_addr_i
add wave -noupdate /multicore_top_tb/multicore_inst/zbt_ctrlgen/zbt_ctrl_inst/bus_data_o
add wave -noupdate /multicore_top_tb/multicore_inst/zbt_ctrlgen/zbt_ctrl_inst/bus_data_i
add wave -noupdate /multicore_top_tb/multicore_inst/zbt_ctrlgen/zbt_ctrl_inst/bus_sel_o
add wave -noupdate /multicore_top_tb/multicore_inst/zbt_ctrlgen/zbt_ctrl_inst/valid_addr
add wave -noupdate /multicore_top_tb/multicore_inst/zbt_ctrlgen/zbt_ctrl_inst/wr_reg
add wave -noupdate /multicore_top_tb/multicore_inst/zbt_ctrlgen/zbt_ctrl_inst/rd_reg
add wave -noupdate /multicore_top_tb/multicore_inst/zbt_ctrlgen/zbt_ctrl_inst/sel_reg
add wave -noupdate /multicore_top_tb/multicore_inst/zbt_ctrlgen/zbt_ctrl_inst/data_reg
add wave -noupdate /multicore_top_tb/multicore_inst/zbt_ctrlgen/zbt_ctrl_inst/addr_reg
add wave -noupdate /multicore_top_tb/multicore_inst/zbt_ctrlgen/zbt_ctrl_inst/ack_int
add wave -noupdate /multicore_top_tb/multicore_inst/zbt_ctrlgen/zbt_ctrl_inst/clk_int
add wave -noupdate /multicore_top_tb/multicore_inst/zbt_ctrlgen/zbt_ctrl_inst/clk_fb
add wave -noupdate /multicore_top_tb/multicore_inst/zbt_ctrlgen/zbt_ctrl_inst/last_d
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 2} {17845330 ps} 0}
configure wave -namecolwidth 378
configure wave -valuecolwidth 107
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {55291150 ps} {261574150 ps}
bookmark add wave {Grant Request} {{1610682 ps} {2260536 ps}} 0
