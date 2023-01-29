//alternate method suggested by @abdullahbatiran
`timescale 1ns / 1ps
module edgedetect2
			(
				input	clk,rst,
				input	data_in,
				output	fle
			);

	reg [1:0] pipe;
	wire fallingedge;
	assign fallingedge = rst ? 0 : (pipe[1] == 1 && pipe[0] == 0);

	always@ (posedge clk) begin pipe <= {pipe[0],data_in}; end

	assign fle = fallingedge;

	
endmodule
