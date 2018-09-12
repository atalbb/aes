`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/11/2018 12:33:49 PM
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
    
reg CLK,RST;
reg [1:0]START;
wire [127:0]DATAOUT;
//wire DATAOUT;
wire DONE;
top T(CLK,RST,START,DONE,DATAOUT);     

initial begin
         CLK = 0;
         RST = 0;
         START = 2;
    #10 RST = 1;
         //START = 2'b10;
    #1000  $finish; // 1 clk for done signal to go down
end
         
always
    #5 CLK = ~CLK;
endmodule
