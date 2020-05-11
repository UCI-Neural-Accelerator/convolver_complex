`timescale 1ns / 1ps

module tb_datapath();

    parameter DATA_WIDTH = 16;
    parameter FRAC_BIT = 8;
    parameter KERNEL_SIZE = 5;
    parameter IMAGE_SIZE = 28;
	
    // Inputs
    reg clk;
    reg reset;
    reg write;
    reg signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] r_weights;
    reg signed [DATA_WIDTH - 1:0] r_pixel_input;
    reg signed [DATA_WIDTH - 1:0] r_bias;
    
    // Output
    wire signed [DATA_WIDTH - 1:0] final_result;
    // Outputs for verification
    wire signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] s_weights_out;
    wire signed [ (KERNEL_SIZE*DATA_WIDTH)- 1:0] s_data_out_0;
    wire signed [ (KERNEL_SIZE*DATA_WIDTH)- 1:0] s_data_out_1;
    wire signed [ (KERNEL_SIZE*DATA_WIDTH)- 1:0] s_data_out_2;
    wire signed [ (KERNEL_SIZE*DATA_WIDTH)- 1:0] s_data_out_3;
    wire signed [ (KERNEL_SIZE*DATA_WIDTH)- 1:0] s_data_out_4;
    wire signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] s_mult_result;
   
    datapath #(.DATA_WIDTH(DATA_WIDTH),.KERNEL_SIZE(KERNEL_SIZE), .FRAC_BIT(FRAC_BIT)) datapath (
        .clk(clk),
        .reset(reset),
	.write(write),
        .bias(r_bias),
        .weights(r_weights),
        .pixel_input(r_pixel_input),
        .add_result(final_result),
        .weights_out(s_weights_out),
        .data_out_0(s_data_out_0),
        .data_out_1(s_data_out_1),
        .data_out_2(s_data_out_2),
        .data_out_3(s_data_out_3),
        .data_out_4(s_data_out_4),
        .mult_result(s_mult_result)
    );

    always
    begin
        clk = 0;
	#10;
	clk = 1;
	#10;
    end

    initial
    begin
        write = 1;
    end

    initial
    begin
        reset = 0;
    end

    integer i;
    initial
    begin
    
        for ( i = 0; i < KERNEL_SIZE**2; i = i + 1)
        begin
            r_weights[i*DATA_WIDTH +: DATA_WIDTH] = 16'b00000001_10000000;  
        end
    
    end
    
    initial
    begin
        r_bias = 16'h0000;
    end

//    integer j;
    initial
    begin

        r_pixel_input = 16'b00000001_10000000;

//        for ( j = 0; j < KERNEL_SIZE; j = j + 1)
//        begin
//            r_pixel_input = 16'b00000001_00000000;  
//        end
        
//        r_pixel_input = 16'b00000000_00000000;
 
     end
    
endmodule