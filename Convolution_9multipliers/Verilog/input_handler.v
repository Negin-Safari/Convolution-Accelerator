module input_handler(clk, rst, start, full, wr);
  
  input clk, rst, start, full;
  
  output wr;
  
  reg ps, ns;
  
  
  always @(posedge clk, posedge rst) begin
    if(rst)
      ps <= 0;
    else
      ps <= ns; 
  end
  
  always @(ps, start, full) begin
    case(ps)
      0: ns <= (start) ? 1 : 0;
      1: ns <= (full) ? 0 : 1;
    endcase
  end
  
  assign wr = (ps == 1) ? 1 : 0;

endmodule