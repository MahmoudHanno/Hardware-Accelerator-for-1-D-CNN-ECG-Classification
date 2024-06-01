module fullyconnected (
    input  rst,clk,en,
    input signed [3:0] [7:0] in,
    output reg [1:0] outfin,
    output reg fc_flag
);

    reg signed [20:0] quant1, quant2,quant3,quant4;
    reg  [4:0] count;
    reg flag;
    reg  signed [63:0] [7:0] filter1;
    reg  signed [63:0] [7:0] filter2;
    reg  signed [63:0] [7:0] filter3;
    reg  signed [63:0] [7:0] filter4;
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            quant1 <= 0;
            quant2 <= 0;
            quant3 <= 0;
            quant4 <= 0;
            count <= 0;
            flag <= 0;
            outfin <= 0;
           
            // Filter 1
            filter1 <= '{
                -3, -58, -16, -86, 30, 20, -82, 14, 21, -25, 73, 21, 7, -35, -42, 56, 14, -51, -15, 12, 62, -50, -29, 23, 37, -15, 75, 37, -30, 117, 52, 27, 90, -18, -50, 58, 75, -82, -40, -22, -73, 7, 4, 17, -1, 57, 28, -13, 40, -14, -57, -27, 67, -12, 8, 46, -11, -10, 72, 52, -20, 126, 13, -32
                };

            // Filter 2
            filter2 <= '{
                25, -24, -8, -23, -9, -6, -22, 0, 43, 37, -57, -16, -73, 63, 71, -51, -69, -69, -34, 48, 20, 2, 44, 53, -5, -41, 27, -56, -66, 27, 9, 64, -41, -69, -37, -37, -5, 13, 3, 33, 23, 25, 3, -48, -2, -124, -15, -30, -45, -9, -34, -94, 9, -17, 57, 69, -20, 4, 69, -29, -46, 71, -86, -6
                };
             // Filter 1
            filter3 <= '{
                -65, -6, 41, -73, -8, -41, -14, 4, -8, 11, -4, 6, 14, -42, 56, 29, 0, 23, -5, -20, 59, 61, 60, -12, -61, 46, -63, -28, 29, -108, -5, -30, -43, 34, -12, -58, 29, 30, 16, 15, -60, 62, -105, -51, 57, 67, 31, -63, -15, 52, -16, -11, 34, 68, 43, -44, -56, 64, -55, 30, -26, -101, 14, -57
                };
                
            // Filter 3
            filter4 <= '{
                -23, 30, 24, 14, 1, -1, -37, -43, 27, 24, 27, 43, 57, 33, -41, 4, 50, 23, 90, 55, -99, -5, -2, 14, -6, -48, 54, -12, 57, -31, 2, 21, -3, 21, 3, 48, -113, -29, 9, -43, 77, -52, 6, 56, -18, -112, 13, 83, 75, 8, 48, 18, -24, 51, 44, -65, 56, -41, 19, 16, -23, -95, -46, 33
                };
            
        end
        else if (en) begin
            if (count <= 15  && flag == 0) begin
                quant1 <= quant1 + (in[0] * filter1[count*4+0] + (in[1] * filter1[count*4+1]) + (in[2] * filter1[count*4+2]) + (in[3] * filter1[count*4+3]));
                quant2 <= quant2 + (in[0] * filter2[count*4+0] + (in[1] * filter2[count*4+1]) + (in[2] * filter2[count*4+2]) + (in[3] * filter2[count*4+3]));
                quant3 <= quant3 + (in[0] * filter3[count*4+0] + (in[1] * filter3[count*4+1]) + (in[2] * filter3[count*4+2]) + (in[3] * filter3[count*4+3]));
                quant4 <= quant4 + (in[0] * filter4[count*4+0] + (in[1] * filter4[count*4+1]) + (in[2] * filter4[count*4+2]) + (in[3] * filter4[count*4+3]));
                count <= count + 1;
                if (count == 15) begin
                    flag <= 1;
                    count <= 0;
                end
            end
        end
        else begin
            count <= 0; // Reset count if en is low
            //quant1 <= 0;
            //quant2 <= 0;
            
        end


    end
    always @(*)begin
        if (flag) begin
            fc_flag=1;
            if (quant1 >= quant2 && quant1 >= quant3 && quant1 >= quant4) begin
                outfin = 0; //normal   
             end
             else if (quant2 >= quant3 && quant2 >= quant4) begin
                 outfin = 1;
             end
             else if ( quant3 >= quant4) begin
                 outfin = 2;
             end
            else begin
                outfin = 3; //abnormal
            end
        end
        else
            fc_flag=0;
    end
endmodule