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
reg start_flag;
parameter N =  59; // Number of Words minus 1
always @(posedge clk or negedge rst or posedge en)begin
   if (!rst) begin
     out <= 0;
     valid <= 0;
   end else if (en) begin
     start_flag <= 1;
     valid <= 1;
   end else if(!en)begin
      start_flag <= 0; 
   end
end
always @(posedge clk)begin
   if(start_flag)begin
        if(out < N)begin
            out <= out + 1;
            valid <= 1;
        end else begin
            start_flag <=0;
            valid <= 0;
        end 
            
   end 
end
endmodule
