`timescale 1ns / 1ps


module weight_register #(parameter bit_width = 32, parameter N = 9) (
    input write,
    input [bit_width-1:0] weight_in,
    output [bit_width-1:0] weight_out [N-1:0]
    );
    
    //temp register to hold input value 
    reg [bit_width-1:0] tmp;
    reg [bit_width-1:0] weight_reg [N-1:0];
    
    integer i;
    
    //assign temperatory weights to output
    genvar j;
    generate
        for (j = 0; j < N; j = j+1)
            begin
                assign weight_out[j] = weight_reg[j];
            end
    endgenerate
    
    //when writing, save into temperatory weight register
    always @ (write)
        begin
            for (i = 0; i < N; i = i+1) 
                begin
                    tmp[i] = weight_in;
                    weight_reg[i] = tmp;
                end
                
        end
    endmodule
    



