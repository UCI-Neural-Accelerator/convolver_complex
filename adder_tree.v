`timescale 1ns/1ps

module adder_tree #(parameter DATA_WIDTH = 16)(
    // inputs
    input signed [DATA_WIDTH-1:0] data_in_0,
    input signed [DATA_WIDTH-1:0] data_in_1,
    input signed [DATA_WIDTH-1:0] data_in_2,
    input signed [DATA_WIDTH-1:0] data_in_3,
    input signed [DATA_WIDTH-1:0] data_in_4,
    input signed [DATA_WIDTH-1:0] data_in_5,
    input signed [DATA_WIDTH-1:0] data_in_6,
    input signed [DATA_WIDTH-1:0] data_in_7,
    input signed [DATA_WIDTH-1:0] data_in_8,
    input signed [DATA_WIDTH-1:0] data_in_9,
    input signed [DATA_WIDTH-1:0] data_in_10,
    input signed [DATA_WIDTH-1:0] data_in_11,
    input signed [DATA_WIDTH-1:0] data_in_12,
    input signed [DATA_WIDTH-1:0] data_in_13,
    input signed [DATA_WIDTH-1:0] data_in_14,
    input signed [DATA_WIDTH-1:0] data_in_15,
    input signed [DATA_WIDTH-1:0] data_in_16,
    input signed [DATA_WIDTH-1:0] data_in_17,
    input signed [DATA_WIDTH-1:0] data_in_18,
    input signed [DATA_WIDTH-1:0] data_in_19,
    input signed [DATA_WIDTH-1:0] data_in_20,
    input signed [DATA_WIDTH-1:0] data_in_21,
    input signed [DATA_WIDTH-1:0] data_in_22,
    input signed [DATA_WIDTH-1:0] data_in_23,
    input signed [DATA_WIDTH-1:0] data_in_24,
    input signed [DATA_WIDTH-1:0] bias,
    
    // outputs
    output signed [DATA_WIDTH-1:0] result
    );
    
    // result of first stage
    wire signed [DATA_WIDTH-1:0] inter_0_0;
    wire signed [DATA_WIDTH-1:0] inter_0_1;
    wire signed [DATA_WIDTH-1:0] inter_0_2;
    wire signed [DATA_WIDTH-1:0] inter_0_3;
    wire signed [DATA_WIDTH-1:0] inter_0_4;
    wire signed [DATA_WIDTH-1:0] inter_0_5;
    wire signed [DATA_WIDTH-1:0] inter_0_6;
    wire signed [DATA_WIDTH-1:0] inter_0_7;
    wire signed [DATA_WIDTH-1:0] inter_0_8;
    wire signed [DATA_WIDTH-1:0] inter_0_9;
    wire signed [DATA_WIDTH-1:0] inter_0_10;
    wire signed [DATA_WIDTH-1:0] inter_0_11;
    wire signed [DATA_WIDTH-1:0] inter_0_12;
    
    // result of second stage
    wire signed [DATA_WIDTH-1:0] inter_1_0;
    wire signed [DATA_WIDTH-1:0] inter_1_1;
    wire signed [DATA_WIDTH-1:0] inter_1_2;
    wire signed [DATA_WIDTH-1:0] inter_1_3;
    wire signed [DATA_WIDTH-1:0] inter_1_4;
    wire signed [DATA_WIDTH-1:0] inter_1_5;
    
    // result of third stage
    wire signed [DATA_WIDTH-1:0] inter_2_0;
    wire signed [DATA_WIDTH-1:0] inter_2_1;
    wire signed [DATA_WIDTH-1:0] inter_2_2;
    
    // result of fourth stage
    wire signed [DATA_WIDTH-1:0] inter_3_0;
    wire signed [DATA_WIDTH-1:0] inter_3_1;
    
    // first stage
    assign inter_0_0 = data_in_0 + data_in_1;
    assign inter_0_1 = data_in_2 + data_in_3;
    assign inter_0_2 = data_in_4 + data_in_5;
    assign inter_0_3 = data_in_6 + data_in_7;
    assign inter_0_4 = data_in_8 + data_in_9;
    assign inter_0_5 = data_in_10 + data_in_11;
    assign inter_0_6 = data_in_12 + data_in_13;
    assign inter_0_7 = data_in_14 + data_in_15;
    assign inter_0_8 = data_in_16 + data_in_17;
    assign inter_0_9 = data_in_18 + data_in_19;
    assign inter_0_10 = data_in_20 + data_in_21;
    assign inter_0_11 = data_in_22 + data_in_23;
    assign inter_0_12 = data_in_24 + bias;
    
    // second stage
    assign inter_1_0 = inter_0_0 + inter_0_1;
    assign inter_1_1 = inter_0_2 + inter_0_3;
    assign inter_1_2 = inter_0_4 + inter_0_5;
    assign inter_1_3 = inter_0_6 + inter_0_7;
    assign inter_1_4 = inter_0_8 + inter_0_9;
    assign inter_1_5 = inter_0_10 + inter_0_11;
    
    // third stage
    assign inter_2_0 = inter_1_0 + inter_1_1;
    assign inter_2_1 = inter_1_2 + inter_1_3;
    assign inter_2_2 = inter_1_4 + inter_1_5;
         
    // fourth stage
    assign inter_3_0 = inter_2_0 + inter_2_1;
    assign inter_3_1 = inter_2_2 + inter_0_12;
    
    // fifth stage
    assign result = inter_3_0 + inter_3_1;   
    
    
endmodule