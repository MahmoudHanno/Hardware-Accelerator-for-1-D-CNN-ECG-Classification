module convlayer4(rst,en,in1,in2,in3,in4,in5,in6,in7,in8,
outfin1,outfin2,outfin3,outfin4,outfin5,outfin6,outfin7,outfin8,outfin9,outfin10,outfin11,outfin12,outfin13,outfin14,outfin15,outfin16);

input rst,en;
reg signed [4:0] [7:0] filter11,filter12,filter13,filter14,filter15,filter16,filter17,filter18,
						 filter21,filter22,filter23,filter24,filter25,filter26,filter27,filter28,
                         filter31,filter32,filter33,filter34,filter35,filter36,filter37,filter38,
                         filter41,filter42,filter43,filter44,filter45,filter46,filter47,filter48,
                         filter51,filter52,filter53,filter54,filter55,filter56,filter57,filter58,
                         filter61,filter62,filter63,filter64,filter65,filter66,filter67,filter68,
                         filter71,filter72,filter73,filter74,filter75,filter76,filter77,filter78,
                         filter81,filter82,filter83,filter84,filter85,filter86,filter87,filter88,
                         filter91,filter92,filter93,filter94,filter95,filter96,filter97,filter98,
                         filter101,filter102,filter103,filter104,filter105,filter106,filter107,filter108,
                         filter111,filter112,filter113,filter114,filter115,filter116,filter117,filter118,
                         filter121,filter122,filter123,filter124,filter125,filter126,filter127,filter128,
                         filter131,filter132,filter133,filter134,filter135,filter136,filter137,filter138,
                         filter141,filter142,filter143,filter144,filter145,filter146,filter147,filter148,
                         filter151,filter152,filter153,filter154,filter155,filter156,filter157,filter158,
                         filter161,filter162,filter163,filter164,filter165,filter166,filter167,filter168;
input [4:0] [7:0] in1,in2,in3,in4,in5,in6,in7,in8;
wire signed [18:0] quant11,quant12,quant13,quant14,quant15,quant16,quant17,quant18,
quant21,quant22,quant23,quant24,quant25,quant26,quant27,quant28,
quant31,quant32,quant33,quant34,quant35,quant36,quant37,quant38,
quant41,quant42,quant43,quant44,quant45,quant46,quant47,quant48,
quant51,quant52,quant53,quant54,quant55,quant56,quant57,quant58,
quant61,quant62,quant63,quant64,quant65,quant66,quant67,quant68,
quant71,quant72,quant73,quant74,quant75,quant76,quant77,quant78,
quant81,quant82,quant83,quant84,quant85,quant86,quant87,quant88,
quant19,quant110,quant111,quant112,quant113,quant114,quant115,quant116,
quant29,quant210,quant211,quant212,quant213,quant214,quant215,quant216,
quant39,quant310,quant311,quant312,quant313,quant314,quant315,quant316,
quant49,quant410,quant411,quant412,quant413,quant414,quant415,quant416,
quant59,quant510,quant511,quant512,quant513,quant514,quant515,quant516,
quant69,quant610,quant611,quant612,quant613,quant614,quant615,quant616,
quant79,quant710,quant711,quant712,quant713,quant714,quant715,quant716,
quant89,quant810,quant811,quant812,quant813,quant814,quant815,quant816;


reg signed [21:0] out1,out2,out3,out4,out5,out6,out7,out8,
out9,out10,out11,out12,out13,out14,out15,out16;
reg signed [21:0] out_cu1,out_cu2,out_cu3,out_cu4,out_cu5,out_cu6,out_cu7,out_cu8,
				  out_cu9,out_cu10,out_cu11,out_cu12,out_cu13,out_cu14,out_cu15,out_cu16;
output reg signed [7:0] outfin1,outfin2,outfin3,outfin4,outfin5,outfin6,outfin7,outfin8,
outfin9,outfin10,outfin11,outfin12,outfin13,outfin14,outfin15,outfin16;

