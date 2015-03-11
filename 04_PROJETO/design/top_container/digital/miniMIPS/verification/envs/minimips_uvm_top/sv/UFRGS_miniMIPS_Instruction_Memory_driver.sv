// IVB checksum: 3573061737
/*-----------------------------------------------------------------
File name     : UFRGS_miniMIPS_Instruction_Memory_driver.sv
Developers    : traugusto
Created       : Sun Mar  8 01:06:00 2015
Description   :
Notes         :
-------------------------------------------------------------------
Copyright 2015 (c) Universidade Federal do Rio Grande do Sul
-----------------------------------------------------------------*/

//------------------------------------------------------------------------------
//
// CLASS: UFRGS_miniMIPS_Instruction_Memory_driver
//
//------------------------------------------------------------------------------

class UFRGS_miniMIPS_Instruction_Memory_driver extends uvm_driver #(UFRGS_miniMIPS_instruction_transaction);

  /***************************************************************************
   IVB-NOTE : REQUIRED : Instruction_Memory DRIVER functionality : DRIVER
   -------------------------------------------------------------------------
   Modify the following methods to match your protocol:
      o drive_Instruction_Memory_transaction - Handshake process
      o arbitrate_for_bus()      - Arbitration process
      o drive_address()    - instruction_transaction address driving
      o drive_data()       - instruction_transaction data driving
      o reset()                  - Instruction_Memory signals reset values
   Note that if you change/add signals to the physical interface you must
   also change these methods.
   ***************************************************************************/

  // The virtual interface used to drive and view HDL signals.
  virtual UFRGS_miniMIPS_if vif;

  // Master Id
  int Instruction_Memory_id;

  // Provide implmentations of virtual methods such as get_type_name and create
  `uvm_component_utils(UFRGS_miniMIPS_Instruction_Memory_driver)

  // new - constructor
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // Additional class methods
  extern virtual task run_phase(uvm_phase phase);
  extern virtual protected task get_and_drive();
  extern virtual protected task reset();
  extern virtual protected task drive_Instruction_Memory_transaction (UFRGS_miniMIPS_instruction_transaction Instruction_Memory_transaction);
  extern virtual protected task arbitrate_for_bus();
  extern virtual protected task drive_address (UFRGS_miniMIPS_instruction_transaction Instruction_Memory_transaction);
  extern virtual protected task drive_data (UFRGS_miniMIPS_instruction_transaction Instruction_Memory_transaction);
  extern virtual protected task read_byte (output bit [31:0]  data, output bit error);
  extern virtual protected task write_byte (bit [31:0] data, output bit error);
  extern virtual protected task drive_size (int size);
  extern virtual protected task drive_read_write(UFRGS_miniMIPS_read_write_enum rw);

  function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	
  	if(!uvm_config_db#(virtual UFRGS_miniMIPS_if)::get(this,"","vif",vif))
		`uvm_error("NOVIF","vif is unset")
  endfunction
endclass : UFRGS_miniMIPS_Instruction_Memory_driver

// run phase
task UFRGS_miniMIPS_Instruction_Memory_driver::run_phase(uvm_phase phase);
  super.run_phase(phase);
  fork
    get_and_drive();
    reset();
  join_none
endtask 

// Gets instruction_transaction from the sequencer
// and passes them to the driver.  
task UFRGS_miniMIPS_Instruction_Memory_driver::get_and_drive();
  @(negedge vif.sig_reset);
  `uvm_info(get_type_name(), "Reset dropped", UVM_LOW)
  forever begin
    @(posedge vif.sig_clock);
    // Get new item from the sequencer
    seq_item_port.get_next_item(req);
    // Drive the data item
    `uvm_info(get_type_name(), $sformatf("Driving Instruction_Memory_transaction :\n%s",req.sprint()), UVM_MEDIUM)
    drive_Instruction_Memory_transaction(req);
    // Communicate item done to the sequencer
    seq_item_port.item_done();
  end
endtask : get_and_drive

