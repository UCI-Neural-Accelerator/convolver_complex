`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/13/2020 11:58:53 AM
// Design Name: 
// Module Name: tb_weight_register
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


module tb_weight_register();
    parameter N = 9;
    parameter DATA_WIDTH = 16;
    parameter CLK_PERIOD = 20;
    parameter RESET_DURATION = 100;
    parameter TEST_ITERATIONS = 10;
    
    // inputs
    reg r_reset;
    reg r_clock;
    reg r_write;
    reg [(N*DATA_WIDTH)-1:0] r_weight_write;
    
    // outputs
    wire [(N*DATA_WIDTH)-1:0] w_weight_read;
    
    // instantiate the weight register
    weight_register #(.DATA_WIDTH(DATA_WIDTH), .N(N)) uut
    (
        .reset(r_reset),
        .clock(r_clock),
        .write(r_write),
        .weight_write(r_weight_write),
        .weight_read(w_weight_read)
    );
    
    // generate clock
    initial
    begin
        r_clock = 1'd0;
        forever #(CLK_PERIOD / 2) r_clock = ~r_clock;
    end
    
    // reset
    initial
    begin
        r_reset = 1'd0;
        #(RESET_DURATION);
        r_reset = 1'd1;
        #(RESET_DURATION);
        r_reset = 1'd0;
    end
    
    // data generation
    initial
    begin
        r_write = 0;
    end
    
    
    

endmodule
