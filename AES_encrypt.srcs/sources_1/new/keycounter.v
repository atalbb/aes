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


module keycounter(input wire clk,
                input wire rst,
                 input wire en,
                 output reg valid,
                 output reg [7:0]out
    );
//reg start_flag;
reg [7:0]N; // Number of Words minus 1
reg [7:0]addr;
always @(posedge clk or negedge rst)begin
   if (!rst) begin
     out <= 0;
     valid <= 0;
     addr <= 0;
   end else if (en) begin
     out <= addr;
     valid <= 1;
     if(addr < N)
        addr <= addr + 1;
   end else if(!en)begin
      valid <= 0;
   end
end
endmodule
