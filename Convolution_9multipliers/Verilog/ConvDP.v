module ConvDP #(parameter n = 8, parameter m = 6, parameter p = 5)(clk, rst, sh, selpix, sel0,
                                              init0, pixadr, result, wr_inram, rd_inram, datain,
                                               full, kernel, load);
  
  input clk, rst, sh, selpix, sel0, init0, wr_inram, rd_inram, load;
  input [m-1:0] pixadr;
  input [n-1:0] datain;
  input [n*9-1:0] kernel;
  output [n-1:0] result;
  output full;
  
  wire [n-1:0] w[0:(2*p+5)];
  wire [n-1:0] pix;
  
  reg [n*9-1:0] k;
  
  //ROM #(n, m) PixRom(pixadr, pix);
  
  RAM #(n, m, p) PixRam(clk, rst, wr_inram, rd_inram, pixadr, datain, pix, full);
  
  Multiplexer #(n) Mux(sel0, selpix, {n{1'b0}}, pix, w[0]);
  
  genvar i;
  
  generate 
    for(i=0; i<(2*p+5); i=i+1) begin: regs
      Register #(n) Regi(clk, rst, init0, sh, w[i], w[i+1]);
    end
  endgenerate
  
  always @(posedge clk, posedge rst) begin
    if(rst)
      k <= 0;
    else if(load)
      k <= kernel;  
  end
  
  MacCalculation #(n) MacC(k ,w[2*p+5], w[2*p+4], w[2*p+3], w[p+4], w[p+3], w[p+2], w[3], w[2], w[1], result);
  
endmodule