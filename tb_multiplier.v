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


module tb_multiplier #(parameter DATA_WIDTH=32, parameter KERNEL_SIZE=3) ();
    
    // Inputs
    reg [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] r_weights;
    reg [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] r_pixel_data;
    
    // Output
    wire [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] w_result;
    
    
    // Instantiate the module
    multiplier #(.KERNEL_SIZE(KERNEL_SIZE), .DATA_WIDTH(DATA_WIDTH)) mult
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
    
    initial begin
    for( i = 0; i < (KERNEL_SIZE**2); i = i + 1)
        begin
            r_weights [i*(DATA_WIDTH-1) +: DATA_WIDTH-1]  = $random;
        end
     end
   
    initial begin
    for ( j = 0; j < 100; j = 1 + j)
        begin 
            r_pixel_data [ j*(DATA_WIDTH-1) +: DATA_WIDTH-1] = $random;
            #50;
            $display("A: %d, B: %d, OUTPUT: %d", r_weights, r_pixel_data, w_result); 
        end
    end

endmodule
