// IVB checksum: 521949463
/*-----------------------------------------------------------------
File name     : UFRGS_miniMIPS_demo_scoreboard.sv
Developers    : traugusto
Created       : Sun Mar  8 01:06:00 2015
Description   :
Notes         :
-------------------------------------------------------------------
Copyright 2015 (c) Universidade Federal do Rio Grande do Sul
-----------------------------------------------------------------*/

//------------------------------------------------------------------------------
//
// CLASS: UFRGS_miniMIPS_demo_scoreboard
//
//------------------------------------------------------------------------------

class UFRGS_miniMIPS_demo_scoreboard extends uvm_scoreboard;

  // This TLM port is used to connect the scoreboard to the monitor
  uvm_analysis_imp#(UFRGS_miniMIPS_instruction_transaction, UFRGS_miniMIPS_demo_scoreboard) item_collected_imp;

  protected bit disable_scoreboard = 0;
  protected int num_writes = 0;
  protected int num_init_reads = 0;
  protected int num_uninit_reads = 0;

  protected int unsigned m_mem_expected[int unsigned];

  // Provide UVM automation and utility methods
  `uvm_component_utils_begin(UFRGS_miniMIPS_demo_scoreboard)
    `uvm_field_int(disable_scoreboard, UVM_DEFAULT)
    `uvm_field_int(num_writes, UVM_DEFAULT|UVM_DEC)
    `uvm_field_int(num_init_reads, UVM_DEFAULT|UVM_DEC)
    `uvm_field_int(num_uninit_reads, UVM_DEFAULT|UVM_DEC)
  `uvm_component_utils_end

  // Constructor - required syntax for UVM automation and utilities
  function new (string name, uvm_component parent);
    super.new(name, parent);
    // Construct the TLM interface
    item_collected_imp = new("item_collected_imp", this);
  endfunction : new

  // Additional class methods
  extern virtual function void write(UFRGS_miniMIPS_instruction_transaction instruction_transaction);
  extern virtual function void memory_verify(input UFRGS_miniMIPS_instruction_transaction instruction_transaction);
  extern virtual function void report_phase(uvm_phase phase);
   
endclass : UFRGS_miniMIPS_demo_scoreboard

  // TLM write() implementation
  function void UFRGS_miniMIPS_demo_scoreboard::write(UFRGS_miniMIPS_instruction_transaction instruction_transaction);
    if(!disable_scoreboard)
      memory_verify(instruction_transaction);
  endfunction : write

  // memory_verify
  function void UFRGS_miniMIPS_demo_scoreboard::memory_verify(input UFRGS_miniMIPS_instruction_transaction instruction_transaction);
    int unsigned data, exp;
    string op;
    for (int i = 0; i < instruction_transaction.size; i++) begin
      // Check to see if entry in associative array for this address when read
      // If so, check that instruction_transaction data matches associative array data.
      if (m_mem_expected.exists(instruction_transaction.addr + i)) begin
        if (instruction_transaction.read_write == READ) begin
          op = instruction_transaction.read_write.name();
          data = instruction_transaction.data[i];
          `uvm_info(get_type_name(),
            $sformatf("%s to existing address...Checking address : %0h with data : %0h", op, instruction_transaction.addr, data), UVM_LOW)
          if(m_mem_expected[instruction_transaction.addr + i] != instruction_transaction.data[i]) begin
            exp = m_mem_expected[instruction_transaction.addr + i];
            `uvm_error("ERR_READ_DATA_MISMTACH",
              $sformatf("Read data mismatch.  Expected : %0h.  Actual : %0h", exp, data))
          end
          num_init_reads++;
        end
        if (instruction_transaction.read_write == WRITE) begin
          op = instruction_transaction.read_write.name();
          data = instruction_transaction.data[i];
          `uvm_info(get_type_name(),
              $sformatf("%s to existing address...Updating address : %0h with data : %0h",
              op, instruction_transaction.addr + i, data), UVM_LOW)
          m_mem_expected[instruction_transaction.addr + i] = instruction_transaction.data[i];
          num_writes++;
        end
      end
      // Check to see if entry in associative array for this address
      // If not, update the location regardless if read or write.
      else begin
        op = instruction_transaction.read_write.name();
        data = instruction_transaction.data[i];
        `uvm_info(get_type_name(),
          $sformatf("%s to empty address...Updating address : %0h with data : %0h", 
          op, instruction_transaction.addr + i, data), UVM_LOW)
        m_mem_expected[instruction_transaction.addr + i] = instruction_transaction.data[i];
        if(instruction_transaction.read_write == READ)
          num_uninit_reads++;
        else if (instruction_transaction.read_write == WRITE)
          num_writes++;
      end
    end
  endfunction : memory_verify

  // report
  function void UFRGS_miniMIPS_demo_scoreboard::report_phase(uvm_phase phase);
    super.report_phase(phase);
    if(!disable_scoreboard)
      `uvm_info(get_type_name(),$sformatf("Reporting scoreboard information...\n%s", this.sprint()), UVM_LOW)
  endfunction
