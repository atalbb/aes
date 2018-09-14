`timescale 10ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2018 11:58:22 PM
// Design Name: 
// Module Name: dataAddrCounter
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
module dataAddrCounter(input clk, input rst ,input start,output reg [7:0]dataAddrCount);
parameter NDATA = 17;    // Number of 32 bit data in Data BRAM



    /* always block to update state every 1 clock cycle */   
always @ (posedge clk or negedge rst)begin
        if(!rst)begin 
            dataAddrCount <= 0;
        end else begin
            if(start)begin
                if(dataAddrCount < NDATA)begin
                    dataAddrCount <= dataAddrCount + 1;
                end
            end
        end
end  
endmodule
