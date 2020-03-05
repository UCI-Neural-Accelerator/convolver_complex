`timescale 1ns / 1ps
module multiplier #(parameter DATA_WIDTH=16, parameter FRAC_BIT = 8, parameter KERNEL_SIZE=5) (
    // Inputs
    input signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] weights,
    input signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] pixel_data,
    
    // Output
    output signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] result
    );

    //generate instances of mult's
    genvar i;
    generate
        for(i = 0; i < (KERNEL_SIZE**2); i = i + 1) begin: mult
        mult
        #(
            .DATA_WIDTH(DATA_WIDTH),
            .FRAC_BIT(FRAC_BIT)
        )
        mult_unit(
            .pixel(pixel_data[i*DATA_WIDTH +: DATA_WIDTH]),
            .weight(weights[i*DATA_WIDTH +: DATA_WIDTH]),
            
            .out(result[i*DATA_WIDTH +: DATA_WIDTH])
        );
        end
    endgenerate  
endmodule
