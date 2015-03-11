// IVB checksum: 1352724673
/*-----------------------------------------------------------------
File name     : test_lib.sv
Developers    : traugusto
Created       : Sun Mar  8 01:06:00 2015
Description   :
Notes         :
-------------------------------------------------------------------
Copyright 2015 (c) Universidade Federal do Rio Grande do Sul
-----------------------------------------------------------------*/

import uvm_pkg::*;
import UFRGS_miniMIPS_pkg::*;
`include "uvm_macros.svh"

`include "UFRGS_miniMIPS_scoreboard.sv"
`include "minimips_UVM_tb.sv"

//----------------------------------------------------------------
//
// TEST: demo_base_test - Base test
//
//----------------------------------------------------------------
class demo_base_test extends uvm_test;

  `uvm_component_utils(demo_base_test)

  minimips_UVM_tb demo_tb0;
  uvm_table_printer printer;

  function new(string name = "demo_base_test", uvm_component parent);
    super.new(name,parent);
    printer = new();
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // Enable transaction recording for everything
    set_config_int("*", "recording_detail", UVM_FULL);
    // Create the tb
    demo_tb0 = minimips_UVM_tb::type_id::create("demo_tb0", this);
  endfunction 

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    // Set verbosity for the bus monitor
    demo_tb0.UFRGS_miniMIPS0.bus_monitor.set_report_verbosity_level(UVM_FULL);
  endfunction 

  virtual function void start_of_simulation_phase(uvm_phase phase);
    super.start_of_simulation_phase(phase);
    printer.knobs.depth = 5; 
    this.print(printer);
  endfunction 

endclass : demo_base_test

//----------------------------------------------------------------
//
// TEST: test_read_modify_write
//
//----------------------------------------------------------------
class test_read_modify_write extends demo_base_test; 
  typedef uvm_config_db#(uvm_object_wrapper) phase_cfg;

  `uvm_component_utils(test_read_modify_write)

  function new(string name = "test_read_modify_write", uvm_component parent);
    super.new(name,parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

// master is running sequnces from the master_seq_lib sequence lib
    phase_cfg::set(this,"demo_tb0.UFRGS_miniMIPS0.Instruction_Memorys[0].sequencer.run_phase","default_sequence",UFRGS_miniMIPS_Instruction_Memory_seq_lib::get_type());
      
// configure library modes (UVM_SEQ_LIB_RANDC = randomize through all registered sequences)
      uvm_config_db #(uvm_sequence_lib_mode)::set(this,
						  "demo_tb0.UFRGS_miniMIPS0.Instruction_Memorys[0].sequencer.run_phase",
						  "default_sequence.selection_mode",
						  UVM_SEQ_LIB_RANDC);

// slave is running reactive sequence (pretending to be a memory)
    phase_cfg::set(this,"demo_tb0.UFRGS_miniMIPS0.Data_Memorys[0].sequencer.run_phase","default_sequence",Data_Memory_memory_seq::get_type());
   
  endfunction 

endclass 
