`timescale 1ns / 1ps

module convolver_complex(
    input clk, reset,
    output result
    );
    
    wire weight_write;    
    datapath datapath_unit(
        .clk(clk),
        .reset(reset),
        .weight_write(weight_write));
        
    wire en;
    controlpath 
    #( .DATA_WIDTH(16),
       .IMAGE_SIZE(28),
       .KERNEL_SIZE(5)
    ) 
    control_unit
    (
        .clk(clk),
        .rstn(reset),
        .enable(en)
    );  
     
        
endmodule
