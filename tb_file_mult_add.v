`timescale 1ns / 1ps

module tb_file_mult_add();

parameter BW = 16;
parameter FRAC_BIT = 8;
parameter KERN_DIM = 5;
parameter DATA_WIDTH = 16;

parameter KERNEL_SIZE = KERN_DIM * KERN_DIM;

parameter HALF_CLK_DURATION = 5;
parameter RESET_DURATION = 18;

reg clk;
reg rstn;

reg signed [DATA_WIDTH-1:0] tmp_pixel;

reg signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] weights;
reg signed [(KERNEL_SIZE**2)*DATA_WIDTH - 1:0] pixel_data;

reg signed [DATA_WIDTH-1:0] adder_bias;

wire signed [DATA_WIDTH - 1:0] out;

initial begin
    clk = 'd0;
    forever #(HALF_CLK_DURATION) clk = ~clk;
end

initial begin
    rstn = 'd1;
    #(RESET_DURATION);
    rstn = 'd0;
    #(RESET_DURATION);
    rstn = 'd1;
end

integer tmp;
integer file;
integer index;
initial begin
    pixel_data = 'd0;
    for(index = 0; index < 25; index = index + 1) begin
        file = $fopen("in.txt", "r");
        tmp = $fscan(file, "%d", tmp_pixel);
        pixel_data[index*DATA_WIDTH +: DATA_WIDTH] = tmp_pixel;
        @(negedge clk);
    end
    
    repeat(25) @(negedge clk);
    
end

// instantiate the datapath with the loaded inputs
datapath #(.DATA_WIDTH(DATA_WIDTH), .KERNEL_SIZE(KERNEL_SIZE), .FRAC_BIT(FRAC_BIT)) uut
    (
        .clk(clk),
        .reset(rstn),
        .bias(adder_bias),
        .weight_write(),
        .write(),
        .weights(weights),
        .pixel_data(pixel_data),
        .add_result(out)
    );


/*
multiplier #(.KERNEL_SIZE(KERNEL_SIZE), .DATA_WIDTH(DATA_WIDTH)) uut
    (
        .weights(mult_weights),
        .pixel_data(mult_pixel_data),
        .result(mult_result)
    );
    
adder_tree #(.DATA_WIDTH(16)) tree
    (
        .data_in_0(mult_result[15:0]),
        .data_in_1(mult_result[31:16]),
        .data_in_2(mult_result[47:32]),
        .data_in_3(mult_result[63:48]),
        .data_in_4(mult_result[79:64]),
        .data_in_5(mult_result[95:80]),
        .data_in_6(mult_result[111:96]),
        .data_in_7(mult_result[127:112]),
        .data_in_8(mult_result[143:128]),
        .data_in_9(mult_result[159:144]),
        .data_in_10(mult_result[175:160]),
        .data_in_11(mult_result[191:176]),
        .data_in_12(mult_result[207:192]),
        .data_in_13(mult_result[223:208]),
        .data_in_14(mult_result[239:224]),
        .data_in_15(mult_result[254:240]),
        .data_in_16(mult_result[271:256]),
        .data_in_17(mult_result[287:272]),
        .data_in_18(mult_result[303:288]),
        .data_in_19(mult_result[319:304]),
        .data_in_20(mult_result[335:320]),
        .data_in_21(mult_result[351:336]),
        .data_in_22(mult_result[367:352]),
        .data_in_23(mult_result[383:368]),
        .data_in_24(mult_result[400:384]),
        .bias(adder_bias),
        .result(out)
    );*/
    
endmodule
