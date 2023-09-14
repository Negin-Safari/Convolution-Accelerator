module RAM #(parameter n, parameter m)(clk, rst, wr, rd, adr, datain, dataout);
  
  input clk, rst, wr, rd;
  input[m-1:0] adr;
  input [n-1:0] datain;
  
  output [n-1:0] dataout;
  
  reg[m-1:0] top;
  
  reg [n-1:0] mem [0:((2**m)-1)]; //((2**m)-1)
  integer i;
  always @(posedge clk, posedge rst) begin
    if(rst) begin
      top = 0;
      for(i =0; i<((2**m)-1); i=i+1) begin
        mem[i] = 0;
      end
    end
    
    else if(wr) begin
     mem[top] = datain;
     top = top + 1;
   end
    
   end
  
  assign dataout =(rd)? mem[adr] : 1'bz;
  
endmodule
