module tb();

wire [NUM-1:0] rot;
reg clk,rst;
parameter NUM = 4;
top #(NUM) u1(clk, rst, rot);

initial begin clk = 0; forever #10 clk = !clk; end

initial begin
	rst = 1;
	#20
	rst = 0;
	#10
	rst = 1;
end

initial begin
	$dumpfile("output.vcd");
	$dumpvars;
	#500
	$finish;
end

endmodule

