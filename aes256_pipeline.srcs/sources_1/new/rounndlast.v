`timescale 10ns / 1ps

module rounndlast(clk,decrypt_i,rin,keylastin,fout);
input clk,decrypt_i;
input [127:0]rin;
input [127:0]keylastin;
output reg[127:0]fout;


reg [127:0]subBytesIn,shiftRowIn,mixColIn;
wire [127:0] subBytesOut,shiftRowOut,mixColOut;
wire [127:0] sb,sr,mcl;

//KeyGeneration t0(rc,keylastin,keyout);
//subbytes t1(clk,rin,sb,decrypt_i);
//shiftrow t2(sb,sr,decrypt_i);
//assign fout= keylastin^sr;
subbytes t1(clk,subBytesIn,subBytesOut,decrypt_i);
shiftrow t2(shiftRowIn,shiftRowOut,decrypt_i);
//assign fout= keylastin^sr;


always @(posedge clk)
    begin    

                subBytesIn <= rin;
                shiftRowIn <= subBytesOut;
                //mixColIn <= shiftRowOut;
                fout <= keylastin^shiftRowOut;   


      end    
endmodule

