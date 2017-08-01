`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/15/2017 12:58:31 PM
// Design Name: 
// Module Name: HashIn
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


module KeyIn(input wire clk,
              input wire rst, 
               input wire en,
               input wire [7:0]addr, 
               input wire [31:0]di,
               output reg done,
               output reg [255:0]KeyO
               );
parameter delay = 3'b0;
parameter END_ADDR = 10;
reg [31:0] RAM [7:0]; // 32bit RAM x 16 slots= 512 bit(64 Byte) RAM
always @(posedge clk or negedge rst)begin
  if(!rst) begin
    done <= 0;
    KeyO <= 0;
  end 
  else if(en)begin
       if(addr < END_ADDR)begin 
           RAM[addr-1] <= di;
           if(addr == END_ADDR-1)begin 
               KeyO <=  {RAM[0],RAM[1],RAM[2],RAM[3],RAM[4],RAM[5],RAM[6],RAM[7]};
             //hashO <= {RAM[0],RAM[1],RAM[2],RAM[3],RAM[4]};
             //msgO <= {RAM[5],RAM[6],RAM[7],RAM[8],RAM[9],RAM[10],RAM[11],RAM[12],RAM[13],RAM[14],RAM[15],RAM[16],RAM[17],RAM[18],RAM[19],RAM[20]};
           end
       end else if(addr >= END_ADDR)
                   done <= #delay 1;
   end
end

endmodule
