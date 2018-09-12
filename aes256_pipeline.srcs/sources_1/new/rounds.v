`timescale 10ns / 1ps

module rounds(clk,decrypt_i,data,keyin,rndout);
input clk;
input decrypt_i;
input [127:0]data;
input [127:0]keyin;
//wire [127:0]keyout;
output [127:0]rndout;

wire [127:0] sb,sr,mcl;

//KeyGeneration t0(rc,keyin,keyout);
subbytes t1(clk,data,sb,decrypt_i);
shiftrow t2(sb,sr,decrypt_i);
mixcolumn t3(sr,mcl,decrypt_i);
assign rndout= keyin^mcl;

endmodule
