`timescale 10ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2018 11:58:22 PM
// Design Name: 
// Module Name: keyAddrCounter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module keyAddrCounter(input clk, input rst ,input [1:0]start,output reg [7:0]keyAddrCount);
parameter NDATA1 = 63;    // Number of 32 bit data in Data BRAM
parameter NDATA2 = 121;
/* always block to update state every 1 clock cycle */   
always @ (posedge clk or negedge rst)begin
    if(!rst)begin 
        if(start == 1)begin
            keyAddrCount <= 0;
        end else if(start == 2)begin
            keyAddrCount <= 60;
        end
    end else begin
        if(start == 1)begin
            if(keyAddrCount < NDATA1)begin
                keyAddrCount <= keyAddrCount + 1;
            end
        end else if(start == 2)begin
            if(keyAddrCount < NDATA2)begin
                keyAddrCount <=  keyAddrCount + 1;
            end
        end
    end
end  
endmodule
