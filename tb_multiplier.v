`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/06/2020 09:13:21 PM
// Design Name: 
// Module Name: tb_multiplier
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_multiplier ();
    parameter DATA_WIDTH = 32;
    parameter KERNEL_SIZE = 3;
    parameter TEST_ITERATIONS = 10;
    parameter CLK_PERIOD = 20;
    
    // Inputs
    reg [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] r_weights;
    reg [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] r_pixel_data;
    
    // Output
    wire [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] w_result;
    
    
    // Instantiate the module
    multiplier #(.KERNEL_SIZE(KERNEL_SIZE), .DATA_WIDTH(DATA_WIDTH)) uut
    (
        .weights(r_weights),
        .pixel_data(r_pixel_data),
        .result(w_result)
    );    
    
//    reg [DATA_WIDTH - 1:0] a;
//    reg [DATA_WIDTH - 1:0] b;
    
//    assign r_weights = a;
//    assign r_pixel_data = b;

    integer i, j;
    initial
    begin
        // test iterations
        for (i = 0; i < TEST_ITERATIONS; i = i + 1)
        begin
            for (j = 0; j < (KERNEL_SIZE**2); j = j + 1)
            begin
                // drive inputs
                r_weights[j*DATA_WIDTH +: DATA_WIDTH] = $random;
                r_pixel_data[j*DATA_WIDTH +: DATA_WIDTH] = $random;
                
                // delay
                #(CLK_PERIOD);
                
                // check output
                if (w_result[j*DATA_WIDTH +: DATA_WIDTH] == r_weights[j*DATA_WIDTH +: DATA_WIDTH] * r_pixel_data[j*DATA_WIDTH +: DATA_WIDTH])
                begin
                    $display("Case: %d\nMultiplcation %d out of %d successful\n", i, (j + 1), (KERNEL_SIZE**2));
                end
                else
                begin
                    $display("Case: %d\nMultiplcation %d out of %d failed\n", i, (j + 1), (KERNEL_SIZE**2));
                end
            end 
        end
    end

endmodule
