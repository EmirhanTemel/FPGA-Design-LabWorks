`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:04:03 10/26/2022 
// Design Name: 
// Module Name:    oneDigitUpDown 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module oneDigitUpDown(clk, rst, upDown, anode, sevenSegment);

input clk, rst, upDown;
output reg [7:0] sevenSegment;
output reg [3:0] anode;

reg [25:0] counter, counterNext;
reg [3:0] anodeNext;
reg [7:0] sevenSegmentNext;
reg [3:0] flag,flagNext;


parameter COUNT = 26'h1FFFFFF;

always @(posedge clk) begin
	counter <= #1 counterNext;
	anode <= #1 anodeNext;
	sevenSegment <= #1 sevenSegmentNext;
	flag <= #1 flagNext;
end

always @(*) begin
	sevenSegmentNext = sevenSegment;
	counterNext = counter;
	anodeNext = anode;
	flagNext = flag;
	
	if(rst) begin
			sevenSegmentNext = 8'b00000011;
			anodeNext = 4'b0111;
			counterNext = 0;
			flagNext = 0;
	end else if(counter == COUNT -1) begin
			counterNext = 0;
			case(flag)
				0: sevenSegmentNext = 8'b00000011;
				1: sevenSegmentNext = 8'b10011111;
				2: sevenSegmentNext = 8'b00100101;
				3: sevenSegmentNext = 8'b00001101;
				4: sevenSegmentNext = 8'b10011001;
				5: sevenSegmentNext = 8'b01001001;
				6: sevenSegmentNext = 8'b01000001;
				7: sevenSegmentNext = 8'b00011111;
				8: sevenSegmentNext = 8'b00000001;
				9: sevenSegmentNext = 8'b00001001;
			endcase
			if(upDown) begin
				flagNext = flag +1;
				if (flag == 9) begin
					flagNext = 0;
				end			
			end else begin
				flagNext = flag -1;
				
				if (flag == 0) begin
					flagNext = 9;
				end
				
			end
	end
	
	else begin
		counterNext = counter +1;
	end
end		
endmodule
