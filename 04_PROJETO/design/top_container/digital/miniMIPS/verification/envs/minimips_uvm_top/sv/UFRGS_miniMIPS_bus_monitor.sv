// IVB checksum: 1150587532

/*-----------------------------------------------------------------
File name     : UFRGS_miniMIPS_bus_monitor.sv
Developers    : traugusto
Created       : Sun Mar  8 01:06:00 2015
Description   : This file implements the bus monitor.
              : The bus monitor monitors all bus activity.
Notes         :
-------------------------------------------------------------------
Copyright Universidade Federal do Rio Grande do Sul (c)2015 
-----------------------------------------------------------------*/

//------------------------------------------------------------------------------
//
// CLASS: Data_Memory_address_map_info
//
// The following class is used to determine which Data_Memory should respond 
// to a instruction_transaction on the bus
//------------------------------------------------------------------------------

class Data_Memory_address_map_info extends uvm_object;

  int min_addr;
  int max_addr;
 
  `uvm_object_utils_begin(Data_Memory_address_map_info)
    `uvm_field_int(min_addr, UVM_DEFAULT)
    `uvm_field_int(max_addr, UVM_DEFAULT)
  `uvm_object_utils_end

  function void set_address_map (int min_addr , int max_addr); 
    this.min_addr = min_addr;
    this.max_addr = max_addr;
  endfunction : set_address_map

endclass : Data_Memory_address_map_info


//------------------------------------------------------------------------------
//
// CLASS: UFRGS_miniMIPS_bus_monitor
//
//------------------------------------------------------------------------------

