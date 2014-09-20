/*
Copyright (c) 2014, Thiago Rider Augusto
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
    * Neither the name of the author nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

`ifndef GUARD_TOP
`define GUARD_TOP
/////////////////////////////////////////////////////
// Importing UVM Packages                          //
/////////////////////////////////////////////////////

 `include "uvm.svh"
import uvm_pkg::* ;

module top();

`include "Configuration.sv"
`include "Packet.sv"
`include "Sequencer.sv"
`include "Sequence.sv"
`include "Driver.sv"
`include "Receiver.sv"
`include "Scoreboard.sv" 
`include "Environment.sv"
`include "test.sv"

/////////////////////////////////////////////////////
// Clock Declaration and Generation                //
/////////////////////////////////////////////////////
    bit Clock;
    
    initial
      begin
          #20;
          forever #10 Clock = ~Clock;
      end
/////////////////////////////////////////////////////
//  Memory interface instance                      //
/////////////////////////////////////////////////////

    mem_interface mem_intf(Clock);

/////////////////////////////////////////////////////
//  Input interface instance                       //
/////////////////////////////////////////////////////

    input_interface input_intf(Clock);

/////////////////////////////////////////////////////
//  output interface instance                      //
/////////////////////////////////////////////////////

    output_interface output_intf[4](Clock);

/////////////////////////////////////////////////////
// Creat Configuration and Strart the run_test//
/////////////////////////////////////////////////////


    Configuration cfg;

initial begin
    cfg = new();
    cfg.input_intf = input_intf;
    cfg.mem_intf = mem_intf;
    cfg.output_intf = output_intf;
   
    run_test();
end

/////////////////////////////////////////////////////
//  DUT instance and signal connection             //
/////////////////////////////////////////////////////

switch DUT    (.clk(Clock),
               .reset(input_intf.reset),
               .data_status(input_intf.data_status),
               .data(input_intf.data_in),
               .port0(output_intf[0].data_out),
               .port1(output_intf[1].data_out),
               .port2(output_intf[2].data_out),
               .port3(output_intf[3].data_out),
               .ready_0(output_intf[0].ready),
               .ready_1(output_intf[1].ready),
               .ready_2(output_intf[2].ready),
               .ready_3(output_intf[3].ready),
               .read_0(output_intf[0].read),
               .read_1(output_intf[1].read),
               .read_2(output_intf[2].read),
               .read_3(output_intf[3].read),
               .mem_en(mem_intf.mem_en),
               .mem_rd_wr(mem_intf.mem_rd_wr),
               .mem_add(mem_intf.mem_add),
               .mem_data(mem_intf.mem_data));


endmodule : top


`endif


























