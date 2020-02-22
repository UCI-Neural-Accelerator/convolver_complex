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
    parameter DATA_WIDTH = 16;
    parameter CLK_PERIOD = 20;
    parameter TEST_ITERATIONS = 10;
    parameter sf = 2.0 ** -8.0;
    
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
    reg signed [DATA_WIDTH-1:0] r_data_in_9;
    reg signed [DATA_WIDTH-1:0] r_data_in_10;
    reg signed [DATA_WIDTH-1:0] r_data_in_11;
    reg signed [DATA_WIDTH-1:0] r_data_in_12;
    reg signed [DATA_WIDTH-1:0] r_data_in_13;
    reg signed [DATA_WIDTH-1:0] r_data_in_14;
    reg signed [DATA_WIDTH-1:0] r_data_in_15;
    reg signed [DATA_WIDTH-1:0] r_data_in_16;
    reg signed [DATA_WIDTH-1:0] r_data_in_17;
    reg signed [DATA_WIDTH-1:0] r_data_in_18;
    reg signed [DATA_WIDTH-1:0] r_data_in_19;
    reg signed [DATA_WIDTH-1:0] r_data_in_20;
    reg signed [DATA_WIDTH-1:0] r_data_in_21;
    reg signed [DATA_WIDTH-1:0] r_data_in_22;
    reg signed [DATA_WIDTH-1:0] r_data_in_23;
    reg signed [DATA_WIDTH-1:0] r_data_in_24;
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
        .data_in_9(r_data_in_9),
        .data_in_10(r_data_in_10),
        .data_in_11(r_data_in_11),
        .data_in_12(r_data_in_12),
        .data_in_13(r_data_in_13),
        .data_in_14(r_data_in_14),
        .data_in_15(r_data_in_15),
        .data_in_16(r_data_in_16),
        .data_in_17(r_data_in_17),
        .data_in_18(r_data_in_18),
        .data_in_19(r_data_in_19),
        .data_in_20(r_data_in_20),
        .data_in_21(r_data_in_21),
        .data_in_22(r_data_in_22),
        .data_in_23(r_data_in_23),
        .data_in_24(r_data_in_24),
        .bias(r_bias),
        .result(w_result)        
    );
    
    reg signed [DATA_WIDTH - 1:0] result;

    // data generation
    integer i;
    initial
    begin
        for (i = 0; i < TEST_ITERATIONS; i = i + 1)
        begin        
            // drive inputs to random
            r_data_in_0 = $random;
            r_data_in_1 = $random;
            r_data_in_2 = $random;
            r_data_in_3 = $random;
            r_data_in_4 = $random;
            r_data_in_5 = $random;
            r_data_in_6 = $random;
            r_data_in_7 = $random;
            r_data_in_8 = $random;
            r_data_in_9 = $random;
            r_data_in_10 = $random;
            r_data_in_11 = $random;
            r_data_in_12 = $random;
            r_data_in_13 = $random;
            r_data_in_14 = $random;
            r_data_in_15 = $random;
            r_data_in_16 = $random;
            r_data_in_17 = $random;
            r_data_in_18 = $random;
            r_data_in_19 = $random;
            r_data_in_20 = $random;
            r_data_in_21 = $random;
            r_data_in_22 = $random;
            r_data_in_23 = $random;
            r_data_in_24 = $random;
            r_bias = $random;
            
            result = r_data_in_0 + r_data_in_1 + r_data_in_2 + r_data_in_3 + 
            r_data_in_4 + r_data_in_5 + r_data_in_6 + r_data_in_7 + r_data_in_8 + 
            r_data_in_9 + r_data_in_10 + r_data_in_11 + r_data_in_12 + r_data_in_13 + 
            r_data_in_14 + r_data_in_15 + r_data_in_16 + r_data_in_17 + r_data_in_18 + 
            r_data_in_19 + r_data_in_20 + r_data_in_21 + r_data_in_22 + r_data_in_23 + r_data_in_24 + r_bias;

            // delay
            #(CLK_PERIOD);
            
            if (w_result == result)
            begin
                $display("Iteration%d: Successfully added\n", i);
                /*$display("Iteration%d: Successfully added:;\n%f \n%f \n%f \n%f \n%f \n%f \n%f \n%f \n%f \n%f \nResult:%f\n",
                            i,
                            $itor(r_data_in_0) * sf,
                            $itor(r_data_in_1) * sf,
                            $itor(r_data_in_2) * sf,
                            $itor(r_data_in_3) * sf,
                            $itor(r_data_in_4) * sf,
                            $itor(r_data_in_5) * sf,
                            $itor(r_data_in_6) * sf,
                            $itor(r_data_in_7) * sf,
                            $itor(r_data_in_8) * sf,
                            $itor(r_bias) * sf,
                            $itor(inter_result[DATA_WIDTH:1]) * sf
                            );*/              
            end
            else
            begin
                $display("Iteration%d: Failed to add\n", i);
                /*$display("Iteration%d: Failed to add:\n%f \n%f \n%f \n%f \n%f \n%f \n%f \n%f \n%f \n%f \nResult:%f\n",
                            i,
                            $itor(r_data_in_0) * sf,
                            $itor(r_data_in_1) * sf,
                            $itor(r_data_in_2) * sf,
                            $itor(r_data_in_3) * sf,
                            $itor(r_data_in_4) * sf,
                            $itor(r_data_in_5) * sf,
                            $itor(r_data_in_6) * sf,
                            $itor(r_data_in_7) * sf,
                            $itor(r_data_in_8) * sf,
                            $itor(inter_result[DATA_WIDTH:1]) * sf,
                            $itor(r_bias) * sf
                            );*/
            end
                       
        end
    end

endmodule
