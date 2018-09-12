`timescale 10ns / 1ps

module rounndlast(clk,decrypt_i,rin,keylastin,fout);
input clk,decrypt_i;
input [127:0]rin;
input [127:0]keylastin;
output [127:0]fout;

wire [127:0] sb,sr,mcl;

//KeyGeneration t0(rc,keylastin,keyout);
subbytes t1(clk,rin,sb,decrypt_i);
shiftrow t2(sb,sr,decrypt_i);
assign fout= keylastin^sr;

endmodule
