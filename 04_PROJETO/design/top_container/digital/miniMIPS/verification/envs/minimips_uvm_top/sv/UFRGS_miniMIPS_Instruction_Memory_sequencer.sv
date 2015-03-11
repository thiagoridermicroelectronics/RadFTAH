// IVB checksum: 1518877769
/*-----------------------------------------------------------------
File name     : UFRGS_miniMIPS_Instruction_Memory_sequencer.sv
Developers    : traugusto
Created       : Sun Mar  8 01:06:00 2015
Description   :
Notes         :
-------------------------------------------------------------------
Copyright 2015 (c) Universidade Federal do Rio Grande do Sul
-----------------------------------------------------------------*/

//------------------------------------------------------------------------------
//
// CLASS: UFRGS_miniMIPS_Instruction_Memory_sequencer
//
//------------------------------------------------------------------------------

class UFRGS_miniMIPS_Instruction_Memory_sequencer extends uvm_sequencer #(UFRGS_miniMIPS_instruction_transaction);
  // Master Id
  int Instruction_Memory_id;

  `uvm_component_utils(UFRGS_miniMIPS_Instruction_Memory_sequencer)

  // new - constructor
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

endclass
