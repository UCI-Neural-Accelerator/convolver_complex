`timescale 1ns / 1ps

module convolver_complex #(parameter DATA_WIDTH = 16, parameter FRAC_BIT = 8, parameter KERNEL_SIZE = 5, parameter IMAGE_SIZE = 28) (
    	input clk, reset, write,
    	input signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] weights_matrix,
    	input signed [DATA_WIDTH - 1:0] pixel_in,
    	input [DATA_WIDTH - 1:0] bias,
	
    	output wire [DATA_WIDTH-1:0] conv_final_result,
        output wire enable_signal
		
		// outputs for verification while simulating
/*     	output wire signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] v_weights_out,
		output wire signed [ (KERNEL_SIZE*DATA_WIDTH)- 1:0] v_data_out_0,
		output wire signed [ (KERNEL_SIZE*DATA_WIDTH)- 1:0] v_data_out_1,
		output wire signed [ (KERNEL_SIZE*DATA_WIDTH)- 1:0] v_data_out_2,
		output wire signed [ (KERNEL_SIZE*DATA_WIDTH)- 1:0] v_data_out_3,
		output wire signed [ (KERNEL_SIZE*DATA_WIDTH)- 1:0] v_data_out_4,
    	output wire signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] v_mult_result,
        output wire signed [ ((IMAGE_SIZE-KERNEL_SIZE)*DATA_WIDTH)- 1:0] v_data_hold_0,
        output wire signed [ ((IMAGE_SIZE-KERNEL_SIZE)*DATA_WIDTH)- 1:0] v_data_hold_1,
    	output wire signed [ ((IMAGE_SIZE-KERNEL_SIZE)*DATA_WIDTH)- 1:0] v_data_hold_2,
    	output wire signed [ ((IMAGE_SIZE-KERNEL_SIZE)*DATA_WIDTH)- 1:0] v_data_hold_3 */
    );

    datapath #(.DATA_WIDTH(DATA_WIDTH),.KERNEL_SIZE(KERNEL_SIZE), .FRAC_BIT(FRAC_BIT), .IMAGE_SIZE(IMAGE_SIZE)) datapath_unit (
        .clk(clk),
        .reset(reset),
		.write(write),
        .bias(bias),
        .weights(weights_matrix),
        .pixel_input(pixel_in),
        .add_result(conv_final_result)
/*         .weights_out(v_weights_out),
        .data_out_0(v_data_out_0),
        .data_out_1(v_data_out_1),
        .data_out_2(v_data_out_2),
        .data_out_3(v_data_out_3),
        .data_out_4(v_data_out_4),
        .mult_result(v_mult_result),
        .data_hold_0(v_data_hold_0),
        .data_hold_1(v_data_hold_1),
        .data_hold_2(v_data_hold_2),
        .data_hold_3(v_data_hold_3) */
    );
        
    controlpath #(.KERNEL_SIZE(KERNEL_SIZE), .DATA_WIDTH(DATA_WIDTH), .IMAGE_SIZE(IMAGE_SIZE)) controlpath_unit (
        .clk(clk),
        .reset(reset),
        .enable(enable_signal)
    ); 
     
endmodule
