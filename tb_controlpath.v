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
    
    // Output
    wire w_enable;
    
    
    // Instantiate the module
    controlpath #(.KERNEL_SIZE(KERNEL_SIZE), .DATA_WIDTH(DATA_WIDTH), .IMAGE_SIZE(IMAGE_SIZE)) uut
    (
        .clk(clk),
        .reset(),
        .enable(w_enable)
    );

    initial
    begin
        clk = 0;
        forever #20 clk = ~clk;
    end

endmodule