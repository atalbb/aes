`timescale 1ns / 1ps

//module AES_TOP(clk,reset,start,finalout,finalDone);
module AES_TOP(clk,rst,start,ready,TxD,finalDone);
    input clk,rst,start;
    //output [127:0] finalout;
    //output finalDone;
output TxD;
input ready;
wire [127:0] finalout;
wire [127:0] plaintext;
wire [127:0] tempout;
output finalDone;



aescipher u1(
             .clk(clk),
             .reset(rst),
             .load_i(start),
             .decrypt_i(1'b0),
             .data_i(128'h 00112233445566778899aabbccddeeff),
             .key(128'h 000102030405060708090a0b0c0d0e0f),
             .ready_o(finaldone),
             .data_o(finalout));
             
uart_tx T1(.clk(clk),.reset(rst),.digest_in(finalout),.ready(ready),.TxD(TxD));
//assign finalout = tempout;

endmodule
