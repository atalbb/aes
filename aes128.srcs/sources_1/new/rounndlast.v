`timescale 1ns / 1ps

module rounndlast(clk,decrypt,rc,rin,keylastin,fout);
input clk;
input decrypt;
input [3:0]rc;
input [127:0]rin;
input [127:0]keylastin;
output [127:0]fout;

wire [127:0] sb,sr,mcl,keyout;

KeyGeneration t0(rc,decrypt,keylastin,keyout);
subbytes t1(rin,sb,decrypt);
shiftrow t2(sb,sr,decrypt);
assign fout= keyout^sr;

endmodule
