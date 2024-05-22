module convlayer2(rst,en,in1,in2,in3,in4,outfin1,outfin2,outfin3,outfin4,outfin5,outfin6,outfin7,outfin8);


input rst,en;
reg signed [4:0] [7:0] filter11,filter12,filter13,filter14;
reg signed [4:0] [7:0] filter21,filter22,filter23,filter24;
reg signed [4:0] [7:0] filter31,filter32,filter33,filter34;
reg signed [4:0] [7:0] filter41,filter42,filter43,filter44;
reg signed [4:0] [7:0] filter51,filter52,filter53,filter54;
reg signed [4:0] [7:0] filter61,filter62,filter63,filter64;
reg signed [4:0] [7:0] filter71,filter72,filter73,filter74;
reg signed [4:0] [7:0] filter81,filter82,filter83,filter84;
input signed [4:0] [7:0] in1,in2,in3,in4;
wire signed [18:0] quant11,quant12,quant13,quant14,quant15,quant16,quant17,quant18,
quant21,quant22,quant23,quant24,quant25,quant26,quant27,quant28,
quant31,quant32,quant33,quant34,quant35,quant36,quant37,quant38,
quant41,quant42,quant43,quant44,quant45,quant46,quant47,quant48;

reg signed [20:0] out1,out2,out3,out4,out5,out6,out7,out8;
reg signed [20:0] out_cu1,out_cu2,out_cu3,out_cu4,out_cu5,out_cu6,out_cu7,out_cu8;
output reg signed [7:0] outfin1,outfin2,outfin3,outfin4,outfin5,outfin6,outfin7,outfin8;


conv cu1(rst,en,in1[0],in1[1],in1[2],in1[3],in1[4],filter11[0],filter11[1],filter11[2],filter11[3],filter11[4],quant11);
conv cu2(rst,en,in1[0],in1[1],in1[2],in1[3],in1[4],filter21[0],filter21[1],filter21[2],filter21[3],filter21[4],quant12);
conv cu3(rst,en,in1[0],in1[1],in1[2],in1[3],in1[4],filter31[0],filter31[1],filter31[2],filter31[3],filter31[4],quant13);
conv cu4(rst,en,in1[0],in1[1],in1[2],in1[3],in1[4],filter41[0],filter41[1],filter41[2],filter41[3],filter41[4],quant14);
conv cu5(rst,en,in1[0],in1[1],in1[2],in1[3],in1[4],filter51[0],filter51[1],filter51[2],filter51[3],filter51[4],quant15);
conv cu6(rst,en,in1[0],in1[1],in1[2],in1[3],in1[4],filter61[0],filter61[1],filter61[2],filter61[3],filter61[4],quant16);
conv cu7(rst,en,in1[0],in1[1],in1[2],in1[3],in1[4],filter71[0],filter71[1],filter71[2],filter71[3],filter71[4],quant17);
conv cu8(rst,en,in1[0],in1[1],in1[2],in1[3],in1[4],filter81[0],filter81[1],filter81[2],filter81[3],filter81[4],quant18);

conv cu9(rst,en,in2[0],in2[1],in2[2],in2[3],in2[4],filter12[0],filter12[1],filter12[2],filter12[3],filter12[4],quant21);
conv cu10(rst,en,in2[0],in2[1],in2[2],in2[3],in2[4],filter22[0],filter22[1],filter22[2],filter22[3],filter22[4],quant22);
conv cu11(rst,en,in2[0],in2[1],in2[2],in2[3],in2[4],filter32[0],filter32[1],filter32[2],filter32[3],filter32[4],quant23);
conv cu12(rst,en,in2[0],in2[1],in2[2],in2[3],in2[4],filter42[0],filter42[1],filter42[2],filter42[3],filter42[4],quant24);
conv cu13(rst,en,in2[0],in2[1],in2[2],in2[3],in2[4],filter52[0],filter52[1],filter52[2],filter52[3],filter52[4],quant25);
conv cu14(rst,en,in2[0],in2[1],in2[2],in2[3],in2[4],filter62[0],filter62[1],filter62[2],filter62[3],filter62[4],quant26);
conv cu15(rst,en,in2[0],in2[1],in2[2],in2[3],in2[4],filter72[0],filter72[1],filter72[2],filter72[3],filter72[4],quant27);
conv cu16(rst,en,in2[0],in2[1],in2[2],in2[3],in2[4],filter82[0],filter82[1],filter82[2],filter82[3],filter82[4],quant28);

