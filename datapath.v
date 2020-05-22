`timescale 1ns / 1ps

module datapath #(parameter DATA_WIDTH = 16, parameter FRAC_BIT = 8, parameter KERNEL_SIZE = 5, parameter IMAGE_SIZE = 28) (
    
    	// inputs
    	input clk, reset, write,
    	input signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] weights,
    	input signed [DATA_WIDTH - 1:0] pixel_input,
    	input [DATA_WIDTH - 1:0] bias,
	
    	// outputs
    	output signed [DATA_WIDTH-1:0] add_result,
	// outputs for verification
	output signed [ (KERNEL_SIZE*DATA_WIDTH)- 1:0] data_out_0,
	output signed [ (KERNEL_SIZE*DATA_WIDTH)- 1:0] data_out_1,
	output signed [ (KERNEL_SIZE*DATA_WIDTH)- 1:0] data_out_2,
	output signed [ (KERNEL_SIZE*DATA_WIDTH)- 1:0] data_out_3,
	output signed [ (KERNEL_SIZE*DATA_WIDTH)- 1:0] data_out_4,
    	output signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] weights_out,
    	output signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] mult_result,
        output wire signed [ ((IMAGE_SIZE-KERNEL_SIZE)*DATA_WIDTH)- 1:0] data_hold_0,
        output wire signed [ ((IMAGE_SIZE-KERNEL_SIZE)*DATA_WIDTH)- 1:0] data_hold_1,
    	output wire signed [ ((IMAGE_SIZE-KERNEL_SIZE)*DATA_WIDTH)- 1:0] data_hold_2,
    	output wire signed [ ((IMAGE_SIZE-KERNEL_SIZE)*DATA_WIDTH)- 1:0] data_hold_3
    );
    
	// wires of the shift registers connected to multiplier
	wire signed [ (KERNEL_SIZE*DATA_WIDTH)- 1:0] w_data_out_0;
	wire signed [ (KERNEL_SIZE*DATA_WIDTH)- 1:0] w_data_out_1;
	wire signed [ (KERNEL_SIZE*DATA_WIDTH)- 1:0] w_data_out_2;
	wire signed [ (KERNEL_SIZE*DATA_WIDTH)- 1:0] w_data_out_3;
	wire signed [ (KERNEL_SIZE*DATA_WIDTH)- 1:0] w_data_out_4;

	// wires of the intermediate shift registers
	wire signed [DATA_WIDTH - 1:0] inter_out_0;
	wire signed [DATA_WIDTH - 1:0] inter_in_1;
	wire signed [DATA_WIDTH - 1:0] inter_out_1;
	wire signed [DATA_WIDTH - 1:0] inter_in_2;
	wire signed [DATA_WIDTH - 1:0] inter_out_2;
	wire signed [DATA_WIDTH - 1:0] inter_in_3;
	wire signed [DATA_WIDTH - 1:0] inter_out_3;
	wire signed [DATA_WIDTH - 1:0] inter_in_4;

    	wire signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] inter_weights;
    	wire signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] pixel_data;	
    	wire signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] m_result;
      
    	// concatenate shift register outputs for multiplier unit
    	assign pixel_data = {w_data_out_4, w_data_out_3, w_data_out_2, w_data_out_1, w_data_out_0};

	// assign for verification
	assign weights_out = inter_weights;
	assign data_out_0 = w_data_out_0;
	assign data_out_1 = w_data_out_1;
	assign data_out_2 = w_data_out_2;
	assign data_out_3 = w_data_out_3;
	assign data_out_4 = w_data_out_4;
	assign mult_result = m_result;

	parameter INTER_SIZE = (IMAGE_SIZE - KERNEL_SIZE);
    
    	weight_register #(.DATA_WIDTH(DATA_WIDTH), .N(KERNEL_SIZE**2)) weight_register_0 (
            .reset(reset),
            .clock(clk),
            .write(write),
            .weight_write(weights),
            .weight_read(inter_weights)
        );

	shift_register #(.SIZE(KERNEL_SIZE), .DATA_WIDTH(DATA_WIDTH)) shift_register_0 (
			.shift_in(pixel_input),
			.clock(clk),
			.reset(reset),
			.shift_out(inter_out_0),
			.data_out(w_data_out_0)
		);
		
	shift_register #(.SIZE(KERNEL_SIZE), .DATA_WIDTH(DATA_WIDTH)) shift_register_1 (
			.shift_in(inter_in_1),
			.clock(clk),
			.reset(reset),
			.shift_out(inter_out_1),
			.data_out(w_data_out_1)
		);

	shift_register #(.SIZE(KERNEL_SIZE), .DATA_WIDTH(DATA_WIDTH)) shift_register_2 (
			.shift_in(inter_in_2),
			.clock(clk),
			.reset(reset),
			.shift_out(inter_out_2),
			.data_out(w_data_out_2)
		);

	shift_register #(.SIZE(KERNEL_SIZE), .DATA_WIDTH(DATA_WIDTH)) shift_register_3 (
			.shift_in(inter_in_3),
			.clock(clk),
			.reset(reset),
			.shift_out(inter_out_3),
			.data_out(w_data_out_3)
		);

	shift_register #(.SIZE(KERNEL_SIZE), .DATA_WIDTH(DATA_WIDTH)) shift_register_4 (
			.shift_in(inter_in_4),
			.clock(clk),
			.reset(reset),
			.shift_out(),
			.data_out(w_data_out_4)
		);

	shift_register #(.SIZE(INTER_SIZE), .DATA_WIDTH(DATA_WIDTH)) inter_register_0 (
			.shift_in(inter_out_0),
			.clock(clk),
			.reset(reset),
			.shift_out(inter_in_1),
			.data_out(data_hold_0)
		);

	shift_register #(.SIZE(INTER_SIZE), .DATA_WIDTH(DATA_WIDTH)) inter_register_1 (
			.shift_in(inter_out_1),
			.clock(clk),
			.reset(reset),
			.shift_out(inter_in_2),
			.data_out(data_hold_1)
		);

	shift_register #(.SIZE(INTER_SIZE), .DATA_WIDTH(DATA_WIDTH)) inter_register_2 (
			.shift_in(inter_out_2),
			.clock(clk),
			.reset(reset),
			.shift_out(inter_in_3),
			.data_out(data_hold_2)
		);

	shift_register #(.SIZE(INTER_SIZE), .DATA_WIDTH(DATA_WIDTH)) inter_register_3 (
			.shift_in(inter_out_3),
			.clock(clk),
			.reset(reset),
			.shift_out(inter_in_4),
			.data_out(data_hold_3)
		);
		
        
     	multiplier #(.FRAC_BIT(FRAC_BIT), .DATA_WIDTH(DATA_WIDTH), .KERNEL_SIZE(KERNEL_SIZE)) multiplier_0 (
            	.weights(inter_weights),
            	.pixel_data(pixel_data),
			
            	.result(m_result)
        );
     
    	adder_tree #(.DATA_WIDTH(DATA_WIDTH)) adder_tree_0 (
        	.data_in_0( m_result[0*DATA_WIDTH +: DATA_WIDTH] ),
        	.data_in_1( m_result[1*DATA_WIDTH +: DATA_WIDTH] ),
        	.data_in_2( m_result[2*DATA_WIDTH +: DATA_WIDTH] ),
        	.data_in_3( m_result[3*DATA_WIDTH +: DATA_WIDTH] ),
        	.data_in_4( m_result[4*DATA_WIDTH +: DATA_WIDTH] ),
        	.data_in_5( m_result[5*DATA_WIDTH +: DATA_WIDTH] ),
        	.data_in_6( m_result[6*DATA_WIDTH +: DATA_WIDTH] ),
        	.data_in_7( m_result[7*DATA_WIDTH +: DATA_WIDTH] ),
        	.data_in_8( m_result[8*DATA_WIDTH +: DATA_WIDTH] ),
        	.data_in_9( m_result[9*DATA_WIDTH +: DATA_WIDTH] ),
        	.data_in_10( m_result[10*DATA_WIDTH +: DATA_WIDTH] ),
        	.data_in_11( m_result[11*DATA_WIDTH +: DATA_WIDTH] ),
        	.data_in_12( m_result[12*DATA_WIDTH +: DATA_WIDTH] ),
        	.data_in_13( m_result[13*DATA_WIDTH +: DATA_WIDTH] ),
        	.data_in_14( m_result[14*DATA_WIDTH +: DATA_WIDTH] ),
        	.data_in_15( m_result[15*DATA_WIDTH +: DATA_WIDTH] ),
        	.data_in_16( m_result[16*DATA_WIDTH +: DATA_WIDTH] ),
        	.data_in_17( m_result[17*DATA_WIDTH +: DATA_WIDTH] ),
        	.data_in_18( m_result[18*DATA_WIDTH +: DATA_WIDTH] ),
        	.data_in_19( m_result[19*DATA_WIDTH +: DATA_WIDTH] ),
        	.data_in_20( m_result[20*DATA_WIDTH +: DATA_WIDTH] ),
        	.data_in_21( m_result[21*DATA_WIDTH +: DATA_WIDTH] ),
        	.data_in_22( m_result[22*DATA_WIDTH +: DATA_WIDTH] ),
        	.data_in_23( m_result[23*DATA_WIDTH +: DATA_WIDTH] ),
        	.data_in_24( m_result[24*DATA_WIDTH +: DATA_WIDTH] ),
        	.bias(bias),
		
        	.result(add_result)        
        );  
    
endmodule