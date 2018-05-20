`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2018 01:52:36 PM
// Design Name: 
// Module Name: enc_testbench
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


module enc_testbench(

    );
parameter HALF_CLK = 5;
parameter FULL_CLK = 2*HALF_CLK;
parameter _5_FULL_CLK = 5 * FULL_CLK;
parameter _16_FULL_CLK = 16 * FULL_CLK;
parameter _17_FULL_CLK = 17 * FULL_CLK;
//parameter
reg clk,rst,enb,uReady;
wire finalDone,ledDone;
wire [7:0]ledOut;
wire [127:0]_cipher;
//top T(clk,rst,enb,uReady,finalDone,ledDone,ledOut);
aes_enc_core AES1(clk,rst,enb,0,0,finalDone,_cipher,ledDone,ledOut);
initial begin
    clk = 0;
    rst = 1;
    enb = 0;
    #100 rst = 0;
    #100 rst = 1;
    #100 enb = 1;
    #_5_FULL_CLK //enbm = 1; // 5 clks to read Initial Hash
    #_16_FULL_CLK // 16 clks to read Data
    #_17_FULL_CLK// 16 clocks for SHA1 conversiona & serializing to five 32-bit data
    #500  $finish; // 1 clk for done signal to go down
end

always
    #HALF_CLK clk = ~clk;

endmodule
