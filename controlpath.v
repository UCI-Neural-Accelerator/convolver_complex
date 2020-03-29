`timescale 1ns / 1ps

/* PREVIOUS APPROACH

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

/* FIRST APPROACH

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
*/

/* ALTERNATIVE APPROACH

        else if (count_conv > (IMAGE_SIZE-2*(KERNEL_SIZE/2)) & count_conv <= (IMAGE_SIZE-2*(KERNEL_SIZE/2) + KERNEL_SIZE))
            enable = 0;
            count_conv = count_conv + 1;
        else
            count_conv = 5'd0;   
*/

module controlpath #(parameter DATA_WIDTH = 16, parameter IMAGE_SIZE = 28, parameter KERNEL_SIZE = 5) (
        input clk,
        input rstn,
        
        output reg enable
    );
	
    reg [4:0] count_conv; //Counter of number of convolutions
    reg [2:0] count_shift_row; //Counter until kernel size when changing row
    
    always@(posedge clk or negedge rstn) begin
        if (~rstn) begin
            count_conv <= 5'd0;
            count_shift_row <= 3'd0;
            enable <= 1'd0;
        end
        else begin
            if (count_conv <= (IMAGE_SIZE-2*(KERNEL_SIZE/2))) begin
                enable <= 1'd1;
                count_conv <= count_conv + 'd1;
                count_shift_row <= 3'd0;
            end
            else begin
               if (count_shift_row == KERNEL_SIZE) begin
                    count_conv <= 5'd0;
                    count_shift_row <= 3'd0;
					enable <= 1'd0;
               end
               else begin
                    enable <= 1'd0;
                    count_shift_row <= count_shift_row + 'd1;
                    count_conv <= count_conv;
                end
            end
        end
    end

endmodule