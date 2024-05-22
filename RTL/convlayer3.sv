module convlayer3(rst,en,in1,in2,in3,in4,in5,in6,in7,in8,outfin1,outfin2,outfin3,outfin4,outfin5,outfin6,outfin7,outfin8);


input rst,en;

reg signed [4:0] [7:0] filter11,filter12,filter13,filter14,filter15,filter16,filter17,filter18;
reg signed [4:0] [7:0] filter21,filter22,filter23,filter24,filter25,filter26,filter27,filter28;
reg signed [4:0] [7:0] filter31,filter32,filter33,filter34,filter35,filter36,filter37,filter38;
reg signed [4:0] [7:0] filter41,filter42,filter43,filter44,filter45,filter46,filter47,filter48;
reg signed [4:0] [7:0] filter51,filter52,filter53,filter54,filter55,filter56,filter57,filter58;
reg signed [4:0] [7:0] filter61,filter62,filter63,filter64,filter65,filter66,filter67,filter68;
reg signed [4:0] [7:0] filter71,filter72,filter73,filter74,filter75,filter76,filter77,filter78;
reg signed [4:0] [7:0] filter81,filter82,filter83,filter84,filter85,filter86,filter87,filter88;
input [4:0] [7:0] in1,in2,in3,in4,in5,in6,in7,in8;
wire signed [18:0] quant11,quant12,quant13,quant14,quant15,quant16,quant17,quant18,
quant21,quant22,quant23,quant24,quant25,quant26,quant27,quant28,
quant31,quant32,quant33,quant34,quant35,quant36,quant37,quant38,
quant41,quant42,quant43,quant44,quant45,quant46,quant47,quant48,
quant51,quant52,quant53,quant54,quant55,quant56,quant57,quant58,
quant61,quant62,quant63,quant64,quant65,quant66,quant67,quant68,
quant71,quant72,quant73,quant74,quant75,quant76,quant77,quant78,
quant81,quant82,quant83,quant84,quant85,quant86,quant87,quant88;

reg signed [21:0] out1,out2,out3,out4,out5,out6,out7,out8;
reg signed [21:0] out_cu1,out_cu2,out_cu3,out_cu4,out_cu5,out_cu6,out_cu7,out_cu8;

output reg signed [7:0] outfin1,outfin2,outfin3,outfin4,outfin5,outfin6,outfin7,outfin8;