conv cu17(rst,en,in3[0],in3[1],in3[2],in3[3],in3[4],filter13[0],filter13[1],filter13[2],filter13[3],filter13[4],quant31);
conv cu18(rst,en,in3[0],in3[1],in3[2],in3[3],in3[4],filter23[0],filter23[1],filter23[2],filter23[3],filter23[4],quant32);
conv cu19(rst,en,in3[0],in3[1],in3[2],in3[3],in3[4],filter33[0],filter33[1],filter33[2],filter33[3],filter33[4],quant33);
conv cu20(rst,en,in3[0],in3[1],in3[2],in3[3],in3[4],filter43[0],filter43[1],filter43[2],filter43[3],filter43[4],quant34);
conv cu21(rst,en,in3[0],in3[1],in3[2],in3[3],in3[4],filter53[0],filter53[1],filter53[2],filter53[3],filter53[4],quant35);
conv cu22(rst,en,in3[0],in3[1],in3[2],in3[3],in3[4],filter63[0],filter63[1],filter63[2],filter63[3],filter63[4],quant36);
conv cu23(rst,en,in3[0],in3[1],in3[2],in3[3],in3[4],filter73[0],filter73[1],filter73[2],filter73[3],filter73[4],quant37);
conv cu24(rst,en,in3[0],in3[1],in3[2],in3[3],in3[4],filter83[0],filter83[1],filter83[2],filter83[3],filter83[4],quant38);

conv cu25(rst,en,in4[0],in4[1],in4[2],in4[3],in4[4],filter14[0],filter14[1],filter14[2],filter14[3],filter14[4],quant41);
conv cu26(rst,en,in4[0],in4[1],in4[2],in4[3],in4[4],filter24[0],filter24[1],filter24[2],filter24[3],filter24[4],quant42);
conv cu27(rst,en,in4[0],in4[1],in4[2],in4[3],in4[4],filter34[0],filter34[1],filter34[2],filter34[3],filter34[4],quant43);
conv cu28(rst,en,in4[0],in4[1],in4[2],in4[3],in4[4],filter44[0],filter44[1],filter44[2],filter44[3],filter44[4],quant44);
conv cu29(rst,en,in4[0],in4[1],in4[2],in4[3],in4[4],filter54[0],filter54[1],filter54[2],filter54[3],filter54[4],quant45);
conv cu30(rst,en,in4[0],in4[1],in4[2],in4[3],in4[4],filter64[0],filter64[1],filter64[2],filter64[3],filter64[4],quant46);
conv cu31(rst,en,in4[0],in4[1],in4[2],in4[3],in4[4],filter74[0],filter74[1],filter74[2],filter74[3],filter74[4],quant47);
conv cu32(rst,en,in4[0],in4[1],in4[2],in4[3],in4[4],filter84[0],filter84[1],filter84[2],filter84[3],filter84[4],quant48);
initial begin
	// Initialize filter values using concatenation from the first CSV file (layer2_0_quant)
	filter11 = '{-57, 25, -82, 0, -29};
	filter21 = '{127, 8, 57, 103, 5};
	filter31 = '{95, -13, -85, -43, -67};
	filter41 = '{-100, 43, 57, -101, 77};
	filter51 = '{-93, 40, 27, 2, -21};
	filter61 = '{-13, 17, -113, -75, -1};
	filter71 = '{-103, 40, 87, -23, 7};
	filter81 = '{49, 114, 68, -56, 88};

	// Initialize filter values using concatenation from the second CSV file (layer2_1_quant)
	filter12 = '{-76, -67, 44, -70, 41};
	filter22 = '{-91, 43, 102, 25, 13};
	filter32 = '{127, 50, 23, -20, -92};
	filter42 = '{78, -73, 109, 60, -73};
	filter52 = '{-68, -99, 57, -72, -61};
	filter62 = '{38, 35, 39, 95, 50};
	filter72 = '{-28, 97, 26, 107, -49};
	filter82 = '{11, 58, 1, 19, 41};

	// Initialize filter values using concatenation from the third CSV file (layer2_2_quant)
	filter13 = '{65, 58, -43, 104, 41};
	filter23 = '{-36, -27, 77, 97, -25};
	filter33 = '{-114, -52, 30, 102, 75};
	filter43 = '{97, 113, 60, -31, -77};
	filter53 = '{-49, -51, -81, -92, -79};
	filter63 = '{-40, -35, -31, 43, -18};
	filter73 = '{-127, -12, -92, -55, 86};
	filter83 = '{-5, 67, -62, 81, 33};

	// Initialize filter values using concatenation from the fourth CSV file (layer2_3_quant)
	filter14 = '{-53, 111, -69, -32, -93};
	filter24 = '{27, 84, -4, -65, 85};
	filter34 = '{23, -2, 89, -24, -110};
	filter44 = '{-87, 32, -78, -21, 33};
	filter54 = '{-93, -73, -26, -81, -11};
	filter64 = '{-83, -35, -99, 7, -94};
	filter74 = '{-99, 77, 56, -78, -74};
	filter84 = '{5, 55, 127, -22, -82};
