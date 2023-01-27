`timescale 1ns / 1ps

module tb_edgedetect ();

wire fle;
reg clk,rst,data_in;

edgedetect u1(clk,rst,data_in,fle);

initial begin clk = 0; forever #10 clk = ~clk; end

initial begin
	rst = 1;
	#20
	rst = 0;
	data_in = 1;
	#40
	data_in = 0;
	#40
	data_in = 1;
end

initial begin
	$dumpfile("tb_edgedetect.vcd");
	$dumpvars(0, tb_edgedetect);
	#120
	$finish;
end

endmodule 
