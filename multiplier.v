`timescale 1ns / 1ps

module multiplier #(parameter DATA_WIDTH=16, FRAC_BIT = 8, parameter KERNEL_SIZE=5) (
    // Inputs
    input signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] weights,
    input signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] pixel_data,
    
    // Output
    output signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] result
    );
    
    //Non register register
    wire signed [DATA_WIDTH*2 - 1:0] temp;
    
    // assign multipliers
    genvar i;
    generate
        for (i = 0; i < (KERNEL_SIZE**2); i = i + 1)
        begin
            assign temp = (weights[i*DATA_WIDTH +: DATA_WIDTH]) * (pixel_data[i*DATA_WIDTH +: DATA_WIDTH]);
            assign result[i*DATA_WIDTH +: DATA_WIDTH] = {temp[DATA_WIDTH*2 - 1], temp[DATA_WIDTH + FRAC_BIT - 1:FRAC_BIT]};
        end
    endgenerate
    
endmodule
