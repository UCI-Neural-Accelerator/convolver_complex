`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.03.2020 11:16:34
// Design Name: 
// Module Name: tb_controlpath
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

module tb_controlpath();


    parameter DATA_WIDTH = 16;
    parameter KERNEL_SIZE = 5;
    parameter IMAGE_SIZE = 28;
    
   
    // Inputs
    reg clk;
    reg reset;
    
    // Output
    wire w_enable;
    
    
    // Instantiate the module
    controlpath #(.KERNEL_SIZE(KERNEL_SIZE), .DATA_WIDTH(DATA_WIDTH), .IMAGE_SIZE(IMAGE_SIZE)) uut
    (
        .clk(clk),
        .reset(reset),
        .enable(w_enable)
    );

    always
    begin
        clk = 0;
	#10;
	clk = 1;
	#10;
    end

    initial
    begin
	reset = 1; //It needs to be reset for working properly; counter initialization before comparison.
	#20;
        reset = 0;
    end

endmodule