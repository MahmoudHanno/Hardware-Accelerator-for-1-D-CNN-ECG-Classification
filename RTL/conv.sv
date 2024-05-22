module conv(rst,en,conv1,conv2,conv3,conv4,conv5,weight1,weight2,weight3,weight4,weight5,out);

input rst,en;
input signed [7:0] conv1,conv2,conv3,conv4,conv5;
input signed [7:0] weight1,weight2,weight3,weight4,weight5;
output signed [18:0] out;
reg signed [15:0]internal1,internal2,internal3,internal4,internal5;
reg signed [16:0]sum1,sum2;
reg signed [17:0]sum3;
reg signed [18:0]sum4; 

always @(*) begin
	if(rst==1) begin
	internal1=0;
	internal2=0;
	internal3=0;
	internal4=0;
	internal5=0;
end else begin
	if(en) begin
	internal1=conv1*weight1;
	internal2=conv2*weight2;
	internal3=conv3*weight3;
	internal4=conv4*weight4;
	internal5=conv5*weight5;
	end else begin
	internal1=0;
	internal2=0;
	internal3=0;
	internal4=0;
	internal5=0;
	end
end
end
always@(*)begin
	if(rst) begin
	sum1 = 0;
	sum2 = 0;
	sum3 = 0;
	sum4 = 0;
end
	else begin
	sum1 = internal1+internal2;
	sum2 = internal3+internal4;
	sum3 = sum1+sum2;
	sum4 = sum3 + internal5;
end
end

	assign out = sum4;

endmodule


