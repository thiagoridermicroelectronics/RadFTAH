module testbench_rename();
parameter cycle = 10;             // clock period
parameter infile = "input.txt";
reg stall,clk,V1,V1f,validIssue,reset,StIssue,StIssu
ef,stallRR;
reg empty,nextEmpty,robSt,nextRobSt,fileClosed;
reg [1:0]CmtCount,instCyc,instCycIssue,instCycf;
reg [2:0]ArD1,ArS1a,ArS1b,ArD1f,ArS1af,ArS1bf;
//*************************************************
******
reg[2:0]ArD2,ArS2a,ArS2b;
reg V2;
wire[3:0] PrD2,PrS2a,PrS2b;
//********************************************
reg [2:0]rob[15:0];  //16 entry array of 3-bit values
reg [3:0]nextRobHead, nextRobTail, nextRobTailValue;
reg [3:0] robHead, robTail;
wire[3:0]PrD1,PrS1a,PrS1b;
wire RRStalled;
integer file,r; // declare file handle
// Instantiation of Register Rename Logic
/***********************************************************
//Changed portion of testbench: Added dummy input parameters
rename RR1(clk,reset,V1,ArD1,ArS1a,ArS1b,V2, ArD2,ArS2a,ArS2b,CmtCount,stallRR,
	   PrD1,PrS1a,PrS1b,PrD2,PrS2a,PrS2b,RRStalled);
/************************************************************
// Define a clock
initial begin clk = 1’b0;
forever #(cycle/2)  clk = !clk;
end
// break incase of infinite loop
initial #100000 $finish;
// initialize variables
initial begin
reset = 1;
file = $fopen( infile , "r");
r = 6;
fileClosed = 0;
//********************************
// Valid2 is tied to 0 permanently
V2 = 0;
//********************************
rob[0] = 0;
rob[1] = 0;
rob[2] = 0;
rob[3] = 0;
rob[4] = 0;
rob[5] = 0;
rob[6] = 0;
rob[7] = 0;
rob[8] = 0;
rob[9] = 0;
rob[10] = 0;
rob[11] = 0;
rob[12] = 0;
rob[13] = 0;
rob[14] = 0;
rob[15] = 0;
#20 reset = 0; // assert reset for 20 ns
end
