/*
Copyright (c) 2014, Thiago Rider Augusto
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
    * Neither the name of the author nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

`ifndef GUARD_ENV
`define GUARD_ENV


class Environment extends uvm_env;

    `uvm_component_utils(Environment)

     Sequencer Seqncr;
     Driver Drvr;
     Receiver Rcvr[4];
     Scoreboard Sbd;
 
    function new(string name , uvm_component parent = null);
        super.new(name, parent);
    endfunction: new


    virtual function void build();
        super.build();
        uvm_report_info(get_full_name(),"START of build ",UVM_LOW);

        Drvr   = Driver::type_id::create("Drvr",this);
        Seqncr = Sequencer::type_id::create("Seqncr",this);
        
        foreach(Rcvr[i]) begin
            Rcvr[i]   = Receiver::type_id::create($psprintf("Rcvr%0d",i),this);
            Rcvr[i].id = i;
        end

        Sbd   = Scoreboard::type_id::create("Sbd",this);
        
        uvm_report_info(get_full_name(),"END of build ",UVM_LOW);
    endfunction
    
    virtual function void connect();
        super.connect();
        uvm_report_info(get_full_name(),"START of connect ",UVM_LOW);

        Drvr.seq_item_port.connect(Seqncr.seq_item_export);

        Drvr.Drvr2Sb_port.connect(Sbd.Drvr2Sb_port);

        foreach(Rcvr[i])
           Rcvr[i].Rcvr2Sb_port.connect(Sbd.Rcvr2Sb_port);

        uvm_report_info(get_full_name(),"END of connect ",UVM_LOW);
    endfunction


endclass : Environment

`endif 
