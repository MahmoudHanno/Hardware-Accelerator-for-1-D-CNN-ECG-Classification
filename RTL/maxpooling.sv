module maxpooling(rst,en,in1,in2,in3,in4,in5,out); 


input rst,en;

input [7:0] in1,in2,in3,in4,in5;

output reg [7:0] out;


always@(*) begin
	
if(rst) begin
	out=0;
end
else begin 

	if(en) begin
	
	if(in1 >= in2 && in1 >= in3 && in1 >= in4 && in1 >= in5) begin
		out=in1;
	end
	else if( in2>=in3 && in2 >= in4 && in2 >= in5 ) begin
		out= in2;
	end
	else if( in3>=in4 && in3 >= in5 ) begin
		out= in3;
	end
	else if( in4>=in5) begin
		out= in4;
	end
	else 
		out=in5;

end
else 
out=0;
end

end

endmodule