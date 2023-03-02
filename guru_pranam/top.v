// Guru Pranam - Common cathode
module top #(
	parameter	BCD_SIZE	= 8,
	parameter	PERIOD		= 3000000,
	parameter	SIZE		= 24
)	(
    /* I/O */
	input						hwclk,
	//input						rst_n = 1,
	output	reg	[BCD_SIZE-1:0]	bcd_out	
	);
	reg	[SIZE-1:0]	counter	= 0;
	reg				clk1	= 0;
	reg				rst_n	= 1;
	// State declaration
	localparam [9:0]	
	S		= 10'b0000000001,
	U		= 10'b0000000010,
	D		= 10'b0000000100,
	I		= 10'b0000001000,
	P		= 10'b0000010000,
	T		= 10'b0000100000,
	ZERO	= 10'b1000000000;	

	reg	[9:0]	state, next_state;
	
	always @ (posedge clk1)	begin
		if	(!rst_n)	state	<=	ZER0;
		else		state	<=	next_state;
	end

	always @(*) begin	// State propogate logic
		case(state)
			S:	next_state = U;
			U:	next_state = D;
			D:	next_state = I;
			I: 	next_state = P;
			P:	next_state = T;
			T:	next_state = ZERO;
			ZERO:	next_state = S;
			default:next_state = ZERO;
		endcase
	end

	always @(state)	begin	// Output decoder
		case(state)
			S:	bcd_out	= 7'd91;
			U:	bcd_out	= 7'd62;
			D:	bcd_out	= 7'd61;
			I:	bcd_out	= 7'd48;
			P:	bcd_out	= 7'd103;
			T:	bcd_out	= 7'd15;
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
