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
           input wire encStart,
           input wire ready,
           output TxD,
           output led0,
           output [7:0]ledout
           );
           
wire [1919:0]Hdo;
wire [127:0]Mdo;
wire _encDone;
wire [127:0]_cipher;

aes_enc_core AES1(clk,rst,encStart,Hdo,Mdo,_encDone,_cipher,led0,ledout);//,led1);
uart_tx U1(clk,rst,_cipher,ready,TxD);

endmodule


