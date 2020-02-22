`timescale 1ns / 1ps

module multiplier #(parameter DATA_WIDTH=16, parameter FRAC_BIT = 8, parameter KERNEL_SIZE=5) (
    // Inputs
    input signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] weights,
    input signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] pixel_data,
    
    // Output
    output signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] result
    );
    
    //Non register register
    wire signed [(KERNEL_SIZE**2)*DATA_WIDTH*2 - 1:0] temp;
    
    // assign multipliers
    /*genvar i;
    generate
        for (i = 0; i < (KERNEL_SIZE**2); i = i + 1)
        begin
            assign temp[i*DATA_WIDTH*2 +: DATA_WIDTH*2] = (weights[i*DATA_WIDTH +: DATA_WIDTH]) * (pixel_data[i*DATA_WIDTH +: DATA_WIDTH]);
            assign result[i*DATA_WIDTH +: DATA_WIDTH] = {temp[i*DATA_WIDTH*2], temp[(3/2)*DATA_WIDTH*i +: DATA_WIDTH-1]};
            //[63,62,61,60,59,58,57,56,|55,54,53,52,51,50,49,48,47,46,45,44,43,42,41,40|,39,38,37,36,35,34,33,32]
        end
    endgenerate*/
    
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
