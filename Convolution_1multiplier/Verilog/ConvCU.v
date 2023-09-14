module ConvCU #(parameter p, parameter m)(clk, rst, start, sh, selpix, sel0, init0, pixadr, avail, done,
                           wr_inram, rd_inram, startmult, donemult, load);
  
  input clk, rst, start, donemult;
  
  output reg sh, selpix, sel0, init0, done, wr_inram, rd_inram, startmult, load;
  output [m-1:0] pixadr;
  output avail;
  
  reg cencol, cenrow, cenadr, cenlast;
  reg[3:0] ps, ns;
  
  wire cocol, corow, coadr, colast;
  wire [m-1:0] cntcol, goalcol, goalrow, cntrow, goaladr, cntadr, goallast, cntlast;
  
  assign goalcol = p; ////////// p-1
  
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
  
  always @(ps, cocol, start, cntrow, cntcol, cntlast, cenrow, colast, coadr, startmult, donemult) begin
    case(ps)
      0: ns = (start) ? 1 : 0;
      1: ns = (coadr) ? 2 : 1;
       
      2: ns = 3;
      3: ns = 4;
      4: ns = (cntcol==(p-1)) ? 5 : 4;
      5: ns = 6;
      6: ns = (startmult) ? 12 : 6; // (startmult) ? 14 : 8;  
      7: ns = (startmult) ? 13 : 7;  //
      8: ns = (startmult) ? 14 : 8; //  (cenrow && (cntrow == (p-1))) ? 9 : (cocol) ? 7 : 8;
      9: ns =  (startmult) ? 15 : 9; //(colast) ? 10 : 9;
      10: ns = 11;
      11: ns = 0;
      12: ns = (donemult && (cntcol == 0)) ? 7 :(donemult) ? 6 : 12;
      13: ns = ((cntrow==0) && (cntcol==0)&& donemult)? 9 :(donemult) ? 8 : 13;
      14: ns = (donemult && (cntcol == 0)) ? 7 :
               (donemult) ? 8 : 14;
      15: ns = (donemult && (cntlast == 0)) ? 10 :
               (donemult) ? 9 : 15;
    endcase
  end
  
  always @(ps, cntcol, cntlast) begin
    sh = 0; init0 = 0; sel0 = 0; selpix = 0; cencol = 0; cenadr = 0; cenrow = 0;  cenlast = 0;
    done = 0; rd_inram = 0; wr_inram = 0; startmult = 0; load =0;
    case(ps)
      0: begin sh = 0; init0 = 1; end
      1: begin  cenadr = 1; wr_inram = 1; load = 1; end
        
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
            if(cntcol == p-1) cenrow = 1; ///// p-1
            if(cntcol >= 1) begin  startmult = 1; end ///
         end
      7: begin sh = 1; sel0 = 1; startmult = 1; end
      8: begin 
            selpix = 1; cencol = 1; cenadr = 1; sh = 1;
            rd_inram = 1;
            if(cntcol == p-1) cenrow = 1;
            if(~(cntcol == 0)) begin  startmult = 1; end ///1
         end
      9: begin 
            sel0 = 1; cenlast = 1; sh = 1;
            if(~(cntlast == 0)) begin startmult = 1; end
         end
      10: begin end
      11: begin done = 1; end
    endcase  
  end
  
  assign avail = donemult;

endmodule
