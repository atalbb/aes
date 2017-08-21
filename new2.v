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
reg [9:0]curr_state, next_state;
reg [7:0]b[15:0];
reg [31:0]w[3:0];
reg [31:0]k[59:0];
//reg [5:0]count;
reg count_flag;

always@(posedge clk or negedge rst)begin
    if(!rst)
        curr_state <= 0;
    else 
        curr_state <= next_state;
end


always@(curr_state or expandedKeyEnable or plaintextEnable)begin
    case (curr_state)
        0:begin
            next_state = 1;
            count_flag = 0;
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
            if(expandedKeyEnable)
            next_state = 4;            
        end
        4:begin
             if(expandedKeyEnable)begin
                 k[0] = expandedKey;
                 next_state = 5;
             end
        end
        5:begin
            if(expandedKeyEnable) begin
                 k[1] = expandedKey;
                 next_state = 6;
            end            
        end
        6:begin
             if(expandedKeyEnable)begin
                 k[2] = expandedKey;
                 next_state = 7;
             end
        end
        7:begin
            if(expandedKeyEnable) begin
                 k[3] = expandedKey;
                 next_state = 8;
            end            
        end
        8:begin
             if(expandedKeyEnable)begin
                 k[4] = expandedKey;
                 next_state = 9;
             end
        end
        9:begin
            if(expandedKeyEnable) begin
                 k[5] = expandedKey;
                 next_state = 10;
            end            
        end
        10:begin
             if(expandedKeyEnable)begin
                 k[6] = expandedKey;
                 next_state = 11;
             end
        end
        11:begin
            if(expandedKeyEnable) begin
                 k[7] = expandedKey;
                 next_state = 12;
            end            
        end
        12:begin
             if(expandedKeyEnable)begin
                 k[8] = expandedKey;
                 next_state = 13;
             end
        end
        13:begin
            if(expandedKeyEnable) begin
                 k[9] = expandedKey;
                 next_state = 14;
            end            
        end
        14:begin
             if(expandedKeyEnable)begin
                 k[10] = expandedKey;
                 next_state = 15;
             end
        end
        15:begin
            if(expandedKeyEnable) begin
                 k[11] = expandedKey;
                 next_state = 16;
            end            
        end
        16:begin
            if(expandedKeyEnable) begin
                 k[12] = expandedKey;
                 next_state = 17;
            end            
        end
        17:begin
             if(expandedKeyEnable)begin
                 k[13] = expandedKey;
                 next_state = 18;
             end
        end
        18:begin
            if(expandedKeyEnable) begin
                 k[14] = expandedKey;
                 next_state = 19;
            end            
        end
        19:begin
             if(expandedKeyEnable)begin
                 k[15] = expandedKey;
                 next_state = 20;
             end
        end
        20:begin
            if(expandedKeyEnable) begin
                 k[16] = expandedKey;
                 next_state = 21;
            end            
        end
        21:begin
            if(expandedKeyEnable) begin
                 k[17] = expandedKey;
                 next_state = 22;
            end            
        end
        22:begin
             if(expandedKeyEnable)begin
                 k[18] = expandedKey;
                 next_state = 23;
             end
        end
        23:begin
            if(expandedKeyEnable) begin
                 k[19] = expandedKey;
                 next_state = 24;
            end            
        end
        24:begin
             if(expandedKeyEnable)begin
                 k[20] = expandedKey;
                 next_state = 25;
             end
        end
        25:begin
            if(expandedKeyEnable) begin
                 k[21] = expandedKey;
                 next_state = 26;
            end            
        end
        26:begin
             if(expandedKeyEnable)begin
                 k[22] = expandedKey;
                 next_state = 27;
             end
        end
        27:begin
            if(expandedKeyEnable) begin
                 k[23] = expandedKey;
                 next_state = 28;
            end            
        end
        28:begin
             if(expandedKeyEnable)begin
                 k[24] = expandedKey;
                 next_state = 29;
             end
        end
        29:begin
            if(expandedKeyEnable) begin
                 k[25] = expandedKey;
                 next_state = 30;
            end            
        end
        30:begin
             if(expandedKeyEnable)begin
                 k[26] = expandedKey;
                 next_state = 31;
             end
        end
        31:begin
            if(expandedKeyEnable) begin
                 k[27] = expandedKey;
                 next_state = 32;
            end            
        end
        32:begin
             if(expandedKeyEnable)begin
                 k[28] = expandedKey;
                 next_state = 33;
             end
        end
        33:begin
            if(expandedKeyEnable) begin
                 k[29] = expandedKey;
                 next_state = 34;
            end            
        end
        34:begin
             if(expandedKeyEnable)begin
                 k[30] = expandedKey;
                 next_state = 35;
             end
        end
        35:begin
            if(expandedKeyEnable) begin
                 k[31] = expandedKey;
                 next_state = 36;
            end            
        end
        36:begin
             if(expandedKeyEnable)begin
                 k[32] = expandedKey;
                 next_state = 37;
             end
        end
        37:begin
            if(expandedKeyEnable) begin
                 k[33] = expandedKey;
                 next_state = 38;
            end            
        end
        38:begin
             if(expandedKeyEnable)begin
                 k[34] = expandedKey;
                 next_state = 39;
             end
        end
        39:begin
            if(expandedKeyEnable) begin
                 k[35] = expandedKey;
                 next_state = 40;
            end            
        end
        40:begin
             if(expandedKeyEnable)begin
                 k[36] = expandedKey;
                 next_state = 41;
             end
        end
        41:begin
            if(expandedKeyEnable) begin
                 k[37] = expandedKey;
                 next_state = 42;
            end            
        end
        42:begin
             if(expandedKeyEnable)begin
                 k[38] = expandedKey;
                 next_state = 43;
             end
        end
       43:begin
            if(expandedKeyEnable) begin
                 k[39] = expandedKey;
                 next_state = 44;
            end            
        end
        44:begin
             if(expandedKeyEnable)begin
                 k[40] = expandedKey;
                 next_state = 45;
             end
        end
        45:begin
            if(expandedKeyEnable) begin
                 k[41] = expandedKey;
                 next_state = 46;
            end            
        end
        46:begin
            if(expandedKeyEnable) begin
                 k[42] = expandedKey;
                 next_state = 47;
            end            
        end
        47:begin
             if(expandedKeyEnable)begin
                 k[43] = expandedKey;
                 next_state = 48;
             end
        end
        48:begin
            if(expandedKeyEnable) begin
                 k[44] = expandedKey;
                 next_state = 49;
            end            
        end
        49:begin
             if(expandedKeyEnable)begin
                 k[45] = expandedKey;
                 next_state = 50;
             end
        end
        50:begin
            if(expandedKeyEnable) begin
                 k[46] = expandedKey;
                 next_state = 51;
            end            
        end
        51:begin
            if(expandedKeyEnable) begin
                 k[47] = expandedKey;
                 next_state = 52;
            end            
        end
        52:begin
             if(expandedKeyEnable)begin
                 k[48] = expandedKey;
                 next_state = 53;
             end
        end
        53:begin
            if(expandedKeyEnable) begin
                 k[49] = expandedKey;
                 next_state = 54;
            end            
        end
        54:begin
             if(expandedKeyEnable)begin
                 k[50] = expandedKey;
                 next_state = 55;
             end
        end
        55:begin
            if(expandedKeyEnable) begin
                 k[51] = expandedKey;
                 next_state = 56;
            end            
        end
        56:begin
             if(expandedKeyEnable)begin
                 k[52] = expandedKey;
                 next_state = 57;
             end
        end
        57:begin
            if(expandedKeyEnable) begin
                 k[53] = expandedKey;
                 next_state = 58;
            end            
        end
        58:begin
             if(expandedKeyEnable)begin
                 k[54] = expandedKey;
                 next_state = 59;
             end
        end
        59:begin
            if(expandedKeyEnable) begin
                 k[55] = expandedKey;
                 next_state = 60;
            end            
        end
        60:begin
             if(expandedKeyEnable)begin
                 k[56] = expandedKey;
                 next_state = 61;
             end
        end
        61:begin
            if(expandedKeyEnable) begin
                 k[57] = expandedKey;
                 next_state = 62;
            end            
        end
        62:begin
             //if(expandedKeyEnable)begin
                 k[58] = expandedKey;
                 next_state = 63;
             //end
        end
        63:begin
            //if(expandedKeyEnable) begin
                 k[59] = expandedKey;
                 next_state = 64;
            //end            
        end

        64:begin
         ciphertext = k[59];
         ciphertextDone = 1;
        
        end
        //end
    endcase
end
endmodule