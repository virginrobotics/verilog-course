// BCD Display - Common cathode
module top #(
	parameter	BCD_SIZE	= 8,
	parameter	PERIOD		= 3000000,
	parameter	SIZE		= 24
)	(
    /* I/O */
	input						hwclk,
	//input						rst_n = 1,	// TODO: Add rst button
	output	reg	[BCD_SIZE-1:0]	bcd_out	
	);
	reg	[SIZE-1:0]	counter	= 0;
	reg				clk1	= 0;
	reg				rst_n	= 1;
	// State declaration
	localparam [9:0]	
	ONE		= 10'b0000000001,
	TWO		= 10'b0000000010,
	THREE	= 10'b0000000100,
	FOUR	= 10'b0000001000,
	FIVE	= 10'b0000010000,
	SIX		= 10'b0000100000,
	SEVEN	= 10'b0001000000,
	EIGHT	= 10'b0010000000,
	NINE	= 10'b0100000000,
	ZERO	= 10'b1000000000;	

	reg	[9:0]	state, next_state;
	
	always @ (posedge clk1)	begin
		if	(!rst_n)	state	<=	ZER0;
		else		state	<=	next_state;
	end

	always @(*) begin	// State propogate logic
		case(state)
			ONE:	next_state = TWO;
			TWO:	next_state = THREE;
			THREE:	next_state = FOUR;
			FOUR: 	next_state = FIVE;
			FIVE:	next_state = SIX;
			SIX:	next_state = SEVEN;
			SEVEN:	next_state = EIGHT;
			EIGHT:	next_state = NINE;
			NINE:	next_state = ZERO;
			ZERO:	next_state = ONE;
			default:next_state = ZERO;
		endcase
	end

	always @(state)	begin	// Output decoder
		case(state)
			ONE:	bcd_out	= 7'd48;
			TWO:	bcd_out	= 7'd109;
			THREE:	bcd_out	= 7'd121;
			FOUR:	bcd_out	= 7'd51;
			FIVE:	bcd_out	= 7'd91;
			SIX:	bcd_out	= 7'd95;
			SEVEN:	bcd_out	= 7'd112;
			EIGHT:	bcd_out	= 7'd127;
			NINE:	bcd_out	= 7'd123;
			ZERO:	bcd_out	= 7'd126;
			default: bcd_out	= 7'd126; 
		endcase
	end
	// One Hertz clk generator 
	always  @ (posedge hwclk) begin
		if (counter == PERIOD) begin
			counter <= {SIZE{1'b0}};
			clk1	<= ~clk1;
		end
		counter <= counter + 1;
	end

	
endmodule
