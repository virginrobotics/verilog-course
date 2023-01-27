`timescale 1ns / 1ps
module edgedetect
			(
				input	clk,rst,
				input	data_in,
				output	reg fle
			);

	reg [2:0] pipe;
	wire fallingedge = (pipe[2:1] == 2'b10);

	always@ (posedge clk) begin pipe <= {pipe[1:0],data_in}; end

	always@ (posedge clk) begin
		if (rst) begin
			fle <= 0;
		end else if (fallingedge) begin
			fle <= 1;
		end
	end

	
endmodule
