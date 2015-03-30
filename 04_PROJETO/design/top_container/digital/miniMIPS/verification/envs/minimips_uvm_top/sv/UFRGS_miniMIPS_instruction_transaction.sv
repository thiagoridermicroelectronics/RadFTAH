// IVB checksum: 1998620955
/*-----------------------------------------------------------------
File name     : UFRGS_miniMIPS_instruction_transaction.sv
Developers    : traugusto
Created       : Sun Mar  8 01:06:00 2015
Description   :
Notes         :
-------------------------------------------------------------------
Copyright 2015 (c) Universidade Federal do Rio Grande do Sul
-----------------------------------------------------------------*/

//------------------------------------------------------------------------------
//
// CLASS: UFRGS_miniMIPS_instruction_transaction
//
//------------------------------------------------------------------------------

class UFRGS_miniMIPS_instruction_transaction extends uvm_sequence_item;     

  /***************************************************************************
   IVB-NOTE : REQUIRED : instruction_transaction definitions : Item definitions
   -------------------------------------------------------------------------
   Adjust the instruction_transaction attribute names as required and add any
   necessary attributes.
   Note that if you change an attribute name, you must change it through
   all the UVC files.
   Make sure to edit the uvm_object_utils_begin to get various utilities (like
   print and copy) for each attribute that you add. 
   ***************************************************************************/           

  rand bit [31:0]                       addr;
  rand UFRGS_miniMIPS_read_write_enum   read_write;
  rand int unsigned                     size;
  rand bit [31:0]                       data[];
  rand int unsigned                     wait_state[];
  rand int unsigned                     error_pos;
  rand int unsigned                     transmit_delay = 0;
  string                                Instruction_Memory = "";
  string                                Data_Memory = "";
 
  constraint c_read_write {
    read_write inside { READ, WRITE };
  }
  constraint c_size {
    size inside {1,2,4,8};
  }
  constraint c_data_wait_size {
    data.size() == size;
    wait_state.size() == size;
  }
  constraint c_transmit_delay { 
    transmit_delay <= 10 ; 
  }
  constraint c_max_wait_state { foreach (wait_state[i]) wait_state[i] <= 8; }

  `uvm_object_utils_begin(UFRGS_miniMIPS_instruction_transaction)
    `uvm_field_int      (addr,           UVM_DEFAULT)
    `uvm_field_enum     (UFRGS_miniMIPS_read_write_enum, read_write, UVM_DEFAULT)
    `uvm_field_int      (size,           UVM_DEFAULT)
    `uvm_field_array_int(data,           UVM_DEFAULT)
    `uvm_field_array_int(wait_state,     UVM_DEFAULT)
    `uvm_field_int      (error_pos,      UVM_DEFAULT)
    `uvm_field_int      (transmit_delay, UVM_DEFAULT)
    `uvm_field_string   (Instruction_Memory,         UVM_DEFAULT|UVM_NOCOMPARE)
    `uvm_field_string   (Data_Memory,          UVM_DEFAULT|UVM_NOCOMPARE)
  `uvm_object_utils_end

  // Constructor - required syntax for UVM automation and utilities
  function new (string name = "UFRGS_miniMIPS_instruction_transaction_inst");
    super.new(name);
  endfunction : new

endclass : UFRGS_miniMIPS_instruction_transaction

