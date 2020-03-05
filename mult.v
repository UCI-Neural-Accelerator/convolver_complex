`timescale 1ns / 1ps
module mult
#(
    parameter 
    DATA_WIDTH = 16,
    FRAC_BIT = 8
)
(
    input signed [DATA_WIDTH-1:0] pixel,
    input signed [DATA_WIDTH-1:0] weight,
    
    output signed [DATA_WIDTH-1:0] out
);
    wire signed [DATA_WIDTH*2-1:0] mult_result; //want to take the middle of this
    
    assign mult_result = pixel * weight;
    assign out = mult_result[DATA_WIDTH+FRAC_BIT-1:FRAC_BIT];

endmodule
