module knightRider(clk, rst, dataOut);

input clk, rst;
output reg [7:0] dataOut;

reg [25:0] counter, counterNext;
reg [ 7:0] dataOutNext;
reg  flag,flagNext;

parameter COUNT = 26'h3FFFFFF;

// registers
always @(posedge clk) begin
	counter <=  counterNext;
	dataOut <=  dataOutNext;
	flag <=  flagNext;
end

always @(*) begin
	dataOutNext = dataOut;
	counterNext = counter;
	flagNext = flag;
	if(rst) begin
		//WRITE YOUR CODE HERE (3 Lines)
		
		
		
	end
	else if(counter == COUNT -1) begin
		//WRITE YOUR CODE HERE (as many lines as necessary)
		
		
		
	end
	else begin
		counterNext = counter +1;
	end
end

endmodule