initial begin
    filter11 <= '{-34, -9, -55, -13, 16};  // Filter 1, Channel 1
    filter21 <= '{-10, 43, 54, -25, 41};  // Filter 2, Channel 1
    filter31 <= '{-56, 7, -22, 12, -4};  // Filter 3, Channel 1
    filter41 <= '{26, -102, 40, -64, -28};  // Filter 4, Channel 1
    filter51 <= '{10, -49, 18, 76, -4};  // Filter 5, Channel 1
    filter61 <= '{29, -65, 7, 11, -1};  // Filter 6, Channel 1
    filter71 <= '{-6, 65, -25, 13, 54};  // Filter 7, Channel 1
    filter81 <= '{25, 3, 4, 41, -38};  // Filter 8, Channel 1
    filter91 <= '{-33, 0, -17, 22, -26};  // Filter 9, Channel 1
    filter101 <= '{19, 38, 32, -23, 41};  // Filter 10, Channel 1
    filter111 <= '{-35, -36, 0, -32, -34};  // Filter 11, Channel 1
    filter121 <= '{-32, -5, 21, -10, -32};  // Filter 12, Channel 1
    filter131 <= '{-65, 38, 22, 60, -16};  // Filter 13, Channel 1
    filter141 <= '{28, -9, -126, 32, -38};  // Filter 14, Channel 1
    filter151 <= '{-48, -11, -20, -28, -3};  // Filter 15, Channel 1
    filter161 <= '{-57, -4, -45, -54, 19};  // Filter 16, Channel 1

    filter12 <= '{-41, 40, 38, 4, -42};  // Filter 1, Channel 2
    filter22 <= '{12, 4, -12, -16, 3};  // Filter 2, Channel 2
    filter32 <= '{9, 6, 26, 34, 17};  // Filter 3, Channel 2
    filter42 <= '{36, 7, 67, 10, 2};  // Filter 4, Channel 2
    filter52 <= '{-10, -94, 38, 27, -49};  // Filter 5, Channel 2
    filter62 <= '{11, -37, 22, 50, 1};  // Filter 6, Channel 2
    filter72 <= '{41, 8, -37, 25, -14};  // Filter 7, Channel 2
    filter82 <= '{30, 54, -35, 43, -23};  // Filter 8, Channel 2
    filter92 <= '{-51, 5, -38, 1, -3};  // Filter 9, Channel 2
    filter102 <= '{-41, -6, 27, -52, 18};  // Filter 10, Channel 2
    filter112 <= '{-11, 0, 10, -52, 0};  // Filter 11, Channel 2
    filter122 <= '{4, 3, -36, -13, 20};  // Filter 12, Channel 2
    filter132 <= '{-44, -13, -31, -18, 17};  // Filter 13, Channel 2
    filter142 <= '{-75, -10, -39, -5, -49};  // Filter 14, Channel 2
    filter152 <= '{-37, 18, -1, 2, -18};  // Filter 15, Channel 2
    filter162 <= '{15, 38, 40, -15, 7};  // Filter 16, Channel 2

    filter13 <= '{-1, -18, 45, -4, -50};  // Filter 1, Channel 3
    filter23 <= '{-73, 40, 52, 24, -35};  // Filter 2, Channel 3
    filter33 <= '{-53, 35, 67, -56, -10};  // Filter 3, Channel 3
    filter43 <= '{-18, 9, 6, -17, 70};  // Filter 4, Channel 3
    filter53 <= '{60, 27, -18, 9, 15};  // Filter 5, Channel 3
    filter63 <= '{-60, -66, 32, -1, 29};  // Filter 6, Channel 3
    filter73 <= '{33, 3, -62, 9, 51};  // Filter 7, Channel 3
    filter83 <= '{15, 14, 4, 28, 33};  // Filter 8, Channel 3
    filter93 <= '{44, -4, -6, 52, -14};  // Filter 9, Channel 3
    filter103 <= '{21, -41, -62, -49, -48};  // Filter 10, Channel 3
    filter113 <= '{-6, 51, 59, 46, -57};  // Filter 11, Channel 3
    filter123 <= '{-12, -26, 62, 23, 38};  // Filter 12, Channel 3
    filter133 <= '{68, -8, 2, 18, -48};  // Filter 13, Channel 3
    filter143 <= '{-53, 13, 35, -27, -52};  // Filter 14, Channel 3
    filter153 <= '{33, -41, 29, 0, -35};  // Filter 15, Channel 3
    filter163 <= '{-16, 3, -20, 39, -18};  // Filter 16, Channel 3

    filter14 <= '{19, -23, 35, -45, 22};  // Filter 1, Channel 4
    filter24 <= '{42, -29, -22, 4, -4};  // Filter 2, Channel 4
    filter34 <= '{24, -44, 59, -61, 57};  // Filter 3, Channel 4
    filter44 <= '{60, -3, -9, 17, -48};  // Filter 4, Channel 4
    filter54 <= '{-71, 44, 68, -9, 20};  // Filter 5, Channel 4
    filter64 <= '{25, -39, -11, 0, 10};  // Filter 6, Channel 4
    filter74 <= '{6, 0, -24, -35, 2};  // Filter 7, Channel 4
    filter84 <= '{69, 9, 0, 62, -4};  // Filter 8, Channel 4
    filter94 <= '{-21, 53, 54, 3, 53};  // Filter 9, Channel 4
    filter104 <= '{-82, 12, 48, -37, 10};  // Filter 10, Channel 4
    filter114 <= '{32, -18, -7, 27, 30};  // Filter 11, Channel 4
    filter124 <= '{31, 16, -97, 57, -12};  // Filter 12, Channel 4
    filter134 <= '{-3, 14, -8, 18, 49};  // Filter 13, Channel 4
    filter144 <= '{63, -35, 16, -27, 37};  // Filter 14, Channel 4
    filter154 <= '{-44, 67, -20, -63, 4};  // Filter 15, Channel 4
    filter164 <= '{-17, 33, 13, -56, 3};  // Filter 16, Channel 4

    filter15 <= '{31, 47, 30, 26, 31};  // Filter 1, Channel 5
    filter25 <= '{-37, 62, 9, -42, -12};  // Filter 2, Channel 5
    filter35 <= '{-29, 30, 31, -30, 0};  // Filter 3, Channel 5
    filter45 <= '{-40, -41, -28, 0, -29};  // Filter 4, Channel 5
    filter55 <= '{5, -40, -1, -22, -7};  // Filter 5, Channel 5
    filter65 <= '{4, -18, 9, -10, 15};  // Filter 6, Channel 5
    filter75 <= '{-27, 12, 22, -47, 13};  // Filter 7, Channel 5
    filter85 <= '{41, -28, 27, -2, -32};  // Filter 8, Channel 5
    filter95 <= '{-68, -45, -13, -20, -3};  // Filter 9, Channel 5
    filter105 <= '{-53, 51, 3, 23, 28};  // Filter 10, Channel 5
    filter115 <= '{22, -28, -24, 1, 26};  // Filter 11, Channel 5
    filter125 <= '{54, 57, -51, -37, -2};  // Filter 12, Channel 5
    filter135 <= '{-45, -9, 26, 28, -28};  // Filter 13, Channel 5
    filter145 <= '{49, -27, -50, 0, -60};  // Filter 14, Channel 5
    filter155 <= '{-53, 22, 70, 15, 56};  // Filter 15, Channel 5
    filter165 <= '{-15, -37, -43, 48, -11};  // Filter 16, Channel 5

    filter16 <= '{-37, -29, -20, -5, -28};  // Filter 1, Channel 6
    filter26 <= '{-4, 19, 27, 48, -31};  // Filter 2, Channel 6
    filter36 <= '{9, 4, 20, 37, 17};  // Filter 3, Channel 6
    filter46 <= '{0, -38, -71, -72, -111};  // Filter 4, Channel 6
    filter56 <= '{29, 14, 38, -24, -38};  // Filter 5, Channel 6
    filter66 <= '{1, 29, 57, 8, 72};  // Filter 6, Channel 6
    filter76 <= '{89, 93, 0, 75, 65};  // Filter 7, Channel 6
    filter86 <= '{-28, -42, -2, -14, 4};  // Filter 8, Channel 6
    filter96 <= '{-70, -66, -13, -84, -62};  // Filter 9, Channel 6
    filter106 <= '{39, 34, 27, 84, 11};  // Filter 10, Channel 6
    filter116 <= '{-78, -75, 10, -94, 31};  // Filter 11, Channel 6
    filter126 <= '{-59, 20, -59, 9, 9};  // Filter 12, Channel 6
    filter136 <= '{64, 19, 2, 26, 35};  // Filter 13, Channel 6
    filter146 <= '{-41, -66, 36, 59, 30};  // Filter 14, Channel 6
    filter156 <= '{39, 21, 19, 20, -65};  // Filter 15, Channel 6
    filter166 <= '{-30, -24, -71, -16, 35};  // Filter 16, Channel 6

    filter17 <= '{53, -1, 15, -36, 28};  // Filter 1, Channel 7
    filter27 <= '{-54, -14, -23, -58, -73};  // Filter 2, Channel 7
    filter37 <= '{52, -27, -24, -32, -14};  // Filter 3, Channel 7
    filter47 <= '{57, -29, 49, 18, -22};  // Filter 4, Channel 7
    filter57 <= '{-14, 48, -2, -20, -6};  // Filter 5, Channel 7
    filter67 <= '{-43, -43, 8, 12, 48};  // Filter 6, Channel 7
    filter77 <= '{-19, -55, -42, 17, -34};  // Filter 7, Channel 7
    filter87 <= '{45, -108, 43, 92, -2};  // Filter 8, Channel 7
    filter97 <= '{1, 8, 24, 20, 39};  // Filter 9, Channel 7
    filter107 <= '{-49, -42, -18, 0, -32};  // Filter 10, Channel 7
    filter117 <= '{76, 54, -19, 6, 37};  // Filter 11, Channel 7
    filter127 <= '{-19, 11, -19, 26, 6};  // Filter 12, Channel 7
    filter137 <= '{-6, -7, -15, -42, -21};  // Filter 13, Channel 7
    filter147 <= '{-1, 3, 12, -89, -31};  // Filter 14, Channel 7
    filter157 <= '{-5, 40, 43, -2, -79};  // Filter 15, Channel 7
    filter167 <= '{-67, -6, 69, -26, -80};  // Filter 16, Channel 7

    filter18 <= '{-20, -28, -13, 29, -40};  // Filter 1, Channel 8
    filter28 <= '{39, -53, -14, -45, 56};  // Filter 2, Channel 8
    filter38 <= '{-24, -48, 23, -7, 14};  // Filter 3, Channel 8
    filter48 <= '{2, -15, 58, -10, -19};  // Filter 4, Channel 8
    filter58 <= '{25, -40, -13, -15, 3};  // Filter 5, Channel 8
    filter68 <= '{37, -36, 3, 34, -19};  // Filter 6, Channel 8
    filter78 <= '{21, 50, 19, -35, 16};  // Filter 7, Channel 8
    filter88 <= '{50, 34, 25, 34, -7};  // Filter 8, Channel 8
    filter98 <= '{-41, 9, 37, 16, 27};  // Filter 9, Channel 8
    filter108 <= '{-33, -10, 38, 60, 27};  // Filter 10, Channel 8
    filter118 <= '{-25, -9, 57, -73, 14};  // Filter 11, Channel 8
    filter128 <= '{-9, 1, -8, 14, 14};  // Filter 12, Channel 8
    filter138 <= '{19, 7, -19, -4, -19};  // Filter 13, Channel 8
    filter148 <= '{37, -54, -13, -29, -17};  // Filter 14, Channel 8
    filter158 <= '{-23, -16, 22, 46, 13};  // Filter 15, Channel 8
    filter168 <= '{-15, 20, -1, -12, 50};  // Filter 16, Channel 8