end

always@(*) begin
	out1=(quant11+quant21+quant31+quant41-77);
	out2=(quant12+quant22+quant32+quant42-127);
	out3=(quant13+quant23+quant33+quant43-75);
	out4=(quant14+quant24+quant34+quant44+49);
	out5=(quant15+quant25+quant35+quant45);
	out6=(quant16+quant26+quant36+quant46+120);
	out7=(quant17+quant27+quant37+quant47-67);
	out8=(quant18+quant28+quant38+quant48-127);
end
always@(*) begin
	out_cu1=out1>>>9;
	out_cu2=out2>>>9;
	out_cu3=out3>>>9;
	out_cu4=out4>>>9;
	out_cu5=out5>>>9;
	out_cu6=out6>>>9;
	out_cu7=out7>>>9;
	out_cu8=out8>>>9;

end

always@(*)
begin
	if (out_cu1[20] == 1'b1 && out_cu1 < 20'b111_1111_1111_1000_0001)
		outfin1 <= 8'b1000_0001;
	else if (out_cu1[20] == 1'b0 && out_cu1 > 21'b000_0000_0000_0111_1111)
		outfin1 <= 8'b0111_1111;
	else
		outfin1 <= out_cu1[7:0];

	if (out_cu2[20] == 1'b1 && out_cu2 < 21'b111_1111_1111_1000_0001)
		outfin2 <= 8'b1000_0001;
	else if (out_cu2[20] == 1'b0 && out_cu2 > 21'b000_0000_0000_0111_1111)
		outfin2 <= 8'b0111_1111;
	else
		outfin2 <= out_cu2[7:0];

	if (out_cu3[20] == 1'b1 && out_cu3 < 21'b111_1111_1111_1000_0001)
		outfin3 <= 8'b1000_0001;
	else if (out_cu3[20] == 1'b0 && out_cu3 > 21'b000_0000_0000_0111_1111)
		outfin3 <= 8'b0111_1111;
	else
		outfin3 <= out_cu3[7:0];

	if (out_cu4[20] == 1'b1 && out_cu4 < 21'b111_1111_1111_1000_0001)
		outfin4 <= 8'b1000_0001;
	else if (out_cu4[20] == 1'b0 && out_cu4 > 21'b000_0000_0000_0111_1111)
		outfin4 <= 8'b0111_1111;
	else
		outfin4 <= out_cu4[7:0];
	
	if (out_cu5[20] == 1'b1 && out_cu5 < 21'b111_1111_1111_1000_0001)
		outfin5 <= 8'b1000_0001;
	else if (out_cu5[20] == 1'b0 && out_cu5 > 21'b000_0000_0000_0111_1111)
		outfin5 <= 8'b0111_1111;
	else
		outfin5 <= out_cu5[7:0];

	if (out_cu6[20] == 1'b1 && out_cu6 < 21'b111_1111_1111_1000_0001)
		outfin6 <= 8'b1000_0001;
	else if (out_cu6[20] == 1'b0 && out_cu6 > 21'b000_0000_0000_0111_1111)
		outfin6 <= 8'b0111_1111;
	else
		outfin6 <= out_cu6[7:0];

	if (out_cu7[20] == 1'b1 && out_cu7 < 21'b111_1111_1111_1000_0001)
		outfin7 <= 8'b1000_0001;
	else if (out_cu7[20] == 1'b0 && out_cu7 > 21'b000_0000_0000_0111_1111)
		outfin7 <= 8'b0111_1111;
	else
		outfin7 <= out_cu7[7:0];

	if (out_cu8[20] == 1'b1 && out_cu8 < 21'b111_1111_1111_1000_0001)
		outfin8 <= 8'b1000_0001;
	else if (out_cu8[20] == 1'b0 && out_cu8 > 21'b000_0000_0000_0111_1111)
		outfin8 <= 8'b0111_1111;
	else
		outfin8 <= out_cu8[7:0];
end

endmodule