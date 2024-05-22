import CNN_test_pkg::*;
import CNN_config_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

module top();
    bit clk;
    string path;
    int i;

    initial begin 
        clk = 0;
        forever #1 clk = ~clk;
    end 

    // Instantiate the CNNtop module and the CNN_if interface
    CNN_if CNNif(clk);
    CNNtop DUT(CNNif.rst, clk, CNNif.main_start, CNNif.seg_final);

    // Assign the virtual interface for UVM
    initial begin
        uvm_config_db #(virtual CNN_if)::set(null, "uvm_test_top", "CNN_IF", CNNif);
        run_test("CNN_test");
    end
    // Initial block to read memory files dynamically and copy to DUT
    initial begin
        for (i = 3; i <= 10; i = i + 1) begin
            $sformat(path, "E:/CNN Test/Simulation/binary_final/row_%0d/binary_data.dat", i);
            $readmemb(path, DUT.x1.firstmem);
            delay(3047); // Custom delay between each file read (optional)
         end
    end

    // Delay task
    task delay(input int n);
        integer j;
        begin
            for (j = 0; j < n; j = j + 1) begin
                #2;
            end
        end
    endtask
endmodule


//vsim -voptargs=+acc work.top


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


//Test