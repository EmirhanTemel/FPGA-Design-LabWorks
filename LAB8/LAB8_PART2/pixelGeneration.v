`timescale 1ns / 1ps

module pixelGeneration(clk, rst, push, pixel_x, pixel_y, video_on, rgb);
input clk,rst;
input [3:0] push;
input [9:0] pixel_x, pixel_y;
input video_on;
output reg [2:0] rgb;

wire square_on;
wire [3:0] pushPos;
reg [9:0] x_loc, x_locN, y_loc, y_locN;
reg upP, downP, leftP, rightP;

always @(posedge clk) begin
	x_loc <= #1 x_locN;
	y_loc <= #1 y_locN;
	upP <= #1 push[2];
	downP <= #1 push[3];
	leftP <= #1 push[1];
	rightP <= #1 push[0];
end

assign pushPos[0]= push[0] && !rightP;
assign pushPos[1]
= push[1] && !leftP;
assign pushPos[2]= push[2] && !upP;
assign pushPos[3]= push[3] && !downP;

always @(*) begin
	x_locN = x_loc;
	y_locN = y_loc;

	if(rst) begin
		x_locN = 320;
		y_locN = 220;
	end

	if(video_on) begin
		rgb = 3'b000;
		case(pushPos)
			1: begin //RIGHT
					x_locN = x_loc+10;
			end	
			2: begin //LEFT
					x_locN = x_loc-10;
			end
			4: begin //UP
					y_locN = y_loc+10;
			end
			8:	begin // DOWN
					y_locN = y_loc-10;
			end
		endcase
	end

	if(square_on)
		rgb = 3'b110;
	else
		rgb = 3'b000;
end

assign square_on = ((pixel_x > x_loc && pixel_x < x_loc+40) && (pixel_y > y_loc && pixel_y < y_loc+40));

endmodule
