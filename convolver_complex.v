`timescale 1ns / 1ps

module convolver_complex(
    input clk, reset,  
    output result
    );
    
    wire three_shift, weight_write;
    
    datapath datapath_unit(
        .clk(clk),
        .reset(reset),
        .three_shift(three_shift),
        .weight_write(weight_write));
        
    /*control control_path(
        .reset(reset),
        .three_shift(three_shift),
        .weight_write(weight_write));*/
endmodule
