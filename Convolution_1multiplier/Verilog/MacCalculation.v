`timescale 1ns/1ns

module MacCalculation_seq #(parameter n)(clk, rst, st, k, in0, in1, in2, in3, in4, in5, in6, in7, in8, out, done);
  input clk, rst, st;
  input [n-1:0] in0, in1, in2, in3, in4, in5, in6, in7, in8;
  input [n*9-1:0] k;
  output [n-1:0] out;
  output reg done;
  wire [n-1:0] selo, ko;
  wire [2*n-1:0] addo, mulo;
  reg [3:0] cnt;
  reg[1:0] ps, ns;
  reg [2*n-1:0] tmp;
  reg [3:0] sel;
  
  reg cen, ld, clr;
  
  assign mulo = selo*(ko); //*1/9 
  
  assign addo = mulo + tmp;
  
  assign out = tmp[(n+6):7];
  
  assign selo = (sel == 4'd0) ? in0:
                (sel == 4'd1) ? in1:
                (sel == 4'd2) ? in2:
                (sel == 4'd3) ? in3:
                (sel == 4'd4) ? in4:
                (sel == 4'd5) ? in5:
                (sel == 4'd6) ? in6:
                (sel == 4'd7) ? in7:
                (sel == 4'd8) ? in8: 1'bz;
                
  assign ko = (sel == 4'd0) ? k[(n-1):0]:
                (sel == 4'd1) ? k[(2*n-1):(n)]:
                (sel == 4'd2) ? k[(3*n-1):(2*n)]:
                (sel == 4'd3) ? k[(4*n-1):(3*n)]:
                (sel == 4'd4) ? k[(5*n-1):(4*n)]:
                (sel == 4'd5) ? k[(6*n-1):(5*n)]:
                (sel == 4'd6) ? k[(7*n-1):(6*n)]:
                (sel == 4'd7) ? k[(8*n-1):(7*n)]:
                (sel == 4'd8) ? k[(9*n-1):(8*n)]: 1'bz;
  

  
  always@(posedge clk, posedge rst) begin
    if(rst) begin
      tmp = 0;
    end
    else if(clr) begin
      tmp = 0;
    end
    else if(ld) begin
      tmp = addo;  
    end
    else 
      tmp = tmp;    
  end
  

 
 always @(posedge clk, posedge rst) begin
   if(rst)
     ps <= 0;
   else
     ps <= ns;
 end
 
 always @(ps, st, cnt) begin
   case(ps)
     0: ns = (st) ? 1: 0;
     1: ns = (cnt == 4'd8) ? 2:1;
     2: ns = 0;
   endcase
 end
 
 always @(posedge clk, posedge rst) begin
   if(rst)
     cnt = 0;
   else if(clr)
     cnt = 0;
   else if(cen)
     cnt = cnt + 1;
   else 
     cnt = cnt;
 end
 
 
 always @(ps, cnt) begin
   done = 0; sel = 0; clr = 0; ld = 0; cen = 0;
   case(ps)
     0: begin cnt = 0; clr = 1;end
     1: begin sel = cnt; ld = 1; cen =1;  end
     2: done = 1;
   endcase
     
 end
 
endmodule



module mac_seq_tb();
  
  reg clk = 0, rst, st;
  reg [8-1:0] in0, in1, in2, in3, in4, in5, in6, in7, in8;
  
  wire [7:0]out;
  wire done;
  
  MacCalculation_seq #(8) uut(clk, rst, st, in0, in1, in2, in3, in4, in5, in6, in7, in8, out, done);
  
  initial repeat(100) #5 clk = ~clk;
  
  
  initial begin
    rst = 1;
    #7;
    rst = 0;
    in0 = 10; in1 = 10; in2=10; in3=10; in4=10; in5=10; in6=10; in7=10; in8=10;
    st = 1;
    #10;
    st = 0;
    #150;
    
    in0 = 19; in1 = 10; in2=10; in3=10; in4=10; in5=10; in6=10; in7=10; in8=10;
    st = 1;
    #10;
    st = 0;
    #150;
    
  end
  
endmodule
    
  







