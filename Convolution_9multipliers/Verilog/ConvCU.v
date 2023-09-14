module ConvCU #(parameter p, parameter m)(clk, rst, start, sh, selpix, sel0,
                   init0, pixadr, avail, done, rd_inram, full, load);
  
  input clk, rst, start, full;
  
  output reg sh, selpix, sel0, init0, avail, done, rd_inram,load;
  output [m-1:0] pixadr;
  
  reg cencol, cenrow, cenadr, cenlast;
  reg[3:0] ps, ns;
  
  wire cocol, corow, coadr, colast;
  wire [m-1:0] cntcol, goalcol, goalrow, cntrow, goaladr, cntadr, goallast, cntlast;
  
  assign goalcol = p-1;
  
  assign goalrow = p;
  
  assign goallast = p+1;
  
  assign goaladr = p*p;
  
  assign pixadr = cntadr; 
  
  Counter #(m) ColCounter(clk, rst, init0, cencol, goalcol, cntcol, cocol);
  
  Counter #(m) RowCounter(clk, rst, init0, cenrow, goalrow, cntrow, corow);
  
  Counter #(m) AdrCounter(clk, rst, init0, cenadr, goaladr, cntadr, coadr);
  
  Counter #(m) lastCounter(clk, rst, init0, cenlast, goallast, cntlast, colast);
  
  always @(posedge clk, posedge rst) begin
    if(rst)
      ps = 0;
    else
      ps = ns;
  end 
  
  always @(ps, cocol, start, cntrow, cenrow, colast) begin
    case(ps)
      0: ns = (start) ? 1 : 0;
      1: ns = 2;//(full) ? 2 : 1;
       
      2: ns = 3;
      3: ns = 4;
      4: ns = (cocol) ? 5 : 4;
      5: ns = 6;
      6: ns = (cocol) ? 7 : 6;
      7: ns = 8;
      8: ns = (cenrow && (cntrow == (p-1))) ? 9 : 
              (cocol) ? 7 : 8; 
      9: ns = (colast) ? 10 : 9;
      10: ns = 11;
      11: ns = 0;
    endcase
  end
  
  always @(ps, cntcol, cntlast) begin
    sh = 0; init0 = 0; sel0 = 0; selpix = 0; cencol = 0; cenadr = 0; cenrow = 0; avail = 0; cenlast = 0;
    done = 0; rd_inram = 0; load = 0;
    case(ps)
      0: begin sh = 0; init0 = 1; end
      1: begin  load = 1; end // cenadr = 1;
        
      2: begin init0 = 1; sh = 0; end
      3: begin sel0 = 1; sh = 1; end
      4: begin 
            selpix = 1; cencol = 1; cenadr = 1; sh = 1;
            rd_inram = 1;
            if(cntcol == p-1) cenrow = 1;
         end 
      5: begin sh = 1; sel0 = 1; end
      6: begin 
            selpix = 1; cencol = 1; cenadr = 1; sh = 1;
            rd_inram = 1;
            if(cntcol == p-1) cenrow = 1;
            if(cntcol >= 2) avail = 1;
         end
      7: begin sh = 1; sel0 = 1; avail = 1; end
      8: begin 
            selpix = 1; cencol = 1; cenadr = 1; sh = 1;
            rd_inram = 1;
            if(cntcol == p-1) cenrow = 1;
            if(~(cntcol == 1)) avail = 1;
         end
      9: begin 
            sel0 = 1; cenlast = 1; sh = 1;
            if(~(cntlast == 2)) avail = 1;
         end
      10: begin avail = 1; end
      11: begin done = 1; end
    endcase  
  end
  

endmodule
