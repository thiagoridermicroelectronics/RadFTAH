/*
Copyright (c) 2014, Thiago Rider Augusto
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
    * Neither the name of the author nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

`ifndef GUARD_INTERFACE
`define GUARD_INTERFACE


//////////////////////////////////////////
// Interface declaration for the memory///
//////////////////////////////////////////

interface mem_ram_interface(input bit clock);

    parameter setup_time = 5ns;
    parameter hold_time = 3ns;

    wire [7:0] mem_data;
    wire [1:0] mem_add;
    wire       mem_en;
    wire       mem_rd_wr;
    
    clocking cb@(posedge clock);
       default input #setup_time output #hold_time;
       output     mem_data;
       output      mem_add;
       output mem_en;
       output mem_rd_wr;
    endclocking:cb
    
    modport MEM(clocking cb,input clock);

endinterface :mem_interface

////////////////////////////////////////////
// Interface for the input side of switch.//
// Reset signal is also passed hear.      //
////////////////////////////////////////////
interface input_interface(input bit clock);

    parameter setup_time = 5ns;
    parameter hold_time = 3ns;

    wire           data_status;
    wire     [7:0] data_in;
    reg            reset; 

    clocking cb@(posedge clock);
       default input #setup_time output #hold_time;
       output    data_status;
       output    data_in;
    endclocking:cb
    
    modport IP(clocking cb,output reset,input clock);
  
endinterface:input_interface

/////////////////////////////////////////////////
// Interface for the output side of the switch.//
// output_interface is for only one output port//
/////////////////////////////////////////////////

interface output_interface(input bit clock);

    parameter setup_time = 5ns;
    parameter hold_time = 3ns;

    wire    [7:0] data_out;
    wire    ready;
    wire    read;
    
    clocking cb@(posedge clock);
      default input #setup_time output #hold_time;
      input     data_out;
      input     ready;
      output    read;
    endclocking:cb
    
    modport OP(clocking cb,input clock);

endinterface:output_interface

//////////////////////////////////////////////////

`endif 
