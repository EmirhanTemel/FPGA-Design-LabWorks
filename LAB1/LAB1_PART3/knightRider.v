module knightRider(clk, rst, dataOut);

input clk, rst;
output reg [7:0] dataOut;

reg [25:0] counter, counterNext;
reg [ 7:0] dataOutNext;
reg  [1:0] flag,flagNext;

parameter COUNT = 26'h1FFFFFF;

// registers
always @(posedge clk) begin
	counter <= #1 counterNext;
	dataOut <= #1 dataOutNext;
	flag <= #1 flagNext;
end

always @(*) begin
	dataOutNext = dataOut;
	counterNext = counter;
	flagNext = flag;
	
	if(rst) begin
		//WRITE YOUR CODE HERE (3 Lines)
		dataOutNext = 8'b10000000;
		counterNext = 0;
		flagNext = 0;
	end
	
	else if(counter == COUNT -1) begin
		//WRITE YOUR CODE HERE (as many lines as necessary)
		counterNext = 0;
		case(flag)
			0: begin
				dataOutNext = dataOut/2;
				if (dataOut[1]) begin
					flagNext=1;
				end
			end
			1: begin
				dataOutNext = dataOut*4;
				if (dataOut[4]) begin
					flagNext=2;
				end
			end
			2: begin
				dataOutNext = dataOut/4;
				if (dataOut[2]) begin
					flagNext=3;
				end
			end
			3: begin
				dataOutNext = dataOut*2;
				if (dataOut[6]) begin
					flagNext=0;
				end
			end
		endcase
		
	end
	else begin
		dataOutNext = dataOut;
		counterNext = counter +1;
	end
end

endmodule