end


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

conv cu33(rst,en,in5[0],in5[1],in5[2],in5[3],in5[4],filter15[0],filter15[1],filter15[2],filter15[3],filter15[4],quant51);
conv cu34(rst,en,in5[0],in5[1],in5[2],in5[3],in5[4],filter25[0],filter25[1],filter25[2],filter25[3],filter25[4],quant52);
conv cu35(rst,en,in5[0],in5[1],in5[2],in5[3],in5[4],filter35[0],filter35[1],filter35[2],filter35[3],filter35[4],quant53);
conv cu36(rst,en,in5[0],in5[1],in5[2],in5[3],in5[4],filter45[0],filter45[1],filter45[2],filter45[3],filter45[4],quant54);
conv cu37(rst,en,in5[0],in5[1],in5[2],in5[3],in5[4],filter55[0],filter55[1],filter55[2],filter55[3],filter55[4],quant55);
conv cu38(rst,en,in5[0],in5[1],in5[2],in5[3],in5[4],filter65[0],filter65[1],filter65[2],filter65[3],filter65[4],quant56);
conv cu39(rst,en,in5[0],in5[1],in5[2],in5[3],in5[4],filter75[0],filter75[1],filter75[2],filter75[3],filter75[4],quant57);
conv cu40(rst,en,in5[0],in5[1],in5[2],in5[3],in5[4],filter85[0],filter85[1],filter85[2],filter85[3],filter85[4],quant58);

