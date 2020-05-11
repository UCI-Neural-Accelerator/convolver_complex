`timescale 1ns / 1ps


module registers #(parameter DATA_WIDTH = 16, parameter FRAC_BIT = 8, parameter KERNEL_SIZE = 5, parameter IMAGE_SIZE = 28) (
    
    // inputs
    input clk, reset, write,
    input signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] weights,
    input signed [DATA_WIDTH - 1:0] pixel_input,
	
    // outputs
    output signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] weights_out,
    output signed [ (KERNEL_SIZE*DATA_WIDTH)- 1:0] data_out_0,
    output signed [ (KERNEL_SIZE*DATA_WIDTH)- 1:0] data_out_1,
    output signed [ (KERNEL_SIZE*DATA_WIDTH)- 1:0] data_out_2,
    output signed [ (KERNEL_SIZE*DATA_WIDTH)- 1:0] data_out_3,
    output signed [ (KERNEL_SIZE*DATA_WIDTH)- 1:0] data_out_4,
    output signed [ ((IMAGE_SIZE-KERNEL_SIZE)*DATA_WIDTH)- 1:0] data_hold_0,
    output signed [ ((IMAGE_SIZE-KERNEL_SIZE)*DATA_WIDTH)- 1:0] data_hold_1,
    output signed [ ((IMAGE_SIZE-KERNEL_SIZE)*DATA_WIDTH)- 1:0] data_hold_2,
    output signed [ ((IMAGE_SIZE-KERNEL_SIZE)*DATA_WIDTH)- 1:0] data_hold_3

    );

	wire signed [ (KERNEL_SIZE**2)*DATA_WIDTH- 1:0] w_weights_out;

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

        wire signed [ ((IMAGE_SIZE-KERNEL_SIZE)*DATA_WIDTH)- 1:0] w_data_hold_0;
        wire signed [ ((IMAGE_SIZE-KERNEL_SIZE)*DATA_WIDTH)- 1:0] w_data_hold_1;
        wire signed [ ((IMAGE_SIZE-KERNEL_SIZE)*DATA_WIDTH)- 1:0] w_data_hold_2;
        wire signed [ ((IMAGE_SIZE-KERNEL_SIZE)*DATA_WIDTH)- 1:0] w_data_hold_3;

	//assign statements
	assign weights_out = w_weights_out;
	assign data_out_0 = w_data_out_0;
	assign data_out_1 = w_data_out_1;
	assign data_out_2 = w_data_out_2;
	assign data_out_3 = w_data_out_3;
	assign data_out_4 = w_data_out_4;
	assign data_hold_0 = w_data_hold_0;
	assign data_hold_1 = w_data_hold_1;
	assign data_hold_2 = w_data_hold_2;
	assign data_hold_3 = w_data_hold_3;
    
    	weight_register #(.DATA_WIDTH(DATA_WIDTH), .N(KERNEL_SIZE**2)) weight_register_0 (
            .reset(reset),
            .clock(clk),
            .write(write),
            .weight_write(weights),
            .weight_read(w_weights_out)
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

	shift_register #(.SIZE(IMAGE_SIZE-KERNEL_SIZE), .DATA_WIDTH(DATA_WIDTH)) inter_register_0 (
			.shift_in(inter_out_0),
			.clock(clk),
			.reset(reset),
			.shift_out(inter_in_1),
			.data_out(w_data_hold_0)
		);

	shift_register #(.SIZE(IMAGE_SIZE-KERNEL_SIZE), .DATA_WIDTH(DATA_WIDTH)) inter_register_1 (
			.shift_in(inter_out_1),
			.clock(clk),
			.reset(reset),
			.shift_out(inter_in_2),
			.data_out(w_data_hold_1)
		);

	shift_register #(.SIZE(IMAGE_SIZE-KERNEL_SIZE), .DATA_WIDTH(DATA_WIDTH)) inter_register_2 (
			.shift_in(inter_out_2),
			.clock(clk),
			.reset(reset),
			.shift_out(inter_in_3),
			.data_out(w_data_hold_2)
		);

	shift_register #(.SIZE(IMAGE_SIZE-KERNEL_SIZE), .DATA_WIDTH(DATA_WIDTH)) inter_register_3 (
			.shift_in(inter_out_3),
			.clock(clk),
			.reset(reset),
			.shift_out(inter_in_4),
			.data_out(w_data_hold_3)
		);  
    
endmodule
