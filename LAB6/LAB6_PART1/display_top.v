`timescale 1ns / 1ps

module display_top(clk, rst, dataIn, sevenSeg, anode);
input rst,clk;
input [7:0] dataIn;
output [7:0] sevenSeg;
output [3:0] anode;

SevenSegFourDig SevenSegFourDig1(.clk(clk), .rst(rst), .in({2'b00, dataIn[7:6], 2'b00, dataIn[5:4], 2'b00, dataIn[3:2], 2'b00, dataIn[1:0]}), 
.sevenSeg(sevenSeg), .anode(anode));

endmodule
