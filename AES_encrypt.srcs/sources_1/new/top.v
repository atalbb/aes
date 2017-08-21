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
           input wire enExpandedKeyIn,
           input wire enPlainTextIn,           
           //output [31:0]plainTextBRAMOUT,
           //output [31:0]expandedKeyBRAMOUT
           output wire cipherTextDone,
           output wire [31:0]cipherTextOut
           );
wire [31:0]plainTextBRAMOUT;
wire [31:0]expandedKeyBRAMOUT;
wire plainTextAddrValid;
wire expandedKeyAddrValid;
wire [7:0]plainTextAddr;       
wire [7:0]expandedKeyAddr;       
PlaintextAddrCounter PT1(clk,rst,enPlainTextIn,plainTextAddrValid,plainTextAddr);
blk_mem_gen_0 B0(clk,plainTextAddrValid,0,plainTextAddr,32'h0,plainTextBRAMOUT);//BRAM for HashIn
expandedKeyAddrCounter EK0(clk,rst,enExpandedKeyIn,expandedKeyAddrValid,expandedKeyAddr);
blk_mem_gen_1 B1(clk,expandedKeyAddrValid,0,expandedKeyAddr,32'h0,expandedKeyBRAMOUT);//BRAM for HashIn
encryption E0(clk,rst,enExpandedKeyIn,expandedKeyBRAMOUT,enPlainTextIn,plainTextBRAMOUT,cipherTextDone,cipherTextOut);

endmodule


