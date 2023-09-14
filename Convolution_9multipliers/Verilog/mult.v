`timescale 1ns/1ns
module mult(a, b, m);
  input [7:0] a,b;
  output [15:0] m;
  
  wire [7:0] b_u;
  wire [2:0] shift_val, encout;
  
  assign b_u = (b[7] == 1'b1) ? ((~b)+1'b1) : b;
  
  priorityencoder  priority(1'b1, b_u, encout);
  
  assign shift_val = ( (b -((8'd1)<<encout)) > (((8'd1)<<(encout + 1'b1)) - b) ) ? (encout + 1'b1) : encout;
  
  assign m = (b[7] == 1'b1) ? (~(a <<shift_val)+1'b1) : (a <<shift_val);
  
endmodule


module mult_1(a, b, m);
  input [7:0] a,b;
  output [15:0] m;
  
  wire [7:0] b_u;
  wire [2:0] encout;
  
  assign b_u = (b[7] == 1'b1) ? ((~b)+1'b1) : b;
  
  priorityencoder  priority(1'b1, b_u, encout);
  
  assign m = (b[7] == 1'b1) ? (~(a <<encout)+1'b1) : (a <<encout);
  
endmodule

module mult_1_h(a, b, m);
  input [7:0] a,b;
  output [15:0] m;
  
  wire [7:0] b_u;
  wire [2:0] encout;
  
  assign b_u = (b[7] == 1'b1) ? ((~b)+1'b1) : b;
  
  priorityencoder  priority(1'b1, b_u, encout);
  
  assign m = (b[7] == 1'b1) ? (~(a <<(encout+1))+1'b1) : (a <<(encout+1));
  
endmodule


module mult_2(a, b, m);
  input [7:0] a,b;
  output [15:0] m;
  
  wire [7:0] b_u, a_u;
  wire [2:0]  aenc, benc;
  wire [15:0] mu;
  
  assign b_u = (b[7] == 1'b1) ? ((~b)+1'b1) : b;
  
 // assign a_u = (a[7] == 1'b1) ? ((~a)+1'b1) : a;
  
  priorityencoder  priority1(1'b1, b_u, benc);
  
  priorityencoder  priority2(1'b1, a, aenc);
  
  assign mu = (a << benc) + (b << aenc) - ((16'd1 <<aenc)<<benc);
  
  assign m =(b[7]) ? (~mu+1'b1) : mu;
  
endmodule










module priorityencoder (en,i,y);
  // declare
  input en;
  input [7:0]i;
  // store and declare output values
  output reg [2:0]y;
  always @(en,i)
  begin
    if(en==1)
      begin
        // priority encoder
        // if condition to chose 
        // output based on priority. 
        if(i[7]==1) y=3'b111;
        else if(i[6]==1) y=3'b110;
        else if(i[5]==1) y=3'b101;
        else if(i[4]==1) y=3'b100;
        else if(i[3]==1) y=3'b011;
        else if(i[2]==1) y=3'b010;
        else if(i[1]==1) y=3'b001;
        else
        y=3'b000;
      end
     // if enable is zero, there is
     // an high impedance value. 
    else y=3'bzzz;
  end
endmodule

// 7bit -> float, 1 bit-> int
module mult_tb();
  
  reg [7:0] a,b;
  wire [15:0] m;
  wire [7:0] res;
  
  assign res = m[14:7];
  
  mult mlt(a, b, m);
  
  initial begin
    
    a = 8'd196;
    b = 8'b11110010;
    #50;
    
    a = 8'd196;
    b = 8'b00001110;
    
    #50;
    
  end
  
  
  
endmodule
