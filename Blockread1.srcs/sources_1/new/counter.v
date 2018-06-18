`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/28/2017 06:13:23 PM
// Design Name: 
// Module Name: counter
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


module counter(input wire clk,
                input wire rst,
                 input wire en,
                 output reg [7:0]out
    );
always @(posedge clk or negedge rst)
 if (!rst) begin
   out <= 8'b0 ;
 end else if (en) begin
   if(out < 66) 
    out <= out + 1;
 end

endmodule
