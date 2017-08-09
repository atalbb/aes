`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/07/2017 04:07:42 PM
// Design Name: 
// Module Name: encryption
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


module encryption(input clk,
                  input rst,
                  input expandedKeyEnable,
                  input [31:0]expandedKey,
                  input plaintextEnable,
                  input [31:0]plaintext,
                  output reg ciphertextDone,
                  output reg [31:0]ciphertext
    );
reg [5:0]curr_state, next_state;
reg [7:0]b[15:0];
reg [31:0]w[3:0];

always@(posedge clk or negedge rst)begin
    if(!rst)
        curr_state <= 0;
    else 
        curr_state <= next_state;
end

always@(curr_state or expandedKeyEnable)begin
    case (curr_state)
        0:begin
            next_state = 1;
        end
        1:begin
            if(expandedKeyEnable)
                next_state = 2;
        end
        2:begin
            if(expandedKeyEnable)
                next_state = 3;    
        end
        3:begin
            if(expandedKeyEnable)begin
                ciphertext = expandedKey;
                ciphertextDone = 1;
            end
        end
    endcase
end
    endmodule