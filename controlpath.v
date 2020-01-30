`timescale 1ns / 1ps

module controlpath(
    input reset, state,
    output reg three_shift, write_weights
    );
    
always @(*)
    if(reset == 1'b1) begin
        three_shift = 1'b0;
        write_weights = 1'b0;
    end
    else begin
        case(state) 
        2'b00: begin
            three_shift = 1'b0;
            write_weights = 1'b0; 
            end
        2'b01: begin
            three_shift = 1'b0;
            write_weights = 1'b1; 
            end
        2'b10: begin
            three_shift = 1'b1;
            write_weights = 1'b0; 
            end
        2'b11: begin
            three_shift = 1'b1;
            write_weights = 1'b1; 
            end
        endcase
    end
endmodule