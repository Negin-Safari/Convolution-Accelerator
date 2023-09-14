module RAM #(parameter n, parameter m, parameter p = 28)(clk, rst, wr, rd, adr, datain, dataout, full);
  
  input clk, rst, wr, rd;
  input[m-1:0] adr;
  input [n-1:0] datain;
  
  output [n-1:0] dataout;
  
  output full;
  
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
   else if(full) begin
     top = 0;
   end 
    else if(wr) begin
     mem[top] = datain;
     top = top + 1;
   end
    
   end
  
  assign full = (top == p*p) ? 1 : 0;
  
  assign dataout =(rd)? mem[adr] : 1'bz;
  
endmodule
