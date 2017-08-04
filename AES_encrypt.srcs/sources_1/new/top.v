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
           output wire [31:0]plainTextBRAMOUT
           );
wire plainTextAddrValid;
wire [256:0]plainTextAddr;       
PlaintextAddrCounter PT1(clk,rst,enPlainTextIn,plainTextAddrValid,plainTextAddr);
blk_mem_gen_0 B0(clk,plainTextAddrValid,0,plainTextAddr,32'h0,plainTextBRAMOUT);//BRAM for HashIn

endmodule


