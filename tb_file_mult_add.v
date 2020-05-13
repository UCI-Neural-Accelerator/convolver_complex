`timescale 1ns / 1ps

module tb_file_mult_add();

parameter IMAGE_SIZE = 28;
parameter FRAC_BIT = 8;
parameter KERNEL_SIZE = 5;
parameter DATA_WIDTH = 16;

parameter HALF_CLK_DURATION = 5;
parameter RESET_DURATION = 18;

reg clk;
reg reset;

reg signed [DATA_WIDTH-1:0] tmp_pixel;

reg signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] weights;
reg signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] pixel_data;

reg signed [DATA_WIDTH-1:0] adder_bias;

wire signed [DATA_WIDTH - 1:0] out;

initial begin
    clk = 'd0;
    forever #(HALF_CLK_DURATION) clk = ~clk;
end

initial begin
    reset = 'd0;
    #(RESET_DURATION);
    reset = 'd1;
    #(RESET_DURATION);
    reset = 'd0;
end

integer tmp;
integer file;
integer index;
initial begin
    pixel_data = 'd0;
    for(index = 0; index < 25; index = index + 1) begin
        file = $fopen("in.txt", "r");
        tmp = $fscan(file, "%d", tmp_pixel);
        pixel_data[index*DATA_WIDTH +: DATA_WIDTH] = tmp_pixel;
        @(negedge clk);
    end
    
    repeat(25) @(negedge clk);
    
end

// instantiate the convolver with the loaded inputs
convolver_complex #(.DATA_WIDTH(DATA_WIDTH), .KERNEL_SIZE(KERNEL_SIZE), .FRAC_BIT(FRAC_BIT), .IMAGE_SIZE(IMAGE_SIZE)) uut
    (
        .clk(clk),
        .reset(reset),
        .write(),
        .weights_matrix(weights),
        .bias(adder_bias),
        .pixel_in(pixel_data),
        .conv_final_result(out),
		.enable_signal()
    );
    
endmodule