conv cu41(rst,en,in6[0],in6[1],in6[2],in6[3],in6[4],filter16[0],filter16[1],filter16[2],filter16[3],filter16[4],quant61);
conv cu42(rst,en,in6[0],in6[1],in6[2],in6[3],in6[4],filter26[0],filter26[1],filter26[2],filter26[3],filter26[4],quant62);
conv cu43(rst,en,in6[0],in6[1],in6[2],in6[3],in6[4],filter36[0],filter36[1],filter36[2],filter36[3],filter36[4],quant63);
conv cu44(rst,en,in6[0],in6[1],in6[2],in6[3],in6[4],filter46[0],filter46[1],filter46[2],filter46[3],filter46[4],quant64);
conv cu45(rst,en,in6[0],in6[1],in6[2],in6[3],in6[4],filter56[0],filter56[1],filter56[2],filter56[3],filter56[4],quant65);
conv cu46(rst,en,in6[0],in6[1],in6[2],in6[3],in6[4],filter66[0],filter66[1],filter66[2],filter66[3],filter66[4],quant66);
conv cu47(rst,en,in6[0],in6[1],in6[2],in6[3],in6[4],filter76[0],filter76[1],filter76[2],filter76[3],filter76[4],quant67);
conv cu48(rst,en,in6[0],in6[1],in6[2],in6[3],in6[4],filter86[0],filter86[1],filter86[2],filter86[3],filter86[4],quant68);

conv cu49(rst,en,in7[0],in7[1],in7[2],in7[3],in7[4],filter17[0],filter17[1],filter17[2],filter17[3],filter17[4],quant71);
conv cu50(rst,en,in7[0],in7[1],in7[2],in7[3],in7[4],filter27[0],filter27[1],filter27[2],filter27[3],filter27[4],quant72);
conv cu51(rst,en,in7[0],in7[1],in7[2],in7[3],in7[4],filter37[0],filter37[1],filter37[2],filter37[3],filter37[4],quant73);
conv cu52(rst,en,in7[0],in7[1],in7[2],in7[3],in7[4],filter47[0],filter47[1],filter47[2],filter47[3],filter47[4],quant74);
conv cu53(rst,en,in7[0],in7[1],in7[2],in7[3],in7[4],filter57[0],filter57[1],filter57[2],filter57[3],filter57[4],quant75);
conv cu54(rst,en,in7[0],in7[1],in7[2],in7[3],in7[4],filter67[0],filter67[1],filter67[2],filter67[3],filter67[4],quant76);
conv cu55(rst,en,in7[0],in7[1],in7[2],in7[3],in7[4],filter77[0],filter77[1],filter77[2],filter77[3],filter77[4],quant77);
conv cu56(rst,en,in7[0],in7[1],in7[2],in7[3],in7[4],filter87[0],filter87[1],filter87[2],filter87[3],filter87[4],quant78);

