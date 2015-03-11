// IVB checksum: 1601945429
/*-----------------------------------------------------------------
File name     : UFRGS_miniMIPS_env.sv
Developers    : traugusto
Created       : Sun Mar  8 01:06:00 2015
Description   :
Notes         :
-------------------------------------------------------------------
Copyright 2015 (c) Universidade Federal do Rio Grande do Sul
-----------------------------------------------------------------*/

//------------------------------------------------------------------------------
//
// CLASS: UFRGS_miniMIPS_env
//
//------------------------------------------------------------------------------

class UFRGS_miniMIPS_env extends uvm_env;

  // Virtual Interface variable
  protected virtual interface UFRGS_miniMIPS_if vif;

  // Control properties
  protected bit has_bus_monitor = 1;
  protected int unsigned num_Instruction_Memorys = 0;
  protected int unsigned num_Data_Memorys = 0;

  // The following two bits are used to control whether checks and coverage are
  // done both in the bus monitor class and the interface.
  bit checks_enable = 1; 
  bit coverage_enable = 1;

  // Components of the environment
  UFRGS_miniMIPS_bus_monitor bus_monitor;
  UFRGS_miniMIPS_Instruction_Memory_agent Instruction_Memorys[];
  UFRGS_miniMIPS_Data_Memory_agent Data_Memorys[];

  // Provide implementations of virtual methods such as get_type_name and create
  `uvm_component_utils_begin(UFRGS_miniMIPS_env)
    `uvm_field_int(has_bus_monitor, UVM_DEFAULT)
    `uvm_field_int(num_Instruction_Memorys, UVM_DEFAULT)
    `uvm_field_int(num_Data_Memorys, UVM_DEFAULT)
    `uvm_field_int(checks_enable, UVM_DEFAULT)
    `uvm_field_int(coverage_enable, UVM_DEFAULT)
  `uvm_component_utils_end

  // Constructor - required syntax for UVM automation and utilities
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // Additional class methods
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void set_Data_Memory_address_map(string Data_Memory_name, int min_addr, int max_addr);
  extern virtual protected task update_vif_enables();
  extern virtual task run_phase(uvm_phase phase);
endclass

// UVM build phase
function void UFRGS_miniMIPS_env::build_phase(uvm_phase phase);
  string inst_name;
  super.build_phase(phase);
  if(has_bus_monitor == 1) begin
    bus_monitor = UFRGS_miniMIPS_bus_monitor::type_id::create("bus_monitor", this);
  end
  Instruction_Memorys = new[num_Instruction_Memorys];
  for(int i = 0; i < num_Instruction_Memorys; i++) begin
    $sformat(inst_name, "Instruction_Memorys[%0d]", i);
    Instruction_Memorys[i] = UFRGS_miniMIPS_Instruction_Memory_agent::type_id::create(inst_name, this);
  end
  Data_Memorys = new[num_Data_Memorys];
  for(int i = 0; i < num_Data_Memorys; i++) begin
    $sformat(inst_name, "Data_Memorys[%0d]", i);
    Data_Memorys[i]  = UFRGS_miniMIPS_Data_Memory_agent::type_id::create(inst_name, this);
  end
endfunction 

// UVM connect phase
function void UFRGS_miniMIPS_env::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  for(int i = 0; i < num_Instruction_Memorys; i++) begin
    Instruction_Memorys[i].set_Instruction_Memory_id(i);
  end

  if(!uvm_config_db#(virtual UFRGS_miniMIPS_if)::get(this,"","vif",vif))
	`uvm_error("NOVIF","vif is unset")
endfunction 

// Used to set the Data_Memory address map
function void UFRGS_miniMIPS_env::set_Data_Memory_address_map(string Data_Memory_name, int min_addr, int max_addr);
  UFRGS_miniMIPS_Data_Memory_monitor tmp_Data_Memory_monitor;
  if( bus_monitor != null ) begin
    // Set Data_Memory address map for bus monitor
    bus_monitor.set_Data_Memory_configs(Data_Memory_name, min_addr, max_addr);
  end
  // Set Data_Memory address map for Data_Memory monitor
  $cast(tmp_Data_Memory_monitor, lookup({Data_Memory_name, ".monitor"}));
  tmp_Data_Memory_monitor.min_addr = min_addr;
  tmp_Data_Memory_monitor.max_addr = max_addr;
endfunction : set_Data_Memory_address_map

// Function to assign the checks and coverage bits
task UFRGS_miniMIPS_env::update_vif_enables();
  vif.has_checks <= checks_enable;
  vif.has_coverage <= coverage_enable;
  forever begin
    @(checks_enable ||coverage_enable);
    vif.has_checks <= checks_enable;
    vif.has_coverage <= coverage_enable;
  end
endtask : update_vif_enables

// implement run task
task UFRGS_miniMIPS_env::run_phase(uvm_phase phase);
  super.run_phase(phase);
  fork
    update_vif_enables();
  join_none
endtask 

