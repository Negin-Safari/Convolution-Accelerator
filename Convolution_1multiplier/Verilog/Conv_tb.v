`timescale 1ns/1ns
module Conv_tb();
  
  reg clk = 0, rst, start;
  reg rd;
  reg [10-1:0] adr;
  
  wire avail, done;
  wire [8-1:0] result, dataout; 
  reg [8-1:0] datain;
  
  reg [8-1:0] mem [0:((2**10)-1)];
  reg [8*9-1:0] kernel;
  
  Conv #(28, 10, 8)uut(clk, rst, start, avail, done, result, datain, dataout, rd, adr, kernel);
  
  //RAM #(8, 10) rmm(clk, rst, avail, rd, adr, result, dataout);
  
  initial repeat(20000) #5 clk = ~clk;
  
  initial begin
    kernel = 72'b000011100000111000001110000011100000111000001110000011100000111000001110;
    rd = 0;
    rst = 1;
    #6;
    rst = 0;
    start = 1;
    #10;
    start = 0;
    #9000;
    
   
  end
  
  integer f, i, j;
  initial begin
  f = $fopen("output.txt","w");
 end
 
 initial begin
    $readmemb("input.txt", mem);
  end 
 
 

initial begin
  #16;
  for (j = 0; j<28*28; j=j+1) begin
    datain = mem[j];
    #10;
  end
end
 
 
 

initial begin
  #95000;
  for (i = 0; i<28*28; i=i+1) begin
    adr = i;
    rd = 1;
    #4;
    $fwrite(f,"%b\n",dataout);
    #1;
  end
  rd = 0;
end

initial begin
  #100000;
  $fclose(f);  
end
  
endmodule
