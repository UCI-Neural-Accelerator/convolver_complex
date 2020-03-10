`timescale 1ns / 1ps
module tb_multiplier ();
    parameter DATA_WIDTH = 16;
    parameter KERNEL_SIZE = 5;
    parameter TEST_ITERATIONS = 10;
    parameter CLK_PERIOD = 20;
    parameter FRAC_BIT = 8;
    
    // Inputs
    reg signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] r_weights;
    reg signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] r_pixel_data;
    
    // Output
    wire signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] w_result;
    
    
    // Instantiate the module
    multiplier #(.KERNEL_SIZE(KERNEL_SIZE), .DATA_WIDTH(DATA_WIDTH)) uut
    (
        .weights(r_weights),
        .pixel_data(r_pixel_data),
        .result(w_result)
    );    

    integer i, j;
    reg signed [DATA_WIDTH - 1:0] a, b;
    reg signed [DATA_WIDTH*2-1:0] mult_temp;
    reg signed [DATA_WIDTH - 1:0] split_temp;

    initial
    begin
        // test iterations
        for (i = 0; i < TEST_ITERATIONS; i = i + 1)
        begin
            for (j = 0; j < (KERNEL_SIZE**2); j = j + 1)
            begin
                // drive inputs
                r_weights[j*DATA_WIDTH +: DATA_WIDTH]    = $random;
                r_pixel_data[j*DATA_WIDTH +: DATA_WIDTH] = $random;
                
                // check output
                a = r_pixel_data[j*DATA_WIDTH +: DATA_WIDTH];
                b = r_weights[j*DATA_WIDTH +: DATA_WIDTH];
                mult_temp = a * b;
                split_temp = mult_temp[DATA_WIDTH+FRAC_BIT-1:FRAC_BIT];
                
                // delay
                #(CLK_PERIOD);
                

                if (w_result[j*DATA_WIDTH +: DATA_WIDTH] == split_temp)
                begin
                    $display("Case: %d\n%b*%b=%b\nMultiplcation %d out of %d successful\n", i+1, r_weights[j*DATA_WIDTH +: DATA_WIDTH],
                    r_pixel_data[j*DATA_WIDTH +: DATA_WIDTH], mult_temp, (j + 1), (KERNEL_SIZE**2));
                end
                else
                begin
                   $display("Case: %d\n%b*%b=%b\nMultiplcation %d out of %d failed\n", i, r_weights[j*DATA_WIDTH +: DATA_WIDTH],
                   r_pixel_data[j*DATA_WIDTH +: DATA_WIDTH], mult_temp, (j + 1), (KERNEL_SIZE**2));
                end
            end 
        end
    end

endmodule
