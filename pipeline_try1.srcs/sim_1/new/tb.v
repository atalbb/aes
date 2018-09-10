`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2018 05:05:07 PM
// Design Name: 
// Module Name: tb
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


module tb(

    );
    
parameter HALF_CLK = 5;
parameter FULL_CLK = 2*HALF_CLK;
parameter _5_FULL_CLK = 5 * FULL_CLK;
parameter _16_FULL_CLK = 16 * FULL_CLK;
parameter _17_FULL_CLK = 17 * FULL_CLK;
//parameter
reg CLK,RST,LOADKEY,LOADDATA,START;
reg ENCDECSELECT;
wire DATAOUTDONE;
wire [127:0]DATAOUT;
//wire [31:0]DATABRAM;
//top T(clk,rst,enb,uReady,finalDone,ledDone,ledOut);
top T(CLK,RST,LOADKEY,LOADDATA,START,ENCDECSELECT,DATAOUT,DATAOUTDONE);
initial begin
         CLK = 0;
         RST = 0;
         LOADKEY = 0;
         LOADDATA = 0;
         START = 0;
         ENCDECSELECT = 0;
    #100 RST = 1;
//         ENCDECSELECT = 1;
    #100 LOADKEY = 1;
         LOADDATA = 1;
    #40  START = 1;
    //#40  LOADDATA = 0;   
    #1000  $finish; // 1 clk for done signal to go down
end

always
    #HALF_CLK CLK = ~CLK;

    
endmodule
