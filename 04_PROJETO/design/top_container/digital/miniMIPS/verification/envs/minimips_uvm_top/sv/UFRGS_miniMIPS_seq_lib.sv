// IVB checksum: 411712709
/*-----------------------------------------------------------------
File name     : UFRGS_miniMIPS_seq_lib.sv
Developers    : traugusto
Created       : Sun Mar  8 01:06:00 2015
Description   :
Notes         :
-------------------------------------------------------------------
Copyright 2015 (c) Universidade Federal do Rio Grande do Sul
-----------------------------------------------------------------*/

//
// master sequence library
//
class UFRGS_miniMIPS_Instruction_Memory_seq_lib extends uvm_sequence_library #(UFRGS_miniMIPS_instruction_transaction);
	`uvm_object_utils(UFRGS_miniMIPS_Instruction_Memory_seq_lib)
	`uvm_sequence_library_utils(UFRGS_miniMIPS_Instruction_Memory_seq_lib)

   function new(string name="UFRGS_miniMIPS_Instruction_Memory_seq_lib"); 
      super.new(name); 

      min_random_count = 1;   
      max_random_count = 5;   

      setup_library();
   endfunction

   // add sequences to library
   function void setup_library();

	// add sequences for this library 
	add_typewide_sequence(read_modify_write_seq::get_type());
	init_sequence_library();
// NOTE: enable for debug
//	print();
   endfunction

endclass
	
