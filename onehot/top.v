// One Hot pattern generator
module top #(
       	parameter NUMWIDTH = 8
	)	
	(
	input 				clk,
	input				rst,
	output reg [NUMWIDTH-1:0] 	rot
);
	reg [NUMWIDTH-1:0]	tmp;
	


	always @(posedge clk or negedge rst) begin
		if (!rst) begin
			rot <= 'b0;
		end else begin
			if (rot[NUMWIDTH-1] == 1) begin
				rot <= 'b0;
			end else begin
				if (rot == 0) begin
					rot[0] <= 1;
				end else begin
					rot <= rot<<1;
				end
			end
		end
	end

endmodule
