module fullyconnected (
    input  rst,clk,en,
    input signed [3:0] [7:0] in,
    output reg [1:0] outfin,
    output reg fc_flag
);

    reg signed [20:0] quant1, quant2;
    reg  [4:0] count;
    reg flag;
    reg  signed [63:0] [7:0] filter1;
    reg  signed [63:0] [7:0] filter2;
	 initial begin
		// Initialize filter values using concatenation from fc_quant.csv
            filter1 = '{43, -21, 55, -29, 82, -60, -36, -42, -23, -35, 1, 108, 65, -56, -48, -55, 41, -1, 96, -18, 34, 90, 61, -42, -98, 16, -72, 46, 65, -39, 53, -69, 96, 103, 67, 24, 63, 42, -38, 25, 70, -79, -83, 33, 84, 65, 64, 16, 103, 95, 44, -49, 3, -69, 37, -84, -74, 35, -10, -43, -17, -19, 64, 48};
            filter2 = '{58, -114, -5, -26, 93, -27, 70, 3, -5, -111, -52, -56, 77, -45, 67, 34, -12, -80, 82, 59, 14, 70, -69, 23, 62, -41, -62, -127, -1, 35, -27, 22, -98, 48, -27, 60, -88, -62, 22, 2, 103, -80, -56, -110, 47, 99, -48, 3, -62, -97, -63, -44, 65, -37, -13, -72, 74, -70, 2, 10, -75, -34, -53, -59};
            
	 end
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            quant1 <=127*16;
            quant2 <=-127*16;
            count <= 0;
            flag <= 0;
           //Data used is pre training quantization
            
            
        end
        else if (en) begin
            if (count <= 15  && flag == 0) begin
                quant1 <= quant1 + (in[0] * filter1[count*4+0] + (in[1] * filter1[count*4+1]) + (in[2] * filter1[count*4+2]) + (in[3] * filter1[count*4+3]));
                quant2 <= quant2 + (in[0] * filter2[count*4+0] + (in[1] * filter2[count*4+1]) + (in[2] * filter2[count*4+2]) + (in[3] * filter2[count*4+3]));
                count <= count + 1;
                if (count == 15) begin
                    flag <= 1;
                    count <= 0;
                end
                if (count == 14) begin
                    fc_flag <= 1;
                end
            end
        end
        else begin
            count <= 0; // Reset count if en is low
            flag <= 0;
            fc_flag<=0;
            quant1 <=127*16;
            quant2 <=-127*16;
            
        end


    end
    
    always @(*)begin
        if (flag) begin
            
            if (quant1 <= quant2) begin
                outfin = 1; //normal   
             end
             else begin
                 outfin = 0;
             end
             
        end
        else begin
            outfin=2;
        end
    end
	
endmodule