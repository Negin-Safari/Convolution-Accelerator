`timescale 1ns/1ns
module Counter #(parameter m)(clk, rst, init0, cen, goal, cnt, co);
  
  input clk, rst, init0, cen;
  input [m-1:0] goal;
  
  output co;
  output reg [m-1:0] cnt;
  
  always @(posedge clk, posedge rst)begin
    if(rst)
      cnt = 0;
    else if(init0 || co)
      cnt = 0;
    else if(cen)
      cnt = cnt + 1;  
    else
      cnt = cnt;
  end
  
  assign co = (cnt == goal)? 1 : 0;
  
endmodule

module counter_tb();
  
  reg clk = 0, rst, init0, cen;
  reg [8-1:0] goal = 5;
  
  wire co;
  wire [8-1:0] cnt;
  
  Counter #(8) uut(clk, rst, init0, cen, goal, cnt, co);
  
  initial repeat(50) #5 clk = ~clk;
  
  initial begin
    rst = 1;
    #6;
    rst = 0;
    cen = 1;
    #100;
    cen = 0;
    init0 = 1;
    #10;
    init0 = 0; 
  end
  
 endmodule 