interface CNN_if(input clk);
    /*
   input rst,main_start,clk;
output [7:0] seg_final;
*/
logic rst;
logic main_start;
logic signed [7:0] firstmem [0:2503] ;
logic [7:0] seg_final;

endinterface : CNN_if