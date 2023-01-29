`timescale 1ns / 1ps

module tb_edgedetect2 ();

wire fle;
reg clk,rst,data_in;

edgedetect2 u1(clk,rst,data_in,fle); //checking twitter response

initial begin clk = 0; forever #2 clk = ~clk; end

initial begin
	rst = 1;
	#20
	rst = 0;
	data_in = 1;
	#38
	data_in = 0;
	#40
	data_in = 1;
end

initial begin
	$dumpfile("tb_edgedetect2.vcd");
	$dumpvars(0, tb_edgedetect2);
	#120
	$finish;
end

endmodule 
