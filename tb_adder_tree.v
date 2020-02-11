`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/11/2020 11:47:48 AM
// Design Name: 
// Module Name: tb_adder_tree
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


module tb_adder_tree();
    parameter DATA_WIDTH = 32;
    parameter CLK_PERIOD = 20;
    parameter TEST_ITERATIONS = 10;
    
    // inputs
    reg signed [DATA_WIDTH-1:0] r_data_in_0;
    reg signed [DATA_WIDTH-1:0] r_data_in_1;
    reg signed [DATA_WIDTH-1:0] r_data_in_2;
    reg signed [DATA_WIDTH-1:0] r_data_in_3;
    reg signed [DATA_WIDTH-1:0] r_data_in_4;
    reg signed [DATA_WIDTH-1:0] r_data_in_5;
    reg signed [DATA_WIDTH-1:0] r_data_in_6;
    reg signed [DATA_WIDTH-1:0] r_data_in_7;
    reg signed [DATA_WIDTH-1:0] r_data_in_8;
    reg signed [DATA_WIDTH-1:0] r_bias;
    
    // output
    wire signed [DATA_WIDTH - 1:0] w_result;
    
    
    // instantiate the adder tree
    adder_tree #(.DATA_WIDTH(DATA_WIDTH)) uut
    (
        .data_in_0(r_data_in_0),
        .data_in_1(r_data_in_1),
        .data_in_2(r_data_in_2),
        .data_in_3(r_data_in_3),
        .data_in_4(r_data_in_4),
        .data_in_5(r_data_in_5),
        .data_in_6(r_data_in_6),
        .data_in_7(r_data_in_7),
        .data_in_8(r_data_in_8),
        .bias(r_bias),
        .result(w_result)        
    );
    
    // data generation
    integer i;
    initial
    begin
        for (i = 0; i < TEST_ITERATIONS; i = i + 1)
        begin        
            // drive inputs to random values
            r_data_in_0 = $random;
            r_data_in_1 = $random;
            r_data_in_2 = $random;
            r_data_in_3 = $random;
            r_data_in_4 = $random;
            r_data_in_5 = $random;
            r_data_in_6 = $random;
            r_data_in_7 = $random;
            r_data_in_8 = $random;
            r_bias = $random;
            
            
            // delay
            #(CLK_PERIOD);
            
            if (w_result == r_data_in_0 +
                            r_data_in_1 +
                            r_data_in_2 +
                            r_data_in_3 +
                            r_data_in_4 +
                            r_data_in_5 +
                            r_data_in_6 +
                            r_data_in_7 +
                            r_data_in_8 +
                            r_bias)
            begin
                $display("Add sucessfull\n");
            end
            else
            begin
                $display("Failed to add:\n%h\n%h\n%h\n%h\n%h\n%h\n%h\n%h\n%h\n%h\n",
                            r_data_in_0,
                            r_data_in_1,
                            r_data_in_2,
                            r_data_in_3,
                            r_data_in_4,
                            r_data_in_5,
                            r_data_in_6,
                            r_data_in_7,
                            r_data_in_8,
                            r_bias);
            end
                       
        end
    end

endmodule
