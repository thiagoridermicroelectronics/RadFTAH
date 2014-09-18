#!/bin/bash

make
cp program.bin ../../program.bin
cp multicore_cfg_teste_1.vhd ../../src/multicore/multicore_cfg.vhd

cd ../../
if [ -e mmcc.vcd ]; then
    rm mmcc.vcd
fi

make && make run

if [ -e mmcc.vcd ]; then
    mv mmcc.vcd tests/mmcc.vcd
fi

cd tests

PARAMETROS='-f mmcc.vcd\
 -s dcache_data_inst@core_wen_i=0\
 -c dcache_data_inst@core_addr_i=0x11004\
 -c dcache_data_inst@core_data_i=0x42'

echo "===========teste 1"
./assert-vcd.py $PARAMETROS

if [ $? -gt 1 ]; then
    exit 1
fi

PARAMETROS="-f mmcc.vcd\
 -s dcache_data_inst@wen_i=0\
 -c dcache_data_inst@core_addr_i=0x11004\
 -c dcache_data_inst@core_data_i=0x42"

./assert-vcd.py $PARAMETROS

if [ $? -gt 1 ]; then
    exit 1
fi

PARAMETROS="-f mmcc.vcd\
 -s sram_inst@mem_data_io=0x42\
 -c sram_inst@mem_addr_i=0x11004\
 -c sram_inst@mem_rwn_i=0\
 -c sram_inst@mem_csn_i=0"

./assert-vcd.py $PARAMETROS

if [ $? -gt 1 ]; then
    exit 1
fi

PARAMETROS="-f mmcc.vcd\
 -s sram_inst@mem_addr_i=0x11004\
 -c sram_inst@mem_data_io=0x42\
 -c sram_inst@mem_rwn_i=1\
 -c sram_inst@mem_csn_i=0"
./assert-vcd.py $PARAMETROS

if [ $? -gt 1 ]; then
    exit 1
fi
