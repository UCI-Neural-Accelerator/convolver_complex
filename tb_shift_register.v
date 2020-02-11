`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/30/2020 11:18:31 AM
// Design Name: 
// Module Name: tb_shift_register
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


module tb_shift_register #(parameter SIZE=3, parameter DATA_WIDTH=32);
    parameter CLK_PERIOD = 20;
    parameter RESET_DURATION = 100;

    // inputs
    reg [(DATA_WIDTH - 1):0] r_shift_in;
    reg r_clock;
    reg r_reset;
    // outputs
    wire [(DATA_WIDTH - 1):0] w_shift_out; 
    wire [(SIZE*DATA_WIDTH) - 1:0] w_data_out;
    
    // instantiate a shift register with the specified parameters
    shift_register #(.SIZE(SIZE), .DATA_WIDTH(DATA_WIDTH)) psr 
        (
            .shift_in(r_shift_in),
            .clock(r_clock),
            .reset(r_reset),
            .shift_out(w_shift_out),
            .data_out(w_data_out)
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
        r_reset = 1'd1;
        #(RESET_DURATION);
        r_reset = 1'd0;
        #(RESET_DURATION);
        r_reset = 1'd1;
    end
    
    // data generation    
    always
    begin
        r_shift_in = 1;
        @(negedge r_reset)
        @(negedge r_clock)
        r_shift_in = 0;
        @(negedge r_clock)
        r_shift_in = 0;
    end
    
endmodule
