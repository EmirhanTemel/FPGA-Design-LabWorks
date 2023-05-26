`timescale 1ns / 1ps
module display_top_tb;

parameter SCWIDTH = 1;


// Inputs
reg clk;
reg rst;
reg [7:0] dataIn;

// Outputs
wire [7:0] sevenSeg;
wire [3:0] anode;
integer error;
// Instantiate the Unit Under Test (UUT)
display_top #(SCWIDTH) uut(.clk(clk), .rst(rst), .dataIn(dataIn), .sevenSeg(sevenSeg), .anode(anode));

initial begin
	clk = 0;
	forever
		#5 clk = ~clk;
end

initial begin
	rst = 1;
	#73 rst = 0;
end

initial begin
	dataIn = 0;
	error = 0;
	#70;
	dataIn = 8'hFF;
	repeat(4)@(anode)begin
		if(sevenSeg != 8'b00001101)begin
		$display("error: expected %b, obtained %b", 8'b00001100, sevenSeg);
		error = error + 1; end
	end
	dataIn = 8'h87;
	@(anode)begin
		if(sevenSeg != 8'b00100101)begin
		$display("error: expected %b, obtained %b", 8'b00100100, sevenSeg);
		error = error + 1; end
	end
	@(anode)begin
		if(sevenSeg != 8'b00000011)begin
		$display("error: expected %b, obtained %b", 8'b00000010, sevenSeg);
		error = error + 1; end
	end
	@(anode)begin
		if(sevenSeg != 8'b10011111)begin
		$display("error: expected %b, obtained %b", 8'b10011110, sevenSeg);
		error = error + 1; end
	end
	@(anode)begin
		if(sevenSeg != 8'b00001101)begin
		$display("error: expected %b, obtained %b", 8'b00001100, sevenSeg);
		error = error + 1; end
	end
	dataIn = 8'hAB;
	repeat(3)@(anode)begin
		if(sevenSeg != 8'b00100101)begin
		$display("error: expected %b, obtained %b", 8'b00100100, sevenSeg);
		error = error + 1; end
	end
	@(anode)begin
		if(sevenSeg != 8'b00001101)begin
		$display("error: expected %b, obtained %b", 8'b00001100, sevenSeg);
		error = error + 1; end
	end
	dataIn = 8'h32;
		@(anode)begin
		if(sevenSeg != 8'b00000011)begin
		$display("error: expected %b, obtained %b", 8'b00000010, sevenSeg);
		error = error + 1; end
	end
	@(anode)begin
		if(sevenSeg != 8'b00001101)begin
		$display("error: expected %b, obtained %b", 8'b00001100, sevenSeg);
		error = error + 1; end
	end
	@(anode)begin
		if(sevenSeg != 8'b00000011)begin
		$display("error: expected %b, obtained %b", 8'b00000010, sevenSeg);
		error = error + 1; end
	end
	@(anode)begin
		if(sevenSeg != 8'b00100101)begin
		$display("error: expected %b, obtained %b", 8'b00100100, sevenSeg);
		error = error + 1; end
	end

	if(error > 0)
		$display("you have %d erros", error);
	else
		$display("congrats you got no error");
	$finish;
end
      
endmodule

