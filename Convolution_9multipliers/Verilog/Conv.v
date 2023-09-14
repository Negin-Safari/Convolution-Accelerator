// Negin Safari 810197525
`timescale 1ns/1ns
module Conv #(parameter p = 5, parameter m = 6, parameter n = 8)(clk, rst, start, avail, done, result, datain, 
                                                                 dataout, rd, adr, kernel);
  
  input clk, rst, start, rd;
  input [n-1:0] datain;
  input [m-1:0] adr;
  input [n*9-1:0] kernel;
  output avail, done;
  output [n-1:0] result, dataout;
  
  wire sh, selpix, sel0, init0, wr_inram, rd_inram, full, flll;
  wire [m-1:0] pixadr;
  
  ConvCU #(p, m) CU(clk, rst, start, sh, selpix, sel0, init0, pixadr, avail, done, rd_inram, full, load);
  
  ConvDP #(n, m, p) DP(clk, rst, sh, selpix, sel0, init0, pixadr, result, wr_inram, rd_inram, datain, full, kernel, load);
  
  RAM #(n, m, p) rmm(clk, rst, avail, rd, adr, result, dataout, flll);
  
  input_handler INH(clk, rst, start, full, wr_inram);
  
endmodule

