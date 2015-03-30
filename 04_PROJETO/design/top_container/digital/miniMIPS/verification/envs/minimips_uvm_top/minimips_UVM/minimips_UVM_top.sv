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
  wire         UFRGS_miniMIPS_ram_rdy;
  wire         UFRGS_miniMIPS_it_mat;
  wire [31:0]  UFRGS_miniMIPS_ram_adr;
  wire [31:0]  UFRGS_miniMIPS_ram_data;
  reg          UFRGS_miniMIPS_ram_req;
  wire         UFRGS_miniMIPS_ram_r_w;
  wire [1:0]   UFRGS_miniMIPS_size;


  UFRGS_miniMIPS_if UFRGS_miniMIPS_if_0(clock, reset);
  
  minimips dut(
    clock,
    reset,
    ram_req,
    ram_adr,
    ram_r_w,
    ram_data,
    ram_ack,
    it_mat
  );


  // Interface Connections
  assign UFRGS_miniMIPS_if_0.sig_clock = clock;
  assign UFRGS_miniMIPS_if_0.sig_reset = reset;


  assign UFRGS_miniMIPS_ram_rdy  = UFRGS_miniMIPS_if_0.sig_ram_rdy;
  assign UFRGS_miniMIPS_it_mat   = UFRGS_miniMIPS_if_0.sig_it_mat;
  assign UFRGS_miniMIPS_ram_adr  = UFRGS_miniMIPS_if_0.sig_ram_adr;
  assign UFRGS_miniMIPS_ram_data = UFRGS_miniMIPS_if_0.sig_ram_data;
  assign UFRGS_miniMIPS_ram_req  = UFRGS_miniMIPS_if_0.sig_ram_req;
  assign UFRGS_miniMIPS_ram_r_w  = UFRGS_miniMIPS_if_0.sig_ram_r_w;
  assign UFRGS_miniMIPS_size     = UFRGS_miniMIPS_if_0.sig_size;


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
