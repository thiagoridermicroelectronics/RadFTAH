// IVB checksum: 863667343
/*-----------------------------------------------------------------
File name     : UFRGS_miniMIPS_Instruction_Memory_seq_lib.sv
Developers    : traugusto
Created       : Sun Mar  8 01:06:00 2015
Description   :
Notes         :
-------------------------------------------------------------------
Copyright 2015 (c) Universidade Federal do Rio Grande do Sul
-----------------------------------------------------------------*/

/***************************************************************************
 IVB-NOTE : OPTIONAL : Instruction_Memory sequence library : Sequence Library
 -------------------------------------------------------------------------
 Here you can add basic Instruction_Memory sequences, and use them to implement 
 different scenarios or behavior (see the examples below).
 1. Implement the new function
 2. Add sequence attributes
 3. Implement the body() task to create the sequence behavior 
 ***************************************************************************/

//------------------------------------------------------------------------------
//
// SEQUENCE: active_base
//
//------------------------------------------------------------------------------
 virtual class active_base_seq#(type REQ=uvm_object,RSP=REQ) extends uvm_sequence #(REQ,RSP);

  function new(string name="active_base_seq");
    super.new(name);
  endfunction

  virtual task pre_body();
	// NOTE see mantis DB
	if(!starting_phase)
    		starting_phase.raise_objection(this);
  endtask

  virtual task post_body();
	if(!starting_phase)
     		starting_phase.drop_objection(this);
  endtask
  
endclass

//------------------------------------------------------------------------------
//
// SEQUENCE: read_byte
//
//------------------------------------------------------------------------------
 
class read_byte_seq extends active_base_seq #(UFRGS_miniMIPS_instruction_transaction);

  function new(string name="read_byte_seq");
    super.new(name);
  endfunction
  
  `uvm_object_utils(read_byte_seq)    

  rand bit [31:0]  start_addr;
  rand int unsigned transmit_del = 0;
  constraint transmit_del_ct { (transmit_del <= 10); }

  virtual task body();
    `uvm_do_with(req,
      { req.addr == start_addr;
        req.read_write == READ;
        req.size == 1;
        req.error_pos == 1000;
        req.transmit_delay == transmit_del; } )
    `uvm_info(get_type_name(),
       $sformatf("Reading : addr = `x%0h, data[0] = `x%0h",
       req.addr, req.data[0]), UVM_HIGH)
  endtask

endclass : read_byte_seq

//------------------------------------------------------------------------------
//
// SEQUENCE: write_byte_seq
//
//------------------------------------------------------------------------------
 
class write_byte_seq extends active_base_seq #(UFRGS_miniMIPS_instruction_transaction);

  function new(string name="write_byte_seq");
    super.new(name);
  endfunction

  `uvm_object_utils(write_byte_seq)
    
  rand bit [31:0]  start_addr;
  rand bit [31:0]   data0;
  rand int unsigned transmit_del = 0;
  constraint transmit_del_ct { (transmit_del <= 10); }

  virtual task body();
    `uvm_do_with(req,
      { req.addr == start_addr;
        req.read_write == WRITE;
        req.size == 1;
        req.data[0] == data0;
        req.error_pos == 1000;
        req.transmit_delay == transmit_del; } )
    `uvm_info(get_type_name(),
       $sformatf("Writing : addr = `x%0h, data[0] = `x%0h",
       req.addr, req.data[0]), UVM_HIGH)
  endtask
endclass : write_byte_seq
 
//------------------------------------------------------------------------------
//
// SEQUENCE: read_modify_write_seq
//
//------------------------------------------------------------------------------

class read_modify_write_seq extends active_base_seq#(UFRGS_miniMIPS_instruction_transaction);

  function new(string name="read_modify_write_seq");
    super.new(name);
  endfunction

  `uvm_object_utils(read_modify_write_seq)    

  read_byte_seq read_byte_seq0;
  write_byte_seq write_byte_seq0;

  rand bit [31:0] start_address;
  rand bit [31:0] addr_check;
  bit [31:0] m_data0;
  bit [31:0] m_data0_check;

  constraint address_ct { (start_address <= 32'hf000); }      
  virtual task body();
    begin
      `uvm_info(get_type_name(),"Starting sequence", UVM_MEDIUM)
      // READ
      `uvm_do_with(read_byte_seq0, 
		{read_byte_seq0.start_addr== start_address;})
      addr_check = read_byte_seq0.req.addr;
      m_data0_check = read_byte_seq0.req.data[0] + 1;
      // WRITE
      `uvm_do_with(write_byte_seq0,
        { write_byte_seq0.start_addr == addr_check;
          write_byte_seq0.data0 == m_data0_check; } )
      // READ MODIFIED WRITE DATA
      `uvm_do_with(read_byte_seq0,
        { read_byte_seq0.start_addr == addr_check; } )
      m_data0 = read_byte_seq0.req.data[0];
    end
  endtask : body
endclass : read_modify_write_seq

