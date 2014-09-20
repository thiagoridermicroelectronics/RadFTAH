/*
Copyright (c) 2014, Thiago Rider Augusto
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
    * Neither the name of the author nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

`ifndef GUARD_DRIVER
`define GUARD_DRIVER

class Driver extends uvm_driver #(Packet);

    Configuration cfg;
   
    virtual input_interface.IP   input_intf;
    virtual mem_interface.MEM  mem_intf;
    
    uvm_analysis_port #(Packet) Drvr2Sb_port;

    `uvm_component_utils(Driver) 
   
    function new( string name = "" , uvm_component parent = null) ;
        super.new( name , parent );
    endfunction : new
   
    virtual function void build();
        super.build();
        Drvr2Sb_port = new("Drvr2Sb", this);
    endfunction :  build
   
    virtual function void end_of_elaboration();
        uvm_object tmp;
        super.end_of_elaboration();
        assert(get_config_object("Configuration",tmp));
        $cast(cfg,tmp);
        this.input_intf = cfg.input_intf;
        this.mem_intf = cfg.mem_intf;
    endfunction : end_of_elaboration

    virtual task run();
        Packet pkt;
        @(input_intf.cb);
        reset_dut();
        cfg_dut();
        forever begin
            seq_item_port.get_next_item(pkt);
            Drvr2Sb_port.write(pkt);
            @(input_intf.cb);
            drive(pkt);
            @(input_intf.cb);
            seq_item_port.item_done();
        end
    endtask : run
   
    virtual task reset_dut();
        uvm_report_info(get_full_name(),"Start of reset_dut() method ",UVM_LOW);
        mem_intf.cb.mem_data      <= 0;
        mem_intf.cb.mem_add       <= 0;
        mem_intf.cb.mem_en        <= 0;
        mem_intf.cb.mem_rd_wr     <= 0;
        input_intf.cb.data_in     <= 0;
        input_intf.cb.data_status <= 0;
        
        input_intf.reset       <= 1;
        repeat (4) @ input_intf.clock;
        input_intf.reset       <= 0;
   
        uvm_report_info(get_full_name(),"End of reset_dut() method ",UVM_LOW);
    endtask : reset_dut
   
    virtual task cfg_dut();
        uvm_report_info(get_full_name(),"Start of cfg_dut() method ",UVM_LOW);
        mem_intf.cb.mem_en <= 1;
        @(mem_intf.cb);
        mem_intf.cb.mem_rd_wr <= 1;

        foreach (cfg.device_add[i])  begin 

            @(mem_intf.cb);
            mem_intf.cb.mem_add  <= i;
            mem_intf.cb.mem_data <= cfg.device_add[i];
            uvm_report_info(get_full_name(),$psprintf(" Port %0d Address %h ",i,cfg.device_add[i]),UVM_LOW);
        
        end
        
        @(mem_intf.cb);
        mem_intf.cb.mem_en    <=0;
        mem_intf.cb.mem_rd_wr <= 0;
        mem_intf.cb.mem_add   <= 0;
        mem_intf.cb.mem_data  <= 0;
   
        uvm_report_info(get_full_name(),"End of cfg_dut() method ",UVM_LOW);
    endtask : cfg_dut
   
    virtual task drive(Packet pkt);
         byte unsigned  bytes[];
         int pkt_len;
         pkt_len = pkt.pack_bytes(bytes);
         uvm_report_info(get_full_name(),"Driving packet ...",UVM_LOW);
         foreach(bytes[i])
         begin
             @(input_intf.cb);
             input_intf.cb.data_status <= 1 ;
             input_intf.cb.data_in <= bytes[i];
         end
   
         @(input_intf.cb);
         input_intf.cb.data_status <= 0 ;
         input_intf.cb.data_in <= 0;
         repeat(2) @(input_intf.cb);
   endtask : drive

endclass : Driver

`endif

