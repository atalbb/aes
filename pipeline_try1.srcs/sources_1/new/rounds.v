`timescale 10ns / 1ps

module rounds(clk,reset,decrypt,rc,data,rndout);
input clk,reset,decrypt;
input [3:0]rc;
input [127:0]data;
//input [127:0]keyin;
//output [127:0]keyout;
wire [127:0]keyout;
output [127:0]rndout;

//wire [127:0] sb,sr,mcl;
reg [127:0]subBytesIn,shiftRowIn,mixColIn;
wire [127:0] subBytesOut,shiftRowOut,mixColOut;
//reg [127:0]addRoundKeyData;
//reg [127:0]addRoundKeyResult;
//KeyGeneration t0(rc,0,keyout);
KeyGeneration t0(rc,decrypt,0,keyout);
//subbytes t1(subBytesIn,subBytesOut);
subbytes t1(subBytesIn,subBytesOut,decrypt);
//shiftrow t2(shiftRowIn,shiftRowOut);
shiftrow t2(shiftRowIn,shiftRowOut,decrypt);
//mixcolumn t3(mixColIn,mixColOut);
mixcolumn t3(mixColIn,mixColOut,decrypt);
assign rndout= (decrypt==0)?(keyout^mixColOut):(mixColOut);

always @(posedge clk or negedge reset)
    begin    
      if(!reset)begin
          subBytesIn <= 0;
          shiftRowIn <= 0;
          mixColIn <= 0;
      end else begin
            if(decrypt == 0)begin
                subBytesIn <= data;
                shiftRowIn <= subBytesOut;
                mixColIn <= shiftRowOut;
                //rndout <= keyout^mixColOut;                
            end else if(decrypt == 1)begin
                subBytesIn <= shiftRowOut;
                shiftRowIn <= data;
                mixColIn <= keyout ^ subBytesOut;
//                rndout <= mixColOut; 
           end
      end
    
end 

endmodule
