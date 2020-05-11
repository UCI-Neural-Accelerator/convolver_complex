`timescale 1ns / 1ps

module tb_registers();

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
    
    // Output
    wire signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] w_weights_out;
    wire signed [ (KERNEL_SIZE*DATA_WIDTH)- 1:0] w_data_out_0;
    wire signed [ (KERNEL_SIZE*DATA_WIDTH)- 1:0] w_data_out_1;
    wire signed [ (KERNEL_SIZE*DATA_WIDTH)- 1:0] w_data_out_2;
    wire signed [ (KERNEL_SIZE*DATA_WIDTH)- 1:0] w_data_out_3;
    wire signed [ (KERNEL_SIZE*DATA_WIDTH)- 1:0] w_data_out_4;
    wire signed [ ((IMAGE_SIZE-KERNEL_SIZE)*DATA_WIDTH)- 1:0] w_data_hold_0;
    wire signed [ ((IMAGE_SIZE-KERNEL_SIZE)*DATA_WIDTH)- 1:0] w_data_hold_1;
    wire signed [ ((IMAGE_SIZE-KERNEL_SIZE)*DATA_WIDTH)- 1:0] w_data_hold_2;
    wire signed [ ((IMAGE_SIZE-KERNEL_SIZE)*DATA_WIDTH)- 1:0] w_data_hold_3;
   
    registers #(.DATA_WIDTH(DATA_WIDTH),.KERNEL_SIZE(KERNEL_SIZE), .FRAC_BIT(FRAC_BIT)) registers_0 (
        .clk(clk),
        .reset(reset),
	.write(write),
        .weights(r_weights),
        .pixel_input(r_pixel_input),
        .weights_out(w_weights_out),
        .data_out_0(w_data_out_0),
        .data_out_1(w_data_out_1),
        .data_out_2(w_data_out_2),
        .data_out_3(w_data_out_3),
        .data_out_4(w_data_out_4),
        .data_hold_0(w_data_hold_0),
        .data_hold_1(w_data_hold_1),
        .data_hold_2(w_data_hold_2),
        .data_hold_3(w_data_hold_3)
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
	reset = 1;
	#100;
        reset = 0;
    end

    initial
    begin
        write = 0;
	#200;
        write = 1;
    end

    integer i;
    initial
    begin
    
        for ( i = 0; i < KERNEL_SIZE**2; i = i + 1)
        begin
            r_weights[i*DATA_WIDTH +: DATA_WIDTH] = 16'b00000001_00000000;  
        end
    
    end
    
    always
    begin
        r_pixel_input = 16'b00000001_00000000;
	#20;
        r_pixel_input = 16'b00000010_00000000;
	#20;
        r_pixel_input = 16'b00000011_00000000;
	#20;
        r_pixel_input = 16'b00000100_00000000;
	#20;
        r_pixel_input = 16'b00000101_00000000;
	#20;
        r_pixel_input = 16'b00000110_00000000;
	#20;
        r_pixel_input = 16'b00000111_00000000;
	#20;
        r_pixel_input = 16'b00001000_00000000;
	#20;
        r_pixel_input = 16'b00001001_00000000;
	#20;
 
     end
    
endmodule
