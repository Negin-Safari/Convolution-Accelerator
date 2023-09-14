module Multiplexer #(parameter n = 8)(sel0, sel1, in0, in1, out);
  
  input sel0, sel1;
  input [n-1:0] in0, in1;
  
  output [n-1:0] out;
  
  assign out = (sel0)? in0 :
               (sel1)? in1 : 0;
               
endmodule