// Reset all Instruction_Memory signals
task UFRGS_miniMIPS_Instruction_Memory_driver::reset();
  forever begin
    @(posedge vif.sig_reset);
    `uvm_info(get_type_name(), "Reset obsverved", UVM_MEDIUM)
    vif.sig_request[Instruction_Memory_id] <= 0;
    vif.rw <= 'h0;
    vif.sig_addr <= 'hz;
    vif.sig_data_out <= 'hz;
    vif.sig_size <= 'bz;
    vif.sig_read <= 'bz;
    vif.sig_write <= 'bz;
    vif.sig_bip <= 'bz;
  end
endtask : reset

// Gets a instruction_transaction and drive it into the DUT
task UFRGS_miniMIPS_Instruction_Memory_driver::drive_Instruction_Memory_transaction (UFRGS_miniMIPS_instruction_transaction Instruction_Memory_transaction);
  if (Instruction_Memory_transaction.transmit_delay > 0) begin
    repeat(Instruction_Memory_transaction.transmit_delay) @(posedge vif.sig_clock);
  end
  arbitrate_for_bus();
  drive_address(Instruction_Memory_transaction);
  drive_data(Instruction_Memory_transaction);
endtask : drive_Instruction_Memory_transaction

// Drives the request signal high and wait till the grant signal is high also.
task UFRGS_miniMIPS_Instruction_Memory_driver::arbitrate_for_bus();
  vif.sig_request[Instruction_Memory_id] <= 1;
  @(posedge vif.sig_clock iff vif.sig_grant[Instruction_Memory_id] === 1);
  vif.sig_request[Instruction_Memory_id] <= 0;
endtask : arbitrate_for_bus

// Drives the address of the instruction_transaction 
task UFRGS_miniMIPS_Instruction_Memory_driver::drive_address (UFRGS_miniMIPS_instruction_transaction Instruction_Memory_transaction);
  vif.sig_addr <= Instruction_Memory_transaction.addr;
  drive_size(Instruction_Memory_transaction.size);
  drive_read_write(Instruction_Memory_transaction.read_write);
  @(posedge vif.sig_clock);
  vif.sig_addr <= 32'bz;
  vif.sig_size <= 2'bz;
  vif.sig_read <= 1'bz;
  vif.sig_write <= 1'bz;  
endtask : drive_address

// Drives the data of the instruction_transaction
task UFRGS_miniMIPS_Instruction_Memory_driver::drive_data (UFRGS_miniMIPS_instruction_transaction Instruction_Memory_transaction);
  bit err;
  for(int i = 0; i <= Instruction_Memory_transaction.size - 1; i ++) begin
    if (i == (Instruction_Memory_transaction.size - 1))
      vif.sig_bip <= 0;
    else
      vif.sig_bip <= 1;
    case (Instruction_Memory_transaction.read_write)
      READ : read_byte(Instruction_Memory_transaction.data[i], err);
      WRITE : write_byte(Instruction_Memory_transaction.data[i], err);
    endcase
  end //for loop
  vif.sig_data_out <= 32'bz;
  vif.sig_bip <= 1'bz;
endtask : drive_data

// Read one data byte
task UFRGS_miniMIPS_Instruction_Memory_driver::read_byte (output bit [31:0]  data, output bit error);
  @(posedge vif.sig_clock iff vif.sig_wait === 0);
  data = vif.sig_data;
endtask : read_byte

// Write one data byte
task UFRGS_miniMIPS_Instruction_Memory_driver::write_byte (bit [31:0] data, output bit error);
  vif.rw <= 1'b1;
  vif.sig_data_out <= data;
  @(posedge vif.sig_clock iff vif.sig_wait === 0);
  vif.rw <= 'h0;
endtask : write_byte

// Drive instruction_transaction size
task UFRGS_miniMIPS_Instruction_Memory_driver::drive_size (int size);
  case (size)
    1: vif.sig_size <= 2'b00;
    2: vif.sig_size <= 2'b01;
    4: vif.sig_size <= 2'b10;
    8: vif.sig_size <= 2'b11;
  endcase
endtask : drive_size

task UFRGS_miniMIPS_Instruction_Memory_driver::drive_read_write(UFRGS_miniMIPS_read_write_enum rw);
  case (rw)
    NOP : begin vif.sig_read <= 0; vif.sig_write <= 0; end
    READ : begin vif.sig_read <= 1; vif.sig_write <= 0; end
    WRITE : begin vif.sig_read <= 0; vif.sig_write <= 1; end
  endcase
endtask : drive_read_write


