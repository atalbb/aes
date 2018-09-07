`timescale 10ns / 1ps

module rounds(clk,rc,data,rndout);
input clk;
input [3:0]rc;
input [127:0]data;
//input [127:0]keyin;
//output [127:0]keyout;
wire [127:0]keyout;
output [127:0]rndout;

wire [127:0] sb,sr,mcl;

KeyGeneration t0(rc,0,keyout);
subbytes t1(data,sb);
shiftrow t2(sb,sr);
mixcolumn t3(sr,mcl);
assign rndout= keyout^mcl;

endmodule
