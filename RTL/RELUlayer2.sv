module RELUlayer2#(parameter WIDTH = 8
			  )
			 (
			  input signed [WIDTH-1:0] Data_in1,Data_in2,Data_in3,Data_in4,Data_in5,Data_in6,Data_in7,Data_in8,
			  output [WIDTH-1:0] Data_out1,Data_out2,Data_out3,Data_out4,Data_out5,Data_out6,Data_out7,Data_out8
			 );



RELU rel1(Data_in1,Data_out1);
RELU rel2(Data_in2,Data_out2);
RELU rel3(Data_in3,Data_out3);
RELU rel4(Data_in4,Data_out4);
RELU rel5(Data_in5,Data_out5);
RELU rel6(Data_in6,Data_out6);
RELU rel7(Data_in7,Data_out7);
RELU rel8(Data_in8,Data_out8);

endmodule