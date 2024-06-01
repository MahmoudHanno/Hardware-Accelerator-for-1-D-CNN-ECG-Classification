module maxpoolinglayer4(rst,en,in1,in2,in3,in4,in5,in6,in7,in8,
	in9,in10,in11,in12,in13,in14,in15,in16,
	out1,out2,out3,out4,out5,out6,out7,out8,
	out9,out10,out11,out12,out13,out14,out15,out16
	);


input rst,en;

input [4:0] [7:0]  in1,in2,in3,in4,in5,in6,in7,in8,
in9,in10,in11,in12,in13,in14,in15,in16;

output reg [7:0] out1,out2,out3,out4,out5,out6,out7,out8,
out9,out10,out11,out12,out13,out14,out15,out16;

maxpooling unit1(rst,en,in1[0],in1[1],in1[2],in1[3],in1[4],out1); 
maxpooling unit2(rst,en,in2[0],in2[1],in2[2],in2[3],in2[4],out2); 
maxpooling unit3(rst,en,in3[0],in3[1],in3[2],in3[3],in3[4],out3); 
maxpooling unit4(rst,en,in4[0],in4[1],in4[2],in4[3],in4[4],out4); 
maxpooling unit5(rst,en,in5[0],in5[1],in5[2],in5[3],in5[4],out5); 
maxpooling unit6(rst,en,in6[0],in6[1],in6[2],in6[3],in6[4],out6); 
maxpooling unit7(rst,en,in7[0],in7[1],in7[2],in7[3],in7[4],out7); 
maxpooling unit8(rst,en,in8[0],in8[1],in8[2],in8[3],in8[4],out8); 

maxpooling unit9(rst,en,in9[0],in9[1],in9[2],in9[3],in9[4],out9); 
maxpooling unit10(rst,en,in10[0],in10[1],in10[2],in10[3],in10[4],out10); 
maxpooling unit11(rst,en,in11[0],in11[1],in11[2],in11[3],in11[4],out11); 
maxpooling unit12(rst,en,in12[0],in12[1],in12[2],in12[3],in12[4],out12); 
maxpooling unit13(rst,en,in13[0],in13[1],in13[2],in13[3],in13[4],out13); 
maxpooling unit14(rst,en,in14[0],in14[1],in14[2],in14[3],in14[4],out14); 
maxpooling unit15(rst,en,in15[0],in15[1],in15[2],in15[3],in15[4],out15); 
maxpooling unit16(rst,en,in16[0],in16[1],in16[2],in16[3],in16[4],out16); 

endmodule