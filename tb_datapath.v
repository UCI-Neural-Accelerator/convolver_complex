`timescale 1ns / 1ps


module tb_datapath();

	parameter DATA_WIDTH = 16;
    parameter FRAC_BIT = 8;
    parameter KERNEL_SIZE = 5;
    parameter IMAGE_SIZE = 28;
	
//    parameter CLK_PERIOD = 20;
//    parameter TEST_ITERATIONS = 10;
//    parameter sf = 2.0 ** -8.0;
	
    // Inputs
    reg clk;
    reg reset;
    reg write;
    reg signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] r_weights;
    reg signed [DATA_WIDTH - 1:0] r_pixel_input;
    reg signed [DATA_WIDTH - 1:0] bias;
	
//    reg signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] rand_weight, rand_pixel;
//    reg signed [DATA_WIDTH - 1:0] rand_bias;
    
    // Output
    wire signed [DATA_WIDTH - 1:0] final_result;
   
    datapath #(.DATA_WIDTH(DATA_WIDTH),.KERNEL_SIZE(KERNEL_SIZE), .FRAC_BIT(FRAC_BIT)) datapath (
        .clk(clk),
        .reset(reset),
		.write(write),
        .bias(bias),
        .weights(r_weights),
        .pixel_input(r_pixel_input),
        .add_result(final_result)
    );

//        #(CLK_PERIOD / 2);        
        
//        if (final_result == 16'h3200)
//        begin
//            $display(" Successfully added. Result: %d\n", final_result * sf);
       
//        end
//        else
//        begin
//            $display("Failed to add. Result: %d\n", final_result * sf);

//        end

    initial
    begin
        clk = 0;
        write = 1;
        reset = 1;
        #100
        reset = 0;
       
        forever #20 clk = ~clk;
    
    end

    integer i;
    initial
    begin
    
        for ( i = 0; i < KERNEL_SIZE**2; i = i + 1)
        begin
            r_weights[i*DATA_WIDTH +: DATA_WIDTH] = 16'b00000001_00000000;  
        end
    
    end
    
    integer j;
    initial
    begin
    
        bias = 16'h0000;
        r_pixel_input = 16'b00000001_00000000;

//        for ( j = 0; j < KERNEL_SIZE; j = j + 1)
//        begin
//            r_pixel_input = 16'b00000001_00000000;  
//        end
        
//        r_pixel_input = 16'b00000000_00000000;
 
     end
    
endmodule