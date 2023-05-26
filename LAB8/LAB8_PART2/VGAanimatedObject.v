`timescale 1ns / 1ps

module VGAanimatedObject(clk, rst, push, rgb, hsync, vsync);
input clk,rst;
input [3:0] push;
output [2:0] rgb;
output hsync, vsync;

wire [9:0] pixel_x, pixel_y;
wire video_on;

pixelGeneration pixelGeneration_1(.clk(clk), .rst(rst), .push(push), .pixel_x(pixel_x), .pixel_y(pixel_y), .video_on(video_on), .rgb(rgb));
vgaSync vgaSync_1(.clk(clk), .rst(rst), .hsync(hsync), .vsync(vsync), .video_on(video_on), .p_tick(), .pixel_x(pixel_x), .pixel_y(pixel_y));

endmodule
