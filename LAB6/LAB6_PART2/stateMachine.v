`timescale 1ns / 1ps

module stateMachine(clk, rst, en, state);

input clk, rst, en;
output reg [2:0] state;

reg [2:0] stateNext;

always @(posedge clk) begin
	state <= #1 stateNext;
end

always @(*) begin
	stateNext = state;
	if(rst) stateNext = 6;
	else if(en) begin
		stateNext = state+1;
		if(state>5) stateNext = 0;
	end
end

endmodule
