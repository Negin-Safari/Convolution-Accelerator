`timescale 1ns/1ns
module Conv #(parameter p = 5, parameter m = 6, parameter n = 8)(clk, rst, start, avail, done, result, datain,
                                                                dataout, rd, adr, kernel);
  
  input clk, rst, start, rd;
  input [n-1:0] datain;
  input [m-1:0] adr;
  input [9*n-1:0] kernel;
  output avail, done;
  output [n-1:0] result, dataout;
  
  wire sh, selpix, sel0, init0, wr_inram, rd_inram;
  wire [m-1:0] pixadr;
  
  wire startmult, donemult, load;
  
  ConvCU #(p, m) CU(clk, rst, start, sh, selpix, sel0, init0, pixadr, avail, done, wr_inram, rd_inram, startmult, donemult, load);
  
  ConvDP #(n, m, p) DP(clk, rst, sh, selpix, sel0, init0, pixadr, result, wr_inram, rd_inram, datain, startmult, donemult, kernel, load);
  
  RAM #(8, 10) rmm(clk, rst, avail, rd, adr, result, dataout);
  
endmodule

