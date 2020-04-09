`timescale 1ns / 1ps

module tb_conv_complex();

parameter BW = 16;
parameter FRAC_BIT = 8;
parameter KERN_DIM = 5;
parameter DATA_WIDTH = 16;

parameter KERNEL_SIZE = KERN_DIM * KERN_DIM;

parameter HALF_CLK_DURATION = 5;
parameter RESET_DURATION = 18;

reg clk;
reg rstn;

reg signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] mult_weights;
reg signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] mult_pixel_data;
wire signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] mult_result;

initial begin
    clk = 'd0;
    forever #(HALF_CLK_DURATION) clk = ~clk;
end

initial begin
    rstn = 'd1;
    #(RESET_DURATION);
    rstn = 'd0;
    #(RESET_DURATION);
    rstn = 'd1;
end

integer tmp;
integer file;
initial begin
    file = $fopen("in.txt", "r");
    tmp = $fscan(file, "%d", mult_pixel_data);
end

multiplier #(.KERNEL_SIZE(KERNEL_SIZE), .DATA_WIDTH(DATA_WIDTH)) uut
    (
        .weights(r_weights),
        .pixel_data(r_pixel_data),
        .result(w_result)
    );
    


endmodule
