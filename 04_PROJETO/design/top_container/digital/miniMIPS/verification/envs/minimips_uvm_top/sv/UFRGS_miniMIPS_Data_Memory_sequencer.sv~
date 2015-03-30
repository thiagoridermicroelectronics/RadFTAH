// IVB checksum: 2260915011
/*-----------------------------------------------------------------
File name     : UFRGS_miniMIPS_Data_Memory_sequencer.sv
Developers    : traugusto
Created       : Sun Mar  8 01:06:01 2015
Description   :
Notes         :
-------------------------------------------------------------------
Copyright 2015 (c) Universidade Federal do Rio Grande do Sul
-----------------------------------------------------------------*/

//------------------------------------------------------------------------------
//
// CLASS: UFRGS_miniMIPS_Data_Memory_sequencer
//
//------------------------------------------------------------------------------

class UFRGS_miniMIPS_Data_Memory_sequencer extends uvm_sequencer #(UFRGS_miniMIPS_instruction_transaction);
  // TLM port to peek the address phase from the Data_Memory monitor
  uvm_blocking_peek_port#(UFRGS_miniMIPS_instruction_transaction) addr_ph_port;

  // Provide implementations of virtual methods such as get_type_name and create
  `uvm_component_utils(UFRGS_miniMIPS_Data_Memory_sequencer)

  // new - constructor
  function new (string name, uvm_component parent);
    super.new(name, parent);
    addr_ph_port = new("addr_ph_port", this);
  endfunction : new

endclass 

