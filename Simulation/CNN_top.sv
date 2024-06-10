import CNN_test_pkg::*;
import CNN_config_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

module top();
    bit clk;
    string path;
    int i,correct,wrong,j=0;
    reg [7:0] labels [0:2155] ;
    logic [7:0] my_label,dataset_label;
    shortreal accuracy;
    initial begin 
        clk = 0;
        forever #1 clk = ~clk;
    end 

    // Instantiate the CNNtop module and the CNN_if interface
    CNN_if CNNif(clk);
    CNNtop DUT(CNNif.rst, clk, CNNif.main_start, CNNif.seg_final);
    assign CNNif.firstmem = DUT.x1.firstmem;
    // Assign the virtual interface for UVM
    initial begin
        uvm_config_db #(virtual CNN_if)::set(null, "uvm_test_top", "CNN_IF", CNNif);
        run_test("CNN_test");

    end
    initial begin
        $readmemb("E:/CNN Final/Simulation/labels_4classes.dat", labels);
        //$sformat(path, "E:/CNN Test/Simulation/binary_final/row_%0d/binary_data.dat", 1358);
        //$readmemb(path, DUT.x1.firstmem);
    end
    // Initial block to read memory files dynamically and copy to DUT
     initial begin
        for (i = 2; i <= 2130; i = i + 1) begin
            $sformat(path, "E:/CNN Final/binary_NA_Q/row_%0d/binary_data.dat", i);
            $readmemb(path, DUT.x1.firstmem);
            delay(3047); // Custom delay between each file read (optional)
            @ (posedge CNNif.main_start) begin
                
                my_label = CNNif.seg_final;
                dataset_label = labels[j];
                check(CNNif.seg_final, labels[j],accuracy);

                j=j+1;
            end
         end
         #6094;
    end 

    task check(input logic [7:0] seg_final, input logic [7:0] label, output int accuracy);
        integer j;
        begin
            if(seg_final == label) begin
                correct = correct + 1;
            end
            else begin
                wrong = wrong + 1;
            end
            accuracy = (correct/(correct+wrong))*100.0;
            $display("Correct: %d, Wrong: %d, Total: %d", correct, wrong, correct+wrong);
        end
    endtask
    task delay(int x);
    int j;
        begin
            for(j=0;j<=x;j=j+1)begin
                #2;
            end
        end
    endtask
endmodule


//vsim -voptargs=+acc work.top
/*add wave -position insertpoint  \
sim:/top/CNNif/clk \
sim:/top/CNNif/rst \
sim:/top/CNNif/main_start \
sim:/top/DUT/x1/firstmem \
sim:/top/CNNif/seg_final \
sim:/top/labels \
sim:/top/my_label \
sim:/top/dataset_label


*/
// 4--->0
// 5--->1
// 6--->0
// 7--->0
// 8--->0
// 9--->0
// 10--->0
// 11--->0
// 1482--->0
// 1483--->0


// 3--->1
// 12--->1
//16--->1
// 19--->1
//1193--->1
// 1194--->1


