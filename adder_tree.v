`timescale 1ns/1ps

module adder_tree(
    input p1,p2,p3,p4,p5,p6,p7,p8,p9,
    input b1,b2,b3,b4,b5,b6,b7,b8,b9,
    output reg result
    );
    
  always @(*)
  begin
    result = p1+p2+p3+p4+p5+p6+p7+p8+p9;
  end
    
endmodule