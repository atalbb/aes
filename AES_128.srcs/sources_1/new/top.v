`include "timescale.v"
//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/30/2018 01:49:24 PM
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


//module AES_TOP(clk,reset,start,finalout,finalDone);
module top(clk,rst,start,ready,TxD);

input clk,rst,start;
output TxD;
input ready;
wire [127:0]text_out;
wire done;

//aes u0 (
//    .clk(clk),
//	.reset(rst),
//	.load_i(start),
//	.decrypt_i(1'b0),
//	.data_i(128'h f34481ec3cc627bacd5dc3fb08f273e6),
//	.key_i(128'h 00000000000000000000000000000000),
//	.ready_o(done),
//	.data_o(text_out)
//	);

aes u0 (
    .clk(clk),
	.reset(rst),
	.load_i(start),
	.decrypt_i(1'b1),
	.data_i(128'h 0336763e966d92595a567cc9ce537f5e),
	.key_i(128'h 00000000000000000000000000000000),
	.ready_o(done),
	.data_o(text_out)
	);


uart_tx T1(.clk(clk),.reset(rst),.digest_in(text_out),.ready(ready),.TxD(TxD));




endmodule
