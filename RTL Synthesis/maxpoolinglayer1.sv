module maxpoolinglayer1(rst,en,in1,in2,in3,in4,out1,out2,out3,out4);


input rst,en;

input [4:0] [7:0]  in1,in2,in3,in4;

output reg [7:0] out1,out2,out3,out4;

maxpooling unit1(rst,en,in1[0],in1[1],in1[2],in1[3],in1[4],out1); 
maxpooling unit2(rst,en,in2[0],in2[1],in2[2],in2[3],in2[4],out2); 
maxpooling unit3(rst,en,in3[0],in3[1],in3[2],in3[3],in3[4],out3); 
maxpooling unit4(rst,en,in4[0],in4[1],in4[2],in4[3],in4[4],out4); 
endmodule