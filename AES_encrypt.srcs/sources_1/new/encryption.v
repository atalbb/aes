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
always@(curr_state or plaintextEnable)begin
    case (curr_state)
        0:begin
            next_state = 1;
        end
        1:begin
            if(plaintextEnable)
                next_state = 2;
        end
        2:begin
            if(plaintextEnable)
                next_state = 3;    
        end
        3:begin
            if(plaintextEnable)begin
                w[0]=plaintext;
                next_state = 4;
            end
        end
        4:begin
            if(plaintextEnable)begin
                w[1]=plaintext;
                next_state = 5;
            end
        end
        5:begin
            if(plaintextEnable)begin
                w[2]=plaintext;
                next_state = 6;
            end
        end
        6:begin
            if(plaintextEnable)begin
                w[3]=plaintext;
                next_state = 7;
            end
        end
        7:begin
            if(plaintextEnable)begin
                ciphertext = w[3];
                ciphertextDone = 1;
            end
        end
    endcase
end
endmodule
