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
		//WRITE YOUR CODE HERE
		dataOutNext = 8'b10000001;
		counterNext = 0;
		flagNext=0;


	end
	else if(counter == COUNT -1) begin
		//WRITE YOUR CODE HERE
		counterNext=0;
		if(dataOut[0]==1)begin
			flagNext=1;
		end
		if(dataOut[3]==1)begin
			flagNext=0;
		end
		if(dataOut[7]==1)begin
			flagNext=0;
		end
		if(dataOut[4]==1)begin
			flagNext=1;
		end
		if(flagNext==0)begin
			dataOutNext [7:4]=dataOut[7:4]/2;
			dataOutNext [3:0]=dataOut[3:0]*2;
			counterNext=0;
		end
		else begin
			dataOutNext [7:4]=dataOut[7:4]*2;
			dataOutNext [3:0]=dataOut[3:0]/2;
			
			counterNext=0;
		end

	end
	else begin
		dataOutNext=dataOut;
		counterNext = counter +1;
	end
end

endmodule