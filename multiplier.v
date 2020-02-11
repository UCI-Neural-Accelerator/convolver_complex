`timescale 1ns / 1ps


module multiplier #(parameter DATA_WIDTH=32, parameter KERNEL_SIZE=3) (
    // Inputs
    input [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] weights,
    input [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] pixel_data,
    
    // Output
    output [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] result
    );
    
    // assign multipliers
    genvar i;
    generate
        for (i = 0; i < (KERNEL_SIZE**2); i = i + 1)
        begin
            assign result[i*(DATA_WIDTH-1) +: DATA_WIDTH-1] = weights[i*(DATA_WIDTH-1) +: DATA_WIDTH-1] * pixel_data[i*(DATA_WIDTH-1) +: DATA_WIDTH-1];
            //assign result[(DATA_WIDTH * (i + 1)) - 1:DATA_WIDTH * i] = weights[(DATA_WIDTH * (i + 1)) - 1:DATA_WIDTH * i] * pixel_data[(DATA_WIDTH * (i + 1)) - 1:DATA_WIDTH * i];
        end
    endgenerate
    
endmodule
