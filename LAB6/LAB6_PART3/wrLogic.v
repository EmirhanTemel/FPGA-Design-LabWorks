`timescale 1ns / 1ps
module wrLogic(clk, rst, enter, sw, seg0wr, seg1wr, seg2wr, seg3wr, datatoLed);
input clk, rst, enter;
input [3:0] sw;
output reg [4:0] seg0wr, seg1wr, seg2wr, seg3wr;
output reg [3:0] datatoLed;

reg [1:0] state, stateNext;
reg [4:0] seg0wrNext, seg1wrNext, seg2wrNext, seg3wrNext;
reg enter_r;
reg [3:0] datatoLedNext;
reg [3:0] temp0, temp1, temp2, temp0Nxt, temp1Nxt, temp2Nxt;

always@(posedge clk)begin
	state <= #1 stateNext;
	enter_r <= #1 enter;
	seg0wr <= #1 seg0wrNext;
	seg1wr <= #1 seg1wrNext;
	seg2wr <= #1 seg2wrNext;
	seg3wr <= #1 seg3wrNext;
	datatoLed <= #1 datatoLedNext;
	temp0 <= #1 temp0Nxt;
	temp1 <= #1 temp1Nxt;
	temp2 <= #1 temp2Nxt;
end

assign posEnter = enter && !enter_r;

always@(*) begin
	datatoLedNext = datatoLed;
	stateNext = state;
	seg0wrNext = seg0wr;
	seg1wrNext = seg1wr;
	seg2wrNext = seg2wr;
	seg3wrNext = seg3wr;
	temp0Nxt = temp0;
	temp1Nxt = temp1;
	temp2Nxt = temp2;
	
	if(rst) stateNext = 0;
		
	else if(posEnter)begin
		stateNext = state+1;
		datatoLedNext = sw;
		case(state)
			0: temp0Nxt = sw;
			1:	temp1Nxt = sw;
			2: temp2Nxt = sw;
			3:	begin
				seg0wrNext[3:0] = temp0Nxt;
				seg1wrNext[3:0] = temp1Nxt;
				seg2wrNext[3:0] = temp2Nxt;
				seg3wrNext[3:0] = sw;
			end
		endcase	 
	end	
end

endmodule
