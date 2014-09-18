#!/bin/bash

function teste_1(){
####################################################################
# Teste 1)
# escreve no endereço E1 e lê do mesmo endereço, desviando da cache;
# verificar se o bloco da cache no qual E1 é mapeado foi alterado
# (cache não pode ter sido alterada)
####################################################################
  cd teste_1/
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
  PARAMETROS="-f mmcc.vcd\
 -m dcache_data_inst\
 -s core_wen_i=0\
 -c core_addr_i=0x11004\
 -c core_data_i=0x42"

  ./assert-vcd.py $PARAMETROS

  if [ $? -gt 1 ]; then
    exit 1
  fi

  PARAMETROS="-f mmcc.vcd\
 -m dcache_data_inst\
 -s wen_i=0\
 -c core_addr_i=0x11004\
 -c core_data_i=0x42"

  ./assert-vcd.py $PARAMETROS

  if [ $? -gt 1 ]; then
    exit 1
  fi

  PARAMETROS="-f mmcc.vcd\
 -m sram_inst\
 -s mem_data_io=0x42\
 -c mem_addr_i=0x11004\
 -c mem_rwn_i=0\
 -c mem_csn_i=0"

  ./assert-vcd.py $PARAMETROS

  if [ $? -gt 1 ]; then
    exit 1
  fi

  PARAMETROS="-f mmcc.vcd\
 -m sram_inst\
 -s mem_addr_i=0x11004\
 -c mem_data_io=0x42\
 -c mem_rwn_i=1\
 -c mem_csn_i=0"
  ./assert-vcd.py $PARAMETROS
  if [ $? -gt 1 ]; then
    exit 1
  fi

}

function teste_2(){
####################################################################
# Teste 2)
#    escreve no endereço E2, cacheável, escreve no endereço E3 que
#    mapeia no mesmo bloco que E2, assim expurgando E2 da cache.
#    Lê novamente E2 para a cache e vefifica valor na cache.
####################################################################
  cd teste_2/
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
 -m dcache_data_inst\
 -s core_data_i=0x40|0x41|0x42|0x43|0x44|0x45|0x46|0x47\
 -c core_addr_i=0x10000|0x10004|0x10008|0x1000c|0x10010|0x10014|0x10018|0x1001c\
 -c core_req_i=1|1|1|1|1|1|1|1
 -c core_wen_i=1|1|1|1|1|1|1|1"

  ./assert-vcd.py $PARAMETROS

  if [ $? -gt 1 ]; then
    exit 1
  fi

  PARAMETROS="-f mmcc.vcd\
 -m dcache_data_inst\
 -s raddr=0x000|0x001|0x002|0x003|0x004|0x005|0x006|0x007 
 -c core_addr_i=0x10000|0x10004|0x10008|0x1000c|0x10010|0x10014|0x10018|0x1001c\
 -c core_data_i=0x40|0x41|0x42|0x43|0x44|0x45|0x46|0x47\
 -c core_req_i=1|1|1|1|1|1|1|1
 -c core_wen_i=1|1|1|1|1|1|1|1"

  ./assert-vcd.py $PARAMETROS

  if [ $? -gt 1 ]; then
    exit 1
  fi

  PARAMETROS="-f mmcc.vcd\
 -m dcache_inst\
 -s bus_data_o=0x40|0x41|0x42|0x43|0x44|0x45|0x46|0x47\
 -c bus_addr_o=0x10000|0x10004|0x10008|0x1000c|0x10010|0x10014|0x10018|0x1001c\
 -c bus_req_o=1|1|1|1|1|1|1|1
 -c bus_wr_o=1|1|1|1|1|1|1|1"

 ./assert-vcd.py $PARAMETROS

  if [ $? -gt 1 ]; then
    exit 1
  fi

  PARAMETROS="-f mmcc.vcd\
 -m sram_inst\
 -s mem_data_io=0x40|0x41|0x42|0x43|0x44|0x45|0x46|0x47\
 -c mem_addr_i=0x10000|0x10004|0x10008|0x1000c|0x10010|0x10014|0x10018|0x1001c\
 -c mem_csn_i=1|1|1|1|1|1|1|1
 -c mem_rwn_i=0|0|0|0|0|0|0|0"

 ./assert-vcd.py $PARAMETROS

  if [ $? -gt 1 ]; then
    exit 1
  fi

  PARAMETROS="-f mmcc.vcd\
 -m dcache_data_inst\
 -s waddr=0x000|0x001|0x002|0x003|0x004|0x005|0x006|0x007 
 -c waddr_i=0x10000|0x10004|0x10008|0x1000c|0x10010|0x10014|0x10018|0x1001c\
 -c wdata_i=0x40|0x41|0x42|0x43|0x44|0x45|0x46|0x47\
 -c wen_i=1|1|1|1|1|1|1|1"

  ./assert-vcd.py $PARAMETROS

  if [ $? -gt 1 ]; then
    exit 1
  fi
}

function teste_3(){
##########################################################################
# Teste sistema de memória
# 3) escrever em todos os blocos da cache (talvez uns blocos a
#    menos, dependendo dos dados do programa de testes);
#    lêr e verificar valores escritos; verificar tráfego no barramento.
#########################################################################

  cd teste_3/
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
  ./assert-vcd.py -f mmcc.vcd -m dcache_data_inst\
 -s core_data_i=$CORE_DATA_VALUES\
 -c core_addr_i=$CORE_ADDR_VALUES\
 -c core_req_i=$CORE_WEN_VALUES\
 -c core_wen_i=$CORE_WEN_VALUES
 ./assert-vcd.py -f mmcc.vcd -m u5_mem\
 -s ctm_data=$CORE_DATA_VALUES\
 -c mtc_adr=$CORE_ADDR_VALUES\
 -c mtc_req=$CORE_WEN_VALUES\
 -c mtc_r_w=$MEM_RW_VALUES

}

function teste_4(){
  cd teste_4/
  make
  cp program.bin ../../program.bin

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
 -m u7_banc\
 -s donnee=0x1|0x2|0x9|0xA\
 -c reg_dest=0xD|0xE|0xF|0x10"

  ./assert-vcd.py $PARAMETROS

  if [ $? -gt 1 ]; then
    exit 1
  fi
}
###########################################################
cp ../src/multicore/multicore_cfg.vhd multicore_cfg.vhd.bak
cp ../Makefile Makefile.bak

teste_1
teste_2
teste_3
clear
echo "teste 4"
teste_4

if [ -e mmcc.vcd ]; then
  rm mmcc.vcd
fi

cp multicore_cfg.vhd.bak ../src/multicore/multicore_cfg.vhd
cp Makefile.bak ../Makefile
exit 0