conv cu57(rst,en,in8[0],in8[1],in8[2],in8[3],in8[4],filter18[0],filter18[1],filter18[2],filter18[3],filter18[4],quant81);
conv cu58(rst,en,in8[0],in8[1],in8[2],in8[3],in8[4],filter28[0],filter28[1],filter28[2],filter28[3],filter28[4],quant82);
conv cu59(rst,en,in8[0],in8[1],in8[2],in8[3],in8[4],filter38[0],filter38[1],filter38[2],filter38[3],filter38[4],quant83);
conv cu60(rst,en,in8[0],in8[1],in8[2],in8[3],in8[4],filter48[0],filter48[1],filter48[2],filter48[3],filter48[4],quant84);
conv cu61(rst,en,in8[0],in8[1],in8[2],in8[3],in8[4],filter58[0],filter58[1],filter58[2],filter58[3],filter58[4],quant85);
conv cu62(rst,en,in8[0],in8[1],in8[2],in8[3],in8[4],filter68[0],filter68[1],filter68[2],filter68[3],filter68[4],quant86);
conv cu63(rst,en,in8[0],in8[1],in8[2],in8[3],in8[4],filter78[0],filter78[1],filter78[2],filter78[3],filter78[4],quant87);
conv cu64(rst,en,in8[0],in8[1],in8[2],in8[3],in8[4],filter88[0],filter88[1],filter88[2],filter88[3],filter88[4],quant88);


conv cu65(rst,en,in1[0],in1[1],in1[2],in1[3],in1[4],filter91[0],filter91[1],filter91[2],filter91[3],filter91[4],quant19);
conv cu66(rst,en,in1[0],in1[1],in1[2],in1[3],in1[4],filter101[0],filter101[1],filter101[2],filter101[3],filter101[4],quant110);
conv cu67(rst,en,in1[0],in1[1],in1[2],in1[3],in1[4],filter111[0],filter111[1],filter111[2],filter111[3],filter111[4],quant111);
conv cu68(rst,en,in1[0],in1[1],in1[2],in1[3],in1[4],filter121[0],filter121[1],filter121[2],filter121[3],filter121[4],quant112);
conv cu69(rst,en,in1[0],in1[1],in1[2],in1[3],in1[4],filter131[0],filter131[1],filter131[2],filter131[3],filter131[4],quant113);
conv cu70(rst,en,in1[0],in1[1],in1[2],in1[3],in1[4],filter141[0],filter141[1],filter141[2],filter141[3],filter141[4],quant114);
conv cu71(rst,en,in1[0],in1[1],in1[2],in1[3],in1[4],filter151[0],filter151[1],filter151[2],filter151[3],filter151[4],quant115);
conv cu72(rst,en,in1[0],in1[1],in1[2],in1[3],in1[4],filter161[0],filter161[1],filter161[2],filter161[3],filter161[4],quant116);

conv cu73(rst,en,in2[0],in2[1],in2[2],in2[3],in2[4],filter92[0],filter92[1],filter92[2],filter92[3],filter92[4],quant29);
conv cu74(rst,en,in2[0],in2[1],in2[2],in2[3],in2[4],filter102[0],filter102[1],filter102[2],filter102[3],filter102[4],quant210);
conv cu75(rst,en,in2[0],in2[1],in2[2],in2[3],in2[4],filter112[0],filter112[1],filter112[2],filter112[3],filter112[4],quant211);
conv cu76(rst,en,in2[0],in2[1],in2[2],in2[3],in2[4],filter122[0],filter122[1],filter122[2],filter122[3],filter122[4],quant212);
conv cu77(rst,en,in2[0],in2[1],in2[2],in2[3],in2[4],filter132[0],filter132[1],filter132[2],filter132[3],filter132[4],quant213);
conv cu78(rst,en,in2[0],in2[1],in2[2],in2[3],in2[4],filter142[0],filter142[1],filter142[2],filter142[3],filter142[4],quant214);
conv cu79(rst,en,in2[0],in2[1],in2[2],in2[3],in2[4],filter152[0],filter152[1],filter152[2],filter152[3],filter152[4],quant215);
conv cu80(rst,en,in2[0],in2[1],in2[2],in2[3],in2[4],filter162[0],filter162[1],filter162[2],filter162[3],filter162[4],quant216);

conv cu81(rst,en,in3[0],in3[1],in3[2],in3[3],in3[4],filter93[0],filter93[1],filter93[2],filter93[3],filter93[4],quant39);
conv cu82(rst,en,in3[0],in3[1],in3[2],in3[3],in3[4],filter103[0],filter103[1],filter103[2],filter103[3],filter103[4],quant310);
conv cu83(rst,en,in3[0],in3[1],in3[2],in3[3],in3[4],filter113[0],filter113[1],filter113[2],filter113[3],filter113[4],quant311);
conv cu84(rst,en,in3[0],in3[1],in3[2],in3[3],in3[4],filter123[0],filter123[1],filter123[2],filter123[3],filter123[4],quant312);
conv cu85(rst,en,in3[0],in3[1],in3[2],in3[3],in3[4],filter133[0],filter133[1],filter133[2],filter133[3],filter133[4],quant313);
conv cu86(rst,en,in3[0],in3[1],in3[2],in3[3],in3[4],filter143[0],filter143[1],filter143[2],filter143[3],filter143[4],quant314);
conv cu87(rst,en,in3[0],in3[1],in3[2],in3[3],in3[4],filter153[0],filter153[1],filter153[2],filter153[3],filter153[4],quant315);
conv cu88(rst,en,in3[0],in3[1],in3[2],in3[3],in3[4],filter163[0],filter163[1],filter163[2],filter163[3],filter163[4],quant316);

