module top(
    input clk,
    output LED1,
    output LED2,
    output LED3,
    output LED4,
    output LED5,
    output LED6,
    output LED7,
    output LED8
    );

	reg[15:0] div_cntr1;
	reg[6:0] div_cntr2;
	reg dec_cntr;
	reg half_sec_pulse;
	
	initial begin
		div_cntr1 = 0;
		div_cntr2 = 0;
		dec_cntr  = 0;
		end
		
	
	always@(posedge clk)
		begin
		div_cntr1 <= div_cntr1 + 1;
		if (div_cntr1 == 0) 
			if (div_cntr2 == 91) 
				begin
				div_cntr2 <= 0;
				half_sec_pulse <= 1;  
				end
			else
				div_cntr2 <= div_cntr2 + 1;
		else
			half_sec_pulse <= 0;
		
		if (half_sec_pulse == 1)	
			dec_cntr <= !dec_cntr;
			
		end	
		
		
	assign LED1 = 1'b0 ? 1'b1 : dec_cntr == 1'b1;
	assign LED2 = 1'b0 ? 1'b1 : dec_cntr == 1'b1;
	assign LED3 = 1'b0 ? 1'b1 : dec_cntr == 1'b1;
	assign LED4 = 1'b0 ? 1'b1 : dec_cntr == 1'b1;
	assign LED5 = 1'b0 ? 1'b1 : dec_cntr == 1'b1;
	assign LED6 = 1'b0 ? 1'b1 : dec_cntr == 1'b1;
	assign LED7 = 1'b0 ? 1'b1 : dec_cntr == 1'b1;
	assign LED8 = 1'b0 ? 1'b1 : dec_cntr == 1'b1;
				
endmodule
