`timescale 10ns / 1ps

module rounds(clk,decrypt_i,data,keyin,rndout);
input clk;
input decrypt_i;
input [127:0]data;
input [127:0]keyin;
//wire [127:0]keyout;
output reg [127:0]rndout;

wire [127:0] sb,sr,mcl;

reg [127:0]subBytesIn,shiftRowIn,mixColIn;
wire [127:0] subBytesOut,shiftRowOut,mixColOut;
//KeyGeneration t0(rc,keyin,keyout);
//subbytes t1(clk,data,sb,decrypt_i);
//shiftrow t2(sb,sr,decrypt_i);
//mixcolumn t3(sr,mcl,decrypt_i);
//assign rndout= keyin^mcl;

subbytes t1(clk,subBytesIn,subBytesOut,decrypt_i);
shiftrow t2(shiftRowIn,shiftRowOut,decrypt_i);
mixcolumn t3(mixColIn,mixColOut,decrypt_i);


always @(posedge clk)
    begin    

                subBytesIn <= data;
                shiftRowIn <= subBytesOut;
                mixColIn <= shiftRowOut;
                rndout <= keyin^mixColOut;   


      end    
endmodule
