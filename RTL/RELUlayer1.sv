module RELUlayer1#(parameter WIDTH = 8
			  )
			 (
			  input signed [WIDTH-1:0] Data_in1,Data_in2,Data_in3,Data_in4,
			  output [WIDTH-1:0] Data_out1,Data_out2,Data_out3,Data_out4
			 );



RELU rel1(Data_in1,Data_out1);
RELU rel2(Data_in2,Data_out2);
RELU rel3(Data_in3,Data_out3);
RELU rel4(Data_in4,Data_out4);

endmodule