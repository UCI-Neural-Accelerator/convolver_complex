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


module tb_shift_register();

    parameter SIZE = 5;
    parameter DATA_WIDTH = 16;
    parameter CLK_PERIOD = 20;
    parameter RESET_DURATION = 100;
    parameter TEST_ITERATIONS = 10;

    // inputs
    reg [(DATA_WIDTH - 1):0] r_shift_in;
    reg r_clock;
    reg r_reset;
    // outputs
    wire [(DATA_WIDTH - 1):0] w_shift_out; 
    wire [(SIZE*DATA_WIDTH) - 1:0] w_data_out;
    
    // instantiate a shift register with the specified parameters
    shift_register #(.SIZE(SIZE), .DATA_WIDTH(DATA_WIDTH)) uut 
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
        r_reset = 1'd0;
        #(RESET_DURATION);
        r_reset = 1'd1;
        #(RESET_DURATION);
        r_reset = 1'd0;
    end
    
    // data generation
    integer i; 
    initial
    begin
        r_shift_in = 0;
        
        // wait for reset
        @(negedge r_reset);
        
        // repeat test multiple times
        for (i = 0; i < TEST_ITERATIONS; i = i + 1)
        begin
            // generate random input to shift in
            r_shift_in = $random;
            
            // wait for shift
            @(negedge r_clock);
            
            // check if the correct value was shifted in
            if (w_data_out[DATA_WIDTH - 1:0] == r_shift_in)
            begin
                $display("Sucessfully shifted %h\n", r_shift_in);
            end
            else
            begin
                $display("Failed to shift %h\n", r_shift_in);
            end
        end
    end
    
endmodule
