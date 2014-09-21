module rom(
	adr, donnee, ack, load
)
	(* const integer foreign = "VHDL(event) WORKLIB.rom:bench"; *);

parameter mem_size = 256, start = 32768, latency = 0;

input [31:0] adr;
output [31:0] donnee;
output ack;
input load;

endmodule