class UFRGS_miniMIPS_bus_monitor extends uvm_monitor;

  // The virtual interface used to view HDL signals.
  virtual interface UFRGS_miniMIPS_if vif;

  // Property indicating the number of instruction_transactions occuring on the UFRGS_miniMIPS.
  protected int unsigned num_instruction_transactions = 0;

  // The following two bits are used to control whether checks and coverage are
  // done both in the bus monitor class and the interface.
  bit checks_enable = 1; 
  bit coverage_enable = 1;

  // Analysis ports for the item_collected, reset end notifier, and phase change
  // notifier.
  uvm_analysis_port #(UFRGS_miniMIPS_instruction_transaction) item_collected_port;
  uvm_analysis_port #(int) reset_end_port;
  uvm_analysis_port #(string) phase_change_port;

  // The following property is used to store Data_Memory address map
  protected Data_Memory_address_map_info Data_Memory_addr_map[string];

  // The following property holds the instruction_transaction information currently
  // being captured (by the collect_address and data_phase methods). 
  protected UFRGS_miniMIPS_instruction_transaction instruction_transaction_collected;

  covergroup instruction_transaction_cg;
    option.per_instance = 1;
    instruction_transaction_dir : coverpoint instruction_transaction_collected.read_write;
    instruction_transaction_size: coverpoint instruction_transaction_collected.size {
      bins sizes[] = {1, 2, 4, 8};
      illegal_bins invalid_sizes = default; }
    instruction_transaction_dirXsize : cross instruction_transaction_dir, instruction_transaction_size;
  endgroup : instruction_transaction_cg

  // Provide implementations of virtual methods such as get_type_name and create
  `uvm_component_utils_begin(UFRGS_miniMIPS_bus_monitor)
    `uvm_field_int(checks_enable, UVM_DEFAULT)
    `uvm_field_int(coverage_enable, UVM_DEFAULT)
    `uvm_field_int(num_instruction_transactions, UVM_DEFAULT)
    `uvm_field_aa_object_string(Data_Memory_addr_map, UVM_DEFAULT)
  `uvm_component_utils_end

  // Constructor - required syntax for UVM automation and utilities
  function new (string name, uvm_component parent);
    super.new(name, parent);
    // Create covergroup only if coverage is enabled
    void'(get_config_int("coverage_enable", coverage_enable));
    if (coverage_enable) begin
      instruction_transaction_cg = new();
      instruction_transaction_cg.set_inst_name("bus_instruction_transaction_cg");
    end
    // Create Data Item
    instruction_transaction_collected = UFRGS_miniMIPS_instruction_transaction::type_id::create("instruction_transaction_collected");
    // Create TLM ports
    item_collected_port = new("item_collected_port", this);
    reset_end_port = new("reset_end_port", this);
    phase_change_port = new("phase_change_port", this);
  endfunction : new

  // Additional class methods
  extern virtual function void set_Data_Memory_configs(string Data_Memory_name, int min_addr, int max_addr);
  extern virtual task run_phase(uvm_phase phase);
  extern protected virtual task observe_reset();
  extern protected virtual task collect_instruction_transactions();
  extern protected virtual task collect_arbitration();
  extern protected virtual task collect_address();
  extern protected virtual task collect_data();
  extern protected virtual function void check_which_Data_Memory();
  extern protected virtual function void perform_checks();
  extern protected virtual function void check_UFRGS_miniMIPS_instruction_transaction_size();
  extern protected virtual function void check_UFRGS_miniMIPS_instruction_transaction_data_size();
  extern protected virtual function void perform_coverage();

  function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	
  	if(!uvm_config_db#(virtual UFRGS_miniMIPS_if)::get(this,"","vif",vif))
		`uvm_error("NOVIF","vif is unset")
  endfunction
endclass : UFRGS_miniMIPS_bus_monitor

// set_Data_Memory_configs
function void UFRGS_miniMIPS_bus_monitor::set_Data_Memory_configs(string Data_Memory_name,
  int min_addr, int max_addr);
  Data_Memory_addr_map[Data_Memory_name] = new();
  Data_Memory_addr_map[Data_Memory_name].set_address_map(min_addr, max_addr);
endfunction : set_Data_Memory_configs

// UVM run phase
task UFRGS_miniMIPS_bus_monitor::run_phase(uvm_phase phase);
  super.run_phase(phase);
  fork
    observe_reset();
    collect_instruction_transactions();
  join_none
endtask 
  
/***************************************************************************
 IVB-NOTE : REQUIRED : Bus Monitor : Monitors
 -------------------------------------------------------------------------
 Modify the following methods to match your protocol:
    o collect_arbitration() - monitor arbitration process
    o collect_address() - monitor instruction_transaction address 
    o collect_data() - monitor instruction_transaction data
 Note that if you change/add signals to the physical interface, you must
 also change these methods.  
 ***************************************************************************/

// Observe reset
task UFRGS_miniMIPS_bus_monitor::observe_reset();
  forever begin
    @(negedge vif.sig_reset);
    reset_end_port.write(0);
  end
endtask : observe_reset

// Collect instruction_transactions
task UFRGS_miniMIPS_bus_monitor::collect_instruction_transactions();
  forever begin
    collect_arbitration();
    collect_address();
    collect_data();
    `uvm_info(get_type_name(), 
      $sformatf("instruction_transaction collected :\n%s",
      instruction_transaction_collected.sprint()), UVM_HIGH)
    if (checks_enable)
      perform_checks();
    if (coverage_enable)
      perform_coverage();
    item_collected_port.write(instruction_transaction_collected);
  end
endtask : collect_instruction_transactions

// Collect arbitration phase
// Determines which one of the Instruction_Memorys got the grant
task UFRGS_miniMIPS_bus_monitor::collect_arbitration();
  string tmpStr;
  @(posedge vif.sig_clock iff (vif.sig_grant != 0));
  phase_change_port.write("arbitration");
  // Enable instruction_transaction recording
  void'(begin_tr(instruction_transaction_collected, "UFRGS_miniMIPS Bus Monitor"));
  // Check which grant is active to determine which Instruction_Memory is performing
  // the instruction_transaction on the bus.
  for (int j = 0; j <= 0; j++) begin
    if (vif.sig_grant[j] === 1) begin
      $sformat(tmpStr,"Instruction_Memorys[%0d]", j);
      instruction_transaction_collected.Instruction_Memory = tmpStr;
      break;   
    end 
  end
endtask : collect_arbitration

// Collect address phase
task UFRGS_miniMIPS_bus_monitor::collect_address();
  @(posedge vif.sig_clock);
  instruction_transaction_collected.addr = vif.sig_addr;
  case (vif.sig_size)
    2'b00 : instruction_transaction_collected.size = 1;
    2'b01 : instruction_transaction_collected.size = 2;
    2'b10 : instruction_transaction_collected.size = 4;
    2'b11 : instruction_transaction_collected.size = 8;
  endcase
  instruction_transaction_collected.data = new[instruction_transaction_collected.size];
  case ({vif.sig_read,vif.sig_write})
    2'b00 : begin
      instruction_transaction_collected.read_write = NOP;
      phase_change_port.write("nop_cycle");
    end
    2'b10 : begin
      instruction_transaction_collected.read_write = READ;
      phase_change_port.write("normal_address_phase");
    end
    2'b01 : begin
      instruction_transaction_collected.read_write = WRITE;
      phase_change_port.write("normal_address_phase");
    end
    2'b11 : begin
      if (checks_enable)
         `uvm_error("ERR_R_AND_W_ACTIVE","Read and Write true at the same time")
    end            
  endcase
endtask : collect_address

// Collect data phase
task UFRGS_miniMIPS_bus_monitor::collect_data();
  if (instruction_transaction_collected.read_write != NOP) begin
    check_which_Data_Memory();
    for (int i = 0; i < instruction_transaction_collected.size; i++) begin
      phase_change_port.write("data_phase");
      @(posedge vif.sig_clock iff vif.sig_wait === 0);
      instruction_transaction_collected.data[i] = vif.sig_data;
    end
    num_instruction_transactions++;
    this.end_tr(instruction_transaction_collected);
  end
endtask : collect_data

// Check which on of the Data_Memorys has this instruction_transaction in his address range
function void UFRGS_miniMIPS_bus_monitor::check_which_Data_Memory();
  string Data_Memory_name;
  bit Data_Memory_found;
  Data_Memory_found = 1'b0;
  if(Data_Memory_addr_map.first(Data_Memory_name))
    do begin
      if (Data_Memory_addr_map[Data_Memory_name].min_addr <= instruction_transaction_collected.addr
        && instruction_transaction_collected.addr <= Data_Memory_addr_map[Data_Memory_name].max_addr) 
      begin
        instruction_transaction_collected.Data_Memory = Data_Memory_name;
        Data_Memory_found = 1'b1;
      end
      if (Data_Memory_found == 1'b1)
        break;
    end
  while (Data_Memory_addr_map.next(Data_Memory_name));
    if(!Data_Memory_found) begin
      `uvm_error("ERR_ILLEGAL_ACCESS", 
      $sformatf("Master attempted a instruction_transaction at illegal address 32'h%0h",
        instruction_transaction_collected.addr))
    end
endfunction : check_which_Data_Memory
 
/***************************************************************************
 IVB-NOTE : OPTIONAL : Bus Monitor Protocol Checks : Checks
 -------------------------------------------------------------------------
 Edit the following checks methods to match your protocol:
    o check_UFRGS_miniMIPS_instruction_transaction_size()
    o check_UFRGS_miniMIPS_instruction_transaction_data_size() 
 Add new protocol checks methods and call them from the
 perform_checks() method.
 ***************************************************************************/

// Perform instruction_transaction checks
function void UFRGS_miniMIPS_bus_monitor::perform_checks();
  check_UFRGS_miniMIPS_instruction_transaction_size();
  check_UFRGS_miniMIPS_instruction_transaction_data_size();
endfunction : perform_checks

// Check instruction_transaction size
function void UFRGS_miniMIPS_bus_monitor::check_UFRGS_miniMIPS_instruction_transaction_size();
 if (instruction_transaction_collected.read_write != NOP) begin
   if(!(instruction_transaction_collected.size == 1 || 
    instruction_transaction_collected.size == 2 || instruction_transaction_collected.size == 4 || 
    instruction_transaction_collected.size == 8)) begin
    `uvm_error("ERR_INVALID_SIZE","Invalid instruction_transaction size!")
  end
 end
endfunction : check_UFRGS_miniMIPS_instruction_transaction_size

// Check instruction_transaction data size
function void UFRGS_miniMIPS_bus_monitor::check_UFRGS_miniMIPS_instruction_transaction_data_size();
  if (instruction_transaction_collected.size != instruction_transaction_collected.data.size())
    `uvm_error("ERR_DATA_LENGTH_MISMATCH","instruction_transaction size field / data size mistmatch.")
endfunction : check_UFRGS_miniMIPS_instruction_transaction_data_size

/***************************************************************************
 IVB-NOTE : OPTIONAL : Bus Monitor Coverage : Coverage
 -------------------------------------------------------------------------
 Modify the following coverage groups to match your protocol:
    o cover_instruction_transaction
    o cover_instruction_transaction_bit
 Add new coverage groups, fields and events, and edit the
 perform_coverage() method. to trigger the new coverage events 
 and fill the new coverage fields.
 ***************************************************************************/

// Triggers coverage events and fill cover fields
function void UFRGS_miniMIPS_bus_monitor::perform_coverage();
  if (instruction_transaction_collected.read_write != NOP) begin
    instruction_transaction_cg.sample();
  end
endfunction : perform_coverage

