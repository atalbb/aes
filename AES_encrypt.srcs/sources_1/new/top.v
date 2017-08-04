`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/28/2017 05:56:32 PM
// Design Name: 
// Module Name: top
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




module top(input wire clk,
           input wire rst,
           input wire enPlainTextIn,
           output plainTextAddrValid,
           output [7:0]plainTextAddr 
           );
           
PlaintextAddrCounter PT1(clk,rst,enPlainTextIn,plainTextAddrValid,plainTextAddr);

endmodule


