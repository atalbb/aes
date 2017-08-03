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


module encrypt(input wire clk,
              input wire rst, 
               input wire keyStart,
               input wire [7:0]addr, 
               input wire [31:0]di,
               output reg done
               //output reg [255:0]KeyO
               );
parameter delay = 3'b0;
parameter END_ADDR = 121;
reg [31:0] RAM [119:0]; // 32bit RAM x 16 slots= 512 bit(64 Byte) RAM
always @(posedge clk or negedge rst)begin
  if(!rst) begin
    done <= 0;
  end 
  else if(keyStart)begin
           if(addr < END_ADDR) 
               RAM[addr-1] <= di; 
           if(addr >= END_ADDR)
               done <= #delay 1;
  end
end
reg [5:0] curr_state, next_state;
parameter RESET = 0;
always@(posedge clk or negedge rst) begin
     if(!rst) begin
        curr_state <= RESET;
        //digest_done <= 0;    
     end else begin
        curr_state <= next_state;
     end
end
always @(curr_state or keyStart or addr)begin
    case(curr_state)
        RESET:begin
                done = 0;
                next_state = 1;
              end
        1:begin
                        
        end
    endcase
end
endmodule
