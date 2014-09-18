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
 -s u7_banc@donnee=0x1|0x2|0x9|0xA\
 -c u7_banc@reg_dest=0xD|0xE|0xF|0x10"

./assert-vcd.py $PARAMETROS

if [ $? -gt 1 ]; then
    exit 1
fi
