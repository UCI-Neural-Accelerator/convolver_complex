`timescale 1ns / 1ps


module weight_register #(parameter DATA_WIDTH = 16, parameter N = 25) (
    // inputs
    input reset,
    input clock,
    input write,
    input [(N*DATA_WIDTH)-1:0] weight_write,
    
    // outputs
    output [(N*DATA_WIDTH)-1:0] weight_read
    );
    
    // Register reg
    reg [DATA_WIDTH-1:0] weight_reg [N-1:0];
    
    // Non-register reg
    
    // assign the read to the value of the register
    genvar geni;
    generate
        for (geni = 0; geni < N; geni = geni + 1)
        begin
            assign weight_read[((DATA_WIDTH*(geni + 1)) - 1):(DATA_WIDTH*geni)] = weight_reg[geni];
        end
    endgenerate
    
    // Synchronous logic and asynchronous reset
    integer i;
    always @(posedge clock or posedge reset)
    begin
        // asynchronous reset
        if (reset)
        begin
            // clear all internal data registers
            for (i = 0; i < N; i = i + 1)
            begin
                weight_reg[i] <= 0;
            end
        end
        else    // normal operation
        begin
            // write new values to registers
            if (write)
            begin
                for (i = 0; i < N; i = i + 1)
                begin
                    weight_reg[i] <= weight_write[i*DATA_WIDTH +: DATA_WIDTH];
                end
            end
        end
    end
    
endmodule
    



