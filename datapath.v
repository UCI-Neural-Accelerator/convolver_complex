`timescale 1ns / 1ps



module datapath #(parameter DATA_WIDTH = 16, parameter KERNEL_SIZE = 5, parameter FRAC_BIT = 8) (
    // inputs
    input clk, reset,
    input three_shift,
    input [DATA_WIDTH - 1:0] bias,
    input weight_write, write,
    input signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] weights, pixel_data,
    // outputs
    output signed [DATA_WIDTH-1:0] add_result
    );    
    
//    wire signed [ (KERNEL_SIZE*DATA_WIDTH)- 1:0] w_data_out_0;
//    wire signed [ (KERNEL_SIZE*DATA_WIDTH)- 1:0] w_data_out_1;
//    wire signed [ (KERNEL_SIZE*DATA_WIDTH)- 1:0] w_data_out_2;
    
    wire signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] m_result;
    //wire signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] pixel_data;    
    //wire signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] weights;     
    
    // concatenate shift register outputs for multiplier unit
//    assign pixel_data = {w_data_out_0, w_data_out_1, w_data_out_2};
    
    // don't know how to pass parameters into instantiated modules
    // not to sure how to connect the shift registers, help jigar or ian?
//    shift_register shift_register_0 (
//            .shift_in(),
//            .clock(clk),
//            .reset(reset),
//            .shift_out(w_shift_out),
//            .data_out(w_data_out_0)
//        );
        
//    shift_register shift_register_1 (
//            .shift_in(w_shift_out),
//            .clock(clk),
//            .reset(reset),
//            .shift_out(w_shift_out_1),
//            .data_out(w_data_out_1)
//        );
        
//     shift_register shift_register_2 (
//            .shift_in(w_shift_out_1),
//            .clock(clk),
//            .reset(reset),
//            .shift_out(),
//            .data_out(w_data_out_2)
//        );
         
//    weight_register weight_register_0 (
//            .reset(reset),
//            .clock(clk),
//            .write(write),
//            .weight_write(weight_write),
//            .weight_read(weights)
//        );
        
     multiplier #(.FRAC_BIT(FRAC_BIT)) multiplier_0 (
            .weights(weights),
            .pixel_data(pixel_data),
            .result(m_result)
        );    
     
    adder_tree #(.DATA_WIDTH(DATA_WIDTH)) adder_tree_0 (
        .data_in_0( m_result[0*DATA_WIDTH +: DATA_WIDTH] ),
        .data_in_1( m_result[1*DATA_WIDTH +: DATA_WIDTH] ),
        .data_in_2( m_result[2*DATA_WIDTH +: DATA_WIDTH] ),
        .data_in_3( m_result[3*DATA_WIDTH +: DATA_WIDTH] ),
        .data_in_4( m_result[4*DATA_WIDTH +: DATA_WIDTH] ),
        .data_in_5( m_result[5*DATA_WIDTH +: DATA_WIDTH] ),
        .data_in_6( m_result[6*DATA_WIDTH +: DATA_WIDTH] ),
        .data_in_7( m_result[7*DATA_WIDTH +: DATA_WIDTH] ),
        .data_in_8( m_result[8*DATA_WIDTH +: DATA_WIDTH] ),
        .data_in_9( m_result[9*DATA_WIDTH +: DATA_WIDTH] ),
        .data_in_10( m_result[10*DATA_WIDTH +: DATA_WIDTH] ),
        .data_in_11( m_result[11*DATA_WIDTH +: DATA_WIDTH] ),
        .data_in_12( m_result[12*DATA_WIDTH +: DATA_WIDTH] ),
        .data_in_13( m_result[13*DATA_WIDTH +: DATA_WIDTH] ),
        .data_in_14( m_result[14*DATA_WIDTH +: DATA_WIDTH] ),
        .data_in_15( m_result[15*DATA_WIDTH +: DATA_WIDTH] ),
        .data_in_16( m_result[16*DATA_WIDTH +: DATA_WIDTH] ),
        .data_in_17( m_result[17*DATA_WIDTH +: DATA_WIDTH] ),
        .data_in_18( m_result[18*DATA_WIDTH +: DATA_WIDTH] ),
        .data_in_19( m_result[19*DATA_WIDTH +: DATA_WIDTH] ),
        .data_in_20( m_result[20*DATA_WIDTH +: DATA_WIDTH] ),
        .data_in_21( m_result[21*DATA_WIDTH +: DATA_WIDTH] ),
        .data_in_22( m_result[22*DATA_WIDTH +: DATA_WIDTH] ),
        .data_in_23( m_result[23*DATA_WIDTH +: DATA_WIDTH] ),
        .data_in_24( m_result[24*DATA_WIDTH +: DATA_WIDTH] ),
        .bias(bias),
        .result(add_result)        
        );
   
    
    
    
    
    
endmodule
