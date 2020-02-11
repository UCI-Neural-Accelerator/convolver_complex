`timescale 1ns/1ps

module adder_tree #(parameter DATA_WIDTH = 32)(
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
    input signed [DATA_WIDTH-1:0] bias,
    
    // outputs
    output signed [DATA_WIDTH-1:0] result
    );
    
    // wire
    wire signed [DATA_WIDTH - 1:0] inter_0_0;
    wire signed [DATA_WIDTH - 1:0] inter_0_1;
    wire signed [DATA_WIDTH - 1:0] inter_0_2;
    wire signed [DATA_WIDTH - 1:0] inter_0_3;
    wire signed [DATA_WIDTH - 1:0] inter_0_4;
    wire signed [DATA_WIDTH - 1:0] inter_1_0;
    wire signed [DATA_WIDTH - 1:0] inter_1_1;
    wire signed [DATA_WIDTH - 1:0] inter_2_0;
    
    // Register reg
    
    // Non-register reg
    
    // first stage
    assign inter_0_0 = data_in_0 + data_in_1;
    assign inter_0_1 = data_in_2 + data_in_3;
    assign inter_0_2 = data_in_4 + data_in_5;
    assign inter_0_3 = data_in_6 + data_in_7;
    assign inter_0_4 = data_in_8 + bias;
    
    // second stage
    assign inter_1_0 = inter_0_0 + inter_0_1;
    assign inter_1_1 = inter_0_2 + inter_0_3;
    
    // third stage
    assign inter_2_0 = inter_1_0 + inter_1_1;
    
    // fourth stage
    assign result = inter_2_0 + inter_0_4;   
    
endmodule