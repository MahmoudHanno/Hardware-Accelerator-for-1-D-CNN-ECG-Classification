module maxpoolinglayer3(rst,en,in1,in2,in3,in4,in5,in6,in7,in8,out1,out2,out3,out4,out5,out6,out7,out8);


input rst,en;

input [4:0] [7:0]  in1,in2,in3,in4,in5,in6,in7,in8;

output reg [7:0] out1,out2,out3,out4,out5,out6,out7,out8;

maxpooling unit1(rst,en,in1[0],in1[1],in1[2],in1[3],in1[4],out1); 
maxpooling unit2(rst,en,in2[0],in2[1],in2[2],in2[3],in2[4],out2); 
maxpooling unit3(rst,en,in3[0],in3[1],in3[2],in3[3],in3[4],out3); 
maxpooling unit4(rst,en,in4[0],in4[1],in4[2],in4[3],in4[4],out4); 
maxpooling unit5(rst,en,in5[0],in5[1],in5[2],in5[3],in5[4],out5); 
maxpooling unit6(rst,en,in6[0],in6[1],in6[2],in6[3],in6[4],out6); 
maxpooling unit7(rst,en,in7[0],in7[1],in7[2],in7[3],in7[4],out7); 
maxpooling unit8(rst,en,in8[0],in8[1],in8[2],in8[3],in8[4],out8); 
endmodule