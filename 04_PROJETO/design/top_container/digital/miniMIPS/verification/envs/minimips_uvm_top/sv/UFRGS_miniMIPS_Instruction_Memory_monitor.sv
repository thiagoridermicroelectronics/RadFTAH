// IVB checksum: 3683728892
/*-----------------------------------------------------------------
File name     : UFRGS_miniMIPS_Instruction_Memory_monitor.sv
Developers    : traugusto
Created       : Sun Mar  8 01:06:00 2015
Description   : This file implements the Instruction_Memory monitor.
              : The Instruction_Memory monitor monitors the activity of
              : its Instruction_Memory agent.
Notes         :
-------------------------------------------------------------------
Copyright Universidade Federal do Rio Grande do Sul (c)2015 
-----------------------------------------------------------------*/

//------------------------------------------------------------------------------
//
// CLASS: UFRGS_miniMIPS_Instruction_Memory_monitor
//
//------------------------------------------------------------------------------

class UFRGS_miniMIPS_Instruction_Memory_monitor extends uvm_monitor;

  // This property is the virtual interfaced needed for this component to drive 
  // and view HDL signals. 
  virtual UFRGS_miniMIPS_if vif;

  // Master Id
  int Instruction_Memory_id;

  // The following two bits are used to control whether checks and coverage are
  // done both in the monitor class and the interface.
  bit checks_enable = 1;
  bit coverage_enable = 1;

  // This port is used to connect the monitor to the scoreboard
  uvm_analysis_port #(UFRGS_miniMIPS_instruction_transaction) item_collected_port;

  //  Current monitored instruction_transaction  
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
  `uvm_component_utils_begin(UFRGS_miniMIPS_Instruction_Memory_monitor)
    `uvm_field_int(checks_enable, UVM_DEFAULT)
    `uvm_field_int(coverage_enable, UVM_DEFAULT)
  `uvm_component_utils_end

  // new - constructor
  function new (string name, uvm_component parent);
    super.new(name, parent);
    // Create covergroup only if coverage is enabled
    void'(get_config_int("coverage_enable", coverage_enable));
    if (coverage_enable) begin
      instruction_transaction_cg = new();
      instruction_transaction_cg.set_inst_name("m_instruction_transaction_cg");
    end
    // Create Data Item
    instruction_transaction_collected = UFRGS_miniMIPS_instruction_transaction::type_id::create("instruction_transaction_collected");
    // Create TLM port
    item_collected_port = new("item_collected_port", this);
  endfunction : new

  // Additional class methods
  extern virtual task run_phase(uvm_phase phase);
  extern virtual protected task collect_instruction_transactions();
  extern virtual protected task collect_arbitration();
  extern virtual protected task collect_address();
  extern virtual protected task collect_data();
  extern virtual protected function void perform_checks();
  extern virtual protected function void check_UFRGS_miniMIPS_instruction_transaction_size();
  extern virtual protected function void check_UFRGS_miniMIPS_instruction_transaction_data_size();
  extern virtual protected function void perform_coverage();

  function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	
  	if(!uvm_config_db#(virtual UFRGS_miniMIPS_if)::get(this,"","vif",vif))
		`uvm_error("NOVIF","vif is unset")
  endfunction
endclass : UFRGS_miniMIPS_Instruction_Memory_monitor

// run phase
task UFRGS_miniMIPS_Instruction_Memory_monitor::run_phase(uvm_phase phase);
  super.run_phase(phase);
  fork
    collect_instruction_transactions();
  join_none
endtask 

/***************************************************************************
 IVB-NOTE : REQUIRED : Instruction_Memory Monitor : Monitors
 -------------------------------------------------------------------------
 Modify the following methods to match your protocol:
    o collect_arbitration() - monitor arbitration process
    o collect_address() - monitor instruction_transaction address 
    o collect_data() - monitor instruction_transaction data
 Note that if you change/add signals to the physical interface, you must
 also change these methods.  
 ***************************************************************************/

// Collect instruction_transactions
task UFRGS_miniMIPS_Instruction_Memory_monitor::collect_instruction_transactions();
  forever begin
    @(posedge vif.sig_clock);
    if (m_parent != null)
      instruction_transaction_collected.Instruction_Memory = m_parent.get_name();
    collect_arbitration();
    collect_address();
    collect_data();
    `uvm_info(get_type_name(),
      $sformatf("instruction_transaction collected :\n%s",
      instruction_transaction_collected.sprint()), UVM_FULL)
    if (checks_enable)
      perform_checks();
    if (coverage_enable)
       perform_coverage();
    item_collected_port.write(instruction_transaction_collected);
  end
endtask : collect_instruction_transactions

// Determines if this Instruction_Memory got the grant 
task UFRGS_miniMIPS_Instruction_Memory_monitor::collect_arbitration();
  @(posedge vif.sig_request[Instruction_Memory_id]);
  @(posedge vif.sig_clock iff vif.sig_grant[Instruction_Memory_id] === 1);
  // Enable instruction_transaction recording
  void'(begin_tr(instruction_transaction_collected, "UFRGS_miniMIPS Instruction_Memory Monitor"));
endtask : collect_arbitration

// Collect address phase
task UFRGS_miniMIPS_Instruction_Memory_monitor::collect_address();
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
    2'b00 : instruction_transaction_collected.read_write = NOP;
    2'b10 : instruction_transaction_collected.read_write = READ;
    2'b01 : instruction_transaction_collected.read_write = WRITE;
  endcase
endtask : collect_address

// Collect data phase
task UFRGS_miniMIPS_Instruction_Memory_monitor::collect_data();
  if (instruction_transaction_collected.read_write != NOP)
    for (int i = 0; i < instruction_transaction_collected.size; i++) begin
      @(posedge vif.sig_clock iff vif.sig_wait === 0);
      instruction_transaction_collected.data[i] = vif.sig_data;
    end
  this.end_tr(instruction_transaction_collected);
endtask : collect_data

/***************************************************************************
 IVB-NOTE : OPTIONAL : Instruction_Memory Monitor Protocol Checks : Checks
 -------------------------------------------------------------------------
 Edit the following checks methods to match your protocol:
    o check_UFRGS_miniMIPS_instruction_transaction_size() 
    o check_UFRGS_miniMIPS_instruction_transaction_data_size() 
 Add new protocol checks methods and call them from the
 perform_checks() method.
 ***************************************************************************/

// Performs instruction_transaction checks
function void UFRGS_miniMIPS_Instruction_Memory_monitor::perform_checks();
  check_UFRGS_miniMIPS_instruction_transaction_size();
  check_UFRGS_miniMIPS_instruction_transaction_data_size();
endfunction : perform_checks

// Check instruction_transaction size
function void UFRGS_miniMIPS_Instruction_Memory_monitor::check_UFRGS_miniMIPS_instruction_transaction_size();
  if(!(instruction_transaction_collected.size == 1 || 
    instruction_transaction_collected.size == 2 || instruction_transaction_collected.size == 4 || 
    instruction_transaction_collected.size == 8)) begin
    `uvm_error("ERR_INVALID_DATA_SIZE","Invalid instruction_transaction size!")
  end
endfunction : check_UFRGS_miniMIPS_instruction_transaction_size

// Check instruction_transaction data size
function void UFRGS_miniMIPS_Instruction_Memory_monitor::check_UFRGS_miniMIPS_instruction_transaction_data_size();
  if (instruction_transaction_collected.size != instruction_transaction_collected.data.size())
    `uvm_error("ERR_DATA_LENGTH_MISMATCH","instruction_transaction size field / data size mismatch.")
endfunction : check_UFRGS_miniMIPS_instruction_transaction_data_size
  
/***************************************************************************
 IVB-NOTE : OPTIONAL : Instruction_Memory Monitor Coverage : Coverage
 -------------------------------------------------------------------------
 Modify the following coverage groups to match your protocol:
    o cover_instruction_transaction
    o cover_instruction_transaction_bit 
 Add new coverage groups, fields and events, and edit the
 perform_coverage() method. to
 trigger the new coverage events and fill the new coverage fields.
 ***************************************************************************/

// Triggers coverage events and fill cover fields
function void UFRGS_miniMIPS_Instruction_Memory_monitor::perform_coverage();
  instruction_transaction_cg.sample();
endfunction : perform_coverage
