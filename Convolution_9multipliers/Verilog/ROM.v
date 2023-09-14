module ROM #(parameter n, parameter m)(adr, data);
  
  input[m-1:0] adr;
  
  output [n-1:0] data;
  
  reg [n-1:0] mem [0:((2**m)-1)]; //((2**m)-1)
  
  initial begin
    $readmemb("input.txt", mem);
  end 
  
  assign data = mem[adr];
  
endmodule


module romt #(parameter n, parameter m)(adr, data);
  
  input[m-1:0] adr;
  
  output reg[n-1:0] data;
  
 // reg [n-1:0] mem [0:((2**m)-1)];
  
 /* initial begin
    $memreadh("pix.txt", mem);
  end */
  
  always @(adr) begin
    case(adr)
      0: data = 1;
      1: data = 2;
      2: data = 3;
      3: data = 4;
      4: data = 5;
      5: data = 6;
      6: data = 7;
      7: data = 8;
      8: data = 9;
      9: data = 10;
      10: data = 11;
      11: data = 12;
      12: data = 13;
      13: data = 14;
      14: data = 15;
      15: data = 16;
      16: data = 17;
      17: data = 18;
      18: data = 19;
      
      19: data = 20;
      
      20: data = 21;
      
      21: data = 22;
      
      22: data = 23;
      
      23: data = 24;
      
      24: data = 25;
      
      25: data = 26;
      26: data = 27;
      27: data = 28;
      28: data = 29;
      29: data = 30;
      
      30: data = 31;
      
      31: data = 32;
      
      32: data = 33;
      
      33: data = 34;
      
      34: data = 35;
      
      35: data = 36;


      
default : data =0;
   endcase
  end
  
 // assign data = mem[adr];
  
endmodule




module rom_tb();
  reg[6-1:0] adr;
  
  wire [8-1:0] data;
  
  romt #(8, 6) uut(adr, data);
  
  initial begin
    adr = 0;
    #20;
    adr = 10;
    #20;
    
  end
  
endmodule
    
  
  
  