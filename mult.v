`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/21/2020 04:10:32 PM
// Design Name: 
// Module Name: mult
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
