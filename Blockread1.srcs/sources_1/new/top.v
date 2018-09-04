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
           input wire enHashIn,
           input wire ready,
           output TxD,
           output led0,
           output [7:0]ledout
           );
           
wire Hdone;
wire [1919:0]Hdo;
wire [127:0]Mdo;
wire [31:0]hashInBRAMOUT;
wire [31:0]DataInBRAMOUT;
wire [7:0]hashAddr;
wire [7:0]DataAddr;
wire digestDone;
wire [127:0]digest;
counter C0(clk,rst,enHashIn,hashAddr);
//counter C1(clk,rst,enHashIn,DataAddr);
blk_mem_gen_0 B0(clk,enHashIn,0,hashAddr,32'h0,hashInBRAMOUT);//BRAM for HashIn
//blk_mem_gen_0 B1(clk,enHashIn,0,DataAddr,32'h0,DataInBRAMOUT);//BRAM for HashIn
HashMsgIn HM1(clk,rst,enHashIn,hashAddr,hashInBRAMOUT,Hdone,Hdo,Mdo);
aes_enc_core AES1(clk,rst,Hdone,Hdo,Mdo,digestDone,digest,led0,ledout);//,led1);
uart_tx U1(clk,rst,digest,ready,TxD);

endmodule