conv cu89(rst,en,in4[0],in4[1],in4[2],in4[3],in4[4],filter94[0],filter94[1],filter94[2],filter94[3],filter94[4],quant49);
conv cu90(rst,en,in4[0],in4[1],in4[2],in4[3],in4[4],filter104[0],filter104[1],filter104[2],filter104[3],filter104[4],quant410);
conv cu91(rst,en,in4[0],in4[1],in4[2],in4[3],in4[4],filter114[0],filter114[1],filter114[2],filter114[3],filter114[4],quant411);
conv cu92(rst,en,in4[0],in4[1],in4[2],in4[3],in4[4],filter124[0],filter124[1],filter124[2],filter124[3],filter124[4],quant412);
conv cu93(rst,en,in4[0],in4[1],in4[2],in4[3],in4[4],filter134[0],filter134[1],filter134[2],filter134[3],filter134[4],quant413);
conv cu94(rst,en,in4[0],in4[1],in4[2],in4[3],in4[4],filter144[0],filter144[1],filter144[2],filter144[3],filter144[4],quant414);
conv cu95(rst,en,in4[0],in4[1],in4[2],in4[3],in4[4],filter154[0],filter154[1],filter154[2],filter154[3],filter154[4],quant415);
conv cu96(rst,en,in4[0],in4[1],in4[2],in4[3],in4[4],filter164[0],filter164[1],filter164[2],filter164[3],filter164[4],quant416);

conv cu97(rst,en,in5[0],in5[1],in5[2],in5[3],in5[4],filter95[0],filter95[1],filter95[2],filter95[3],filter95[4],quant59);
conv cu98(rst,en,in5[0],in5[1],in5[2],in5[3],in5[4],filter105[0],filter105[1],filter105[2],filter105[3],filter105[4],quant510);
conv cu99(rst,en,in5[0],in5[1],in5[2],in5[3],in5[4],filter115[0],filter115[1],filter115[2],filter115[3],filter115[4],quant511);
conv cu100(rst,en,in5[0],in5[1],in5[2],in5[3],in5[4],filter125[0],filter125[1],filter125[2],filter125[3],filter125[4],quant512);
conv cu101(rst,en,in5[0],in5[1],in5[2],in5[3],in5[4],filter135[0],filter135[1],filter135[2],filter135[3],filter135[4],quant513);
conv cu102(rst,en,in5[0],in5[1],in5[2],in5[3],in5[4],filter145[0],filter145[1],filter145[2],filter145[3],filter145[4],quant514);
conv cu103(rst,en,in5[0],in5[1],in5[2],in5[3],in5[4],filter155[0],filter155[1],filter155[2],filter155[3],filter155[4],quant515);
conv cu104(rst,en,in5[0],in5[1],in5[2],in5[3],in5[4],filter165[0],filter165[1],filter165[2],filter165[3],filter165[4],quant516);

conv cu105(rst,en,in6[0],in6[1],in6[2],in6[3],in6[4],filter96[0],filter96[1],filter96[2],filter96[3],filter96[4],quant69);
conv cu106(rst,en,in6[0],in6[1],in6[2],in6[3],in6[4],filter106[0],filter106[1],filter106[2],filter106[3],filter106[4],quant610);
conv cu107(rst,en,in6[0],in6[1],in6[2],in6[3],in6[4],filter116[0],filter116[1],filter116[2],filter116[3],filter116[4],quant611);
conv cu108(rst,en,in6[0],in6[1],in6[2],in6[3],in6[4],filter126[0],filter126[1],filter126[2],filter126[3],filter126[4],quant612);
conv cu109(rst,en,in6[0],in6[1],in6[2],in6[3],in6[4],filter136[0],filter136[1],filter136[2],filter136[3],filter136[4],quant613);
conv cu110(rst,en,in6[0],in6[1],in6[2],in6[3],in6[4],filter146[0],filter146[1],filter146[2],filter146[3],filter146[4],quant614);
conv cu111(rst,en,in6[0],in6[1],in6[2],in6[3],in6[4],filter156[0],filter156[1],filter156[2],filter156[3],filter156[4],quant615);
conv cu112(rst,en,in6[0],in6[1],in6[2],in6[3],in6[4],filter166[0],filter166[1],filter166[2],filter166[3],filter166[4],quant616);

conv cu113(rst,en,in7[0],in7[1],in7[2],in7[3],in7[4],filter97[0],filter97[1],filter97[2],filter97[3],filter97[4],quant79);
conv cu114(rst,en,in7[0],in7[1],in7[2],in7[3],in7[4],filter107[0],filter107[1],filter107[2],filter107[3],filter107[4],quant710);
conv cu115(rst,en,in7[0],in7[1],in7[2],in7[3],in7[4],filter117[0],filter117[1],filter117[2],filter117[3],filter117[4],quant711);
conv cu116(rst,en,in7[0],in7[1],in7[2],in7[3],in7[4],filter127[0],filter127[1],filter127[2],filter127[3],filter127[4],quant712);
conv cu117(rst,en,in7[0],in7[1],in7[2],in7[3],in7[4],filter137[0],filter137[1],filter137[2],filter137[3],filter137[4],quant713);
conv cu118(rst,en,in7[0],in7[1],in7[2],in7[3],in7[4],filter147[0],filter147[1],filter147[2],filter147[3],filter147[4],quant714);
conv cu119(rst,en,in7[0],in7[1],in7[2],in7[3],in7[4],filter157[0],filter157[1],filter157[2],filter157[3],filter157[4],quant715);
conv cu120(rst,en,in7[0],in7[1],in7[2],in7[3],in7[4],filter167[0],filter167[1],filter167[2],filter167[3],filter167[4],quant716);

