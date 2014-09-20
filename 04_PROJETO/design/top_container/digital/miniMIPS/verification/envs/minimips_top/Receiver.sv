/*
Copyright (c) 2014, Thiago Rider Augusto
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
    * Neither the name of the author nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

`ifndef GUARD_RECEIVER
`define GUARD_RECEIVER

class Receiver extends uvm_component;

    virtual output_interface.OP output_intf;

    Configuration cfg;

    integer id;

    uvm_analysis_port #(Packet) Rcvr2Sb_port;

   `uvm_component_utils(Receiver) 

    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new


    virtual function void build();
        super.build();
        Rcvr2Sb_port = new("Rcvr2Sb", this);
    endfunction : build

    virtual function void end_of_elaboration();
        uvm_object tmp;
        super.end_of_elaboration();
        assert(get_config_object("Configuration",tmp));
        $cast(cfg,tmp);
        output_intf = cfg.output_intf[id]; 
    endfunction : end_of_elaboration

    virtual task run();
    Packet pkt;
         fork
         forever
         begin
            // declare the queue and dynamic array here 
	    // so they are automatically allocated for every packet
             bit [7:0] bq[$],bytes[];

             repeat(2) @(posedge output_intf.clock);
             wait(output_intf.cb.ready)
             output_intf.cb.read <= 1;  
    
             repeat(2) @(posedge output_intf.clock);
             while (output_intf.cb.ready)
             begin
                  bq.push_back(output_intf.cb.data_out);
                  @(posedge output_intf.clock);
             end
             bytes = new[bq.size()] (bq); // Copy queue into dyn array

             output_intf.cb.read <= 0;   
             @(posedge output_intf.clock);
             uvm_report_info(get_full_name(),"Received packet ...",UVM_LOW);
             pkt = new();
             void'(pkt.unpack_bytes(bytes));
             Rcvr2Sb_port.write(pkt);
         end
         join

     endtask : run


endclass :  Receiver

`endif

