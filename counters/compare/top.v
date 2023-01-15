module top (
	input		  	hwclk,
	output	  [LED-1:0]	led
);

parameter LED     = 8; 
parameter N	  = 24;

reg [N-1:0] counter  = 0;
reg [N-1:0] counter2 = 0;


reg[15:0] div_cntr1;
reg[6:0] div_cntr2;
reg dec_cntr;
reg half_sec_pulse;


		initial begin
		div_cntr1 = 0;
		div_cntr2 = 0;
		dec_cntr  = 0;
		led[LED-1:0] = 0;
		end
		
	
always@(posedge hwclk) begin
	div_cntr1 <= div_cntr1 + 1;
	if (div_cntr1 == 0) 
		if (div_cntr2 == 91) begin
			div_cntr2 <= 0;
			half_sec_pulse <= 1;  
		end
		else begin
			div_cntr2 <= div_cntr2 + 1;
		end
	else begin
		half_sec_pulse <= 0;
		
		if (half_sec_pulse == 1) begin	
			dec_cntr <= !dec_cntr;
			led[0] <= ~led[0];
		end
	end		
			
end


always @ (posedge hwclk) begin
	if (counter == 6000000) begin
		counter <= 0;
		led[LED-1] <= ~led[LED-1];
	end

	else
		counter <= counter + 1;
	
	
end

assign led[LED-2:LED-7] = '0;
//assign led[0] = 1'b0 ? 1'b1 : dec_cntr == 1'b1;
endmodule

