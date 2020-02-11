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
       
       case(state)
       
    end
endmodule
/*