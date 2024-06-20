module RELU #(parameter WIDTH = 8)
(
    input signed [WIDTH-1:0] Data_in,
    output [WIDTH-1:0] Data_out
);
    assign Data_out = (Data_in < 0) ? {WIDTH{1'b0}} : Data_in[WIDTH-1:0];
endmodule
