`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/28/2018 12:27:07 AM
// Design Name: 
// Module Name: AES_TB
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


module AES_TB;
parameter HALF_CLK = 5;
parameter FULL_CLK = 2*HALF_CLK;
parameter _5_FULL_CLK = 5 * FULL_CLK;
parameter _16_FULL_CLK = 16 * FULL_CLK;
parameter _17_FULL_CLK = 17 * FULL_CLK;
	// Inputs
	reg clk,reset,start;
    
	// Outputs
	wire [127:0] finalout;
	wire finalDone;

	// Instantiate the Unit Under Test (UUT)
	AES_TOP uut (
		.clk(clk), 
		.reset(reset),
		.start(start),
		.finalout(finalout),
        .finalDone(finalDone)
	);

initial begin
    clk = 0;
    reset = 0;
    start = 0;
    #100 reset = 1;
    #100 reset = 0;
    #100 start = 1;
    #_5_FULL_CLK //enbm = 1; // 5 clks to read Initial Hash
    #_16_FULL_CLK // 16 clks to read Data
    #_17_FULL_CLK// 16 clocks for SHA1 conversiona & serializing to five 32-bit data
    #500  $finish; // 1 clk for done signal to go down
end

always
    #5 clk = ~clk;
endmodule

      



