/*
Copyright (c) 2014, Thiago Rider Augusto
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
    * Neither the name of the author nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

`ifndef GUARD_PACKET
`define GUARD_PACKET


//Define the enumerated types for packet types
typedef enum { GOOD_FCS, BAD_FCS } fcs_kind_t;

class Packet extends uvm_sequence_item;

    rand fcs_kind_t     fcs_kind;
    
    rand bit [7:0] length;
    rand bit [7:0] da;
    rand bit [7:0] sa;
    rand bit [7:0] data[];
    rand byte fcs;
    
    constraint payload_size_c { data.size inside { [2 : 55]};}
    
    constraint length_c {  length == data.size; } 
                     
    
    function new(string name = "");
         super.new(name);
    endfunction : new
    
    function void post_randomize();
         if(fcs_kind == GOOD_FCS)
             fcs = 8'b0;
         else
            fcs = 8'b1;
         fcs = cal_fcs();
    endfunction : post_randomize
    
   ///// method to calculate the fcs /////
    virtual function byte cal_fcs;
       return da ^ sa ^ length ^ data.xor() ^ fcs;
    endfunction : cal_fcs
    
    `uvm_object_utils_begin(Packet)
       `uvm_field_int(da, UVM_ALL_ON|UVM_NOPACK)
       `uvm_field_int(sa, UVM_ALL_ON|UVM_NOPACK)
       `uvm_field_int(length, UVM_ALL_ON|UVM_NOPACK)
       `uvm_field_array_int(data, UVM_ALL_ON|UVM_NOPACK)
       `uvm_field_int(fcs, UVM_ALL_ON|UVM_NOPACK)
    `uvm_object_utils_end
    
    function void do_pack(uvm_packer packer);
        super.do_pack(packer);
        packer.pack_field_int(da,$bits(da));
        packer.pack_field_int(sa,$bits(sa));
        packer.pack_field_int(length,$bits(length));
        foreach(data[i])
          packer.pack_field_int(data[i],8);
        packer.pack_field_int(fcs,$bits(fcs));
    endfunction : do_pack
    
    function void do_unpack(uvm_packer packer);
        int sz;
        super.do_pack(packer);
    
        da = packer.unpack_field_int($bits(da));
        sa = packer.unpack_field_int($bits(sa));
        length = packer.unpack_field_int($bits(length));
         
        data.delete();
        data = new[length];
        foreach(data[i])
          data[i] = packer.unpack_field_int(8);
        fcs = packer.unpack_field_int($bits(fcs));
    endfunction : do_unpack

endclass : Packet

/*
/////////////////////////////////////////////////////////
////    Test to check the packet implementation      ////
/////////////////////////////////////////////////////////
module test;

    Packet pkt1 = new("pkt1");
    Packet pkt2 = new("pkt2");
    byte unsigned pkdbytes[];

    initial
    repeat(10)
       if(pkt1.randomize)
       begin
          $display(" Randomization Sucessesfull.");
          pkt1.print();
          uvm_default_packer.use_metadata = 1;     
          void'(pkt1.pack_bytes(pkdbytes));
          $display("Size of pkd bits %d",pkdbytes.size());
          pkt2.unpack_bytes(pkdbytes);
          pkt2.print();
          if(pkt2.compare(pkt1))
              $display(" Packing,Unpacking and compare worked");
          else
              $display(" *** Something went wrong in Packing or Unpacking or compare *** \n \n");
       end
       else
       $display(" *** Randomization Failed ***");
    
endmodule

*/
`endif
