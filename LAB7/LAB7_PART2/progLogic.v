module progLogic(clk, rst, switch, enter, addrWr, dataWr, wrEn);
input clk,rst,enter;
input [7:0] switch;
output reg [7:0] addrWr;
output reg [15:0] dataWr;
output reg wrEn;

reg enterPrev, wrEnNxt;
reg state, stateNxt;
reg [7:0] addrWrNxt;
reg [15:0] dataWrNxt;

assign posEnter = enter && !enterPrev;

always@(posedge clk) begin
	enterPrev <= #1 enter;
	state <= #1 stateNxt;
	dataWr <= #1 dataWrNxt;
	addrWr <= #1 addrWrNxt;
	wrEn <= #1 wrEnNxt;
end

always@* begin
	dataWrNxt = dataWr;
	stateNxt = state;
	addrWrNxt = addrWr;
	wrEnNxt = wrEn;
	if(rst) begin
		stateNxt = 0;
		addrWrNxt = 0; //INITIAL ADDRESS LOCATION
		wrEnNxt = 0;
	end
	else if(posEnter) begin
		stateNxt = state+1;
		case(state)
			0: dataWrNxt[15:8] = switch;
			1: begin
				dataWrNxt[7:0] = switch;
				wrEnNxt = 1;
			end
		endcase
	end
	else if(wrEn) begin
		addrWrNxt = addrWr +1;
		wrEnNxt = 0;
	end
end
endmodule
