// IVB checksum: 1594639166
/*-----------------------------------------------------------------
File name     : UFRGS_miniMIPS_Data_Memory_monitor.sv
Developers    : traugusto
Created       : Sun Mar  8 01:06:01 2015
Description   : This file implements the Data_Memory monitor.
              : The Data_Memory monitor monitors the activity of
              : its Data_Memory agent.
Notes         :
-------------------------------------------------------------------
Copyright Universidade Federal do Rio Grande do Sul (c)2015 
-----------------------------------------------------------------*/

//------------------------------------------------------------------------------
//
// CLASS: UFRGS_miniMIPS_Data_Memory_monitor
//
//------------------------------------------------------------------------------

class UFRGS_miniMIPS_Data_Memory_monitor extends uvm_monitor;
  
  // This property is the virtual interface needed for this component to drive
  // and view HDL signals.
  virtual UFRGS_miniMIPS_if vif;

  // The following two unsigned integer properties are used by
  // check_addr_range() method to detect if a instruction_transaction is for this target.
  int unsigned min_addr = '0;
  int unsigned max_addr = '1;

  // The following two bits are used to control whether checks and coverage are
  // done both in the monitor class and the interface.
  bit checks_enable = 1;
  bit coverage_enable = 1;

  // This port is used to connect the monitor to the scoreboard
  uvm_analysis_port#(UFRGS_miniMIPS_instruction_transaction) item_collected_port;
  // This port is used to connect the sequencer to the monitor
  uvm_blocking_peek_imp#(UFRGS_miniMIPS_instruction_transaction,UFRGS_miniMIPS_Data_Memory_monitor) addr_ph_imp;

  // The following property holds the instruction_transaction information currently
  // begin captured (by the collect_address and data_phase methods). 
  protected UFRGS_miniMIPS_instruction_transaction instruction_transaction_collected;

  // monitor notifier that the address phase (and full item) has been collected
  event address_phase_grabbed;

  covergroup instruction_transaction_cg;
    option.per_instance = 1;
    instruction_transaction_dir : coverpoint instruction_transaction_collected.read_write;
    instruction_transaction_size: coverpoint instruction_transaction_collected.size {
      bins sizes[] = {1, 2, 4, 8};
      illegal_bins invalid_sizes = default; }
    instruction_transaction_dirXsize : cross instruction_transaction_dir, instruction_transaction_size;
  endgroup : instruction_transaction_cg

  // Provide implementations of virtual methods such as get_type_name and create
  `uvm_component_utils_begin(UFRGS_miniMIPS_Data_Memory_monitor)
    `uvm_field_int(min_addr, UVM_DEFAULT)
    `uvm_field_int(max_addr, UVM_DEFAULT)
    `uvm_field_int(checks_enable, UVM_DEFAULT)
    `uvm_field_int(coverage_enable, UVM_DEFAULT)
  `uvm_component_utils_end

  // new - constructor
  function new(string name, uvm_component parent=null);
    super.new(name, parent);
    // Create covergroup only if coverage is enabled
    void'(get_config_int("coverage_enable", coverage_enable));
    if (coverage_enable) begin
      instruction_transaction_cg = new();
      instruction_transaction_cg.set_inst_name("s_instruction_transaction_cg");
    end
    // Create Data Item
    instruction_transaction_collected = UFRGS_miniMIPS_instruction_transaction::type_id::create("instruction_transaction_collected");
    // Create TLM ports
    item_collected_port = new("item_collected_port", this);
    addr_ph_imp = new("addr_ph_imp", this);
  endfunction : new

  // Additional class methods
  extern virtual task run_phase(uvm_phase phase);
  extern virtual protected task collect_instruction_transactions();
  extern virtual protected function bit check_addr_range();
  extern virtual protected task collect_address();
  extern virtual protected task collect_data();
  extern virtual protected function void perform_checks();
  extern virtual protected function void check_UFRGS_miniMIPS_instruction_transaction_size();
  extern virtual protected function void check_UFRGS_miniMIPS_instruction_transaction_data_size();
  extern protected function void perform_coverage();
  extern task peek(output UFRGS_miniMIPS_instruction_transaction instruction_transaction);

  function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	
  	if(!uvm_config_db#(virtual UFRGS_miniMIPS_if)::get(this,"","vif",vif))
		`uvm_error("NOVIF","vif is unset")
  endfunction
endclass

// run phase
task UFRGS_miniMIPS_Data_Memory_monitor::run_phase(uvm_phase phase);
  super.run_phase(phase);
  fork
    collect_instruction_transactions();
  join_none
endtask 

/***************************************************************************
 IVB-NOTE : REQUIRED : Data_Memory Monitor : Monitors
 -------------------------------------------------------------------------
 Modify the following methods to match your protocol:
    o check_addr_range() - check address range
    o collect_address() - monitor instruction_transaction address 
    o collect_data() - monitor instruction_transaction data
 Note that if you change/add signals to the physical interface, you must
 also change these methods.  
 ***************************************************************************/

// Collect Data_Memory instruction_transactions
task UFRGS_miniMIPS_Data_Memory_monitor::collect_instruction_transactions();
  bit range_check;
  forever begin
    if (m_parent != null)
      instruction_transaction_collected.Data_Memory = m_parent.get_name();
    collect_address();
    range_check = check_addr_range();
    if (range_check) begin
      // Enable instruction_transaction recording
      void'(begin_tr(instruction_transaction_collected, "UFRGS_miniMIPS Data_Memory Monitor"));
      -> address_phase_grabbed;
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
  end
endtask : collect_instruction_transactions

// Check if the instruction_transaction is in this Data_Memory address range
function bit UFRGS_miniMIPS_Data_Memory_monitor::check_addr_range();
  if ((instruction_transaction_collected.addr >= min_addr) &&
    (instruction_transaction_collected.addr <= max_addr)) begin
    return 1;
  end
  return 0;
endfunction : check_addr_range

// Collect address phase
task UFRGS_miniMIPS_Data_Memory_monitor::collect_address();
  @(posedge vif.sig_clock iff ( (vif.sig_read === 1) || 
    (vif.sig_write === 1) ) );
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
task UFRGS_miniMIPS_Data_Memory_monitor::collect_data();
  if (instruction_transaction_collected.read_write != NOP) begin
    for (int i = 0; i < instruction_transaction_collected.size; i++) begin
      @(posedge vif.sig_clock iff vif.sig_wait === 0);
      instruction_transaction_collected.data[i] = vif.sig_data;
    end
  end
  this.end_tr(instruction_transaction_collected);
endtask : collect_data
  
/***************************************************************************
 IVB-NOTE : OPTIONAL : Data_Memory Monitor Protocol Checks : Checks
 -------------------------------------------------------------------------
 Edit the following checks methods to match your protocol:
    o check_UFRGS_miniMIPS_instruction_transaction_size() 
    o check_UFRGS_miniMIPS_instruction_transaction_data_size() 
 Add new protocol checks methods and call them from the
 perform_checks() method. 
 ***************************************************************************/

function void UFRGS_miniMIPS_Data_Memory_monitor::perform_checks();
  check_UFRGS_miniMIPS_instruction_transaction_size();
  check_UFRGS_miniMIPS_instruction_transaction_data_size();
endfunction : perform_checks

// Check instruction_transaction size
function void UFRGS_miniMIPS_Data_Memory_monitor::check_UFRGS_miniMIPS_instruction_transaction_size();
  if(!(instruction_transaction_collected.size == 1 || 
    instruction_transaction_collected.size == 2 || instruction_transaction_collected.size == 4 || 
    instruction_transaction_collected.size == 8)) begin
    `uvm_error("ERR_INVALID_DATA_SIZE","Invalid instruction_transaction size!")
  end
endfunction : check_UFRGS_miniMIPS_instruction_transaction_size

// Check instruction_transaction data size
function void UFRGS_miniMIPS_Data_Memory_monitor::check_UFRGS_miniMIPS_instruction_transaction_data_size();
  if (instruction_transaction_collected.size != instruction_transaction_collected.data.size())
    `uvm_error("ERR_DATA_LENGTH_MISMATCH","instruction_transaction transaction size field / data size mismatch.")
endfunction : check_UFRGS_miniMIPS_instruction_transaction_data_size
 
/***************************************************************************
 IVB-NOTE : OPTIONAL : Data_Memory Monitor Coverage : Coverage
 -------------------------------------------------------------------------
 Modify the following coverage groups to match your protocol:
    o instruction_transaction_cg
 Add new coverage groups, fields and events, and edit the
 perform_coverage() method. to
 trigger the new coverage events and fill the new coverage fields. 
 ***************************************************************************/

// Triggers coverage events and fill cover fields
function void UFRGS_miniMIPS_Data_Memory_monitor::perform_coverage();
  instruction_transaction_cg.sample();
endfunction : perform_coverage

task UFRGS_miniMIPS_Data_Memory_monitor::peek(output UFRGS_miniMIPS_instruction_transaction instruction_transaction);
  @address_phase_grabbed;
  instruction_transaction = instruction_transaction_collected;
endtask
