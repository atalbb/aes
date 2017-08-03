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
           input wire enKeyIn,
           output done,
           //output [31:0]key           
           output [31:0]keyInBRAMOUT
           //output [31:0]keyOut
           );
           
wire Kdone;
wire [255:0]keyOut;
//wire [255:0]Kdo;
//wire [511:0]Mdo;
wire [31:0]keyInBRAMOUT;
wire [7:0]keyAddr;
wire keyValid;
//wire digestDone;
//wire [159:0]digest;
keycounter KC0(clk,rst,enKeyIn,keyValid,keyAddr);
blk_mem_gen_0 B0(clk,keyValid,0,keyAddr,32'h0,keyInBRAMOUT);//BRAM for HashIn
//KeyIn K1(clk,rst,enKeyIn,keyAddr,keyInBRAMOUT,Kdone,keyOut);
//key_expansion KX1(clk,rst,Kdone,keyOut,done,key);
//core_logic SHA1(clk,rst,Hdone,Hdo,Mdo,digestDone,digest,led0,ledout);//,led1);
//uart_tx U1(clk,rst,digest,ready,TxD);

endmodule