conv cu121(rst,en,in8[0],in8[1],in8[2],in8[3],in8[4],filter98[0],filter98[1],filter98[2],filter98[3],filter98[4],quant89);
conv cu122(rst,en,in8[0],in8[1],in8[2],in8[3],in8[4],filter108[0],filter108[1],filter108[2],filter108[3],filter108[4],quant810);
conv cu123(rst,en,in8[0],in8[1],in8[2],in8[3],in8[4],filter118[0],filter118[1],filter118[2],filter118[3],filter118[4],quant811);
conv cu124(rst,en,in8[0],in8[1],in8[2],in8[3],in8[4],filter128[0],filter128[1],filter128[2],filter128[3],filter128[4],quant812);
conv cu125(rst,en,in8[0],in8[1],in8[2],in8[3],in8[4],filter138[0],filter138[1],filter138[2],filter138[3],filter138[4],quant813);
conv cu126(rst,en,in8[0],in8[1],in8[2],in8[3],in8[4],filter148[0],filter148[1],filter148[2],filter148[3],filter148[4],quant814);
conv cu127(rst,en,in8[0],in8[1],in8[2],in8[3],in8[4],filter158[0],filter158[1],filter158[2],filter158[3],filter158[4],quant815);
conv cu128(rst,en,in8[0],in8[1],in8[2],in8[3],in8[4],filter168[0],filter168[1],filter168[2],filter168[3],filter168[4],quant816);


always@(*) begin
	out1=(quant11+quant21+quant31+quant41+quant51+quant61+quant71+quant81);
	out2=(quant12+quant22+quant32+quant42+quant52+quant62+quant72+quant82);
	out3=(quant13+quant23+quant33+quant43+quant53+quant63+quant73+quant83);
	out4=(quant14+quant24+quant34+quant44+quant54+quant64+quant74+quant84);
	out5=(quant15+quant25+quant35+quant45+quant55+quant65+quant75+quant85);
	out6=(quant16+quant26+quant36+quant46+quant56+quant66+quant76+quant86);
	out7=(quant17+quant27+quant37+quant47+quant57+quant67+quant77+quant87);
	out8=(quant18+quant28+quant38+quant48+quant58+quant68+quant78+quant88);
	out9=(quant19+quant29+quant39+quant49+quant59+quant69+quant79+quant89);
	out10=(quant110+quant210+quant310+quant410+quant510+quant610+quant710+quant810);
	out11=(quant111+quant211+quant311+quant411+quant511+quant611+quant711+quant811);
	out12=(quant112+quant212+quant312+quant412+quant512+quant612+quant712+quant812);
	out13=(quant113+quant213+quant313+quant413+quant513+quant613+quant713+quant813);
	out14=(quant114+quant214+quant314+quant414+quant514+quant614+quant714+quant814);
	out15=(quant115+quant215+quant315+quant415+quant515+quant615+quant715+quant815);
	out16=(quant116+quant216+quant316+quant416+quant516+quant616+quant716+quant816);

end
always@(*) begin
	out_cu1=out1>>>8;
	out_cu2=out2>>>8;
	out_cu3=out3>>>8;
	out_cu4=out4>>>8;
	out_cu5=out5>>>8;
	out_cu6=out6>>>8;
	out_cu7=out7>>>8;
	out_cu8=out8>>>8;
	out_cu9=out9>>>8;
	out_cu10=out10>>>8;
	out_cu11=out11>>>8;
	out_cu12=out12>>>8;
	out_cu13=out13>>>8;
	out_cu14=out14>>>8;
	out_cu15=out15>>>8;
	out_cu16=out16>>>8;

end

