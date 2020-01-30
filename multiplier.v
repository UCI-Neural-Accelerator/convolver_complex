`timescale 1ns / 1ps


module multiplier#(parameter data_width = 32, parameter N = 9,
parameter kernel = 2) (

    input [31:0] weights [N-1:0],
    input [31:0] PSR_0 [kernel:0],
    input [31:0] PSR_1 [kernel:0],
    input [31:0] PSR_2 [kernel:0],
    
    output [31:0] mult_result [N-1:0]
    );
    
    
    
    genvar i;
    generate
        for (i = 0; i < kernel; i = i+1)
            begin
                assign mult_result[kernel] = weights[kernel] * PSR_0[2-kernel];
                assign mult_result[kernel+3] = weights[kernel+3] * PSR_1[2-kernel];
                assign mult_result[kernel+6] = weights[kernel+6] * PSR_2[2-kernel];
            end
    endgenerate
    
endmodule
