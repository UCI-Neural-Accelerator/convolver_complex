`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/26/2020 11:29:58 AM
// Design Name: 
// Module Name: tb_datapath
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


module tb_datapath();

    parameter KERNEL_SIZE = 5;
    parameter DATA_WIDTH = 16;
    parameter CLK_PERIOD = 20;
    parameter TEST_ITERATIONS = 10;
    parameter sf = 2.0 ** -8.0;

    // Inputs
    reg signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] r_weights;
    reg signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] r_pixel_data;
    reg signed [DATA_WIDTH - 1:0] bias;
    reg signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] rand_weight, rand_pixel;
    reg signed [DATA_WIDTH - 1:0] rand_bias;
    
    // Output
    wire signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] m_result;
    wire signed [DATA_WIDTH - 1:0] final_result;
    
    
    // instantiate the adder tree
    adder_tree #(.DATA_WIDTH(DATA_WIDTH)) adder 
    (
        .data_in_0( m_result[0 +: DATA_WIDTH] ),
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
        .result(final_result)             
    );
    
    multiplier #(.KERNEL_SIZE(KERNEL_SIZE), .DATA_WIDTH(DATA_WIDTH)) mult1
    (
        .weights(r_weights),
        .pixel_data(r_pixel_data),
        .result(m_result)
    );    


    
    integer i;
    initial 
    begin
    
        // initialize bias
        bias = 0;    
        
        for ( i = 0; i < KERNEL_SIZE**2; i = i + 1)
        begin
            r_weights[i*DATA_WIDTH +: DATA_WIDTH] = 16'b00000001_00000000;
            r_pixel_data[i*DATA_WIDTH +: DATA_WIDTH] = 16'b00000010_00000000;
        end
    
            
    
            
        if (final_result == 16'd50)
        begin
            $display(" Successfully added\n");
       
        end
        else
        begin
            $display("Failed to add\n");
    
        end
    
    end
    
    
endmodule
