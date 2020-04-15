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

    parameter N = 25;
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
    
    // Non-reg register
    reg [DATA_WIDTH-1:0] rand [N-1:0];
    
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
    integer i, j;
    initial
    begin
        r_write = 0;
        
        // wait for reset
        @(negedge r_reset);
        
        // check reset value here
        if (w_weight_read == {N*DATA_WIDTH{1'b0}})
        begin
            $display("Reset successfull.\n");
        end
        else
        begin
            $display("Reset failed.\n");
        end
        
        for (i = 0; i < TEST_ITERATIONS; i = i + 1)
        begin
        
            // enable write
            r_write = 1;
            
            // drive write inputs
            for (j = 0; j < N; j = j + 1)
            begin
                rand[j] = $random;
                r_weight_write[j*DATA_WIDTH +: DATA_WIDTH] = rand[j];
            end
            
            // wait for clock
            @(negedge r_clock);
            
            // check output has changed
                if (w_weight_read == {N*DATA_WIDTH{1'b0}})
                begin
                    $display("Write failed.\n");
                end
                else
                begin
                    $display("Write successfull.\n");
                end
                            
            // disable write
            r_write = 0;
            
            // wait for clock
            @(negedge r_clock);
            
            // check output has not changed
        
        end
        
    end
   

endmodule
