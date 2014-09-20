/*
Copyright (c) 2014, Thiago Rider Augusto
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
    * Neither the name of the author nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

class Seq_device0_and_device1 extends uvm_sequence #(Packet);

     function new(string name = "Seq_device0_and_device1");
         super.new(name);
     endfunction : new
 
     Packet item;
 
     `uvm_sequence_utils(Seq_device0_and_device1, Sequencer)    

     virtual task body();
        forever begin
         `uvm_do_with(item, {da == p_sequencer.cfg.device_add[0];} ); 
         `uvm_do_with(item, {da == p_sequencer.cfg.device_add[1];} ); 
        end
     endtask : body
  
endclass : Seq_device0_and_device1

class Seq_constant_length extends uvm_sequence #(Packet);

     function new(string name = "Seq_constant_length");
         super.new(name);
     endfunction : new
 
     Packet item;
 
     `uvm_sequence_utils(Seq_constant_length, Sequencer)    

     virtual task body();
        forever begin
         `uvm_do_with(item, {length == 10; da == p_sequencer.cfg.device_add[0];} ); 
        end
     endtask : body
  
endclass : Seq_constant_length