always@(*)
begin
	if (out_cu1[21] == 1'b1 && out_cu1 < 22'b111_1111_1111_1000_0001)
		outfin1 <= 8'b1000_0001;
	else if (out_cu1[21] == 1'b0 && out_cu1 > 22'b000_0000_0000_0111_1111)
		outfin1 <= 8'b0111_1111;
	else
		outfin1 <= out_cu1[7:0];

	if (out_cu2[21] == 1'b1 && out_cu2 < 22'b111_1111_1111_1000_0001)
		outfin2 <= 8'b1000_0001;
	else if (out_cu2[21] == 1'b0 && out_cu2 > 22'b000_0000_0000_0111_1111)
		outfin2 <= 8'b0111_1111;
	else
		outfin2 <= out_cu2[7:0];

	if (out_cu3[21] == 1'b1 && out_cu3 < 22'b111_1111_1111_1000_0001)
		outfin3 <= 8'b1000_0001;
	else if (out_cu3[21] == 1'b0 && out_cu3 > 22'b000_0000_0000_0111_1111)
		outfin3 <= 8'b0111_1111;
	else
		outfin3 <= out_cu3[7:0];

	if (out_cu4[21] == 1'b1 && out_cu4 < 22'b111_1111_1111_1000_0001)
		outfin4 <= 8'b1000_0001;
	else if (out_cu4[21] == 1'b0 && out_cu4 > 22'b000_0000_0000_0111_1111)
		outfin4 <= 8'b0111_1111;
	else
		outfin4 <= out_cu4[7:0];
	
	if (out_cu5[21] == 1'b1 && out_cu5 < 22'b111_1111_1111_1000_0001)
		outfin5 <= 8'b1000_0001;
	else if (out_cu5[21] == 1'b0 && out_cu5 > 22'b000_0000_0000_0111_1111)
		outfin5 <= 8'b0111_1111;
	else
		outfin5 <= out_cu5[7:0];

	if (out_cu6[21] == 1'b1 && out_cu6 < 22'b111_1111_1111_1000_0001)
		outfin6 <= 8'b1000_0001;
	else if (out_cu6[21] == 1'b0 && out_cu6 > 22'b000_0000_0000_0111_1111)
		outfin6 <= 8'b0111_1111;
	else
		outfin6 <= out_cu6[7:0];

	if (out_cu7[21] == 1'b1 && out_cu7 < 22'b111_1111_1111_1000_0001)
		outfin7 <= 8'b1000_0001;
	else if (out_cu7[21] == 1'b0 && out_cu7 > 22'b000_0000_0000_0111_1111)
		outfin7 <= 8'b0111_1111;
	else
		outfin7 <= out_cu7[7:0];

	if (out_cu8[21] == 1'b1 && out_cu8 < 22'b111_1111_1111_1000_0001)
		outfin8 <= 8'b1000_0001;
	else if (out_cu8[21] == 1'b0 && out_cu8 > 22'b000_0000_0000_0111_1111)
		outfin8 <= 8'b0111_1111;
	else
		outfin8 <= out_cu8[7:0];

		if (out_cu9[21] == 1'b1 && out_cu9 < 22'b111_1111_1111_1000_0001)
		outfin9 <= 8'b1000_0001;
	else if (out_cu9[21] == 1'b0 && out_cu9 > 22'b000_0000_0000_0111_1111)
		outfin9 <= 8'b0111_1111;
	else
		outfin9 <= out_cu9[7:0];

	if (out_cu10[21] == 1'b1 && out_cu10 < 22'b111_1111_1111_1000_0001)
		outfin10 <= 8'b1000_0001;
	else if (out_cu10[21] == 1'b0 && out_cu10 > 22'b000_0000_0000_0111_1111)
		outfin10 <= 8'b0111_1111;
	else
		outfin10 <= out_cu10[7:0];

	if (out_cu11[21] == 1'b1 && out_cu11 < 22'b111_1111_1111_1000_0001)
		outfin11 <= 8'b1000_0001;
	else if (out_cu11[21] == 1'b0 && out_cu11 > 22'b000_0000_0000_0111_1111)
		outfin11 <= 8'b0111_1111;
	else
		outfin11 <= out_cu11[7:0];

	if (out_cu12[21] == 1'b1 && out_cu12 < 22'b111_1111_1111_1000_0001)
		outfin12 <= 8'b1000_0001;
	else if (out_cu12[21] == 1'b0 && out_cu12 > 22'b000_0000_0000_0111_1111)
		outfin12 <= 8'b0111_1111;
	else
		outfin12 <= out_cu12[7:0];
	
	if (out_cu13[21] == 1'b1 && out_cu13 < 22'b111_1111_1111_1000_0001)
		outfin13 <= 8'b1000_0001;
	else if (out_cu13[21] == 1'b0 && out_cu13 > 22'b000_0000_0000_0111_1111)
		outfin13 <= 8'b0111_1111;
	else
		outfin13 <= out_cu13[7:0];

	if (out_cu14[21] == 1'b1 && out_cu14 < 22'b111_1111_1111_1000_0001)
		outfin14 <= 8'b1000_0001;
	else if (out_cu14[21] == 1'b0 && out_cu14 > 22'b000_0000_0000_0111_1111)
		outfin14 <= 8'b0111_1111;
	else
		outfin14 <= out_cu14[7:0];

	if (out_cu15[21] == 1'b1 && out_cu15 < 22'b111_1111_1111_1000_0001)
		outfin15 <= 8'b1000_0001;
	else if (out_cu15[21] == 1'b0 && out_cu15 > 22'b000_0000_0000_0111_1111)
		outfin15 <= 8'b0111_1111;
	else
		outfin15 <= out_cu15[7:0];

	if (out_cu16[21] == 1'b1 && out_cu16 < 22'b111_1111_1111_1000_0001)
		outfin16 <= 8'b1000_0001;
	else if (out_cu16[21] == 1'b0 && out_cu16 > 22'b000_0000_0000_0111_1111)
		outfin16 <= 8'b0111_1111;
	else
		outfin16 <= out_cu16[7:0];
	
	
end






endmodule