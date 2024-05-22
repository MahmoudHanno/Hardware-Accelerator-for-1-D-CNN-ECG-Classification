module CNNtop(rst,clk,main_start,seg_final);
input rst,main_start,clk;
output [7:0] seg_final;

wire [7:0] seg;
reg [7:0] out41,out42,out43,out44,out45,out46,out47,out48,out49,out410,out411,out412,out413,out414,out415,out416;
reg done1,done2,done3,done4;
reg maxflag1,maxflag2,maxflag3,maxflag4;
reg start1,start2,start3,start4;

	reg [7:0] out11,out12,out13,out14;
	reg [7:0] out21,out22,out23,out24,out25,out26,out27,out28;
	reg [7:0] out31,out32,out33,out34,out35,out36,out37,out38;

    controlprocedure1 x1(rst,clk,start1,done1,out11,out12,out13,out14,maxflag1);
 controlprocedure2 x2(rst,clk,start2,done2,maxflag1,out11,out12,out13,out14,out21,out22,out23,out24,out25,out26,out27,out28,maxflag2);
 controlprocedure3 x3(rst,clk,start3,done3,maxflag2,out21,out22,out23,out24,out25,out26,out27,out28,out31,out32,out33,out34,out35,out36,out37,out38,maxflag3);
 controlprocedure4 x4(rst,clk,start4,done4,maxflag3,out31,out32,out33,out34,out35,out36,out37,out38,
	out41,out42,out43,out44,out45,out46,out47,out48,out49,out410,out411,out412,out413,out414,out415,out416,maxflag4);

    maincontrol x5(rst,main_start,clk,maxflag4,out41,out42,out43,out44,out45,out46,out47,out48,out49,out410,out411,out412,out413,out414,out415,out416,done1,done2,done3,done4,
    start1,start2,start3,start4,seg);

    assign seg_final=seg;

endmodule