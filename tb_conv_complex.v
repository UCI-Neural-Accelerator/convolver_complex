`timescale 1ns / 1ps

module tb_conv_complex();

    parameter DATA_WIDTH = 16;
    parameter FRAC_BIT = 8;
    parameter KERNEL_SIZE = 5;
    parameter IMAGE_SIZE = 28;

    // Inputs
    reg clk;
    reg reset;
    reg write;
    reg signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] r_weights_matrix;
    reg signed [DATA_WIDTH - 1:0] r_pixel_in;
    reg signed [DATA_WIDTH - 1:0] r_bias;
    
    // Output
    wire signed [DATA_WIDTH - 1:0] w_conv_final_result;
    wire w_enable_signal;
    // Outputs for verification
    //wire signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] s_weights_out;
    //wire signed [ (KERNEL_SIZE*DATA_WIDTH)- 1:0] s_data_out_0;
    //wire signed [ (KERNEL_SIZE*DATA_WIDTH)- 1:0] s_data_out_1;
    //wire signed [ (KERNEL_SIZE*DATA_WIDTH)- 1:0] s_data_out_2;
    //wire signed [ (KERNEL_SIZE*DATA_WIDTH)- 1:0] s_data_out_3;
    //wire signed [ (KERNEL_SIZE*DATA_WIDTH)- 1:0] s_data_out_4;
    //wire signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] s_mult_result;
    //wire signed [ ((IMAGE_SIZE-KERNEL_SIZE)*DATA_WIDTH)- 1:0] s_data_hold_0;
    //wire signed [ ((IMAGE_SIZE-KERNEL_SIZE)*DATA_WIDTH)- 1:0] s_data_hold_1;
    //wire signed [ ((IMAGE_SIZE-KERNEL_SIZE)*DATA_WIDTH)- 1:0] s_data_hold_2;
    //wire signed [ ((IMAGE_SIZE-KERNEL_SIZE)*DATA_WIDTH)- 1:0] s_data_hold_3;

    convolver_complex #(.DATA_WIDTH(DATA_WIDTH), .KERNEL_SIZE(KERNEL_SIZE), .FRAC_BIT(FRAC_BIT), .IMAGE_SIZE(IMAGE_SIZE)) uut (
        .clk(clk),
        .reset(reset),
	.write(write),
        .weights_matrix(r_weights_matrix),
        .pixel_in(r_pixel_in),
        .bias(r_bias),
        .conv_final_result(w_conv_final_result),
	.enable_signal(w_enable_signal)
        //.v_weights_out(s_weights_out),
        //.v_data_out_0(s_data_out_0),
        //.v_data_out_1(s_data_out_1),
        //.v_data_out_2(s_data_out_2),
        //.v_data_out_3(s_data_out_3),
        //.v_data_out_4(s_data_out_4),
        //.v_mult_result(s_mult_result),
        //.v_data_hold_0(s_data_hold_0),
        //.v_data_hold_1(s_data_hold_1),
        //.v_data_hold_2(s_data_hold_2),
        //.v_data_hold_3(s_data_hold_3)
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
	write = 0;
	#10;
        write = 1;
    end

    initial
    begin
	reset = 1;
	#5;
        reset = 0;
    end

    integer i;
    initial
    begin
    
        for ( i = 0; i < KERNEL_SIZE**2; i = i + 1)
        begin
            r_weights_matrix[i*DATA_WIDTH +: DATA_WIDTH] = 16'b00000001_10000000;  
        end
    
    end
    
    initial
    begin
        r_bias = 16'h03_00;
    end

//    integer j;
    initial
    begin

        r_pixel_in = 16'b00000001_01000000;

//        for ( j = 0; j < KERNEL_SIZE; j = j + 1)
//        begin
//            r_pixel_input = 16'b00000001_00000000;  
//        end
        
//        r_pixel_input = 16'b00000000_00000000;
 
     end

endmodule
