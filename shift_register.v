`timescale 1ns / 1ps

// shift register
// shifts right 1 position every clock cycle
// shifts right 3 positions if selected
module shift_register #(parameter SIZE=3, parameter DATA_WIDTH=32) (
    input [(DATA_WIDTH - 1):0] shift_in,  // value to be shifted in
    input clock,
    input reset,    // reset all registers to 0
    output [(DATA_WIDTH - 1):0] shift_out,    // value shifted out
    output [(SIZE*DATA_WIDTH)-1:0] data_out    // value of each register
    );
    
    integer i;
    
    // Register reg
    reg [(DATA_WIDTH - 1):0] data [(SIZE - 1):0];   // internal registers to hold the data values
    reg [(DATA_WIDTH - 1):0] shift_out_reg;
    
    // Non-register reg
    
    
    // Assignments
    assign shift_out = shift_out_reg;   // connect shift out to value
    // assign assign the data registers to the flattened outputs
    genvar geni;
    generate
        for (geni = 0; geni < SIZE; geni = geni + 1)
        begin
            assign data_out[((DATA_WIDTH*(geni + 1)) - 1):(DATA_WIDTH*geni)] = data[geni];
        end
    endgenerate
    
    always @(posedge clock)
    begin
        shift_out_reg <= data[SIZE - 1];    // shift out the most significant register
        for (i = (SIZE - 1); i > 0; i = i - 1) // shift the rest of the registers
        begin
            data[i] <= data[i - 1];
        end
        data[0] <= shift_in;    // shift the new value in
    end
    
    // Combinational logic
    always @(*)
    begin
        // asynchronous reset
        if (reset == 1'b1)
        begin
            // clear all internal data registers
            for (i = 0; i < SIZE; i = i + 1)
            begin
                data[i] <= 0;
            end            
        end
    end
    

endmodule