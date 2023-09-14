module Register #(parameter n = 8)(clk, rst, init0, ld, D, Q);
  
  input clk, rst, ld, init0;
  input [n-1:0] D;
  
  output reg [n-1:0] Q;
  
  always @(posedge clk, posedge rst) begin
    if(rst)
      Q = 0;
    else if(init0)
      Q = 0;
    else if(ld)
      Q = D;
  end
   
endmodule