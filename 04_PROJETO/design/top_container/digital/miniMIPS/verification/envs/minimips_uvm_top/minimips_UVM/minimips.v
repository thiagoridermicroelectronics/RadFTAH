//This is dummy DUT. 

module dut_dummy(
  input wire UFRGS_miniMIPS_req_Instruction_Memory_0,
  output reg UFRGS_miniMIPS_gnt_Instruction_Memory_0,
  
  input wire UFRGS_miniMIPS_clock,
  input wire UFRGS_miniMIPS_reset,
  input wire [31:0] UFRGS_miniMIPS_addr,
  input wire [1:0] UFRGS_miniMIPS_size,
  output reg UFRGS_miniMIPS_read,
  output reg UFRGS_miniMIPS_write,
  output reg  UFRGS_miniMIPS_start,
  input wire UFRGS_miniMIPS_bip,
  inout wire [31:0] UFRGS_miniMIPS_data,
  input wire UFRGS_miniMIPS_wait,
  input wire UFRGS_miniMIPS_error);
  reg [2:0]   state;

  //fake arbiter, only one Instruction_Memory

   always @(posedge UFRGS_miniMIPS_clock or posedge UFRGS_miniMIPS_reset) begin
     if( UFRGS_miniMIPS_reset) begin
       UFRGS_miniMIPS_start <= 1'b0;
       state<=3'h0;
     end
       else
         case(state)
         0: begin //Begin out of Reset
             UFRGS_miniMIPS_start <= 1'b1;
             state<=3'h3;
         end
         3: begin //Start state
             UFRGS_miniMIPS_start <= 1'b0;
             if(UFRGS_miniMIPS_gnt_Instruction_Memory_0==0) begin
                 state<=3'h4;
             end
             else
                 state<=3'h1;
         end
         4: begin // No-op state
             UFRGS_miniMIPS_start <= 1'b1;
             state<=3'h3;
         end
         1: begin // Addr state
             state<=3'h2;
             UFRGS_miniMIPS_start <= 1'b0;
         end
         2: begin // Data state
             if((UFRGS_miniMIPS_error==1) || ((UFRGS_miniMIPS_bip==0) && (UFRGS_miniMIPS_wait==0))) begin
                 state<=3'h3;
                 UFRGS_miniMIPS_start <= 1'b1;
             end
             else begin
                 state<=3'h2;
                 UFRGS_miniMIPS_start <= 1'b0;
             end
         end
         endcase
     end

   always @(negedge UFRGS_miniMIPS_clock or posedge UFRGS_miniMIPS_reset) begin
     if(UFRGS_miniMIPS_reset == 1'b1) 
       UFRGS_miniMIPS_gnt_Instruction_Memory_0 <= 0;
     else begin
       if(UFRGS_miniMIPS_start && UFRGS_miniMIPS_req_Instruction_Memory_0)
         UFRGS_miniMIPS_gnt_Instruction_Memory_0 <= 1;
       else
         UFRGS_miniMIPS_gnt_Instruction_Memory_0 <= 0;
     end
   end

   always @(posedge UFRGS_miniMIPS_clock or posedge UFRGS_miniMIPS_reset) begin
     if( UFRGS_miniMIPS_reset) begin
       UFRGS_miniMIPS_read <= 1'bZ;
       UFRGS_miniMIPS_write <= 1'bZ;
     end
     else if(UFRGS_miniMIPS_start && !UFRGS_miniMIPS_gnt_Instruction_Memory_0) begin
       UFRGS_miniMIPS_read <= 1'b0;
       UFRGS_miniMIPS_write <= 1'b0;
     end
     else begin
       UFRGS_miniMIPS_read <= 1'bZ;
       UFRGS_miniMIPS_write <= 1'bZ;
     end
   end

endmodule

 
