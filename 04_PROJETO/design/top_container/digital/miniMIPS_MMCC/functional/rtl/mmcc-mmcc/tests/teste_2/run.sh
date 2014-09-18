####################################################################
# Teste 2)
#    escreve no endereço E2, cacheável, escreve no endereço E3 que
#    mapeia no mesmo bloco que E2, assim expurgando E2 da cache.
#    Lê novamente E2 para a cache e vefifica valor na cache.
####################################################################

make
cp program.bin ../../program.bin
cp multicore_cfg_teste_2.vhd ../../src/multicore/multicore_cfg.vhd

cd ../../
if [ -e mmcc.vcd ]; then
    rm mmcc.vcd
fi
make && make run

if [ -e mmcc.vcd ]; then
    mv mmcc.vcd tests/mmcc.vcd
fi

cd tests
PARAMETROS="-f mmcc.vcd\
 -s dcache_data_inst@core_data_i=0x40|0x41|0x42|0x43|0x44|0x45|0x46|0x47\
 -c dcache_data_inst@core_addr_i=0x10000|0x10004|0x10008|0x1000c|0x10010|0x10014|0x10018|0x1001c\
 -c dcache_data_inst@core_req_i=1|1|1|1|1|1|1|1
 -c dcache_data_inst@core_wen_i=1|1|1|1|1|1|1|1"

./assert-vcd.py $PARAMETROS

if [ $? -gt 1 ]; then
    exit 1
fi

PARAMETROS="-f mmcc.vcd\
 -s dcache_data_inst@raddr=0x000|0x001|0x002|0x003|0x004|0x005|0x006|0x007 
 -c dcache_data_inst@core_addr_i=0x10000|0x10004|0x10008|0x1000c|0x10010|0x10014|0x10018|0x1001c\
 -c dcache_data_inst@core_data_i=0x40|0x41|0x42|0x43|0x44|0x45|0x46|0x47\
 -c dcache_data_inst@core_req_i=1|1|1|1|1|1|1|1
 -c dcache_data_inst@core_wen_i=1|1|1|1|1|1|1|1"

./assert-vcd.py $PARAMETROS

if [ $? -gt 1 ]; then
    exit 1
fi

PARAMETROS="-f mmcc.vcd\
 -s dcache_inst@bus_data_o=0x40|0x41|0x42|0x43|0x44|0x45|0x46|0x47\
 -c dcache_inst@bus_addr_o=0x10000|0x10004|0x10008|0x1000c|0x10010|0x10014|0x10018|0x1001c\
 -c dcache_inst@bus_req_o=1|1|1|1|1|1|1|1
 -c dcache_inst@bus_wr_o=1|1|1|1|1|1|1|1"

./assert-vcd.py $PARAMETROS

if [ $? -gt 1 ]; then
    exit 1
fi

PARAMETROS="-f mmcc.vcd\
 -s sram_inst@mem_data_io=0x40|0x41|0x42|0x43|0x44|0x45|0x46|0x47\
 -c sram_inst@mem_addr_i=0x10000|0x10004|0x10008|0x1000c|0x10010|0x10014|0x10018|0x1001c\
 -c sram_inst@mem_csn_i=1|1|1|1|1|1|1|1
 -c sram_inst@mem_rwn_i=0|0|0|0|0|0|0|0"

./assert-vcd.py $PARAMETROS

if [ $? -gt 1 ]; then
    exit 1
fi

PARAMETROS="-f mmcc.vcd\
 -s dcache_data_inst@waddr=0x000|0x001|0x002|0x003|0x004|0x005|0x006|0x007
 -c dcache_data_inst@waddr_i=0x10000|0x10004|0x10008|0x1000c|0x10010|0x10014|0x10018|0x1001c\
 -c dcache_data_inst@wdata_i=0x40|0x41|0x42|0x43|0x44|0x45|0x46|0x47\
 -c dcache_data_inst@wen_i=1|1|1|1|1|1|1|1"

./assert-vcd.py $PARAMETROS

if [ $? -gt 1 ]; then
    exit 1
fi