initial begin
    // Initialize filter values using concatenation from layer3_0_quant.csv
    filter11 = '{113, -4, -20, -9, 44};
    filter21 = '{103, -11, 62, 43, 5};
    filter31 = '{56, 52, -17, 0, -25};
    filter41 = '{62, -46, 105, -31, 127};
    filter51 = '{41, -9, 37, -10, 24};
    filter61 = '{-50, -42, 16, -58, -41};
    filter71 = '{-89, -84, 13, -85, 19};
    filter81 = '{103, -29, -22, 48, 52};

    // Initialize filter values using concatenation from layer3_1_quant.csv
    filter12 = '{-55, 18, -36, 77, -19};
    filter22 = '{65, -37, 40, -34, -13};
    filter32 = '{-13, -99, 61, 13, -61};
    filter42 = '{24, 9, -70, -16, -72};
    filter52 = '{-10, 19, 29, -78, 18};
    filter62 = '{89, 54, -23, -15, 77};
    filter72 = '{-30, 21, 38, 55, 32};
    filter82 = '{64, -33, 3, 66, -14};

    // Initialize filter values using concatenation from layer3_2_quant.csv
    filter13 = '{36, -28, 58, 31, -76};
    filter23 = '{102, 25, 79, 77, 43};
    filter33 = '{-24, -75, -49, 16, 84};
    filter43 = '{-23, 72, 26, 29, 19};
    filter53 = '{60, 57, 68, -4, -37};
    filter63 = '{51, -50, -1, 45, 92};
    filter73 = '{35, -52, 33, 62, 76};
    filter83 = '{40, 5, 12, -54, 70};

    // Initialize filter values using concatenation from layer3_3_quant.csv
    filter14 = '{-45, -56, 89, 4, 38};
    filter24 = '{15, 74, 39, 20, -53};
    filter34 = '{98, -73, 45, 28, -46};
    filter44 = '{49, -44, -79, 24, 9};
    filter54 = '{-58, -38, -8, -35, 66};
    filter64 = '{27, -31, 71, -41, -5};
    filter74 = '{90, -74, 55, -6, 18};
    filter84 = '{3, 87, -65, 61, -50};

    // Initialize filter values using concatenation from layer3_4_quant.csv
    filter15 = '{-17, 82, -63, -68, -30};
    filter25 = '{79, 41, 97, -2, -99};
    filter35 = '{72, 9, -88, 88, 91};
    filter45 = '{18, -43, -51, -77, -4};
    filter55 = '{-87, -19, 40, -92, 53};
    filter65 = '{29, 85, 28, 76, 7};
    filter75 = '{33, -12, 0, -61, -24};
    filter85 = '{4, -3, 50, -29, 21};

    // Initialize filter values using concatenation from layer3_5_quant.csv
    filter16 = '{32, -79, 67, 52, 12};
    filter26 = '{-89, 10, 74, 38, 58};
    filter36 = '{-16, 64, -22, 84, -71};
    filter46 = '{20, -32, -12, 34, -27};
    filter56 = '{-5, 36, 14, -15, -26};
    filter66 = '{31, 37, 27, -55, 13};
    filter76 = '{-2, 60, 46, 26, 19};
    filter86 = '{-39, -28, -21, 6, -66};

    // Initialize filter values using concatenation from layer3_6_quant.csv
    filter17 = '{10, -43, 9, 11, 61};
    filter27 = '{-29, 81, -18, -84, -48};
    filter37 = '{-31, 89, 51, 57, -27};
    filter47 = '{64, 55, -38, -35, -58};
    filter57 = '{36, -33, -69, -23, 17};
    filter67 = '{80, -45, -75, -36, -3};
    filter77 = '{44, -16, -14, -62, 30};
    filter87 = '{-50, -62, -19, -68, 15};

    // Initialize filter values using concatenation from layer3_7_quant.csv
    filter18 = '{-72, 65, -49, 18, -42};
    filter28 = '{26, 73, 14, -55, 5};
    filter38 = '{39, -48, -44, -62, 6};
    filter48 = '{-36, 16, 35, -60, 23};
    filter58 = '{-9, 92, 64, -70, -41};
    filter68 = '{-25, 22, 47, -38, -29};
    filter78 = '{57, -58, 62, -50, 32};
    filter88 = '{21, -20, 87, -34, -54};
end


conv cu1(rst,en,in1[0],in1[1],in1[2],in1[3],in1[4],filter11[0],filter11[1],filter11[2],filter11[3],filter11[4],quant11);
conv cu2(rst,en,in1[0],in1[1],in1[2],in1[3],in1[4],filter21[0],filter21[1],filter21[2],filter21[3],filter21[4],quant12);
conv cu3(rst,en,in1[0],in1[1],in1[2],in1[3],in1[4],filter31[0],filter31[1],filter31[2],filter31[3],filter31[4],quant13);
conv cu4(rst,en,in1[0],in1[1],in1[2],in1[3],in1[4],filter41[0],filter41[1],filter41[2],filter41[3],filter41[4],quant14);
conv cu5(rst,en,in1[0],in1[1],in1[2],in1[3],in1[4],filter51[0],filter51[1],filter51[2],filter51[3],filter51[4],quant15);
conv cu6(rst,en,in1[0],in1[1],in1[2],in1[3],in1[4],filter61[0],filter61[1],filter61[2],filter61[3],filter61[4],quant16);
conv cu7(rst,en,in1[0],in1[1],in1[2],in1[3],in1[4],filter71[0],filter71[1],filter71[2],filter71[3],filter71[4],quant17);
conv cu8(rst,en,in1[0],in1[1],in1[2],in1[3],in1[4],filter81[0],filter81[1],filter81[2],filter81[3],filter81[4],quant18);

conv cu9 (rst,en,in2[0],in2[1],in2[2],in2[3],in2[4],filter12[0],filter12[1],filter12[2],filter12[3],filter12[4],quant21);
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


