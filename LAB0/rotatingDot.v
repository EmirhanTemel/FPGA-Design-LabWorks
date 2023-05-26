module rotatingDot(clk, rst, dataOut);

input clk, rst;
output reg [7:0] dataOut;

reg [25:0] counter, counterNext;
reg [ 7:0] dataOutNext;

parameter COUNT = 26'h3FFFFFF;


always @(posedge clk) begin
	counter <= #1 counterNext;
	dataOut <= #1 dataOutNext;
end

always @(*) begin
	if(rst) begin
		dataOutNext = 8'b10000000; 
		counterNext = 0;
	end
	else if(counter == COUNT -1) begin
		dataOutNext = dataOut / 2;
		counterNext = 0;
	end
	else begin
		dataOutNext = dataOut;
		counterNext = counter + 1;
	end
end

endmodule
