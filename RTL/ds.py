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
	