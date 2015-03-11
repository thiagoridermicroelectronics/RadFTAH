// IVB checksum: 2009803106
/*-----------------------------------------------------------------
File name     : UFRGS_miniMIPS_Data_Memory_driver.sv
Developers    : traugusto
Created       : Sun Mar  8 01:06:00 2015
Description   :
Notes         :
-------------------------------------------------------------------
Copyright 2015 (c) Universidade Federal do Rio Grande do Sul
-----------------------------------------------------------------*/

//------------------------------------------------------------------------------
//
// CLASS: UFRGS_miniMIPS_Data_Memory_driver
//
//------------------------------------------------------------------------------
 
class UFRGS_miniMIPS_Data_Memory_driver extends uvm_driver #(UFRGS_miniMIPS_instruction_transaction);

  /***************************************************************************
   IVB-NOTE : REQUIRED : Data_Memory DRIVER functionality : DRIVER
   -------------------------------------------------------------------------
   Modify the following methods to match your protocol:
      o respond_to_instruction_transaction - response driving
      o reset()    - Data_Memory signals reset values
   Note that if you change/add signals to the physical interface you must
   also change these methods.
   ***************************************************************************/

  // The virtual interface used to drive and view HDL signals.
  virtual UFRGS_miniMIPS_if vif;

  // Provide implementations of virtual methods such as get_type_name and create
  `uvm_component_utils(UFRGS_miniMIPS_Data_Memory_driver)

  // new - constructor
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // Additional class methods
  extern virtual task run_phase(uvm_phase phase);
  extern virtual protected task get_and_drive();
  extern virtual protected task reset();
  extern virtual protected task respond_to_instruction_transaction(UFRGS_miniMIPS_instruction_transaction resp);

  function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	
  	if(!uvm_config_db#(virtual UFRGS_miniMIPS_if)::get(this,"","vif",vif))
		`uvm_error(get_type_name(),"vif is unset")
  endfunction
endclass 

// UVM run phase
task UFRGS_miniMIPS_Data_Memory_driver::run_phase(uvm_phase phase);
  super.run_phase(phase);
  fork
    get_and_drive();
    reset();
  join_none
endtask 

// Continually gets responses from the sequencer and passes them to the driver.
task UFRGS_miniMIPS_Data_Memory_driver::get_and_drive();
  @(negedge vif.sig_reset);
  `uvm_info(get_type_name(), "Reset dropped", UVM_MEDIUM)
  forever begin
    @(posedge vif.sig_clock);
    // Get new item from the sequencer
    seq_item_port.get_next_item(rsp);
    // Drive the response
    `uvm_info(get_type_name(),
      $sformatf("Driving response :\n%s", rsp.sprint()), UVM_HIGH)
    respond_to_instruction_transaction(rsp);
    // Communicate item done to the sequencer
    seq_item_port.item_done();
  end
endtask : get_and_drive

// Reset all Data_Memory signals
task UFRGS_miniMIPS_Data_Memory_driver::reset();
  forever begin
    @(posedge vif.sig_reset);
    `uvm_info(get_type_name(), "Reset observed", UVM_MEDIUM)
    vif.sig_error <= 1'bz;
    vif.sig_wait <= 1'bz;
    vif.rw <= 1'b0;
  end
endtask : reset

// Get response and drive it into the DUT
task UFRGS_miniMIPS_Data_Memory_driver::respond_to_instruction_transaction(UFRGS_miniMIPS_instruction_transaction resp);
  if (resp.read_write != NOP)
  begin
    vif.sig_error <= 1'b0;
    for (int i = 0; i < resp.size; i++)
    begin
      case (resp.read_write)
        READ : begin
          vif.rw <= 1'b1;
          vif.sig_data_out <= resp.data[i];
        end
        WRITE : begin
        end
      endcase
      if (resp.wait_state[i] > 0) begin
        vif.sig_wait <= 1'b1;
        repeat (resp.wait_state[i])
          @(posedge vif.sig_clock);
      end
      vif.sig_wait <= 1'b0;
      @(posedge vif.sig_clock);
      resp.data[i] = vif.sig_data;
    end
    vif.rw <= 1'b0;
    vif.sig_wait <= 1'bz;
    vif.sig_error <= 1'bz;
  end
endtask : respond_to_instruction_transaction
