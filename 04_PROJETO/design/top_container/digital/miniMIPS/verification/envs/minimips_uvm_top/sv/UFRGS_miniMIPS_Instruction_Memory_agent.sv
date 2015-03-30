// IVB checksum: 44681358
/*-----------------------------------------------------------------
File name     : UFRGS_miniMIPS_Instruction_Memory_agent.sv
Developers    : traugusto
Created       : Sun Mar  8 01:06:00 2015
Description   :
Notes         :
-------------------------------------------------------------------
Copyright 2015 (c) Universidade Federal do Rio Grande do Sul
-----------------------------------------------------------------*/

//------------------------------------------------------------------------------
//
// CLASS: UFRGS_miniMIPS_Instruction_Memory_agent
//
//------------------------------------------------------------------------------

class UFRGS_miniMIPS_Instruction_Memory_agent extends uvm_agent;
  // Master's id
  protected int Instruction_Memory_id;

  UFRGS_miniMIPS_Instruction_Memory_driver driver;
  UFRGS_miniMIPS_Instruction_Memory_sequencer sequencer;
  UFRGS_miniMIPS_Memory_monitor monitor;
  
  /***************************************************************************
   IVB-NOTE : OPTIONAL : Instruction_Memory Agent : Agents
   -------------------------------------------------------------------------
   Add Instruction_Memory fields, events and methods.
   For each field you add:
     o Update the build method.
     o Update the `uvm_component_utils_begin macro to get various UVM utilities
       for this attribute.
   ***************************************************************************/

  // Provide implementations of virtual methods such as get_type_name and create
  `uvm_component_utils_begin(UFRGS_miniMIPS_Instruction_Memory_agent)
    `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_DEFAULT)
    `uvm_field_int(Instruction_Memory_id, UVM_DEFAULT)
  `uvm_component_utils_end

  // new - constructor
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // Additional class methods
// build
function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  monitor = UFRGS_miniMIPS_Memory_monitor::type_id::create("monitor", this);
  if(is_active == UVM_ACTIVE) begin
    sequencer = UFRGS_miniMIPS_Instruction_Memory_sequencer::type_id::create("sequencer", this);
    driver = UFRGS_miniMIPS_Instruction_Memory_driver::type_id::create("driver", this);
  end
endfunction 

// connect phase
function void connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  if(is_active == UVM_ACTIVE) begin
    // Binds the driver to the sequencer using consumer-producer interface
    driver.seq_item_port.connect(sequencer.seq_item_export);
  end
endfunction 

// assign the id of the agent's children
function void set_Instruction_Memory_id(int i);
  monitor.Instruction_Memory_id = i;
  if (is_active == UVM_ACTIVE) begin
    sequencer.Instruction_Memory_id = i;
    driver.Instruction_Memory_id = i;
  end
endfunction

endclass 

  
