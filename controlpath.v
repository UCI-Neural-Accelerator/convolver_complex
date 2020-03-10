`timescale 1ns / 1ps
/*
module controlpath
#(
    parameter
    KERN_DIM = 3,
    WIDTH = 28,
    
    //state names
    STATE_BW = 2,
    STANDBY = 2'b00,
    UPDATE_W = 2'b01,
    SHIFT_THREE = 2'b10,
    SHIFT_WRITE_W = 2'b11
)
(
    input reset,
    input clk,
    
    output reg three_shift, write_weights
);
    
    //Register reg
    reg[STATE_BW-1:0] state;
    
    //Non-register reg
    reg[STATE_BW-1:0] state_nxt;

    always @(posedge clk or negedge reset) begin
        if(!reset) begin
            state <= 'd0;
        end
        else begin
            state <= state_nxt;
        end
    end


    always @(*) begin
       state_nxt = STANDBY;
       
       //case(state)
       
    end
endmodule*/

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.03.2020 11:20:34
// Design Name: 
// Module Name: controlpath
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


module controlpath #(parameter DATA_WIDTH = 16, parameter IMAGE_SIZE = 28, parameter KERNEL_SIZE = 5) (
        input clk,
        input reset,
        
        output reg enable
    );
    
    reg [5:0] count = 0;
    
    always@(posedge clk)
    begin
        count = count + 1;
        if (count == 6'd24)
            enable = 1;
        else if (count == 6'd49) begin
            enable = 0;
            count = 6'd0;
        end
    end   
   
endmodule