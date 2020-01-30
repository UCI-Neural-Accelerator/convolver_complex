`timescale 1ns / 1ps

// shift register
// shifts right 1 position every clock cycle
// shifts right 3 positions if selected
module shift_register #(parameter size=3, parameter data_width=32) (
    input [(data_width - 1):0] shift_in,  // value to be shifted in
    input three_shift,  // select for 3-shift
    input clock,
    input reset,    // reset all registers to 0
    output [(data_width - 1):0] shift_out,    // value shifted out
    output [(data_width - 1):0] data_out [(size - 1):0]    // value of each register
    );
    
    // internal registers to hold the data values
    reg [(data_width - 1):0] data [(size - 1):0];
    reg [(data_width - 1):0] shift_out_reg;
    
    // connect shift out to value
    assign shift_out = shift_out_reg;
    
    // assign all the outputs to the vaule of the data registers
    generate
        genvar i;
        for (i = 0; i < size; i = i + 1)
        begin
            assign data_out[i] = data[i];
        end
    endgenerate

    integer j;
    always @(posedge clock)
    begin
        if (reset == 1'b1)  // reset condition
        begin
            for (j = 0; j < size; j = i + 1)
            begin
                data[j] = 1'b0;
            end
            shift_out_reg = 0;
        end
        else
        begin
            if (three_shift == 1'b1)    // three shift condition
            begin
            end
            else
            begin
                // shift out
                shift_out_reg = data[size - 1];
                // shift 
                for (j = (size - 2); j < -1; j = j - 1)
                begin
                    data[j + 1] = data[j];
                end
                // shift in
                data[0] = shift_in;
            end
        end
    end

endmodule