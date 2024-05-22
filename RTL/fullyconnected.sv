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
            quant1 <= 127;
            quant2 <= -127;
            count <= 0;
            flag <= 0;
            outfin <= 0;
           
            // Initialize filter values using concatenation from fc_quant.csv
    filter1 = '{29, 77, -58, -62, 42, 101, 127, 61,
                 -16, 58, -19, 117, 94, 120, -82, -91,
                  -103, 69, 67, -76, -36, -63, 61, 77,
                   21, -76, -16, 80, -33, 65, 51, 32, 
                   -3, 8, 33, -20, -46, 111, 60, 17, 
                   -57, -59, 12, 121, 73, -58, -104, 
                   -14, -78, 79, 72, -6, 64, 100, 39,
                    107, -3, 51, 39, -47, 69, -3, -15, 13};

    filter2 = '{6, -24, -97, 4, 90, -107, -52, 
                -46, 57, 84, -43, 4, -67, -36, 
                93, 69, 77, -99, 36, 1, 90, -105, 
                -73, 40, -73, -63, 84, -70, -14, 
                -31, 33, 12, 89, -95, -5, 115, 7, 
                28, -9, -22, -97, -66, 8, -28, -91, 
                -88, -34, 89, 0, -106, -30, 32, 11, 
                -94, 53, -54, -121, -37, 70, -104, 
                19, -34, -16, 119};
            
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
            end
        end
        else begin
            count <= 0; // Reset count if en is low
            flag <= 0;
            quant1 <= 0;
            quant2 <= 0;
            
        end


    end
    always @(*)begin
        if (flag) begin
            fc_flag=1;
            if (quant1 >= quant2) begin
                outfin = 0; //normal   
             end
             else begin
                 outfin = 1;
             end
        end
        else
            fc_flag=0;
    end
endmodule