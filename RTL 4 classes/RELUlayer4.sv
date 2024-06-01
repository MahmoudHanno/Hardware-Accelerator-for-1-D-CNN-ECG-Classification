module RELUlayer4#(parameter WIDTH = 8
			  )
			 (
			  input signed [WIDTH-1:0] Data_in1,Data_in2,Data_in3,Data_in4,Data_in5,Data_in6,Data_in7,Data_in8,
			  Data_in9,Data_in10,Data_in11,Data_in12,Data_in13,Data_in14,Data_in15,Data_in16,
			  output [WIDTH-1:0] Data_out1,Data_out2,Data_out3,Data_out4,Data_out5,Data_out6,Data_out7,Data_out8,
			  Data_out9,Data_out10,Data_out11,Data_out12,Data_out13,Data_out14,Data_out15,Data_out16
			 );



RELU rel1(Data_in1,Data_out1);
RELU rel2(Data_in2,Data_out2);
RELU rel3(Data_in3,Data_out3);
RELU rel4(Data_in4,Data_out4);
RELU rel5(Data_in5,Data_out5);
RELU rel6(Data_in6,Data_out6);
RELU rel7(Data_in7,Data_out7);
RELU rel8(Data_in8,Data_out8);
RELU rel9(Data_in9,Data_out9);
RELU rel10(Data_in10,Data_out10);
RELU rel11(Data_in11,Data_out11);
RELU rel12(Data_in12,Data_out12);
RELU rel13(Data_in13,Data_out13);
RELU rel14(Data_in14,Data_out14);
RELU rel15(Data_in15,Data_out15);
RELU rel16(Data_in16,Data_out16);

endmodule