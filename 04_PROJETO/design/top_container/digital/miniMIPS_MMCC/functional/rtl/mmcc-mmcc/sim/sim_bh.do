vlib work

vcom -93 ../src/utils_pkg.vhd
vcom -93 ../src/coherence_pkg.vhd
vcom -93 ../src/multicore_cfg.vhd
vcom -93 ../src/memory.vhd
vcom -93 ../src/memory_ctrl.vhd
vcom -93 ../src/asyncmem_ctrl.vhd
vcom -93 ../src/zbt_ctrl.vhd
vcom -93 ../src/bus_mux.vhd
vcom -93 ../src/dcache_tag.vhd
vcom -93 ../src/dcache_data.vhd
vcom -93 ../src/dcache_loader.vhd
vcom -93 ../src/dcache.vhd
vcom -93 ../src/icache_tag.vhd
vcom -93 ../src/icache_data.vhd
vcom -93 ../src/icache_loader.vhd
vcom -93 ../src/icache.vhd
vcom -93 ../src/pack_mips.vhd
vcom -93 ../src/alu.vhd
vcom -93 ../src/banc.vhd
vcom -93 ../src/pps_di.vhd
vcom -93 ../src/pps_ei.vhd
vcom -93 ../src/pps_ex.vhd
vcom -93 ../src/pps_mem.vhd
vcom -93 ../src/pps_pf.vhd
vcom -93 ../src/predict.vhd
vcom -93 ../src/renvoi.vhd
vcom -93 ../src/syscop.vhd
vcom -93 ../src/mmu.vhd
vcom -93 ../src/minimips.vhd
vcom -93 ../src/uart.vhd
vcom -93 ../xil_cores/dis_fifo.vhd
vcom -93 ../src/multicore_top.vhd
vcom -93 ../bench/package_utility.vhd
vcom -93 ../bench/CY7C1354C.vhd
vcom -93 ../bench/flash_mem.vhd
vcom -93 ../bench/sram_mem.vhd
vcom -93 ../bench/multicore_top_tb.vhd
vsim -t 1ps -wlf sim_bh.wlf -wlfthreads work.multicore_top_tb(multicore_top_tb)
do sig_bh.do
run 3400000 ns