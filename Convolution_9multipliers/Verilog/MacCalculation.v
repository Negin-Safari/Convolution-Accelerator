module MacCalculation #(parameter n)(kernel, in0, in1, in2, in3, in4, in5, in6, in7, in8, out);
  
  input [n-1:0] in0, in1, in2, in3, in4, in5, in6, in7, in8;
  input [n*9-1:0] kernel;
  output [n-1:0] out;
  
  wire [2*n-1:0] m0out, m1out, m2out, m3out, m4out, m5out, m6out, m7out, m8out;
  wire [2*n+8:0] res;
  
 // assign out = (in0 + in1 + in2 + in3 + in4 + in5 + in6 + in7 + in8)/9;
 
 
 //mult m0(in0, 8'b00001110, m0out);
// mult m1(in1, 8'b00001110, m1out);
// mult m2(in2, 8'b00001110, m2out);
// 
// mult m3(in3, 8'b00001110, m3out);
// mult m4(in4, 8'b00001110, m4out);
// mult m5(in5, 8'b00001110, m5out);
// 
// mult m6(in6, 8'b00001110, m6out);
// mult m7(in7, 8'b00001110, m7out);
// mult m8(in8, 8'b00001110, m8out);
 
 
 //mult_1 m0(in0, 8'b00001110, m0out);
// mult_1 m1(in1, 8'b00001110, m1out);
// mult_1 m2(in2, 8'b00001110, m2out);
// 
// mult_1 m3(in3, 8'b00001110, m3out);
// mult_1 m4(in4, 8'b00001110, m4out);
// mult_1 m5(in5, 8'b00001110, m5out);
// 
// mult_1 m6(in6, 8'b00001110, m6out);
// mult_1 m7(in7, 8'b00001110, m7out);
// mult_1 m8(in8, 8'b00001110, m8out);
 
 
 mult_1_h m0(in0, kernel[n-1:0], m0out);
 mult_1_h m1(in1, kernel[(2*n-1):n], m1out);
 mult_1_h m2(in2, kernel[(3*n-1):(2*n)], m2out);
 
 mult_1_h m3(in3, kernel[(4*n-1):(3*n)], m3out);
 mult_1_h m4(in4, kernel[(5*n-1):(4*n)], m4out);
 mult_1_h m5(in5, kernel[(6*n-1):(5*n)], m5out);
 
 mult_1_h m6(in6, kernel[(7*n-1):(6*n)], m6out);
 mult_1_h m7(in7, kernel[(8*n-1):(7*n)], m7out);
 mult_1_h m8(in8, kernel[(9*n-1):(8*n)], m8out);


 //mult_2 m0(in0, 8'b00001110, m0out);
// mult_2 m1(in1, 8'b00001110, m1out);
// mult_2 m2(in2, 8'b00001110, m2out);
// 
// mult_2 m3(in3, 8'b00001110, m3out);
// mult_2 m4(in4, 8'b00001110, m4out);
// mult_2 m5(in5, 8'b00001110, m5out);
// 
// mult_2 m6(in6, 8'b00001110, m6out);
// mult_2 m7(in7, 8'b00001110, m7out);
// mult_2 m8(in8, 8'b00001110, m8out);
 
 assign res = m0out + m1out + m2out + m3out + m4out + m5out + m6out + m7out + m8out;
 
 assign out = res[14:7];
  
endmodule