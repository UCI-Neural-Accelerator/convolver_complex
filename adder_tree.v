`timescale 1ns/1ps

module adder_tree#(parameter WIDTH = 32, parameter INPUTS = 9)(
    input wire[WIDTH*INPUTS-1:0] data_in,
    input[WIDTH-1:0] bias,
    output reg[INPUTS+WIDTH-1:0] out_data
    );
    
    reg[INPUTS+WIDTH-1:0] temp_data;
    always @(*)
    begin
        for(i = 0; i < INPUTS; i = i + 1)
            temp_data = temp_data + data_in[i*WIDTH +: WIDTH];
        out_data = temp_data;
    end
endmodule