/*
conv cu17(rst,en,in3[0],in3[1],in3[2],in3[3],in3[4],filter1[0],filter1[1],filter1[2],filter1[3],filter1[4],quant31);
conv cu18(rst,en,in3[0],in3[1],in3[2],in3[3],in3[4],filter2[0],filter2[1],filter2[2],filter2[3],filter2[4],quant32);
conv cu19(rst,en,in3[0],in3[1],in3[2],in3[3],in3[4],filter3[0],filter3[1],filter3[2],filter3[3],filter3[4],quant33);
conv cu20(rst,en,in3[0],in3[1],in3[2],in3[3],in3[4],filter4[0],filter4[1],filter4[2],filter4[3],filter4[4],quant34);
conv cu21(rst,en,in3[0],in3[1],in3[2],in3[3],in3[4],filter5[0],filter5[1],filter5[2],filter5[3],filter5[4],quant35);
conv cu22(rst,en,in3[0],in3[1],in3[2],in3[3],in3[4],filter6[0],filter6[1],filter6[2],filter6[3],filter6[4],quant36);
conv cu23(rst,en,in3[0],in3[1],in3[2],in3[3],in3[4],filter7[0],filter7[1],filter7[2],filter7[3],filter7[4],quant37);
conv cu24(rst,en,in3[0],in3[1],in3[2],in3[3],in3[4],filter8[0],filter8[1],filter8[2],filter8[3],filter8[4],quant38);

conv cu25(rst,en,in4[0],in4[1],in4[2],in4[3],in4[4],filter1[0],filter1[1],filter1[2],filter1[3],filter1[4],quant41);
conv cu26(rst,en,in4[0],in4[1],in4[2],in4[3],in4[4],filter2[0],filter2[1],filter2[2],filter2[3],filter2[4],quant42);
conv cu27(rst,en,in4[0],in4[1],in4[2],in4[3],in4[4],filter3[0],filter3[1],filter3[2],filter3[3],filter3[4],quant43);
conv cu28(rst,en,in4[0],in4[1],in4[2],in4[3],in4[4],filter4[0],filter4[1],filter4[2],filter4[3],filter4[4],quant44);
conv cu29(rst,en,in4[0],in4[1],in4[2],in4[3],in4[4],filter5[0],filter5[1],filter5[2],filter5[3],filter5[4],quant45);
conv cu30(rst,en,in4[0],in4[1],in4[2],in4[3],in4[4],filter6[0],filter6[1],filter6[2],filter6[3],filter6[4],quant46);
conv cu31(rst,en,in4[0],in4[1],in4[2],in4[3],in4[4],filter7[0],filter7[1],filter7[2],filter7[3],filter7[4],quant47);
conv cu32(rst,en,in4[0],in4[1],in4[2],in4[3],in4[4],filter8[0],filter8[1],filter8[2],filter8[3],filter8[4],quant48);

conv cu33(rst,en,in5[0],in5[1],in5[2],in5[3],in5[4],filter1[0],filter1[1],filter1[2],filter1[3],filter1[4],quant51);
conv cu34(rst,en,in5[0],in5[1],in5[2],in5[3],in5[4],filter2[0],filter2[1],filter2[2],filter2[3],filter2[4],quant52);
conv cu35(rst,en,in5[0],in5[1],in5[2],in5[3],in5[4],filter3[0],filter3[1],filter3[2],filter3[3],filter3[4],quant53);
conv cu36(rst,en,in5[0],in5[1],in5[2],in5[3],in5[4],filter4[0],filter4[1],filter4[2],filter4[3],filter4[4],quant54);
conv cu37(rst,en,in5[0],in5[1],in5[2],in5[3],in5[4],filter5[0],filter5[1],filter5[2],filter5[3],filter5[4],quant55);
conv cu38(rst,en,in5[0],in5[1],in5[2],in5[3],in5[4],filter6[0],filter6[1],filter6[2],filter6[3],filter6[4],quant56);
conv cu39(rst,en,in5[0],in5[1],in5[2],in5[3],in5[4],filter7[0],filter7[1],filter7[2],filter7[3],filter7[4],quant57);
conv cu40(rst,en,in5[0],in5[1],in5[2],in5[3],in5[4],filter8[0],filter8[1],filter8[2],filter8[3],filter8[4],quant58);

conv cu41(rst,en,in6[0],in6[1],in6[2],in6[3],in6[4],filter1[0],filter1[1],filter1[2],filter1[3],filter1[4],quant61);
conv cu42(rst,en,in6[0],in6[1],in6[2],in6[3],in6[4],filter2[0],filter2[1],filter2[2],filter2[3],filter2[4],quant62);
conv cu43(rst,en,in6[0],in6[1],in6[2],in6[3],in6[4],filter3[0],filter3[1],filter3[2],filter3[3],filter3[4],quant63);
conv cu44(rst,en,in6[0],in6[1],in6[2],in6[3],in6[4],filter4[0],filter4[1],filter4[2],filter4[3],filter4[4],quant64);
conv cu45(rst,en,in6[0],in6[1],in6[2],in6[3],in6[4],filter5[0],filter5[1],filter5[2],filter5[3],filter5[4],quant65);
conv cu46(rst,en,in6[0],in6[1],in6[2],in6[3],in6[4],filter6[0],filter6[1],filter6[2],filter6[3],filter6[4],quant66);
conv cu47(rst,en,in6[0],in6[1],in6[2],in6[3],in6[4],filter7[0],filter7[1],filter7[2],filter7[3],filter7[4],quant67);
conv cu48(rst,en,in6[0],in6[1],in6[2],in6[3],in6[4],filter8[0],filter8[1],filter8[2],filter8[3],filter8[4],quant68);

conv cu49(rst,en,in7[0],in7[1],in7[2],in7[3],in7[4],filter1[0],filter1[1],filter1[2],filter1[3],filter1[4],quant71);
conv cu50(rst,en,in7[0],in7[1],in7[2],in7[3],in7[4],filter2[0],filter2[1],filter2[2],filter2[3],filter2[4],quant72);
conv cu51(rst,en,in7[0],in7[1],in7[2],in7[3],in7[4],filter3[0],filter3[1],filter3[2],filter3[3],filter3[4],quant73);
conv cu52(rst,en,in7[0],in7[1],in7[2],in7[3],in7[4],filter4[0],filter4[1],filter4[2],filter4[3],filter4[4],quant74);
conv cu53(rst,en,in7[0],in7[1],in7[2],in7[3],in7[4],filter5[0],filter5[1],filter5[2],filter5[3],filter5[4],quant75);
conv cu54(rst,en,in7[0],in7[1],in7[2],in7[3],in7[4],filter6[0],filter6[1],filter6[2],filter6[3],filter6[4],quant76);
conv cu55(rst,en,in7[0],in7[1],in7[2],in7[3],in7[4],filter7[0],filter7[1],filter7[2],filter7[3],filter7[4],quant77);
conv cu56(rst,en,in7[0],in7[1],in7[2],in7[3],in7[4],filter8[0],filter8[1],filter8[2],filter8[3],filter8[4],quant78);

conv cu57(rst,en,in8[0],in8[1],in8[2],in8[3],in8[4],filter1[0],filter1[1],filter1[2],filter1[3],filter1[4],quant81);
conv cu58(rst,en,in8[0],in8[1],in8[2],in8[3],in8[4],filter2[0],filter2[1],filter2[2],filter2[3],filter2[4],quant82);
conv cu59(rst,en,in8[0],in8[1],in8[2],in8[3],in8[4],filter3[0],filter3[1],filter3[2],filter3[3],filter3[4],quant83);
conv cu60(rst,en,in8[0],in8[1],in8[2],in8[3],in8[4],filter4[0],filter4[1],filter4[2],filter4[3],filter4[4],quant84);
conv cu61(rst,en,in8[0],in8[1],in8[2],in8[3],in8[4],filter5[0],filter5[1],filter5[2],filter5[3],filter5[4],quant85);
conv cu62(rst,en,in8[0],in8[1],in8[2],in8[3],in8[4],filter6[0],filter6[1],filter6[2],filter6[3],filter6[4],quant86);
conv cu63(rst,en,in8[0],in8[1],in8[2],in8[3],in8[4],filter7[0],filter7[1],filter7[2],filter7[3],filter7[4],quant87);
conv cu64(rst,en,in8[0],in8[1],in8[2],in8[3],in8[4],filter8[0],filter8[1],filter8[2],filter8[3],filter8[4],quant88);
*/
always@(*) begin
	out1=(quant11+quant21+quant31+quant41+quant51+quant61+quant71+quant81);
	out2=(quant12+quant22+quant32+quant42+quant52+quant62+quant72+quant82);
	out3=(quant13+quant23+quant33+quant43+quant53+quant63+quant73+quant83);
	out4=(quant14+quant24+quant34+quant44+quant54+quant64+quant74+quant84);
	out5=(quant15+quant25+quant35+quant45+quant55+quant65+quant75+quant85);
	out6=(quant16+quant26+quant36+quant46+quant56+quant66+quant76+quant86);
	out7=(quant17+quant27+quant37+quant47+quant57+quant67+quant77+quant87);
	out8=(quant18+quant28+quant38+quant48+quant58+quant68+quant78+quant88);
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