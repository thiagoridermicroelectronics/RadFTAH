module ram(
	req, adr, data_inout, r_w, ready
)
	(* const integer foreign = "VHDL(event) WORKLIB.ram:bench"; *);

parameter mem_size = 256, latency = 0;

input req;
input [31:0] adr;
inout [31:0] data_inout;
input r_w;
output ready;

endmodule
