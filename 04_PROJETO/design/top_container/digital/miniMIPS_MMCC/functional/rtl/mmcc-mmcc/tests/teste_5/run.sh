##########################################################################
# Teste sistema de memória
# 3) escrever em todos os blocos da cache (talvez uns blocos a
#    menos, dependendo dos dados do programa de testes);
#    lêr e verificar valores escritos; verificar tráfego no barramento.
#########################################################################

make
cp program.bin ../../program.bin
cp makefile_5a ../../Makefile

cd ../../
if [ -e mmcc.vcd ]; then
    rm mmcc.vcd
fi
make && make run

if [ -e mmcc.vcd ]; then
    mv mmcc.vcd tests/mmcc.vcd
fi

cd tests
PAGE_WORDS=1024
ADDRESS=65536
CORE_ADDR_VALUES="D$ADDRESS"
CORE_WEN_VALUES="1"
MEM_RW_VALUES="0"
CORE_DATA_VALUES="D$PAGE_WORDS"
for ((i=$PAGE_WORDS;i>0;i--)) do
CORE_ADDR_VALUES="$CORE_ADDR_VALUES|D$ADDRESS"
CORE_DATA_VALUES="$CORE_DATA_VALUES|D$i"
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

PAGE_WORDS=1024
ADDRESS=65536
CORE_ADDR_VALUES="D$ADDRESS"
CORE_WEN_VALUES="1"
MEM_RW_VALUES="0"
CORE_DATA_VALUES="D$PAGE_WORDS"
REG_DEST_VALUES="D17"

for ((i=$PAGE_WORDS-1;i>0;i--)) do
CORE_ADDR_VALUES="$CORE_ADDR_VALUES|D$ADDRESS"
CORE_DATA_VALUES="$CORE_DATA_VALUES|D$i"
CORE_WEN_VALUES="$CORE_WEN_VALUES|1"
MEM_RW_VALUES="$MEM_RW_VALUES|0"
REG_DEST_VALUES="$REG_DEST_VALUES|D17"
ADDRESS=$(($ADDRESS+4))
done

./assert-vcd.py -f mmcc.vcd\
 -s u5_mem@mtc_adr=$CORE_ADDR_VALUES\
 -c u5_mem@ctm_data=$CORE_DATA_VALUES\
 -c u5_mem@mtc_r_w=0\
 -c u5_mem@mtc_req=1
# -c u5_mem@stop_all=1

if [ $? -gt 1 ]; then
    exit 1
fi
