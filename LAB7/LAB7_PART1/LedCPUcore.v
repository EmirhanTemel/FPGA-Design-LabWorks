`timescale 1ns / 1ps
module LedCPUcore(clk, rst, addrRd, dataRd, outPattern);
input clk, rst;
input [15:0] dataRd;
output reg [7:0] addrRd;
output reg [7:0] outPattern;

reg [7:0] addrRdNxt, outPatternNxt;
reg [25:0] counter, counterNext;
reg state, stateNxt;

parameter FREQ = 0;

always@(posedge clk) begin
	counter <= #1 counterNext;
	addrRd <= #1 addrRdNxt;
	outPattern <= #1 outPatternNxt;
	state <= #1 stateNxt;
end

always@* begin
	counterNext = counter;
	outPatternNxt = outPattern;
	addrRdNxt = addrRd;
	stateNxt = state;
	
	if (rst)
		stateNxt = 0;
	else if (dataRd[7:0] == 0) // JUMP
		addrRdNxt = dataRd[15:8];
	else if (dataRd[7:0] == 8'b00001000)
		stateNxt = 1;
			
	if (counter == (FREQ * dataRd[7:0])-1) begin
		counterNext = 0;
		case(state)
			0: addrRdNxt = 0;
			1:	begin
				addrRdNxt = addrRd +1;
				outPatternNxt = dataRd[15:8];
			end
		endcase
	end
	else
		counterNext = counter +1;
		
end
endmodule
