`timescale 1ns / 1ps

module tb_conv_complex();

parameter BW = 16;
parameter  FRAC_BIT = 8;
parameter KERN_DIM = 5;
//parameter WIDTH = 28;
//parameter POOL_WIDTH = 24;
//parameter NUM_CHAN_IN = 1;
//parameter NUM_CHAN = 20;
//parameter CHAN_BW = $clog2(NUM_CHAN);

parameter KERN_SIZE = KERN_DIM * KERN_DIM;

parameter HALF_CLK_DURATION = 5;
parameter RESET_DURATION = 18;
//parameter PROBE_SLACK = 0.5;

reg clk;
reg rstn;

//reg [CHAN_BW-1:0] chan;
reg enable;
//reg input_en;
reg signed [BW-1:0] iPixel;
wire [BW*KERN_SIZE-1:0] weights;
wire signed [BW-1:0] bias;

wire signed [BW-1:0] oOut;

wire weight_write;

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

integer tmpchan;
integer filechan;
initial begin
    filechan = $fopen("chan.in", "r");
    tmpchan = $fscanf(filechan, "%d", chan);
end

convolver_complex uut 
(
    .clk(clk),
    .reset(rstn),
    .weight_write(weight_write)
);

//need to add more here? look at min soo's design, he has more modules here



endmodule
