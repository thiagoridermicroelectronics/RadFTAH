module minimips(
	clock, reset, ram_req, ram_adr, ram_r_w, ram_data, ram_ack, it_mat
)
	(* const integer foreign = "VHDL(event) WORKLIB.minimips:rtl"; *);
input clock;
input reset;
output ram_req;
output [31:0] ram_adr;
output ram_r_w;
inout [31:0] ram_data;
input ram_ack;
input it_mat;

endmodule
