`timescale 10ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/11/2018 12:45:29 PM
// Design Name: 
// Module Name: keyBuffer
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


module keyBuffer(input clk,
                  input reset,
                  input [1:0]start,
                  input [7:0]addr,
                  input [31:0]keyIn,
                  output reg [1919:0]keyOut,
                  output reg keyReady
                );
reg [31:0] RAM [62:0]; // 32bit RAM x 16 slots= 512 bit(64 Byte) RAM
always @(posedge clk or negedge reset)begin
  if(!reset) begin
    keyOut <= 0;
    keyReady <= 0;
  end 
  else if(start == 1)begin
       if(addr < 61)begin 
             RAM[addr-1] <= keyIn;
       end 
       if(addr == 61)begin 
              keyOut <= {RAM[0],RAM[1],RAM[2],RAM[3],RAM[4],RAM[5],RAM[6],RAM[7],RAM[8],RAM[9],
                       RAM[10],RAM[11],RAM[12],RAM[13],RAM[14],RAM[15],RAM[16],RAM[17],RAM[18],RAM[19],
                       RAM[20],RAM[21],RAM[22],RAM[23],RAM[24],RAM[25],RAM[26],RAM[27],RAM[28],RAM[29],
                       RAM[30],RAM[31],RAM[32],RAM[33],RAM[34],RAM[35],RAM[36],RAM[37],RAM[38],RAM[39],
                       RAM[40],RAM[41],RAM[42],RAM[43],RAM[44],RAM[45],RAM[46],RAM[47],RAM[48],RAM[49],
                       RAM[50],RAM[51],RAM[52],RAM[53],RAM[54],RAM[55],RAM[56],RAM[57],RAM[58],RAM[59]};
              keyReady <=  1;
       end 
   end   else if(start == 2)begin
        if(addr < 121)begin 
              RAM[addr-60-1] <= keyIn;
        end 
        if(addr == 121)begin 
               keyOut <= {RAM[0],RAM[1],RAM[2],RAM[3],RAM[4],RAM[5],RAM[6],RAM[7],RAM[8],RAM[9],
                        RAM[10],RAM[11],RAM[12],RAM[13],RAM[14],RAM[15],RAM[16],RAM[17],RAM[18],RAM[19],
                        RAM[20],RAM[21],RAM[22],RAM[23],RAM[24],RAM[25],RAM[26],RAM[27],RAM[28],RAM[29],
                        RAM[30],RAM[31],RAM[32],RAM[33],RAM[34],RAM[35],RAM[36],RAM[37],RAM[38],RAM[39],
                        RAM[40],RAM[41],RAM[42],RAM[43],RAM[44],RAM[45],RAM[46],RAM[47],RAM[48],RAM[49],
                        RAM[50],RAM[51],RAM[52],RAM[53],RAM[54],RAM[55],RAM[56],RAM[57],RAM[58],RAM[59]};
               keyReady <=  1;
        end 
   end
end
endmodule

