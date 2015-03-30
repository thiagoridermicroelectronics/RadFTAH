// IVB checksum: 678898507
/*-----------------------------------------------------------------
File name     : minimips_UVM_tb.sv
Developers    : traugusto
Created       : Sun Mar  8 01:06:00 2015
Description   :
Notes         :
-------------------------------------------------------------------
Copyright 2015 (c) Universidade Federal do Rio Grande do Sul
-----------------------------------------------------------------*/

//------------------------------------------------------------------------------
//
// CLASS: minimips_UVM_tb
//
//------------------------------------------------------------------------------

class minimips_UVM_tb extends uvm_env;

  // Provide UVM automation and utility methods
  `uvm_component_utils(minimips_UVM_tb)

  // UFRGS_miniMIPS environment
  UFRGS_miniMIPS_env UFRGS_miniMIPS0;

  // Scoreboard to check the memory operation.
  UFRGS_miniMIPS_scoreboard scoreboard0;

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
  uvm_config_db#(virtual UFRGS_miniMIPS_if)::set(null,"/\.UFRGS_miniMIPS0(\..*)?$/","vif",minimips_UVM_top.UFRGS_miniMIPS_if_0);

  UFRGS_miniMIPS0 = UFRGS_miniMIPS_env::type_id::create("UFRGS_miniMIPS0", this);

  //Create Scoreboard - Only TWO max are created
  scoreboard0 = UFRGS_miniMIPS_scoreboard::type_id::create("scoreboard0", this);
endfunction 

// UVM connect phase
function void connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  //Connect Memorys monitors to scoreboard
  // Connect Data_Memory0 monitor to scoreboard
  UFRGS_miniMIPS0.Data_Memorys[0].monitor.item_collected_port.connect(scoreboard0.item_collected_imp);
  // Connect Instruction_Memory0 monitor to scoreboard
  UFRGS_miniMIPS0.Instruction_Memorys[0].monitor.item_collected_port.connect(scoreboard0.item_collected_imp);
  // Set up Instruction_Memory address map for UFRGS_miniMIPS0
  UFRGS_miniMIPS0.set_Memory_address_map("Instruction_Memorys[0]", 0, 32'hffff);
  // Set up Data_Memory address map for UFRGS_miniMIPS0
  UFRGS_miniMIPS0.set_Memory_address_map("Data_Memorys[0]", 0, 32'hffff);
endfunction 

// UVM start_of_simulation() phase
function void start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
  uvm_test_done.set_drain_time(this, 1000);
endfunction 

endclass : minimips_UVM_tb