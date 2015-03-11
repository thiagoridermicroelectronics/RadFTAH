// IVB checksum: 2710388972
/*-----------------------------------------------------------------
File name     : demo_top.sv
Developers    : traugusto
Created       : Sun Mar  8 01:06:00 2015
Description   :
Notes         :
-------------------------------------------------------------------
Copyright 2015 (c) Universidade Federal do Rio Grande do Sul
-----------------------------------------------------------------*/

module minimips_UVM_top;

  // Import the UVM Package
  import uvm_pkg::*;

  // Import the UFRGS_MINIMIPS UVC Package
  import UFRGS_miniMIPS_pkg::*;

  // include all tests from test library
  `include "test_lib.sv"

  reg clock;
  reg reset;
  wire [31:0]  UFRGS_miniMIPS_addr;
  wire [1:0] UFRGS_miniMIPS_size;
  wire UFRGS_miniMIPS_read;
  wire UFRGS_miniMIPS_write;
  reg UFRGS_miniMIPS_start;
  wire UFRGS_miniMIPS_bip;
  wire [31:0] UFRGS_miniMIPS_data;
  wire UFRGS_miniMIPS_wait;
  wire UFRGS_miniMIPS_error;
  reg UFRGS_miniMIPS_req_Instruction_Memory0;
  reg UFRGS_miniMIPS_gnt_Instruction_Memory0;  

  UFRGS_miniMIPS_if UFRGS_miniMIPS_if_0(clock, reset);
  
  dut_dummy dut(
    UFRGS_miniMIPS_req_Instruction_Memory0,
    UFRGS_miniMIPS_gnt_Instruction_Memory0,
    clock,
    reset,
    UFRGS_miniMIPS_addr,
    UFRGS_miniMIPS_size,
    UFRGS_miniMIPS_read,
    UFRGS_miniMIPS_write,
    UFRGS_miniMIPS_start,
    UFRGS_miniMIPS_bip,
    UFRGS_miniMIPS_data,
    UFRGS_miniMIPS_wait,
    UFRGS_miniMIPS_error
  );

  // Interface Connections
  //assign UFRGS_miniMIPS_if_0.sig_clock = UFRGS_miniMIPS_clock;
  //assign UFRGS_miniMIPS_if_0.sig_reset = UFRGS_miniMIPS_reset;

  assign UFRGS_miniMIPS_req_Instruction_Memory0 = UFRGS_miniMIPS_if_0.sig_request[0];
  assign UFRGS_miniMIPS_if_0.sig_grant[0] = UFRGS_miniMIPS_gnt_Instruction_Memory0;

  assign UFRGS_miniMIPS_addr = UFRGS_miniMIPS_if_0.sig_addr;
  assign UFRGS_miniMIPS_size = UFRGS_miniMIPS_if_0.sig_size;
  assign UFRGS_miniMIPS_read = UFRGS_miniMIPS_if_0.sig_read;
  assign UFRGS_miniMIPS_write = UFRGS_miniMIPS_if_0.sig_write;
  assign UFRGS_miniMIPS_if_0.sig_start = UFRGS_miniMIPS_start;
  assign UFRGS_miniMIPS_bip = UFRGS_miniMIPS_if_0.sig_bip;

  assign UFRGS_miniMIPS_if_0.sig_data = UFRGS_miniMIPS_data;

  assign UFRGS_miniMIPS_wait = UFRGS_miniMIPS_if_0.sig_wait;
  assign UFRGS_miniMIPS_error = UFRGS_miniMIPS_if_0.sig_error;

  assign UFRGS_miniMIPS_data = UFRGS_miniMIPS_if_0.rw ? UFRGS_miniMIPS_if_0.sig_data_out : 32'bz;

  initial begin
    run_test();
  end

  initial begin
    reset <= 1'b1;
    clock <= 1'b1;
    #51 reset = 1'b0;
  end

  //Generate Clock
  always
    #5 clock = ~clock;

endmodule
