##########################################################################
# Teste sistema de memória
# 3) escrever em todos os blocos da cache (talvez uns blocos a
#    menos, dependendo dos dados do programa de testes);
#    lêr e verificar valores escritos; verificar tráfego no barramento.
#########################################################################

make
cp program.bin ../../program.bin
cp multicore_cfg_teste_3.vhd ../../src/multicore/multicore_cfg.vhd
cp makefile_3 ../../Makefile

cd ../../
if [ -e mmcc.vcd ]; then
    rm mmcc.vcd
fi
make && make run

if [ -e mmcc.vcd ]; then
    mv mmcc.vcd tests/mmcc.vcd
fi

CACHE_WORDS=512
WVALUE="0x42"
ADDRESS=65536
CORE_ADDR_VALUES="D$ADDRESS"
CORE_DATA_VALUES="$WVALUE"
CORE_WEN_VALUES="1"
MEM_RW_VALUES="0"
cd tests

for ((i=0;i<$CACHE_WORDS;i++)) do
CORE_ADDR_VALUES="$CORE_ADDR_VALUES|D$ADDRESS"
CORE_DATA_VALUES="$CORE_DATA_VALUES|$WVALUE"
CORE_WEN_VALUES="$CORE_WEN_VALUES|1"
MEM_RW_VALUES="$MEM_RW_VALUES|0"
ADDRESS=$(($ADDRESS+4))
done

./assert-vcd.py -f mmcc.vcd\
 -s dcache_data_inst@core_data_i=$CORE_DATA_VALUES\
 -c dcache_data_inst@core_addr_i=$CORE_ADDR_VALUES\
 -c dcache_data_inst@core_req_i=$CORE_WEN_VALUES\
 -c dcache_data_inst@core_wen_i=$CORE_WEN_VALUES

if [ $? -gt 1 ]; then
    exit 1
fi

./assert-vcd.py -f mmcc.vcd\
 -s u5_mem@ctm_data=$CORE_DATA_VALUES\
 -c u5_mem@mtc_adr=$CORE_ADDR_VALUES\
 -c u5_mem@mtc_req=$CORE_WEN_VALUES\
 -c u5_mem@mtc_r_w=$MEM_RW_VALUES

if [ $? -gt 1 ]; then
    exit 1
fi
