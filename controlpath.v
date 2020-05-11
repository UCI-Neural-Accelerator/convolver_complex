`timescale 1ns / 1ps

/* PREVIOUS APPROACH

module controlpath
#(
    parameter
    KERN_DIM = 3,
    WIDTH = 28,
    
    //state names
    STATE_BW = 2,
    STANDBY = 2'b00,
    UPDATE_W = 2'b01,
    SHIFT_THREE = 2'b10,
    SHIFT_WRITE_W = 2'b11
)
(
    input reset,
    input clk,
    
    output reg three_shift, write_weights
);
    
    //Register reg
    reg[STATE_BW-1:0] state;
    
    //Non-register reg
    reg[STATE_BW-1:0] state_nxt;

    always @(posedge clk or negedge reset) begin
        if(!reset) begin
            state <= 'd0;
        end
        else begin
            state <= state_nxt;
        end
    end


    always @(*) begin
       state_nxt = STANDBY;
       
       //case(state)
       
    end
endmodule*/

/* FIRST APPROACH

module controlpath #(parameter DATA_WIDTH = 16, parameter IMAGE_SIZE = 28, parameter KERNEL_SIZE = 5) (
        input clk,
        input rstn,
        
        output reg enable
    );
	
    reg [4:0] count_conv; //Counter of number of convolutions
    reg [2:0] count_shift_row; //Counter until kernel size when changing row
    
    always@(posedge clk or negedge rstn) begin
        if (~rstn) begin
            count_conv <= 5'd0;
            count_shift_row <= 3'd0;
            enable <= 1'd0;
        end
        else begin
            if (count_conv < (IMAGE_SIZE-KERNEL_SIZE+1)) begin
                enable <= 1'd1;
                count_conv <= count_conv + 1'd1;
                count_shift_row <= 3'd0;
            end
            else begin
               if (count_shift_row == (KERNEL_SIZE-1)) begin
                    count_conv <= 5'd0;
                    count_shift_row <= 3'd0;
					enable <= 1'd1;
               end
               else begin
                    enable <= 1'd0;
                    count_shift_row <= count_shift_row + 1'd1;
                    count_conv <= count_conv;
                end
            end
        end
    end

endmodule
*/

//FSM APPROACH

module controlpath #(parameter DATA_WIDTH = 16, parameter IMAGE_SIZE = 28, parameter KERNEL_SIZE = 5) (
        input wire clk,
        input wire reset,
        
        output reg enable
    );
    
	reg [6:0] counter;
	reg [4:0] counter_rows;
	
	localparam STATE_Initial = 2'd0,
		   STATE_1 = 2'd1,
		   STATE_2 = 2'd2,
		   STATE_3_PlaceHolder = 2'd3;

	reg[1:0] CurrentState;
	reg[1:0] NextState;
	
	
	always@( * ) begin
		enable = 1'd0;
		case(CurrentState)
			STATE_1: begin 
				enable = 1'd1;
			end
			//STATE_3: begin
				//enable = 1'bz; //ONLY FOR TESTING
			//end
		endcase
	end

	//ALTERNATIVE APPROACH FOR WIRE AND UNIDIMENSIONAL VARIABLE
	//assign enable = (CurrentState == STATE_1);


    	always@(posedge clk or posedge reset) begin
        	if (reset) begin
			CurrentState <= STATE_Initial;
			counter <= 7'd0;
			counter_rows <= 5'd0;
		end
        	else begin
			CurrentState <= NextState;
			counter <= counter + 1'd1;
			if (enable == 1'd0) begin
				if (counter == 1'd0) counter_rows <= counter_rows + 1'd1;
			end
		end                
   	end
	
	
	always@( * ) begin
		NextState = CurrentState;
		case(CurrentState)
			STATE_Initial: begin
				if (counter == ((KERNEL_SIZE**2+(KERNEL_SIZE-1)*(IMAGE_SIZE-KERNEL_SIZE))-1)) begin 
					NextState = STATE_1;
					counter = 7'd0;
				end
			end
			STATE_1: begin
				if (counter == (IMAGE_SIZE-KERNEL_SIZE+1)) begin 
					NextState = STATE_2;
					counter = 7'd0;
				end
			end
			STATE_2: begin
				if (counter == (KERNEL_SIZE-1)) begin 
					NextState = STATE_1;
					counter = 7'd0;
				end
				else if (counter_rows == ((IMAGE_SIZE-KERNEL_SIZE+1)+1)) begin 
					NextState = STATE_Initial;
					counter_rows = 7'd0;
					counter = 7'd0;
				end
			end
			STATE_3_PlaceHolder: begin
				NextState = STATE_Initial;
				counter_rows = 7'd0;
				counter = 7'd0;
			end
		endcase
	end

endmodule