// IVB checksum: 678898507
/*-----------------------------------------------------------------
File name     : demo_tb.sv
Developers    : traugusto
Created       : Sun Mar  8 01:06:00 2015
Description   :
Notes         :
-------------------------------------------------------------------
Copyright 2015 (c) Universidade Federal do Rio Grande do Sul
-----------------------------------------------------------------*/

//------------------------------------------------------------------------------
//
// CLASS: UFRGS_miniMIPS_demo_tb
//
//------------------------------------------------------------------------------

class demo_tb extends uvm_env;

  // Provide UVM automation and utility methods
  `uvm_component_utils(demo_tb)

  // UFRGS_miniMIPS environment
  UFRGS_miniMIPS_env UFRGS_miniMIPS0;

  // Scoreboard to check the memory operation of the Data_Memory.
  // NOTE: Only two max will be shown
  UFRGS_miniMIPS_demo_scoreboard scoreboard0;

  // Constructor - required syntax for UVM automation and utilities
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // Additional class methods

// UVM build phase
function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  set_config_int("UFRGS_miniMIPS0", "num_Instruction_Memorys", 1);
  set_config_int("UFRGS_miniMIPS0", "num_Data_Memorys", 1);

  // set vif property interface for UFRGS_miniMIPS0
  // set the property for *.UFRGS_miniMIPS0,vif and *.UFRGS_miniMIPS0.*,vif
  uvm_config_db#(virtual UFRGS_miniMIPS_if)::set(null,"/\.UFRGS_miniMIPS0(\..*)?$/","vif",demo_top.UFRGS_miniMIPS_if_0);

  UFRGS_miniMIPS0 = UFRGS_miniMIPS_env::type_id::create("UFRGS_miniMIPS0", this);

  //Create Scoreboard - Only TWO max are created
  scoreboard0 = UFRGS_miniMIPS_demo_scoreboard::type_id::create("scoreboard0", this);
endfunction 

// UVM connect phase
function void connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  //Connect Data_Memory monitor to scoreboard - only 2 are shown
  // Connect Data_Memory0 monitor to scoreboard
  UFRGS_miniMIPS0.Data_Memorys[0].monitor.item_collected_port.connect(scoreboard0.item_collected_imp);
  // Set up Data_Memory address map for UFRGS_miniMIPS0
  UFRGS_miniMIPS0.set_Data_Memory_address_map("Data_Memorys[0]", 0, 32'hffff);
endfunction 

// UVM start_of_simulation() phase
function void start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
  uvm_test_done.set_drain_time(this, 1000);
endfunction 

endclass : demo_tb
