`timescale 1ns / 1ps
module tb_mult ();
    parameter DATA_WIDTH = 16;
    parameter TEST_ITERATIONS = 10;
    parameter CLK_PERIOD = 20;
    parameter FRAC_BIT = 8;
    
    // Inputs
    reg signed [DATA_WIDTH - 1:0] r_weight;
    reg signed [DATA_WIDTH - 1:0] r_pixel;
    
    // Output
    wire signed [DATA_WIDTH - 1:0] w_result;
    
    
    // Instantiate the module
    mult #(.DATA_WIDTH(DATA_WIDTH), .FRAC_BIT(FRAC_BIT)) multiplier (
        .pixel(r_pixel),
        .weight(r_weight),
        .out(w_result)
    );   

    integer i;
    reg signed [DATA_WIDTH - 1:0] a, b;
    reg signed [DATA_WIDTH*2-1:0] mult_temp;
    reg signed [DATA_WIDTH - 1:0] split_temp;

    initial
    begin
        // test iterations
        for (i = 0; i < TEST_ITERATIONS; i = i + 1)
        begin
            // drive inputs
            r_weight = $random;
            r_pixel = $random;

            
            // check output
            a = r_pixel;
            b = r_weight;
            mult_temp = a * b;
            split_temp = mult_temp[DATA_WIDTH+FRAC_BIT-1:FRAC_BIT];
            
            #(CLK_PERIOD);
            $display("Hardware output: %b\nExpected output: %b\n", w_result, split_temp);

        end
    end

endmodule
