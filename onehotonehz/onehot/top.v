// One Hot pattern generator
module top #(
       	parameter NUMWIDTH = 8,
	parameter PERIOD   = 6000000
	)	
	(
	input 				clk,
	input				rst,
	output reg [NUMWIDTH-1:0] 	rot = '0
);
	parameter 		N = 24;

	reg [NUMWIDTH-1:0]	tmp;
	reg [N-1:0] 		counter = 0;
	reg 			onehz = 0;

	always @(posedge clk) begin
		if (counter == PERIOD) begin
			counter <= '0;
			onehz	<= ~onehz;
		end
		counter 	<= counter + 1;
	end


	always @(posedge onehz) begin
		if (rst) begin
			rot <= '0;
		end else begin
			if (rot[NUMWIDTH-1] == 1) begin
				rot <= '0;
			end else begin
				if (rot == '0) begin
					rot[0] <= 1;
				end else begin
					rot <= rot<<1;
				end
			end
		end
	end

endmodule
