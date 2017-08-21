`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/02/2017 09:46:18 AM
// Design Name: 
// Module Name: aes_enc_tb
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


module aes_enc_tb(

    );
parameter HALF_CLK = 5;
    parameter FULL_CLK = 2*HALF_CLK;
    parameter _5_FULL_CLK = 5 * FULL_CLK;
    parameter _16_FULL_CLK = 16 * FULL_CLK;
    parameter _17_FULL_CLK = 17 * FULL_CLK;
    //parameter
    reg clk,rst,enb,enk;
    wire [31:0]data;
    wire finalDone;
    top T(clk,rst,enk,enb,finalDone,data);
    initial begin
        clk = 0;
        rst = 1;
        enb = 0;
        enk = 0;
        #50 rst = 0;
        #50 rst = 1;
//        #50 enb = 1;
//        #100 enb = 0;
//        #50 enb = 1;
//        #50 enb = 0;
//        #100 enb = 1;
//        #100 enb = 0;
//        #100 enb = 1;
//        #100 enb = 0;
          #50 enk = 1;
         #650 enk = 0;
         #50 enb = 1;
         #100 enb = 0;
        #10  $finish; // 1 clk for done signal to go down;
    end
    
    always
        #HALF_CLK clk = ~clk;
    
    endmodule
