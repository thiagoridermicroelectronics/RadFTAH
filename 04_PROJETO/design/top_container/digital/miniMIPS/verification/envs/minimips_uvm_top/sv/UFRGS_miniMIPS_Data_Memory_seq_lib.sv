// IVB checksum: 2758269952
/*-----------------------------------------------------------------
File name     : UFRGS_miniMIPS_Data_Memory_seq_lib.sv
Developers    : traugusto
Created       : Sun Mar  8 01:06:01 2015
Description   :
Notes         :
-------------------------------------------------------------------
Copyright 2015 (c) Universidade Federal do Rio Grande do Sul
-----------------------------------------------------------------*/
 
/***************************************************************************
 IVB-NOTE : OPTIONAL : Data_Memory sequence library : Sequence Library
 -------------------------------------------------------------------------
 Here you can add basic Data_Memory sequences, and use them to implement 
 different scenarios or behavior (see the examples below).
 1. Implement the new function
 2. Add sequence attributes
 3. Implement the body() task to create the sequence behavior
 ***************************************************************************/

//------------------------------------------------------------------------------
//
// SEQUENCE: Data_Memory_memory_seq
//
//------------------------------------------------------------------------------

class Data_Memory_memory_seq extends uvm_sequence #(UFRGS_miniMIPS_instruction_transaction);

  function new(string name="Data_Memory_memory_seq");
    super.new(name);
  endfunction

  `uvm_object_utils(Data_Memory_memory_seq)

   // typed pointer to sequencer running this sequence p_sequncer
  `uvm_declare_p_sequencer(UFRGS_miniMIPS_Data_Memory_sequencer)

  UFRGS_miniMIPS_instruction_transaction util_Data_Memory_transaction;

  bit [31:0] m_mem[int unsigned];
  bit [31:0] temp_data[];
 
  virtual task body();
    forever
    begin
      p_sequencer.addr_ph_port.peek(util_Data_Memory_transaction);
      //READ, i.e.  util_Data_Memory_transaction.read_write == READ
      if( util_Data_Memory_transaction.read_write == READ ) begin : READ_block
        temp_data = new[util_Data_Memory_transaction.size];
        for(int unsigned i = 0 ; i < util_Data_Memory_transaction.size ; i ++) begin
          if (!m_mem.exists(util_Data_Memory_transaction.addr + i)) begin
            m_mem[util_Data_Memory_transaction.addr + i] = $urandom;
          end
          temp_data[i] = m_mem[util_Data_Memory_transaction.addr + i];
        end
        `uvm_do_with(req, 
          { addr == util_Data_Memory_transaction.addr;
            read_write == util_Data_Memory_transaction.read_write;
            size == util_Data_Memory_transaction.size;
            foreach (data[i]) data[i] == temp_data[i];
            foreach (wait_state[i]) wait_state[i] == 2;
            error_pos == 1000;
            transmit_delay == 0; } )
      end : READ_block
      //WRITE, i.e.  util_Data_Memory_transaction.read_write == WRITE
      if( util_Data_Memory_transaction.read_write == WRITE ) begin : WRITE_block
        `uvm_do_with(req,
          { addr == util_Data_Memory_transaction.addr;
            read_write == util_Data_Memory_transaction.read_write;
            size == util_Data_Memory_transaction.size;
            foreach (wait_state[i]) wait_state[i] == 0; } )
        for(int unsigned i = 0 ; i < req.size ; i ++) begin : for_block
          m_mem[req.addr + i] = req.data[i] ;
        end : for_block
      end : WRITE_block
    end
  endtask : body

endclass : Data_Memory_memory_seq

