`timescale 1ns / 1ps

module tb_file_mult_add();

parameter IMAGE_SIZE = 28;
parameter KERNEL_SIZE = 5;
parameter DATA_WIDTH = 16;
parameter FRAC_BIT = 8;

parameter HALF_CLK_DURATION = 10;
parameter RESET_DURATION = 20;

reg clk;
reg reset;
reg write;

reg signed [DATA_WIDTH - 1:0] tmp_weight;

reg signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] in_weights;
reg signed [DATA_WIDTH - 1:0] in_pixel_data;
reg signed [DATA_WIDTH-1:0] in_adder_bias;

wire signed [DATA_WIDTH - 1:0] out_result;
wire signed out_enable;

initial begin
    clk = 'd0;
    forever #(HALF_CLK_DURATION) clk = ~clk;
end

initial begin
    reset = 'd1;
    #(RESET_DURATION);
    reset = 'd0;
end

initial begin
    write = 'd0;
    #(HALF_CLK_DURATION);
    write = 'd1;
end

//APPROACH IN CASE THE FILE WITH THE WEIGHTS IS ONLY ONE ROW WITH ALL OF THEM CONCATENATED
/*integer file;
initial begin
        file = $fopen("input_weights.txt", "r"); //opens the text file in read mode
        $fscanf(file, "%b\n", in_weights); //file, format, argument
end*/

//APPROACH IN CASE THE FILE WITH THE WEIGHTS HAS KERNEL_SIZE**2 ROWS WITH ONE VALUE EACH
integer file_weights;
integer index;
initial begin
    file_weights = $fopen("input_weights.txt", "r");
    for(index = 0; index < (KERNEL_SIZE**2); index = index + 1) begin
        $fscanf(file_weights, "%b\n", tmp_weight);
        in_weights[index*DATA_WIDTH +: DATA_WIDTH] = tmp_weight;
    end
end

//APPROACH FOR THE FILE OF IMAGE_SIZE*IMAGE_SIZE ROWS WITH ALL THE IMAGE PIXELS
integer file_pixels;
integer index2;
initial begin
    file_pixels = $fopen("input_pixels.txt", "r");
    for(index2 = 0; index2 < (IMAGE_SIZE*IMAGE_SIZE); index2 = index2 + 1) begin
        $fscanf(file_pixels, "%b\n", in_pixel_data);
        @(posedge clk);
    end  
end

integer file_bias;
initial begin
        file_bias = $fopen("input_bias.txt", "r");
        $fscanf(file_bias, "%b\n", in_adder_bias);
end

//instantiate the convolver with the loaded inputs and weights
convolver_complex #(.DATA_WIDTH(DATA_WIDTH), .KERNEL_SIZE(KERNEL_SIZE), .FRAC_BIT(FRAC_BIT), .IMAGE_SIZE(IMAGE_SIZE)) uut
    (
        .clk(clk),
        .reset(reset),
        .write(write),
        .weights_matrix(in_weights),
        .bias(in_adder_bias),
        .pixel_in(in_pixel_data),
        .conv_final_result(out_result),
	.enable_signal(out_enable)
    );

//save the outputs of the convolutions for making the comparison
integer file_output;
initial begin
	file_output = $fopen("output_convolver.txt", "w"); //opens the text file in write mode
end
always begin
 	@(posedge clk);
	if (out_enable) $fwrite(file_output, "%b\n", out_result); //file, format, argument
end

endmodule
