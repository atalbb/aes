`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2018 05:28:26 PM
// Design Name: 
// Module Name: aes_decrypt_core
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


module aes_enc_core(input clk,
                  input rst,
                  input start,
                  input [1919:0]keyIn, // 60 words(32-bit) expanded key
                  input [127:0]dataIn, // 4 word(32-bit) data block
                  output reg encDone,
                  output reg [127:0]plaintext,
                  output reg ledDone,
                  output reg [7:0]led_out

    );
/* Current State and Next State Declartion */    
reg [9:0]curr_state, next_state;

reg [7:0]d[15:0];
reg [7:0]d1[15:0];
reg [7:0]d2[15:0];
reg [7:0]d3[15:0];
reg [7:0]d4[15:0];
reg [7:0]d5[15:0];
reg [7:0]d6[15:0];
reg [7:0]d7[15:0];
reg [7:0]d8[15:0];
reg [7:0]d9[15:0];
reg [7:0]d10[15:0];
//reg [7:0]d1[15:0];
reg [31:0]w[3:0];
reg [31:0]w1[3:0];
reg [31:0]w2[3:0];
reg [31:0]w3[3:0];
reg [31:0]w4[3:0];
reg [31:0]w5[3:0];
reg [31:0]w6[3:0];

reg [31:0]k[59:0];
reg [7:0]inv_sbox[255:0];
reg [7:0]eTable[255:0];
reg [7:0]lTable[255:0];
reg [31:0]tempStart[3:0];
reg [31:0]tempStart1[3:0];
reg [31:0]tempStart2[3:0];
reg [31:0]tempStart3[3:0];
reg [31:0]tempStart4[3:0];
reg [31:0]tempStart5[3:0];
reg [7:0]tempSbox[15:0];
reg [7:0]tempSbox1[15:0];
reg [7:0]tempSbox2[15:0];
reg [7:0]tempSbox3[15:0];
reg [7:0]tempSbox4[15:0];
reg [7:0]tempSbox5[15:0];
reg [7:0]tempSbox6[15:0];
reg [7:0]tempSbox7[15:0];
reg [7:0]tempSbox8[15:0];
reg [7:0]tempSbox9[15:0];

reg [7:0]tempRow[15:0];
reg [7:0]tempRow1[15:0];
reg [7:0]tempRow2[15:0];
reg [7:0]tempRow3[15:0];
reg [7:0]tempRow4[15:0];
reg [7:0]tempRow5[15:0];
/* 16-bits wide because they hold sum of two 8 bits data */
reg [15:0]l[63:0];
reg [15:0]l1[63:0];
reg [15:0]l2[63:0];
reg [15:0]l3[63:0];
reg [15:0]l4[63:0];
reg [15:0]l5[63:0];
reg [15:0]l6[63:0];
reg [15:0]LT[63:0];
reg [15:0]LT1[63:0];
reg [15:0]LT2[63:0];
reg [15:0]LT3[63:0];
reg [15:0]LT4[63:0];
reg [15:0]LT5[63:0];
reg [15:0]LT6[63:0];
reg [7:0]ET[63:0];
reg [7:0]ET1[63:0];
reg [7:0]ET2[63:0];
reg [7:0]ET3[63:0];
reg [7:0]ET4[63:0];
reg [7:0]ET5[63:0];
reg [7:0]ET6[63:0];
    
/* always block to update state every 1 clock cycle */   
always @ (posedge clk or negedge rst)begin
    if(!rst)
        curr_state <=  0;
    else
        curr_state <=  next_state;
end    
 
always @(curr_state or start)begin
    case(curr_state)
        0: begin
        ledDone = 0;    
        encDone = 0;
        /* Inverse SBOX */
inv_sbox[8'h00] = 8'h52;inv_sbox[8'h01] = 8'h09;inv_sbox[8'h02] = 8'h6a;inv_sbox[8'h03] = 8'hd5;inv_sbox[8'h04] = 8'h30;
inv_sbox[8'h05] = 8'h36;inv_sbox[8'h06] = 8'ha5;inv_sbox[8'h07] = 8'h38;inv_sbox[8'h08] = 8'hbf;inv_sbox[8'h09] = 8'h40;
inv_sbox[8'h0a] = 8'ha3;inv_sbox[8'h0b] = 8'h9e;inv_sbox[8'h0c] = 8'h81;inv_sbox[8'h0d] = 8'hf3;inv_sbox[8'h0e] = 8'hd7;
inv_sbox[8'h0f] = 8'hfb;inv_sbox[8'h10] = 8'h7c;inv_sbox[8'h11] = 8'he3;inv_sbox[8'h12] = 8'h39;inv_sbox[8'h13] = 8'h82;
inv_sbox[8'h14] = 8'h9b;inv_sbox[8'h15] = 8'h2f;inv_sbox[8'h16] = 8'hff;inv_sbox[8'h17] = 8'h87;inv_sbox[8'h18] = 8'h34;
inv_sbox[8'h19] = 8'h8e;inv_sbox[8'h1a] = 8'h43;inv_sbox[8'h1b] = 8'h44;inv_sbox[8'h1c] = 8'hc4;inv_sbox[8'h1d] = 8'hde;
inv_sbox[8'h1e] = 8'he9;inv_sbox[8'h1f] = 8'hcb;inv_sbox[8'h20] = 8'h54;inv_sbox[8'h21] = 8'h7b;inv_sbox[8'h22] = 8'h94;
inv_sbox[8'h23] = 8'h32;inv_sbox[8'h24] = 8'ha6;inv_sbox[8'h25] = 8'hc2;inv_sbox[8'h26] = 8'h23;inv_sbox[8'h27] = 8'h3d;
inv_sbox[8'h28] = 8'hee;inv_sbox[8'h29] = 8'h4c;inv_sbox[8'h2a] = 8'h95;inv_sbox[8'h2b] = 8'h0b;inv_sbox[8'h2c] = 8'h42;
inv_sbox[8'h2d] = 8'hfa;inv_sbox[8'h2e] = 8'hc3;inv_sbox[8'h2f] = 8'h4e;inv_sbox[8'h30] = 8'h08;inv_sbox[8'h31] = 8'h2e;
inv_sbox[8'h32] = 8'ha1;inv_sbox[8'h33] = 8'h66;inv_sbox[8'h34] = 8'h28;inv_sbox[8'h35] = 8'hd9;inv_sbox[8'h36] = 8'h24;
inv_sbox[8'h37] = 8'hb2;inv_sbox[8'h38] = 8'h76;inv_sbox[8'h39] = 8'h5b;inv_sbox[8'h3a] = 8'ha2;inv_sbox[8'h3b] = 8'h49;
inv_sbox[8'h3c] = 8'h6d;inv_sbox[8'h3d] = 8'h8b;inv_sbox[8'h3e] = 8'hd1;inv_sbox[8'h3f] = 8'h25;inv_sbox[8'h40] = 8'h72;inv_sbox[8'h41] = 8'hf8;

inv_sbox[8'h42] = 8'hf6;inv_sbox[8'h43] = 8'h64;inv_sbox[8'h44] = 8'h86;inv_sbox[8'h45] = 8'h68;inv_sbox[8'h46] = 8'h98;
inv_sbox[8'h47] = 8'h16;inv_sbox[8'h48] = 8'hd4;inv_sbox[8'h49] = 8'ha4;inv_sbox[8'h4a] = 8'h5c;inv_sbox[8'h4b] = 8'hcc;
inv_sbox[8'h4c] = 8'h5d;inv_sbox[8'h4d] = 8'h65;inv_sbox[8'h4e] = 8'hb6;inv_sbox[8'h4f] = 8'h92;inv_sbox[8'h50] = 8'h6c;
inv_sbox[8'h51] = 8'h70;inv_sbox[8'h52] = 8'h48;inv_sbox[8'h53] = 8'h50;inv_sbox[8'h54] = 8'hfd;inv_sbox[8'h55] = 8'hed;
inv_sbox[8'h56] = 8'hb9;inv_sbox[8'h57] = 8'hda;inv_sbox[8'h58] = 8'h5e;inv_sbox[8'h59] = 8'h15;inv_sbox[8'h5a] = 8'h46;
inv_sbox[8'h5b] = 8'h57;inv_sbox[8'h5c] = 8'ha7;inv_sbox[8'h5d] = 8'h8d;inv_sbox[8'h5e] = 8'h9d;inv_sbox[8'h5f] = 8'h84;
inv_sbox[8'h60] = 8'h90;inv_sbox[8'h61] = 8'hd8;inv_sbox[8'h62] = 8'hab;inv_sbox[8'h63] = 8'h00;inv_sbox[8'h64] = 8'h8c;
inv_sbox[8'h65] = 8'hbc;inv_sbox[8'h66] = 8'hd3;inv_sbox[8'h67] = 8'h0a;inv_sbox[8'h68] = 8'hf7;inv_sbox[8'h69] = 8'he4;
inv_sbox[8'h6a] = 8'h58;inv_sbox[8'h6b] = 8'h05;inv_sbox[8'h6c] = 8'hb8;inv_sbox[8'h6d] = 8'hb3;inv_sbox[8'h6e] = 8'h45;
inv_sbox[8'h6f] = 8'h06;inv_sbox[8'h70] = 8'hd0;inv_sbox[8'h71] = 8'h2c;inv_sbox[8'h72] = 8'h1e;inv_sbox[8'h73] = 8'h8f;
inv_sbox[8'h74] = 8'hca;inv_sbox[8'h75] = 8'h3f;inv_sbox[8'h76] = 8'h0f;inv_sbox[8'h77] = 8'h02;inv_sbox[8'h78] = 8'hc1;
inv_sbox[8'h79] = 8'haf;inv_sbox[8'h7a] = 8'hbd;inv_sbox[8'h7b] = 8'h03;inv_sbox[8'h7c] = 8'h01;inv_sbox[8'h7d] = 8'h13;
inv_sbox[8'h7e] = 8'h8a;inv_sbox[8'h7f] = 8'h6b;inv_sbox[8'h80] = 8'h3a;inv_sbox[8'h81] = 8'h91;inv_sbox[8'h82] = 8'h11;
inv_sbox[8'h83] = 8'h41;inv_sbox[8'h84] = 8'h4f;inv_sbox[8'h85] = 8'h67;inv_sbox[8'h86] = 8'hdc;inv_sbox[8'h87] = 8'hea;
inv_sbox[8'h88] = 8'h97;inv_sbox[8'h89] = 8'hf2;inv_sbox[8'h8a] = 8'hcf;inv_sbox[8'h8b] = 8'hce;inv_sbox[8'h8c] = 8'hf0;
inv_sbox[8'h8d] = 8'hb4;inv_sbox[8'h8e] = 8'he6;inv_sbox[8'h8f] = 8'h73;inv_sbox[8'h90] = 8'h96;inv_sbox[8'h91] = 8'hac;
inv_sbox[8'h92] = 8'h74;inv_sbox[8'h93] = 8'h22;inv_sbox[8'h94] = 8'he7;inv_sbox[8'h95] = 8'had;inv_sbox[8'h96] = 8'h35;
inv_sbox[8'h97] = 8'h85;inv_sbox[8'h98] = 8'he2;inv_sbox[8'h99] = 8'hf9;inv_sbox[8'h9a] = 8'h37;inv_sbox[8'h9b] = 8'he8;
inv_sbox[8'h9c] = 8'h1c;inv_sbox[8'h9d] = 8'h75;inv_sbox[8'h9e] = 8'hdf;inv_sbox[8'h9f] = 8'h6e;inv_sbox[8'ha0] = 8'h47;
inv_sbox[8'ha1] = 8'hf1;inv_sbox[8'ha2] = 8'h1a;inv_sbox[8'ha3] = 8'h71;inv_sbox[8'ha4] = 8'h1d;inv_sbox[8'ha5] = 8'h29;
inv_sbox[8'ha6] = 8'hc5;inv_sbox[8'ha7] = 8'h89;inv_sbox[8'ha8] = 8'h6f;inv_sbox[8'ha9] = 8'hb7;inv_sbox[8'haa] = 8'h62;
inv_sbox[8'hab] = 8'h0e;inv_sbox[8'hac] = 8'haa;inv_sbox[8'had] = 8'h18;inv_sbox[8'hae] = 8'hbe;inv_sbox[8'haf] = 8'h1b;
inv_sbox[8'hb0] = 8'hfc;inv_sbox[8'hb1] = 8'h56;inv_sbox[8'hb2] = 8'h3e;inv_sbox[8'hb3] = 8'h4b;inv_sbox[8'hb4] = 8'hc6;
inv_sbox[8'hb5] = 8'hd2;inv_sbox[8'hb6] = 8'h79;inv_sbox[8'hb7] = 8'h20;inv_sbox[8'hb8] = 8'h9a;inv_sbox[8'hb9] = 8'hdb;
inv_sbox[8'hba] = 8'hc0;inv_sbox[8'hbb] = 8'hfe;inv_sbox[8'hbc] = 8'h78;inv_sbox[8'hbd] = 8'hcd;inv_sbox[8'hbe] = 8'h5a;
inv_sbox[8'hbf] = 8'hf4;inv_sbox[8'hc0] = 8'h1f;inv_sbox[8'hc1] = 8'hdd;inv_sbox[8'hc2] = 8'ha8;inv_sbox[8'hc3] = 8'h33;
inv_sbox[8'hc4] = 8'h88;inv_sbox[8'hc5] = 8'h07;inv_sbox[8'hc6] = 8'hc7;inv_sbox[8'hc7] = 8'h31;inv_sbox[8'hc8] = 8'hb1;
inv_sbox[8'hc9] = 8'h12;inv_sbox[8'hca] = 8'h10;inv_sbox[8'hcb] = 8'h59;inv_sbox[8'hcc] = 8'h27;inv_sbox[8'hcd] = 8'h80;
inv_sbox[8'hce] = 8'hec;inv_sbox[8'hcf] = 8'h5f;inv_sbox[8'hd0] = 8'h60;inv_sbox[8'hd1] = 8'h51;inv_sbox[8'hd2] = 8'h7f;
inv_sbox[8'hd3] = 8'ha9;inv_sbox[8'hd4] = 8'h19;inv_sbox[8'hd5] = 8'hb5;inv_sbox[8'hd6] = 8'h4a;inv_sbox[8'hd7] = 8'h0d;
inv_sbox[8'hd8] = 8'h2d;inv_sbox[8'hd9] = 8'he5;inv_sbox[8'hda] = 8'h7a;inv_sbox[8'hdb] = 8'h9f;inv_sbox[8'hdc] = 8'h93;
inv_sbox[8'hdd] = 8'hc9;inv_sbox[8'hde] = 8'h9c;inv_sbox[8'hdf] = 8'hef;inv_sbox[8'he0] = 8'ha0;inv_sbox[8'he1] = 8'he0;
inv_sbox[8'he2] = 8'h3b;inv_sbox[8'he3] = 8'h4d;inv_sbox[8'he4] = 8'hae;inv_sbox[8'he5] = 8'h2a;inv_sbox[8'he6] = 8'hf5;
inv_sbox[8'he7] = 8'hb0;inv_sbox[8'he8] = 8'hc8;inv_sbox[8'he9] = 8'heb;inv_sbox[8'hea] = 8'hbb;inv_sbox[8'heb] = 8'h3c;
inv_sbox[8'hec] = 8'h83;inv_sbox[8'hed] = 8'h53;inv_sbox[8'hee] = 8'h99;inv_sbox[8'hef] = 8'h61;inv_sbox[8'hf0] = 8'h17;
inv_sbox[8'hf1] = 8'h2b;inv_sbox[8'hf2] = 8'h04;inv_sbox[8'hf3] = 8'h7e;inv_sbox[8'hf4] = 8'hba;inv_sbox[8'hf5] = 8'h77;
inv_sbox[8'hf6] = 8'hd6;inv_sbox[8'hf7] = 8'h26;inv_sbox[8'hf8] = 8'he1;inv_sbox[8'hf9] = 8'h69;inv_sbox[8'hfa] = 8'h14;
inv_sbox[8'hfb] = 8'h63;inv_sbox[8'hfc] = 8'h55;inv_sbox[8'hfd] = 8'h21;inv_sbox[8'hfe] = 8'h0c;inv_sbox[8'hff] = 8'h7d;

        /*E - Table*/        
        eTable[8'h00] = 8'h01;eTable[8'h01] = 8'h03;eTable[8'h02] = 8'h05;eTable[8'h03] = 8'h0f;eTable[8'h04] = 8'h11;
        eTable[8'h05] = 8'h33;eTable[8'h06] = 8'h55;eTable[8'h07] = 8'hff;eTable[8'h08] = 8'h1a;eTable[8'h09] = 8'h2e;
        eTable[8'h0a] = 8'h72;eTable[8'h0b] = 8'h96;eTable[8'h0c] = 8'ha1;eTable[8'h0d] = 8'hf8;eTable[8'h0e] = 8'h13;
        eTable[8'h0f] = 8'h35;eTable[8'h10] = 8'h5f;eTable[8'h11] = 8'he1;eTable[8'h12] = 8'h38;eTable[8'h13] = 8'h48;
        eTable[8'h14] = 8'hd8;eTable[8'h15] = 8'h73;eTable[8'h16] = 8'h95;eTable[8'h17] = 8'ha4;eTable[8'h18] = 8'hf7;
        eTable[8'h19] = 8'h02;eTable[8'h1a] = 8'h06;eTable[8'h1b] = 8'h0a;eTable[8'h1c] = 8'h1e;eTable[8'h1d] = 8'h22; 
        eTable[8'h1e] = 8'h66;eTable[8'h1f] = 8'haa;eTable[8'h20] = 8'he5;eTable[8'h21] = 8'h34;eTable[8'h22] = 8'h5c;
        eTable[8'h23] = 8'he4;eTable[8'h24] = 8'h37;eTable[8'h25] = 8'h59;eTable[8'h26] = 8'heb;eTable[8'h27] = 8'h26;
        eTable[8'h28] = 8'h6a;eTable[8'h29] = 8'hbe;eTable[8'h2a] = 8'hd9;eTable[8'h2b] = 8'h70;eTable[8'h2c] = 8'h90;
        eTable[8'h2d] = 8'hab;eTable[8'h2e] = 8'he6;eTable[8'h2f] = 8'h31;eTable[8'h30] = 8'h53;eTable[8'h31] = 8'hf5;
        eTable[8'h32] = 8'h04;eTable[8'h33] = 8'h0c;eTable[8'h34] = 8'h14;eTable[8'h35] = 8'h3c;eTable[8'h36] = 8'h44;
        eTable[8'h37] = 8'hcc;eTable[8'h38] = 8'h4f;eTable[8'h39] = 8'hd1;eTable[8'h3a] = 8'h68;eTable[8'h3b] = 8'hb8;
        eTable[8'h3c] = 8'hd3;eTable[8'h3d] = 8'h6e;eTable[8'h3e] = 8'hb2;eTable[8'h3f] = 8'hcd;eTable[8'h40] = 8'h4c;
        eTable[8'h41] = 8'hd4;eTable[8'h42] = 8'h67;eTable[8'h43] = 8'ha9;eTable[8'h44] = 8'he0;eTable[8'h45] = 8'h3b;
        eTable[8'h46] = 8'h4d;eTable[8'h47] = 8'hd7;eTable[8'h48] = 8'h62;eTable[8'h49] = 8'ha6;eTable[8'h4a] = 8'hf1;
        eTable[8'h4b] = 8'h08;eTable[8'h4c] = 8'h18;eTable[8'h4d] = 8'h28;eTable[8'h4e] = 8'h78;eTable[8'h4f] = 8'h88;
        eTable[8'h50] = 8'h83;eTable[8'h51] = 8'h9e;eTable[8'h52] = 8'hb9;eTable[8'h53] = 8'hd0;eTable[8'h54] = 8'h6b;
        eTable[8'h55] = 8'hbd;eTable[8'h56] = 8'hdc;eTable[8'h57] = 8'h7f;eTable[8'h58] = 8'h81;eTable[8'h59] = 8'h98;
        eTable[8'h5a] = 8'hb3;eTable[8'h5b] = 8'hce;eTable[8'h5c] = 8'h49;eTable[8'h5d] = 8'hdb;eTable[8'h5e] = 8'h76;
        eTable[8'h5f] = 8'h9a;eTable[8'h60] = 8'hb5;eTable[8'h61] = 8'hc4;eTable[8'h62] = 8'h57;eTable[8'h63] = 8'hf9;
        eTable[8'h64] = 8'h10;eTable[8'h65] = 8'h30;eTable[8'h66] = 8'h50;eTable[8'h67] = 8'hf0;eTable[8'h68] = 8'h0b;
        eTable[8'h69] = 8'h1d;eTable[8'h6a] = 8'h27;eTable[8'h6b] = 8'h69;eTable[8'h6c] = 8'hbb;eTable[8'h6d] = 8'hd6;
        eTable[8'h6e] = 8'h61;eTable[8'h6f] = 8'ha3;eTable[8'h70] = 8'hfe;eTable[8'h71] = 8'h19;eTable[8'h72] = 8'h2b;
        eTable[8'h73] = 8'h7d;eTable[8'h74] = 8'h87;eTable[8'h75] = 8'h92;eTable[8'h76] = 8'had;eTable[8'h77] = 8'hec;
        eTable[8'h78] = 8'h2f;eTable[8'h79] = 8'h71;eTable[8'h7a] = 8'h93;eTable[8'h7b] = 8'hae;eTable[8'h7c] = 8'he9;
        eTable[8'h7d] = 8'h20;eTable[8'h7e] = 8'h60;eTable[8'h7f] = 8'ha0;eTable[8'h80] = 8'hfb;eTable[8'h81] = 8'h16;
        eTable[8'h82] = 8'h3a;eTable[8'h83] = 8'h4e;eTable[8'h84] = 8'hd2;eTable[8'h85] = 8'h6d;eTable[8'h86] = 8'hb7;
        eTable[8'h87] = 8'hc2;eTable[8'h88] = 8'h5d;eTable[8'h89] = 8'he7;eTable[8'h8a] = 8'h32;eTable[8'h8b] = 8'h56;
        eTable[8'h8c] = 8'hfa;eTable[8'h8d] = 8'h15;eTable[8'h8e] = 8'h3f;eTable[8'h8f] = 8'h41;eTable[8'h90] = 8'hc3;
        eTable[8'h91] = 8'h5e;eTable[8'h92] = 8'he2;eTable[8'h93] = 8'h3d;eTable[8'h94] = 8'h47;eTable[8'h95] = 8'hc9;
        eTable[8'h96] = 8'h40;eTable[8'h97] = 8'hc0;eTable[8'h98] = 8'h5b;eTable[8'h99] = 8'hed;eTable[8'h9a] = 8'h2c;       
        eTable[8'h9b] = 8'h74;eTable[8'h9c] = 8'h9c;eTable[8'h9d] = 8'hbf;eTable[8'h9e] = 8'hda;eTable[8'h9f] = 8'h75;
        eTable[8'ha0] = 8'h9f;eTable[8'ha1] = 8'hba;eTable[8'ha2] = 8'hd5;eTable[8'ha3] = 8'h64;eTable[8'ha4] = 8'hac;
        eTable[8'ha5] = 8'hef;eTable[8'ha6] = 8'h2a;eTable[8'ha7] = 8'h7e;eTable[8'ha8] = 8'h82;eTable[8'ha9] = 8'h9d;
        eTable[8'haa] = 8'hbc;eTable[8'hab] = 8'hdf;eTable[8'hac] = 8'h7a;eTable[8'had] = 8'h8e;eTable[8'hae] = 8'h89;
        eTable[8'haf] = 8'h80;eTable[8'hb0] = 8'h9b;eTable[8'hb1] = 8'hb6;eTable[8'hb2] = 8'hc1;eTable[8'hb3] = 8'h58;
        eTable[8'hb4] = 8'he8;eTable[8'hb5] = 8'h23;eTable[8'hb6] = 8'h65;eTable[8'hb7] = 8'haf;eTable[8'hb8] = 8'hea;
        eTable[8'hb9] = 8'h25;eTable[8'hba] = 8'h6f;eTable[8'hbb] = 8'hb1;eTable[8'hbc] = 8'hc8;eTable[8'hbd] = 8'h43;
        eTable[8'hbe] = 8'hc5;eTable[8'hbf] = 8'h54;eTable[8'hc0] = 8'hfc;eTable[8'hc1] = 8'h1f;eTable[8'hc2] = 8'h21;
        eTable[8'hc3] = 8'h63;eTable[8'hc4] = 8'ha5;eTable[8'hc5] = 8'hf4;eTable[8'hc6] = 8'h07;eTable[8'hc7] = 8'h09;
        eTable[8'hc8] = 8'h1b;eTable[8'hc9] = 8'h2d;eTable[8'hca] = 8'h77;eTable[8'hcb] = 8'h99;eTable[8'hcc] = 8'hb0;
        eTable[8'hcd] = 8'hcb;eTable[8'hce] = 8'h46;eTable[8'hcf] = 8'hca;eTable[8'hd0] = 8'h45;eTable[8'hd1] = 8'hcf;
        eTable[8'hd2] = 8'h4a;eTable[8'hd3] = 8'hde;eTable[8'hd4] = 8'h79;eTable[8'hd5] = 8'h8b;eTable[8'hd6] = 8'h86;
        eTable[8'hd7] = 8'h91;eTable[8'hd8] = 8'ha8;eTable[8'hd9] = 8'he3;eTable[8'hda] = 8'h3e;eTable[8'hdb] = 8'h42;
        eTable[8'hdc] = 8'hc6;eTable[8'hdd] = 8'h51;eTable[8'hde] = 8'hf3;eTable[8'hdf] = 8'h0e;eTable[8'he0] = 8'h12;
        eTable[8'he1] = 8'h36;eTable[8'he2] = 8'h5a;eTable[8'he3] = 8'hee;eTable[8'he4] = 8'h29;eTable[8'he5] = 8'h7b;
        eTable[8'he6] = 8'h8d;eTable[8'he7] = 8'h8c;eTable[8'he8] = 8'h8f;eTable[8'he9] = 8'h8a;eTable[8'hea] = 8'h85;
        eTable[8'heb] = 8'h94;eTable[8'hec] = 8'ha7;eTable[8'hed] = 8'hf2;eTable[8'hee] = 8'h0d;eTable[8'hef] = 8'h17;
        eTable[8'hf0] = 8'h39;eTable[8'hf1] = 8'h4b;eTable[8'hf2] = 8'hdd;eTable[8'hf3] = 8'h7c;eTable[8'hf4] = 8'h84;
        eTable[8'hf5] = 8'h97;eTable[8'hf6] = 8'ha2;eTable[8'hf7] = 8'hfd;eTable[8'hf8] = 8'h1c;eTable[8'hf9] = 8'h24;
        eTable[8'hfa] = 8'h6c;eTable[8'hfb] = 8'hb4;eTable[8'hfc] = 8'hc7;eTable[8'hfd] = 8'h52;eTable[8'hfe] = 8'hf6;
        eTable[8'hff] = 8'h01;    
        
        /* L- Table */    
        lTable[8'h01] = 8'h00;lTable[8'h02] = 8'h19;lTable[8'h03] = 8'h01;lTable[8'h04] = 8'h32;lTable[8'h05] = 8'h02;
        lTable[8'h06] = 8'h1a;lTable[8'h07] = 8'hc6;lTable[8'h08] = 8'h4b;lTable[8'h09] = 8'hc7;lTable[8'h0a] = 8'h1b;
        lTable[8'h0b] = 8'h68;lTable[8'h0c] = 8'h33;lTable[8'h0d] = 8'hee;lTable[8'h0e] = 8'hdf;lTable[8'h0f] = 8'h03;
        lTable[8'h10] = 8'h64;lTable[8'h11] = 8'h04;lTable[8'h12] = 8'he0;lTable[8'h13] = 8'h0e;lTable[8'h14] = 8'h34;
        lTable[8'h15] = 8'h8d;lTable[8'h16] = 8'h81;lTable[8'h17] = 8'hef;lTable[8'h18] = 8'h4c;lTable[8'h19] = 8'h71;
        lTable[8'h1a] = 8'h08;lTable[8'h1b] = 8'hc8;lTable[8'h1c] = 8'hf8;lTable[8'h1d] = 8'h69;lTable[8'h1e] = 8'h1c;
        lTable[8'h1f] = 8'hc1;lTable[8'h20] = 8'h7d;lTable[8'h21] = 8'hc2;lTable[8'h22] = 8'h1d;lTable[8'h23] = 8'hb5;
        lTable[8'h24] = 8'hf9;lTable[8'h25] = 8'hb9;lTable[8'h26] = 8'h27;lTable[8'h27] = 8'h6a;lTable[8'h28] = 8'h4d;
        lTable[8'h29] = 8'he4;lTable[8'h2a] = 8'ha6;lTable[8'h2b] = 8'h72;lTable[8'h2c] = 8'h9a;lTable[8'h2d] = 8'hc9;
        lTable[8'h2e] = 8'h09;lTable[8'h2f] = 8'h78;lTable[8'h30] = 8'h65;lTable[8'h31] = 8'h2f;lTable[8'h32] = 8'h8a;
        lTable[8'h33] = 8'h05;lTable[8'h34] = 8'h21;lTable[8'h35] = 8'h0f;lTable[8'h36] = 8'he1;lTable[8'h37] = 8'h24;
        lTable[8'h38] = 8'h12;lTable[8'h39] = 8'hf0;lTable[8'h3a] = 8'h82;lTable[8'h3b] = 8'h45;lTable[8'h3c] = 8'h35;
        lTable[8'h3d] = 8'h93;lTable[8'h3e] = 8'hda;lTable[8'h3f] = 8'h8e;lTable[8'h40] = 8'h96;lTable[8'h41] = 8'h8f;
        lTable[8'h42] = 8'hdb;lTable[8'h43] = 8'hbd;lTable[8'h44] = 8'h36;lTable[8'h45] = 8'hd0;lTable[8'h46] = 8'hce;
        lTable[8'h47] = 8'h94;lTable[8'h48] = 8'h13;lTable[8'h49] = 8'h5c;lTable[8'h4a] = 8'hd2;lTable[8'h4b] = 8'hf1;
        lTable[8'h4c] = 8'h40;lTable[8'h4d] = 8'h46;lTable[8'h4e] = 8'h83;lTable[8'h4f] = 8'h38;lTable[8'h50] = 8'h66;
        lTable[8'h51] = 8'hdd;lTable[8'h52] = 8'hfd;lTable[8'h53] = 8'h30;lTable[8'h54] = 8'hbf;lTable[8'h55] = 8'h06;
        lTable[8'h56] = 8'h8b;lTable[8'h57] = 8'h62;lTable[8'h58] = 8'hb3;lTable[8'h59] = 8'h25;lTable[8'h5a] = 8'he2;
        lTable[8'h5b] = 8'h98;lTable[8'h5c] = 8'h22;lTable[8'h5d] = 8'h88;lTable[8'h5e] = 8'h91;lTable[8'h5f] = 8'h10;
        lTable[8'h60] = 8'h7e;lTable[8'h61] = 8'h6e;lTable[8'h62] = 8'h48;lTable[8'h63] = 8'hc3;lTable[8'h64] = 8'ha3;
        lTable[8'h65] = 8'hb6;lTable[8'h66] = 8'h1e;lTable[8'h67] = 8'h42;lTable[8'h68] = 8'h3a;lTable[8'h69] = 8'h6b;
        lTable[8'h6a] = 8'h28;lTable[8'h6b] = 8'h54;lTable[8'h6c] = 8'hfa;lTable[8'h6d] = 8'h85;lTable[8'h6e] = 8'h3d;
        lTable[8'h6f] = 8'hba;lTable[8'h70] = 8'h2b;lTable[8'h71] = 8'h79;lTable[8'h72] = 8'h0a;lTable[8'h73] = 8'h15;
        lTable[8'h74] = 8'h9b;lTable[8'h75] = 8'h9f;lTable[8'h76] = 8'h5e;lTable[8'h77] = 8'hca;lTable[8'h78] = 8'h4e;
        lTable[8'h79] = 8'hd4;lTable[8'h7a] = 8'hac;lTable[8'h7b] = 8'he5;lTable[8'h7c] = 8'hf3;lTable[8'h7d] = 8'h73;
        lTable[8'h7e] = 8'ha7;lTable[8'h7f] = 8'h57;lTable[8'h80] = 8'haf;lTable[8'h81] = 8'h58;lTable[8'h82] = 8'ha8;
        lTable[8'h83] = 8'h50;lTable[8'h84] = 8'hf4;lTable[8'h85] = 8'hea;lTable[8'h86] = 8'hd6;lTable[8'h87] = 8'h74;
        lTable[8'h88] = 8'h4f;lTable[8'h89] = 8'hae;lTable[8'h8a] = 8'he9;lTable[8'h8b] = 8'hd5;lTable[8'h8c] = 8'he7;
        lTable[8'h8d] = 8'he6;lTable[8'h8e] = 8'had;lTable[8'h8f] = 8'he8;lTable[8'h90] = 8'h2c;lTable[8'h91] = 8'hd7;
        lTable[8'h92] = 8'h75;lTable[8'h93] = 8'h7a;lTable[8'h94] = 8'heb;lTable[8'h95] = 8'h16;lTable[8'h96] = 8'h0b;
        lTable[8'h97] = 8'hf5;lTable[8'h98] = 8'h59;lTable[8'h99] = 8'hcb;lTable[8'h9a] = 8'h5f;lTable[8'h9b] = 8'hb0;
        lTable[8'h9c] = 8'h9c;lTable[8'h9d] = 8'ha9;lTable[8'h9e] = 8'h51;lTable[8'h9f] = 8'ha0;lTable[8'ha0] = 8'h7f;
        lTable[8'ha1] = 8'h0c;lTable[8'ha2] = 8'hf6;lTable[8'ha3] = 8'h6f;lTable[8'ha4] = 8'h17;lTable[8'ha5] = 8'hc4;
        lTable[8'ha6] = 8'h49;lTable[8'ha7] = 8'hec;lTable[8'ha8] = 8'hd8;lTable[8'ha9] = 8'h43;lTable[8'haa] = 8'h1f;
        lTable[8'hab] = 8'h2d;lTable[8'hac] = 8'ha4;lTable[8'had] = 8'h76;lTable[8'hae] = 8'h7b;lTable[8'haf] = 8'hb7;
        lTable[8'hb0] = 8'hcc;lTable[8'hb1] = 8'hbb;lTable[8'hb2] = 8'h3e;lTable[8'hb3] = 8'h5a;lTable[8'hb4] = 8'hfb;
        lTable[8'hb5] = 8'h60;lTable[8'hb6] = 8'hb1;lTable[8'hb7] = 8'h86;lTable[8'hb8] = 8'h3b;lTable[8'hb9] = 8'h52;
        lTable[8'hba] = 8'ha1;lTable[8'hbb] = 8'h6c;lTable[8'hbc] = 8'haa;lTable[8'hbd] = 8'h55;lTable[8'hbe] = 8'h29;
        lTable[8'hbf] = 8'h9d;lTable[8'hc0] = 8'h97;lTable[8'hc1] = 8'hb2;lTable[8'hc2] = 8'h87;lTable[8'hc3] = 8'h90;
        lTable[8'hc4] = 8'h61;lTable[8'hc5] = 8'hbe;lTable[8'hc6] = 8'hdc;lTable[8'hc7] = 8'hfc;lTable[8'hc8] = 8'hbc;
        lTable[8'hc9] = 8'h95;lTable[8'hca] = 8'hcf;lTable[8'hcb] = 8'hcd;lTable[8'hcc] = 8'h37;lTable[8'hcd] = 8'h3f;
        lTable[8'hce] = 8'h5b;lTable[8'hcf] = 8'hd1;lTable[8'hd0] = 8'h53;lTable[8'hd1] = 8'h39;lTable[8'hd2] = 8'h84;
        lTable[8'hd3] = 8'h3c;lTable[8'hd4] = 8'h41;lTable[8'hd5] = 8'ha2;lTable[8'hd6] = 8'h6d;lTable[8'hd7] = 8'h47;
        lTable[8'hd8] = 8'h14;lTable[8'hd9] = 8'h2a;lTable[8'hda] = 8'h9e;lTable[8'hdb] = 8'h5d;lTable[8'hdc] = 8'h56;
        lTable[8'hdd] = 8'hf2;lTable[8'hde] = 8'hd3;lTable[8'hdf] = 8'hab;lTable[8'he0] = 8'h44;lTable[8'he1] = 8'h11;
        lTable[8'he2] = 8'h92;lTable[8'he3] = 8'hd9;lTable[8'he4] = 8'h23;lTable[8'he5] = 8'h20;lTable[8'he6] = 8'h2e;
        lTable[8'he7] = 8'h89;lTable[8'he8] = 8'hb4;lTable[8'he9] = 8'h7c;lTable[8'hea] = 8'hb8;lTable[8'heb] = 8'h26;
        lTable[8'hec] = 8'h77;lTable[8'hed] = 8'h99;lTable[8'hee] = 8'he3;lTable[8'hef] = 8'ha5;lTable[8'hf0] = 8'h67;
        lTable[8'hf1] = 8'h4a;lTable[8'hf2] = 8'hed;lTable[8'hf3] = 8'hde;lTable[8'hf4] = 8'hc5;lTable[8'hf5] = 8'h31;
        lTable[8'hf6] = 8'hfe;lTable[8'hf7] = 8'h18;lTable[8'hf8] = 8'h0d;lTable[8'hf9] = 8'h63;lTable[8'hfa] = 8'h8c;
        lTable[8'hfb] = 8'h80;lTable[8'hfc] = 8'hc0;lTable[8'hfd] = 8'hf7;lTable[8'hfe] = 8'h70;lTable[8'hff] = 8'h07;
        
        next_state = 1;   
     end
    1: begin
       if(start) begin
            next_state = 2;
       end
     end        
    2:begin
         if(start) begin
//            k[59] = keyIn[31:0];k[58] = keyIn[63:32];k[57] = keyIn[95:64];k[56] = keyIn[127:96];
//            k[55] = keyIn[159:128];k[54] = keyIn[191:160];k[53] = keyIn[223:192];k[52] = keyIn[255:224];
//            k[51] = keyIn[287:256];k[50] = keyIn[319:288];k[49] = keyIn[351:320];k[48] = keyIn[383:352];
//            k[47] = keyIn[415:384];k[46] = keyIn[447:416];k[45] = keyIn[479:448];k[44] = keyIn[511:480];
//            k[43] = keyIn[543:512];k[42] = keyIn[575:544];k[41] = keyIn[607:576];k[40] = keyIn[639:608];
//            k[39] = keyIn[671:640];k[38] = keyIn[703:672];k[37] = keyIn[735:704];k[36] = keyIn[767:736];
//            k[35] = keyIn[799:768];k[34] = keyIn[831:800];k[33] = keyIn[863:832];k[32] = keyIn[895:864];
//            k[31] = keyIn[927:896];k[30] = keyIn[959:928];k[29] = keyIn[991:960];k[28] = keyIn[1023:992];
//            k[27] = keyIn[1055:1024];k[26] = keyIn[1087:1056];k[25] = keyIn[1119:1088];k[24] = keyIn[1151:1120];
//            k[23] = keyIn[1183:1152];k[22] = keyIn[1215:1184];k[21] = keyIn[1247:1216];k[20] = keyIn[1279:1248];
//            k[19] = keyIn[1311:1280];k[18] = keyIn[1343:1312];k[17] = keyIn[1375:1344];k[16] = keyIn[1407:1376];
//            k[15] = keyIn[1439:1408];k[14] = keyIn[1471:1440];k[13] = keyIn[1503:1472];k[12] = keyIn[1535:1504];
//            k[11] = keyIn[1567:1536];k[10] = keyIn[1599:1568];k[9] = keyIn[1631:1600];k[8] = keyIn[1663:1632];
//            k[7] = keyIn[1695:1664];k[6] = keyIn[1727:1696];k[5] = keyIn[1759:1728];k[4] = keyIn[1791:1760];
//            k[3] = keyIn[1823:1792];k[2] = keyIn[1855:1824];k[1] = keyIn[1887:1856];k[0] = keyIn[1919:1888];
            
//            w[3] = dataIn[31:0];
//            w[2] = dataIn[63:32];
//            w[1] = dataIn[95:64];
//            w[0] = dataIn[127:96];
            
            k[0]=32'h00010203;k[1]=32'h04050607;k[2]=32'h08090a0b;k[3] = 32'h0c0d0e0f;k[4] = 32'h10111213;
            k[5]=32'h14151617;k[6]=32'h18191a1b;k[7]=32'h1c1d1e1f;k[8] = 32'ha573c29f;k[9] = 32'ha176c498;
            k[10]=32'ha97fce93;k[11]=32'ha572c09c;k[12]=32'h1651a8cd;k[13] = 32'h0244beda;k[14] = 32'h1a5da4c1;
            k[15]=32'h0640bade;k[16]=32'hae87dff0;k[17]=32'h0ff11b68;k[18] = 32'ha68ed5fb;k[19] = 32'h03fc1567;
            k[20]=32'h6de1f148;k[21]=32'h6fa54f92;k[22]=32'h75f8eb53;k[23] = 32'h73b8518d;k[24] = 32'hc656827f;
            k[25]=32'hc9a79917;k[26]=32'h6f294cec;k[27]=32'h6cd5598b;k[28] = 32'h3de23a75;k[29] = 32'h524775e7;
            k[30]=32'h27bf9eb4;k[31]=32'h5407cf39;k[32]=32'h0bdc905f;k[33] = 32'hc27b0948;k[34] = 32'had5245a4;
            k[35]=32'hc1871c2f;k[36]=32'h45f5a660;k[37]=32'h17b2d387;k[38] = 32'h300d4d33;k[39] = 32'h640a820a;
            k[40]=32'h7ccff71c;k[41]=32'hbeb4fe54;k[42]=32'h13e6bbf0;k[43] = 32'hd261a7df;k[44] = 32'hf01afafe;
            k[45]=32'he7a82979;k[46]=32'hd7a5644a;k[47]=32'hb3afe640;k[48] = 32'h2541fe71;k[49] = 32'h9bf50025;
            k[50]=32'h8813bbd5;k[51]=32'h5a721c0a;k[52]=32'h4e5a6699;k[53] = 32'ha9f24fe0;k[54] = 32'h7e572baa;
            k[55]=32'hcdf8cdea;k[56]=32'h24fc79cc;k[57]=32'hbf0979e9;k[58] = 32'h371ac23c;k[59] = 32'h6d68de36;
            
            w[0] = 32'h8ea2b7ca;w[1] = 32'h516745bf;w[2] = 32'heafc4990;w[3] = 32'h4b496089;
            next_state = 3;
          end    
    end
   3:begin
   /* round[0].iinput => w[n] */
   /* round[0].isch => k[n] */
   /* round[1].istart => tempStart[n] */
   /* round[1].istart = round[0].iinput XOR round[0].k_isch */
        tempStart[0] = w[0] ^ k[56];
        tempStart[1] = w[1] ^ k[57];
        tempStart[2] = w[2] ^ k[58];
        tempStart[3] = w[3] ^ k[59];
        next_state =  4;  
    end
	4:begin
        tempRow[0] = tempStart[0][31:24];tempRow[1] = tempStart[3][23:16];tempRow[2] = tempStart[2][15:8];tempRow[3] = tempStart[1][7:0];
        tempRow[4] = tempStart[1][31:24];tempRow[5] = tempStart[0][23:16];tempRow[6] = tempStart[3][15:8];tempRow[7] = tempStart[2][7:0];
        tempRow[8] = tempStart[2][31:24];tempRow[9] = tempStart[1][23:16];tempRow[10] = tempStart[0][15:8];tempRow[11] = tempStart[3][7:0];
        tempRow[12] =tempStart[3][31:24];tempRow[13] =tempStart[2][23:16];tempRow[14] = tempStart[1][15:8];tempRow[15] = tempStart[0][7:0];
        next_state = 5;
	end
    5:begin
        /* round[1].is_box => tempSbox[n] */
        tempSbox[0] = inv_sbox[tempRow[0]];tempSbox[1] = inv_sbox[tempRow[1]];tempSbox[2] = inv_sbox[tempRow[2]];tempSbox[3] = inv_sbox[tempRow[3]];
        tempSbox[4] = inv_sbox[tempRow[4]];tempSbox[5] = inv_sbox[tempRow[5]];tempSbox[6] = inv_sbox[tempRow[6]];tempSbox[7] = inv_sbox[tempRow[7]];
        tempSbox[8] = inv_sbox[tempRow[8]];tempSbox[9] = inv_sbox[tempRow[9]];tempSbox[10] = inv_sbox[tempRow[10]];tempSbox[11] = inv_sbox[tempRow[11]];
        tempSbox[12] = inv_sbox[tempRow[12]];tempSbox[13] = inv_sbox[tempRow[13]];tempSbox[14] = inv_sbox[tempRow[14]];tempSbox[15] = inv_sbox[tempRow[15]];
        next_state = 6;
    end
	6:begin
        d[0] = tempSbox[0]^k[52][31:24];
        d[1] = tempSbox[1]^k[52][23:16];
        d[2] = tempSbox[2]^k[52][15:8];
        d[3] = tempSbox[3]^k[52][7:0];
        d[4] = tempSbox[4]^k[53][31:24];
        d[5] = tempSbox[5]^k[53][23:16];
        d[6] = tempSbox[6]^k[53][15:8];
        d[7] = tempSbox[7]^k[53][7:0];
        d[8] = tempSbox[8]^k[54][31:24];
        d[9] = tempSbox[9]^k[54][23:16];
        d[10] = tempSbox[10]^k[54][15:8];
        d[11] = tempSbox[11]^k[54][7:0];
        d[12] = tempSbox[12]^k[55][31:24];
        d[13] = tempSbox[13]^k[55][23:16];
        d[14] = tempSbox[14]^k[55][15:8];
        d[15] = tempSbox[15]^k[55][7:0];
		next_state = 7;
	end

	7:begin 
	    /* For b0 & b4*/
		if(d[0] == 0)begin LT[0] = 0; LT[4] = 0; LT[8] = 0; LT[12] = 0 ;end
		else begin LT[0] = lTable[d[0]] + lTable[8'h0e];LT[4] = lTable[d[0]] + lTable[8'h09];LT[8] =  lTable[d[0]] + lTable[8'h0d];LT[12] = lTable[d[0]] + lTable[8'h0b];end
	    /* For b1 & b2*/
		if(d[1] == 0)begin LT[1] = 0;LT[5] = 0;LT[9] =0; LT[13] = 0;end
		else begin LT[1] = lTable[d[1]] + lTable[8'h0b];LT[5] = lTable[d[1]] + lTable[8'h0e];LT[9] = lTable[d[1]] + lTable[8'h09]; LT[13] = lTable[d[1]] + lTable[8'h0d];end
	    /* For b3 & b4*/
		if(d[2] == 0)begin LT[2] = 0;LT[6] = 0;LT[10] = 0;LT[14] = 0;end
		else begin LT[2] = lTable[d[2]] + lTable[8'h0d];LT[6] = lTable[d[2]] + lTable[8'h0b];LT[10] = lTable[d[2]] + lTable[8'h0e];LT[14] = lTable[d[2]] + lTable[8'h09];end
	    /* For b5 & b7*/			
		if(d[3] == 0)begin LT[3] = 0;LT[7] = 0;LT[11] = 0;LT[15] = 0;end 
		else begin  LT[3] = lTable[d[3]] + lTable[8'h09];LT[7] = lTable[d[3]] + lTable[8'h0d];LT[11] = lTable[d[3]] + lTable[8'h0b];LT[15] = lTable[d[3]] + lTable[8'h0e];end
	    /* For b8 & b14 */				
		if(d[4] == 0)begin LT[16] = 0; LT[20] = 0; LT[24] = 0; LT[28] = 0;end
		else begin LT[16] = lTable[d[4]] + lTable[8'h0e]; LT[20] = lTable[d[4]] + lTable[8'h09]; LT[24] = lTable[d[4]] + lTable[8'h0d]; LT[28] = lTable[d[4]] + lTable[8'h0b];end
		/* For b9 & b10 */
		if(d[5] == 0)begin LT[17] = 0;LT[21] = 0; LT[25] = 0;LT[29] = 0;end
		else begin LT[17] = lTable[d[5]] + lTable[8'h0b];LT[21] = lTable[d[5]] + lTable[8'h0e]; LT[25] = lTable[d[5]] + lTable[8'h09];LT[29] = lTable[d[5]] + lTable[8'h0d];end
		/* For b11 & b12*/
		if(d[6] == 0)begin LT[18] = 0;LT[22] = 0; LT[26] = 0;LT[30] = 0;end
		else begin LT[18] = lTable[d[6]] + lTable[8'h0d];LT[22] = lTable[d[6]] + lTable[8'h0b]; LT[26] = lTable[d[6]] + lTable[8'h0e];LT[30] = lTable[d[6]] + lTable[8'h09];end
		/* For b13 & b15 */
		if(d[7] == 0)begin LT[19] = 0;LT[23] = 0; LT[27] = 0;LT[31] = 0;end
		else begin LT[19] = lTable[d[7]] + lTable[8'h09];LT[23] = lTable[d[7]] + lTable[8'h0d]; LT[27] = lTable[d[7]] + lTable[8'h0b];LT[31] = lTable[d[7]] + lTable[8'h0e];end
		/* For b16 & b22 */
		if(d[8] == 0)begin LT[32] = 0;LT[36] = 0; LT[40] = 0;LT[44] = 0;end
		else begin LT[32] = lTable[d[8]] + lTable[8'h0e];LT[36] = lTable[d[8]] + lTable[8'h09];LT[40] = lTable[d[8]] + lTable[8'h0d];LT[44] = lTable[d[8]] + lTable[8'h0b];end
		/* For b17 & 18 */
		if(d[9] == 0)begin LT[33] = 0;LT[37] = 0; LT[41] = 0;LT[45] = 0;end
		else begin LT[33] = lTable[d[9]] + lTable[8'h0b];LT[37] = lTable[d[9]] + lTable[8'h0e]; LT[41] = lTable[d[9]] + lTable[8'h09];LT[45] = lTable[d[9]] + lTable[8'h0d];end
		/* For b19 & b20 */
		if(d[10] == 0)begin LT[34] = 0;LT[38] = 0;LT[42] = 0;LT[46] = 0;end
		else begin LT[34] = lTable[d[10]] + lTable[8'h0d];LT[38] = lTable[d[10]] + lTable[8'h0b];LT[42] = lTable[d[10]] + lTable[8'h0e];LT[46] = lTable[d[10]] + lTable[8'h09];end
		/* For b21 & b23 */
		if(d[11] == 0)begin LT[35] = 0; LT[39] =0;LT[43] = 0; LT[47] =0;end
		else begin  LT[35] = lTable[d[11]] + lTable[8'h09]; LT[39] =lTable[d[11]] + lTable[8'h0d];LT[43] = lTable[d[11]] + lTable[8'h0b]; LT[47] =lTable[d[11]] + lTable[8'h0e];end	
		/* For b24 & b30 */
		if(d[12] == 0)begin LT[48] = 0;LT[52] = 0; LT[56] = 0;LT[60] = 0;end 
		else begin LT[48] = lTable[d[12]] + lTable[8'h0e];LT[52] = lTable[d[12]] + lTable[8'h09]; LT[56] = lTable[d[12]] + lTable[8'h0d];LT[60] = lTable[d[12]] + lTable[8'h0b];end 		
		/* For b25 & b26 */		
		if(d[13] == 0)begin LT[49] = 0;LT[53] = 0; LT[57] = 0;LT[61] = 0;end 
		else begin  LT[49] = lTable[d[13]] + lTable[8'h0b];LT[53] = lTable[d[13]] + lTable[8'h0e]; LT[57] = lTable[d[13]] + lTable[8'h09];LT[61] = lTable[d[13]] + lTable[8'h0d];end 
		/* For b27 & b28 */
		if(d[14] == 0)begin LT[50] = 0;LT[54] = 0; LT[58] = 0;LT[62] = 0;end 
		else begin LT[50] = lTable[d[14]] + lTable[8'h0d];LT[54] = lTable[d[14]] + lTable[8'h0b]; LT[58] = lTable[d[14]] + lTable[8'h0e];LT[62] = lTable[d[14]] + lTable[8'h09];end 
		/* For b29 & b31 */
		if(d[15] == 0)begin LT[51] = 0;LT[55] = 0; LT[59] = 0;LT[63] = 0;end 
		else begin LT[51] = lTable[d[15]] + lTable[8'h09];LT[55] = lTable[d[15]] + lTable[8'h0d]; LT[59] = lTable[d[15]] + lTable[8'h0b];LT[63] = lTable[d[15]] + lTable[8'h0e];end 

        next_state = 8;
    end
    8:begin
		if(LT[0] > 255)begin l[0] = LT[0] - 255;end
		else begin l[0] = LT[0];end
		if(LT[1] > 255)begin l[1] = LT[1] - 255;end
		else  begin l[1] = LT[1];end
		if(LT[2] > 255)begin l[2] = LT[2] - 255;end
		else  begin l[2] = LT[2];end
		if(LT[3] > 255)begin l[3] = LT[3] - 255;end
		else  begin l[3] = LT[3];end
		if(LT[4] > 255)begin l[4] = LT[4] - 255;end
		else  begin l[4] = LT[4];end
		if(LT[5] > 255)begin l[5] = LT[5] - 255;end
		else  begin l[5] = LT[5];end
		if(LT[6] > 255)begin l[6] = LT[6] - 255;end
		else  begin l[6] = LT[6];end
		if(LT[7] > 255)begin l[7] = LT[7] - 255;end
		else  begin l[7] = LT[7];end
		if(LT[8] > 255)begin l[8] = LT[8] - 255;end
		else  begin l[8] = LT[8];end
		if(LT[9] > 255)begin l[9] = LT[9] - 255;end
		else  begin l[9] = LT[9];end
		if(LT[10] > 255)begin l[10] = LT[10] - 255;end
		else  begin l[10] = LT[10];end
		if(LT[11] > 255)begin l[11] = LT[11] - 255;end
		else  begin l[11] = LT[11];end
		if(LT[12] > 255)begin l[12] = LT[12] - 255;end
		else  begin l[12] = LT[12];end
		if(LT[13] > 255)begin l[13] = LT[13] - 255;end
		else  begin l[13] = LT[13];end
		if(LT[14] > 255)begin l[14] = LT[14] - 255;end
		else  begin l[14] = LT[14];end
		if(LT[15] > 255)begin l[15] = LT[15] - 255;end
		else  begin l[15] = LT[15];end
		if(LT[16] > 255)begin l[16] = LT[16] - 255;end
		else  begin l[16] = LT[16];end
		if(LT[17] > 255)begin l[17] = LT[17] - 255;end
		else  begin l[17] = LT[17];end
		if(LT[18] > 255)begin l[18] = LT[18] - 255;end
		else  begin l[18] = LT[18];end
		if(LT[19] > 255)begin l[19] = LT[19] - 255;end
		else  begin l[19] = LT[19];end
		if(LT[20] > 255)begin l[20] = LT[20] - 255;end
		else  begin l[20] = LT[20];end
		if(LT[21] > 255)begin l[21] = LT[21] - 255;end
		else  begin l[21] = LT[21];end
		if(LT[22] > 255)begin l[22] = LT[22] - 255;end
		else  begin l[22] = LT[22];end
		if(LT[23] > 255)begin l[23] = LT[23] - 255;end
		else  begin l[23] = LT[23];end
		if(LT[24] > 255)begin l[24] = LT[24] - 255;end
		else  begin l[24] = LT[24];end
		if(LT[25] > 255)begin l[25] = LT[25] - 255;end
		else  begin l[25] = LT[25];end
		if(LT[26] > 255)begin l[26] = LT[26] - 255;end
		else  begin l[26] = LT[26];end
		if(LT[27] > 255)begin l[27] = LT[27] - 255;end
		else  begin l[27] = LT[27];end
		if(LT[28] > 255)begin l[28] = LT[28] - 255;end
		else  begin l[28] = LT[28];end
		if(LT[29] > 255)begin l[29] = LT[29] - 255;end
		else  begin l[29] = LT[29];end
		if(LT[30] > 255)begin l[30] = LT[30] - 255;end
		else  begin l[30] = LT[30];end
		if(LT[31] > 255)begin l[31] = LT[31] - 255;end
		else  begin l[31] = LT[31];end
		if(LT[32] > 255)begin l[32] = LT[32] - 255;end
		else  begin l[32] = LT[32];end
		if(LT[33] > 255)begin l[33] = LT[33] - 255;end
		else  begin l[33] = LT[33];end
		if(LT[34] > 255)begin l[34] = LT[34] - 255;end
		else  begin l[34] = LT[34];end
		if(LT[35] > 255)begin l[35] = LT[35] - 255;end
		else  begin l[35] = LT[35];end
		if(LT[36] > 255)begin l[36] = LT[36] - 255;end
		else  begin l[36] = LT[36];end
		if(LT[37] > 255)begin l[37] = LT[37] - 255;end
		else  begin l[37] = LT[37];end
		if(LT[38] > 255)begin l[38] = LT[38] - 255;end
		else  begin l[38] = LT[38];end
		if(LT[39] > 255)begin l[39] = LT[39] - 255;end
		else  begin l[39] = LT[39];end
		if(LT[40] > 255)begin l[40] = LT[40] - 255;end
		else  begin l[40] = LT[40];end
		if(LT[41] > 255)begin l[41] = LT[41] - 255;end
		else  begin l[41] = LT[41];end
		if(LT[42] > 255)begin l[42] = LT[42] - 255;end
		else  begin l[42] = LT[42];end
		if(LT[43] > 255)begin l[43] = LT[43] - 255;end
		else  begin l[43] = LT[43];end
		if(LT[44] > 255)begin l[44] = LT[44] - 255;end
		else  begin l[44] = LT[44];end
		if(LT[45] > 255)begin l[45] = LT[45] - 255;end
		else  begin l[45] = LT[45];end
		if(LT[46] > 255)begin l[46] = LT[46] - 255;end
		else  begin l[46] = LT[46];end
		if(LT[47] > 255)begin l[47] = LT[47] - 255;end
		else  begin l[47] = LT[47];end
		if(LT[48] > 255)begin l[48] = LT[48] - 255;end
		else  begin l[48] = LT[48];end
		if(LT[49] > 255)begin l[49] = LT[49] - 255;end
		else  begin l[49] = LT[49];end
		if(LT[50] > 255)begin l[50] = LT[50] - 255;end
		else  begin l[50] = LT[50];end
		if(LT[51] > 255)begin l[51] = LT[51] - 255;end
		else  begin l[51] = LT[51];end
		if(LT[52] > 255)begin l[52] = LT[52] - 255;end
		else  begin l[52] = LT[52];end
		if(LT[53] > 255)begin l[53] = LT[53] - 255;end
		else  begin l[53] = LT[53];end
		if(LT[54] > 255)begin l[54] = LT[54] - 255;end
		else  begin l[54] = LT[54];end
		if(LT[55] > 255)begin l[55] = LT[55] - 255;end
		else  begin l[55] = LT[55];end
		if(LT[56] > 255)begin l[56] = LT[56] - 255;end
		else  begin l[56] = LT[56];end
		if(LT[57] > 255)begin l[57] = LT[57] - 255;end
		else  begin l[57] = LT[57];end
		if(LT[58] > 255)begin l[58] = LT[58] - 255;end
		else  begin l[58] = LT[58];end
		if(LT[59] > 255)begin l[59] = LT[59] - 255;end
		else  begin l[59] = LT[59];end
		if(LT[60] > 255)begin l[60] = LT[60] - 255;end
		else  begin l[60] = LT[60];end
		if(LT[61] > 255)begin l[61] = LT[61] - 255;end
		else  begin l[61] = LT[61];end
		if(LT[62] > 255)begin l[62] = LT[62] - 255;end
		else  begin l[62] = LT[62];end
		if(LT[63] > 255)begin l[63] = LT[63] - 255;end
		else  begin l[63] = LT[63];end		
		next_state = 9;
	end
	9:begin
		/* for d0 */
		if(l[0] == 0)begin ET[0] = 0;end
		else begin ET[0] = eTable[l[0]];end
		if(l[1] == 0)begin ET[1] = 0;end
		else begin ET[1] = eTable[l[1]];end
		/* for d1 */
		if(l[2] == 0)begin ET[2] = 0;end
		else begin ET[2] = eTable[l[2]];end
		if(l[3] == 0)begin ET[3] = 0;end
		else begin ET[3] = eTable[l[3]];end
		/* for d2 */
		if(l[4] == 0)begin ET[4] = 0;end
		else begin ET[4] = eTable[l[4]];end
		if(l[5] == 0)begin ET[5] = 0;end
		else begin ET[5] = eTable[l[5]];end
		/* for d3 */
		if(l[6] == 0)begin ET[6] = 0;end
		else begin ET[6] = eTable[l[6]];end
		if(l[7] == 0)begin ET[7] = 0;end
		else begin ET[7] = eTable[l[7]];end
		/* for d4 */
		if(l[8] == 0)begin ET[8] = 0;end
		else begin ET[8] = eTable[l[8]];end
		if(l[9] == 0)begin ET[9] = 0;end
		else begin ET[9] = eTable[l[9]];end
		/* for d5 */
		if(l[10] == 0)begin ET[10] = 0;end
		else begin ET[10] = eTable[l[10]];end
		if(l[11] == 0)begin ET[11] = 0;end
		else begin ET[11] = eTable[l[11]];end
		/* for d6 */
		if(l[12] == 0)begin ET[12] = 0;end
		else begin ET[12] = eTable[l[12]];end
		if(l[13] == 0)begin ET[13] = 0;end
		else begin ET[13] = eTable[l[13]];end
		/* for d7 */
		if(l[14] == 0)begin ET[14] = 0;end
		else begin ET[14] = eTable[l[14]];end
		if(l[15] == 0)begin ET[15] = 0;end
		else begin ET[15] = eTable[l[15]];end
		/* for d8 */
		if(l[16] == 0)begin ET[16] = 0;end
		else begin ET[16] = eTable[l[16]];end
		if(l[17] == 0)begin ET[17] = 0;end
		else begin ET[17] = eTable[l[17]];end
		/* for d9 */
		if(l[18] == 0)begin ET[18] = 0;end
		else begin ET[18] = eTable[l[18]];end
		if(l[19] == 0)begin ET[19] = 0;end
		else begin ET[19] = eTable[l[19]];end
		/* for d10 */
		if(l[20] == 0)begin ET[20] = 0;end
		else begin ET[20] = eTable[l[20]];end
		if(l[21] == 0)begin ET[21] = 0;end
		else begin ET[21] = eTable[l[21]];end
		/* for d11 */
		if(l[22] == 0)begin ET[22] = 0;end
		else begin ET[22] = eTable[l[22]];end
		if(l[23] == 0)begin ET[23] = 0;end
		else begin ET[23] = eTable[l[23]];end
		/* for d12 */
		if(l[24] == 0)begin ET[24] = 0;end
		else begin ET[24] = eTable[l[24]];end
		if(l[25] == 0)begin ET[25] = 0;end
		else begin ET[25] = eTable[l[25]];end
		/* for d13 */
		if(l[26] == 0)begin ET[26] = 0;end
		else begin ET[26] = eTable[l[26]];end
		if(l[27] == 0)begin ET[27] = 0;end
		else begin ET[27] = eTable[l[27]];end
		/* for d14 */
		if(l[28] == 0)begin ET[28] = 0;end
		else begin ET[28] = eTable[l[28]];end
		if(l[29] == 0)begin ET[29] = 0;end
		else begin ET[29] = eTable[l[29]];end
		/* for d15 */
		if(l[30] == 0)begin ET[30] = 0;end
		else begin ET[30] = eTable[l[30]];end
		if(l[31] == 0)begin ET[31] = 0;end
		else begin ET[31] = eTable[l[31]];end
		if(l[32] == 0)begin ET[32] = 0;end
		else begin ET[32] = eTable[l[32]];end
		if(l[33] == 0)begin ET[33] = 0;end
		else begin ET[33] = eTable[l[33]];end
		if(l[34] == 0)begin ET[34] = 0;end
		else begin ET[34] = eTable[l[34]];end
		if(l[35] == 0)begin ET[35] = 0;end
		else begin ET[35] = eTable[l[35]];end
		if(l[36] == 0)begin ET[36] = 0;end
		else begin ET[36] = eTable[l[36]];end
		if(l[37] == 0)begin ET[37] = 0;end
		else begin ET[37] = eTable[l[37]];end
		if(l[38] == 0)begin ET[38] = 0;end
		else begin ET[38] = eTable[l[38]];end
		if(l[39] == 0)begin ET[39] = 0;end
		else begin ET[39] = eTable[l[39]];end
		if(l[40] == 0)begin ET[40] = 0;end
		else begin ET[40] = eTable[l[40]];end
		if(l[41] == 0)begin ET[41] = 0;end
		else begin ET[41] = eTable[l[41]];end
		if(l[42] == 0)begin ET[42] = 0;end
		else begin ET[42] = eTable[l[42]];end
		if(l[43] == 0)begin ET[43] = 0;end
		else begin ET[43] = eTable[l[43]];end
		if(l[44] == 0)begin ET[44] = 0;end
		else begin ET[44] = eTable[l[44]];end
		if(l[45] == 0)begin ET[45] = 0;end
		else begin ET[45] = eTable[l[45]];end
		if(l[46] == 0)begin ET[46] = 0;end
		else begin ET[46] = eTable[l[46]];end
		if(l[47] == 0)begin ET[47] = 0;end
		else begin ET[47] = eTable[l[47]];end
		if(l[48] == 0)begin ET[48] = 0;end
		else begin ET[48] = eTable[l[48]];end
		if(l[49] == 0)begin ET[49] = 0;end
		else begin ET[49] = eTable[l[49]];end
		if(l[50] == 0)begin ET[50] = 0;end
		else begin ET[50] = eTable[l[50]];end		
		if(l[51] == 0)begin ET[51] = 0;end
		else begin ET[51] = eTable[l[51]];end
		if(l[52] == 0)begin ET[52] = 0;end
		else begin ET[52] = eTable[l[52]];end
		if(l[53] == 0)begin ET[53] = 0;end
		else begin ET[53] = eTable[l[53]];end
		if(l[54] == 0)begin ET[54] = 0;end
		else begin ET[54] = eTable[l[54]];end
		if(l[55] == 0)begin ET[55] = 0;end
		else begin ET[55] = eTable[l[55]];end
		if(l[56] == 0)begin ET[56] = 0;end
		else begin ET[56] = eTable[l[56]];end
		if(l[57] == 0)begin ET[57] = 0;end
		else begin ET[57] = eTable[l[57]];end
		if(l[58] == 0)begin ET[58] = 0;end
		else begin ET[58] = eTable[l[58]];end
		if(l[59] == 0)begin ET[59] = 0;end
		else begin ET[59] = eTable[l[59]];end
		if(l[60] == 0)begin ET[60] = 0;end
		else begin ET[60] = eTable[l[60]];end	
		if(l[61] == 0)begin ET[61] = 0;end
		else begin ET[61] = eTable[l[61]];end
		if(l[62] == 0)begin ET[62] = 0;end
		else begin ET[62] = eTable[l[62]];end
		if(l[63] == 0)begin ET[63] = 0;end
		else begin ET[63] = eTable[l[63]];end
		next_state = 10;
	end
    10:begin
        d1[0] = ET[0]^ET[1]^ET[2]^ET[3];
        d1[1] = ET[4]^ET[5]^ET[6]^ET[7];
        d1[2] = ET[8]^ET[9]^ET[10]^ET[11];
        d1[3] = ET[12]^ET[13]^ET[14]^ET[15];
        d1[4] = ET[16]^ET[17]^ET[18]^ET[19];
        d1[5] = ET[20]^ET[21]^ET[22]^ET[23];
        d1[6] = ET[24]^ET[25]^ET[26]^ET[27];
        d1[7] = ET[28]^ET[29]^ET[30]^ET[31];
        d1[8] = ET[32]^ET[33]^ET[34]^ET[35];
        d1[9] = ET[36]^ET[37]^ET[38]^ET[39];
        d1[10] = ET[40]^ET[41]^ET[42]^ET[43];
        d1[11] = ET[44]^ET[45]^ET[46]^ET[47];
        d1[12] = ET[48]^ET[49]^ET[50]^ET[51];
        d1[13] = ET[52]^ET[53]^ET[54]^ET[55];
        d1[14] = ET[56]^ET[57]^ET[58]^ET[59];
        d1[15] =ET[60]^ET[61]^ET[62]^ET[63]; 
        next_state = 11;
    end
	11:begin
        tempRow1[0] = d1[0];tempRow1[4] = d1[4];tempRow1[8] = d1[8];tempRow1[12] = d1[12];
        tempRow1[1] = d1[13];tempRow1[5] = d1[1];tempRow1[9] = d1[5];tempRow1[13] = d1[9];
        tempRow1[2] = d1[10];tempRow1[6] = d1[14];tempRow1[10] = d1[2];tempRow1[14] = d1[6];
        tempRow1[3] = d1[7];tempRow1[7] = d1[11];tempRow1[11] = d1[15];tempRow1[15] = d1[3];
        next_state = 12;
	end
	12:begin
        tempSbox1[0] = inv_sbox[tempRow1[0]];tempSbox1[1] = inv_sbox[tempRow1[1]];tempSbox1[2] = inv_sbox[tempRow1[2]];tempSbox1[3] = inv_sbox[tempRow1[3]];
        tempSbox1[4] = inv_sbox[tempRow1[4]];tempSbox1[5] = inv_sbox[tempRow1[5]];tempSbox1[6] = inv_sbox[tempRow1[6]];tempSbox1[7] = inv_sbox[tempRow1[7]];
        tempSbox1[8] = inv_sbox[tempRow1[8]];tempSbox1[9] = inv_sbox[tempRow1[9]];tempSbox1[10] = inv_sbox[tempRow1[10]];tempSbox1[11] = inv_sbox[tempRow1[11]];
        tempSbox1[12] = inv_sbox[tempRow1[12]];tempSbox1[13] = inv_sbox[tempRow1[13]];tempSbox1[14] = inv_sbox[tempRow1[14]];tempSbox1[15] = inv_sbox[tempRow1[15]];
		next_state = 13;
	end
	13:begin
        d2[0] = tempSbox1[0]^k[48][31:24];
        d2[1] = tempSbox1[1]^k[48][23:16];
        d2[2] = tempSbox1[2]^k[48][15:8];
        d2[3] = tempSbox1[3]^k[48][7:0];
        d2[4] = tempSbox1[4]^k[49][31:24];
        d2[5] = tempSbox1[5]^k[49][23:16];
        d2[6] = tempSbox1[6]^k[49][15:8];
        d2[7] = tempSbox1[7]^k[49][7:0];
        d2[8] = tempSbox1[8]^k[50][31:24];
        d2[9] = tempSbox1[9]^k[50][23:16];
        d2[10] = tempSbox1[10]^k[50][15:8];
        d2[11] = tempSbox1[11]^k[50][7:0];
        d2[12] = tempSbox1[12]^k[51][31:24];
        d2[13] = tempSbox1[13]^k[51][23:16];
        d2[14] = tempSbox1[14]^k[51][15:8];
        d2[15] = tempSbox1[15]^k[51][7:0];
		next_state = 14;
	end
	14:begin 
	    /* For b0 & b4*/
		if(d2[0] == 0)begin LT1[0] = 0; LT1[4] = 0; LT1[8] = 0; LT1[12] = 0 ;end
		else begin LT1[0] = lTable[d2[0]] + lTable[8'h0e];LT1[4] = lTable[d2[0]] + lTable[8'h09];LT1[8] =  lTable[d2[0]] + lTable[8'h0d];LT1[12] = lTable[d2[0]] + lTable[8'h0b];end
	    /* For b1 & b2*/
		if(d2[1] == 0)begin LT1[1] = 0;LT1[5] = 0;LT1[9] =0; LT1[13] = 0;end
		else begin LT1[1] = lTable[d2[1]] + lTable[8'h0b];LT1[5] = lTable[d2[1]] + lTable[8'h0e];LT1[9] = lTable[d2[1]] + lTable[8'h09]; LT1[13] = lTable[d2[1]] + lTable[8'h0d];end
	    /* For b3 & b4*/
		if(d2[2] == 0)begin LT1[2] = 0;LT1[6] = 0;LT1[10] = 0;LT1[14] = 0;end
		else begin LT1[2] = lTable[d2[2]] + lTable[8'h0d];LT1[6] = lTable[d2[2]] + lTable[8'h0b];LT1[10] = lTable[d2[2]] + lTable[8'h0e];LT1[14] = lTable[d2[2]] + lTable[8'h09];end
	    /* For b5 & b7*/			
		if(d2[3] == 0)begin LT1[3] = 0;LT1[7] = 0;LT1[11] = 0;LT1[15] = 0;end 
		else begin  LT1[3] = lTable[d2[3]] + lTable[8'h09];LT1[7] = lTable[d2[3]] + lTable[8'h0d];LT1[11] = lTable[d2[3]] + lTable[8'h0b];LT1[15] = lTable[d2[3]] + lTable[8'h0e];end
	    /* For b8 & b14 */				
		if(d2[4] == 0)begin LT1[16] = 0; LT1[20] = 0; LT1[24] = 0; LT1[28] = 0;end
		else begin LT1[16] = lTable[d2[4]] + lTable[8'h0e]; LT1[20] = lTable[d2[4]] + lTable[8'h09]; LT1[24] = lTable[d2[4]] + lTable[8'h0d]; LT1[28] = lTable[d2[4]] + lTable[8'h0b];end
		/* For b9 & b10 */
		if(d2[5] == 0)begin LT1[17] = 0;LT1[21] = 0; LT1[25] = 0;LT1[29] = 0;end
		else begin LT1[17] = lTable[d2[5]] + lTable[8'h0b];LT1[21] = lTable[d2[5]] + lTable[8'h0e]; LT1[25] = lTable[d2[5]] + lTable[8'h09];LT1[29] = lTable[d2[5]] + lTable[8'h0d];end
		/* For b11 & b12*/
		if(d2[6] == 0)begin LT1[18] = 0;LT1[22] = 0; LT1[26] = 0;LT1[30] = 0;end
		else begin LT1[18] = lTable[d2[6]] + lTable[8'h0d];LT1[22] = lTable[d2[6]] + lTable[8'h0b]; LT1[26] = lTable[d2[6]] + lTable[8'h0e];LT1[30] = lTable[d2[6]] + lTable[8'h09];end
		/* For b13 & b15 */
		if(d2[7] == 0)begin LT1[19] = 0;LT1[23] = 0; LT1[27] = 0;LT1[31] = 0;end
		else begin LT1[19] = lTable[d2[7]] + lTable[8'h09];LT1[23] = lTable[d2[7]] + lTable[8'h0d]; LT1[27] = lTable[d2[7]] + lTable[8'h0b];LT1[31] = lTable[d2[7]] + lTable[8'h0e];end
		/* For b16 & b22 */
		if(d2[8] == 0)begin LT1[32] = 0;LT1[36] = 0; LT1[40] = 0;LT1[44] = 0;end
		else begin LT1[32] = lTable[d2[8]] + lTable[8'h0e];LT1[36] = lTable[d2[8]] + lTable[8'h09];LT1[40] = lTable[d2[8]] + lTable[8'h0d];LT1[44] = lTable[d2[8]] + lTable[8'h0b];end
		/* For b17 & 18 */
		if(d2[9] == 0)begin LT1[33] = 0;LT1[37] = 0; LT1[41] = 0;LT1[45] = 0;end
		else begin LT1[33] = lTable[d2[9]] + lTable[8'h0b];LT1[37] = lTable[d2[9]] + lTable[8'h0e]; LT1[41] = lTable[d2[9]] + lTable[8'h09];LT1[45] = lTable[d2[9]] + lTable[8'h0d];end
		/* For b19 & b20 */
		if(d2[10] == 0)begin LT1[34] = 0;LT1[38] = 0;LT1[42] = 0;LT1[46] = 0;end
		else begin LT1[34] = lTable[d2[10]] + lTable[8'h0d];LT1[38] = lTable[d2[10]] + lTable[8'h0b];LT1[42] = lTable[d2[10]] + lTable[8'h0e];LT1[46] = lTable[d2[10]] + lTable[8'h09];end
		/* For b21 & b23 */
		if(d2[11] == 0)begin LT1[35] = 0; LT1[39] =0;LT1[43] = 0; LT1[47] =0;end
		else begin  LT1[35] = lTable[d2[11]] + lTable[8'h09]; LT1[39] =lTable[d2[11]] + lTable[8'h0d];LT1[43] = lTable[d2[11]] + lTable[8'h0b]; LT1[47] =lTable[d2[11]] + lTable[8'h0e];end	
		/* For b24 & b30 */
		if(d2[12] == 0)begin LT1[48] = 0;LT1[52] = 0; LT1[56] = 0;LT1[60] = 0;end 
		else begin LT1[48] = lTable[d2[12]] + lTable[8'h0e];LT1[52] = lTable[d2[12]] + lTable[8'h09]; LT1[56] = lTable[d2[12]] + lTable[8'h0d];LT1[60] = lTable[d2[12]] + lTable[8'h0b];end 		
		/* For b25 & b26 */		
		if(d2[13] == 0)begin LT1[49] = 0;LT1[53] = 0; LT1[57] = 0;LT1[61] = 0;end 
		else begin  LT1[49] = lTable[d2[13]] + lTable[8'h0b];LT1[53] = lTable[d2[13]] + lTable[8'h0e]; LT1[57] = lTable[d2[13]] + lTable[8'h09];LT1[61] = lTable[d2[13]] + lTable[8'h0d];end 
		/* For b27 & b28 */
		if(d2[14] == 0)begin LT1[50] = 0;LT1[54] = 0; LT1[58] = 0;LT1[62] = 0;end 
		else begin LT1[50] = lTable[d2[14]] + lTable[8'h0d];LT1[54] = lTable[d2[14]] + lTable[8'h0b]; LT1[58] = lTable[d2[14]] + lTable[8'h0e];LT1[62] = lTable[d2[14]] + lTable[8'h09];end 
		/* For b29 & b31 */
		if(d2[15] == 0)begin LT1[51] = 0;LT1[55] = 0; LT1[59] = 0;LT1[63] = 0;end 
		else begin LT1[51] = lTable[d2[15]] + lTable[8'h09];LT1[55] = lTable[d2[15]] + lTable[8'h0d]; LT1[59] = lTable[d2[15]] + lTable[8'h0b];LT1[63] = lTable[d2[15]] + lTable[8'h0e];end 

        next_state = 15;
    end
    15:begin
		if(LT1[0] > 255)begin l1[0] = LT1[0] - 255;end
		else begin l1[0] = LT1[0];end
		if(LT1[1] > 255)begin l1[1] = LT1[1] - 255;end
		else  begin l1[1] = LT1[1];end
		if(LT1[2] > 255)begin l1[2] = LT1[2] - 255;end
		else  begin l1[2] = LT1[2];end
		if(LT1[3] > 255)begin l1[3] = LT1[3] - 255;end
		else  begin l1[3] = LT1[3];end
		if(LT1[4] > 255)begin l1[4] = LT1[4] - 255;end
		else  begin l1[4] = LT1[4];end
		if(LT1[5] > 255)begin l1[5] = LT1[5] - 255;end
		else  begin l1[5] = LT1[5];end
		if(LT1[6] > 255)begin l1[6] = LT1[6] - 255;end
		else  begin l1[6] = LT1[6];end
		if(LT1[7] > 255)begin l1[7] = LT1[7] - 255;end
		else  begin l1[7] = LT1[7];end
		if(LT1[8] > 255)begin l1[8] = LT1[8] - 255;end
		else  begin l1[8] = LT1[8];end
		if(LT1[9] > 255)begin l1[9] = LT1[9] - 255;end
		else  begin l1[9] = LT1[9];end
		if(LT1[10] > 255)begin l1[10] = LT1[10] - 255;end
		else  begin l1[10] = LT1[10];end
		if(LT1[11] > 255)begin l1[11] = LT1[11] - 255;end
		else  begin l1[11] = LT1[11];end
		if(LT1[12] > 255)begin l1[12] = LT1[12] - 255;end
		else  begin l1[12] = LT1[12];end
		if(LT1[13] > 255)begin l1[13] = LT1[13] - 255;end
		else  begin l1[13] = LT1[13];end
		if(LT1[14] > 255)begin l1[14] = LT1[14] - 255;end
		else  begin l1[14] = LT1[14];end
		if(LT1[15] > 255)begin l1[15] = LT1[15] - 255;end
		else  begin l1[15] = LT1[15];end
		if(LT1[16] > 255)begin l1[16] = LT1[16] - 255;end
		else  begin l1[16] = LT1[16];end
		if(LT1[17] > 255)begin l1[17] = LT1[17] - 255;end
		else  begin l1[17] = LT1[17];end
		if(LT1[18] > 255)begin l1[18] = LT1[18] - 255;end
		else  begin l1[18] = LT1[18];end
		if(LT1[19] > 255)begin l1[19] = LT1[19] - 255;end
		else  begin l1[19] = LT1[19];end
		if(LT1[20] > 255)begin l1[20] = LT1[20] - 255;end
		else  begin l1[20] = LT1[20];end
		if(LT1[21] > 255)begin l1[21] = LT1[21] - 255;end
		else  begin l1[21] = LT1[21];end
		if(LT1[22] > 255)begin l1[22] = LT1[22] - 255;end
		else  begin l1[22] = LT1[22];end
		if(LT1[23] > 255)begin l1[23] = LT1[23] - 255;end
		else  begin l1[23] = LT1[23];end
		if(LT1[24] > 255)begin l1[24] = LT1[24] - 255;end
		else  begin l1[24] = LT1[24];end
		if(LT1[25] > 255)begin l1[25] = LT1[25] - 255;end
		else  begin l1[25] = LT1[25];end
		if(LT1[26] > 255)begin l1[26] = LT1[26] - 255;end
		else  begin l1[26] = LT1[26];end
		if(LT1[27] > 255)begin l1[27] = LT1[27] - 255;end
		else  begin l1[27] = LT1[27];end
		if(LT1[28] > 255)begin l1[28] = LT1[28] - 255;end
		else  begin l1[28] = LT1[28];end
		if(LT1[29] > 255)begin l1[29] = LT1[29] - 255;end
		else  begin l1[29] = LT1[29];end
		if(LT1[30] > 255)begin l1[30] = LT1[30] - 255;end
		else  begin l1[30] = LT1[30];end
		if(LT1[31] > 255)begin l1[31] = LT1[31] - 255;end
		else  begin l1[31] = LT1[31];end
		if(LT1[32] > 255)begin l1[32] = LT1[32] - 255;end
		else  begin l1[32] = LT1[32];end
		if(LT1[33] > 255)begin l1[33] = LT1[33] - 255;end
		else  begin l1[33] = LT1[33];end
		if(LT1[34] > 255)begin l1[34] = LT1[34] - 255;end
		else  begin l1[34] = LT1[34];end
		if(LT1[35] > 255)begin l1[35] = LT1[35] - 255;end
		else  begin l1[35] = LT1[35];end
		if(LT1[36] > 255)begin l1[36] = LT1[36] - 255;end
		else  begin l1[36] = LT1[36];end
		if(LT1[37] > 255)begin l1[37] = LT1[37] - 255;end
		else  begin l1[37] = LT1[37];end
		if(LT1[38] > 255)begin l1[38] = LT1[38] - 255;end
		else  begin l1[38] = LT1[38];end
		if(LT1[39] > 255)begin l1[39] = LT1[39] - 255;end
		else  begin l1[39] = LT1[39];end
		if(LT1[40] > 255)begin l1[40] = LT1[40] - 255;end
		else  begin l1[40] = LT1[40];end
		if(LT1[41] > 255)begin l1[41] = LT1[41] - 255;end
		else  begin l1[41] = LT1[41];end
		if(LT1[42] > 255)begin l1[42] = LT1[42] - 255;end
		else  begin l1[42] = LT1[42];end
		if(LT1[43] > 255)begin l1[43] = LT1[43] - 255;end
		else  begin l1[43] = LT1[43];end
		if(LT1[44] > 255)begin l1[44] = LT1[44] - 255;end
		else  begin l1[44] = LT1[44];end
		if(LT1[45] > 255)begin l1[45] = LT1[45] - 255;end
		else  begin l1[45] = LT1[45];end
		if(LT1[46] > 255)begin l1[46] = LT1[46] - 255;end
		else  begin l1[46] = LT1[46];end
		if(LT1[47] > 255)begin l1[47] = LT1[47] - 255;end
		else  begin l1[47] = LT1[47];end
		if(LT1[48] > 255)begin l1[48] = LT1[48] - 255;end
		else  begin l1[48] = LT1[48];end
		if(LT1[49] > 255)begin l1[49] = LT1[49] - 255;end
		else  begin l1[49] = LT1[49];end
		if(LT1[50] > 255)begin l1[50] = LT1[50] - 255;end
		else  begin l1[50] = LT1[50];end
		if(LT1[51] > 255)begin l1[51] = LT1[51] - 255;end
		else  begin l1[51] = LT1[51];end
		if(LT1[52] > 255)begin l1[52] = LT1[52] - 255;end
		else  begin l1[52] = LT1[52];end
		if(LT1[53] > 255)begin l1[53] = LT1[53] - 255;end
		else  begin l1[53] = LT1[53];end
		if(LT1[54] > 255)begin l1[54] = LT1[54] - 255;end
		else  begin l1[54] = LT1[54];end
		if(LT1[55] > 255)begin l1[55] = LT1[55] - 255;end
		else  begin l1[55] = LT1[55];end
		if(LT1[56] > 255)begin l1[56] = LT1[56] - 255;end
		else  begin l1[56] = LT1[56];end
		if(LT1[57] > 255)begin l1[57] = LT1[57] - 255;end
		else  begin l1[57] = LT1[57];end
		if(LT1[58] > 255)begin l1[58] = LT1[58] - 255;end
		else  begin l1[58] = LT1[58];end
		if(LT1[59] > 255)begin l1[59] = LT1[59] - 255;end
		else  begin l1[59] = LT1[59];end
		if(LT1[60] > 255)begin l1[60] = LT1[60] - 255;end
		else  begin l1[60] = LT1[60];end
		if(LT1[61] > 255)begin l1[61] = LT1[61] - 255;end
		else  begin l1[61] = LT1[61];end
		if(LT1[62] > 255)begin l1[62] = LT1[62] - 255;end
		else  begin l1[62] = LT1[62];end
		if(LT1[63] > 255)begin l1[63] = LT1[63] - 255;end
		else  begin l1[63] = LT1[63];end		
		next_state = 16;
	end
	16:begin
		/* for d0 */
		if(l1[0] == 0)begin ET1[0] = 0;end
		else begin ET1[0] = eTable[l1[0]];end
		if(l1[1] == 0)begin ET1[1] = 0;end
		else begin ET1[1] = eTable[l1[1]];end
		/* for d2 */
		if(l1[2] == 0)begin ET1[2] = 0;end
		else begin ET1[2] = eTable[l1[2]];end
		if(l1[3] == 0)begin ET1[3] = 0;end
		else begin ET1[3] = eTable[l1[3]];end
		/* for d2 */
		if(l1[4] == 0)begin ET1[4] = 0;end
		else begin ET1[4] = eTable[l1[4]];end
		if(l1[5] == 0)begin ET1[5] = 0;end
		else begin ET1[5] = eTable[l1[5]];end
		/* for d3 */
		if(l1[6] == 0)begin ET1[6] = 0;end
		else begin ET1[6] = eTable[l1[6]];end
		if(l1[7] == 0)begin ET1[7] = 0;end
		else begin ET1[7] = eTable[l1[7]];end
		/* for d4 */
		if(l1[8] == 0)begin ET1[8] = 0;end
		else begin ET1[8] = eTable[l1[8]];end
		if(l1[9] == 0)begin ET1[9] = 0;end
		else begin ET1[9] = eTable[l1[9]];end
		/* for d5 */
		if(l1[10] == 0)begin ET1[10] = 0;end
		else begin ET1[10] = eTable[l1[10]];end
		if(l1[11] == 0)begin ET1[11] = 0;end
		else begin ET1[11] = eTable[l1[11]];end
		/* for d6 */
		if(l1[12] == 0)begin ET1[12] = 0;end
		else begin ET1[12] = eTable[l1[12]];end
		if(l1[13] == 0)begin ET1[13] = 0;end
		else begin ET1[13] = eTable[l1[13]];end
		/* for d7 */
		if(l1[14] == 0)begin ET1[14] = 0;end
		else begin ET1[14] = eTable[l1[14]];end
		if(l1[15] == 0)begin ET1[15] = 0;end
		else begin ET1[15] = eTable[l1[15]];end
		/* for d8 */
		if(l1[16] == 0)begin ET1[16] = 0;end
		else begin ET1[16] = eTable[l1[16]];end
		if(l1[17] == 0)begin ET1[17] = 0;end
		else begin ET1[17] = eTable[l1[17]];end
		/* for d9 */
		if(l1[18] == 0)begin ET1[18] = 0;end
		else begin ET1[18] = eTable[l1[18]];end
		if(l1[19] == 0)begin ET1[19] = 0;end
		else begin ET1[19] = eTable[l1[19]];end
		/* for d10 */
		if(l1[20] == 0)begin ET1[20] = 0;end
		else begin ET1[20] = eTable[l1[20]];end
		if(l1[21] == 0)begin ET1[21] = 0;end
		else begin ET1[21] = eTable[l1[21]];end
		/* for d11 */
		if(l1[22] == 0)begin ET1[22] = 0;end
		else begin ET1[22] = eTable[l1[22]];end
		if(l1[23] == 0)begin ET1[23] = 0;end
		else begin ET1[23] = eTable[l1[23]];end
		/* for d12 */
		if(l1[24] == 0)begin ET1[24] = 0;end
		else begin ET1[24] = eTable[l1[24]];end
		if(l1[25] == 0)begin ET1[25] = 0;end
		else begin ET1[25] = eTable[l1[25]];end
		/* for d13 */
		if(l1[26] == 0)begin ET1[26] = 0;end
		else begin ET1[26] = eTable[l1[26]];end
		if(l1[27] == 0)begin ET1[27] = 0;end
		else begin ET1[27] = eTable[l1[27]];end
		/* for d14 */
		if(l1[28] == 0)begin ET1[28] = 0;end
		else begin ET1[28] = eTable[l1[28]];end
		if(l1[29] == 0)begin ET1[29] = 0;end
		else begin ET1[29] = eTable[l1[29]];end
		/* for d15 */
		if(l1[30] == 0)begin ET1[30] = 0;end
		else begin ET1[30] = eTable[l1[30]];end
		if(l1[31] == 0)begin ET1[31] = 0;end
		else begin ET1[31] = eTable[l1[31]];end
		if(l1[32] == 0)begin ET1[32] = 0;end
		else begin ET1[32] = eTable[l1[32]];end
		if(l1[33] == 0)begin ET1[33] = 0;end
		else begin ET1[33] = eTable[l1[33]];end
		if(l1[34] == 0)begin ET1[34] = 0;end
		else begin ET1[34] = eTable[l1[34]];end
		if(l1[35] == 0)begin ET1[35] = 0;end
		else begin ET1[35] = eTable[l1[35]];end
		if(l1[36] == 0)begin ET1[36] = 0;end
		else begin ET1[36] = eTable[l1[36]];end
		if(l1[37] == 0)begin ET1[37] = 0;end
		else begin ET1[37] = eTable[l1[37]];end
		if(l1[38] == 0)begin ET1[38] = 0;end
		else begin ET1[38] = eTable[l1[38]];end
		if(l1[39] == 0)begin ET1[39] = 0;end
		else begin ET1[39] = eTable[l1[39]];end
		if(l1[40] == 0)begin ET1[40] = 0;end
		else begin ET1[40] = eTable[l1[40]];end
		if(l1[41] == 0)begin ET1[41] = 0;end
		else begin ET1[41] = eTable[l1[41]];end
		if(l1[42] == 0)begin ET1[42] = 0;end
		else begin ET1[42] = eTable[l1[42]];end
		if(l1[43] == 0)begin ET1[43] = 0;end
		else begin ET1[43] = eTable[l1[43]];end
		if(l1[44] == 0)begin ET1[44] = 0;end
		else begin ET1[44] = eTable[l1[44]];end
		if(l1[45] == 0)begin ET1[45] = 0;end
		else begin ET1[45] = eTable[l1[45]];end
		if(l1[46] == 0)begin ET1[46] = 0;end
		else begin ET1[46] = eTable[l1[46]];end
		if(l1[47] == 0)begin ET1[47] = 0;end
		else begin ET1[47] = eTable[l1[47]];end
		if(l1[48] == 0)begin ET1[48] = 0;end
		else begin ET1[48] = eTable[l1[48]];end
		if(l1[49] == 0)begin ET1[49] = 0;end
		else begin ET1[49] = eTable[l1[49]];end
		if(l1[50] == 0)begin ET1[50] = 0;end
		else begin ET1[50] = eTable[l1[50]];end		
		if(l1[51] == 0)begin ET1[51] = 0;end
		else begin ET1[51] = eTable[l1[51]];end
		if(l1[52] == 0)begin ET1[52] = 0;end
		else begin ET1[52] = eTable[l1[52]];end
		if(l1[53] == 0)begin ET1[53] = 0;end
		else begin ET1[53] = eTable[l1[53]];end
		if(l1[54] == 0)begin ET1[54] = 0;end
		else begin ET1[54] = eTable[l1[54]];end
		if(l1[55] == 0)begin ET1[55] = 0;end
		else begin ET1[55] = eTable[l1[55]];end
		if(l1[56] == 0)begin ET1[56] = 0;end
		else begin ET1[56] = eTable[l1[56]];end
		if(l1[57] == 0)begin ET1[57] = 0;end
		else begin ET1[57] = eTable[l1[57]];end
		if(l1[58] == 0)begin ET1[58] = 0;end
		else begin ET1[58] = eTable[l1[58]];end
		if(l1[59] == 0)begin ET1[59] = 0;end
		else begin ET1[59] = eTable[l1[59]];end
		if(l1[60] == 0)begin ET1[60] = 0;end
		else begin ET1[60] = eTable[l1[60]];end	
		if(l1[61] == 0)begin ET1[61] = 0;end
		else begin ET1[61] = eTable[l1[61]];end
		if(l1[62] == 0)begin ET1[62] = 0;end
		else begin ET1[62] = eTable[l1[62]];end
		if(l1[63] == 0)begin ET1[63] = 0;end
		else begin ET1[63] = eTable[l1[63]];end
		next_state = 17;
	end
    17:begin
        d3[0] = ET1[0]^ET1[1]^ET1[2]^ET1[3];
        d3[1] = ET1[4]^ET1[5]^ET1[6]^ET1[7];
        d3[2] = ET1[8]^ET1[9]^ET1[10]^ET1[11];
        d3[3] = ET1[12]^ET1[13]^ET1[14]^ET1[15];
        d3[4] = ET1[16]^ET1[17]^ET1[18]^ET1[19];
        d3[5] = ET1[20]^ET1[21]^ET1[22]^ET1[23];
        d3[6] = ET1[24]^ET1[25]^ET1[26]^ET1[27];
        d3[7] = ET1[28]^ET1[29]^ET1[30]^ET1[31];
        d3[8] = ET1[32]^ET1[33]^ET1[34]^ET1[35];
        d3[9] = ET1[36]^ET1[37]^ET1[38]^ET1[39];
        d3[10] = ET1[40]^ET1[41]^ET1[42]^ET1[43];
        d3[11] = ET1[44]^ET1[45]^ET1[46]^ET1[47];
        d3[12] = ET1[48]^ET1[49]^ET1[50]^ET1[51];
        d3[13] = ET1[52]^ET1[53]^ET1[54]^ET1[55];
        d3[14] = ET1[56]^ET1[57]^ET1[58]^ET1[59];
        d3[15] =ET1[60]^ET1[61]^ET1[62]^ET1[63]; 
        next_state = 18;
    end
	18:begin
        tempRow2[0] = d3[0];tempRow2[4] = d3[4];tempRow2[8] = d3[8];tempRow2[12] = d3[12];
        tempRow2[1] = d3[13];tempRow2[5] = d3[1];tempRow2[9] = d3[5];tempRow2[13] = d3[9];
        tempRow2[2] = d3[10];tempRow2[6] = d3[14];tempRow2[10] = d3[2];tempRow2[14] = d3[6];
        tempRow2[3] = d3[7];tempRow2[7] = d3[11];tempRow2[11] = d3[15];tempRow2[15] = d3[3];
        next_state = 19;
	end
	19:begin
        tempSbox2[0] = inv_sbox[tempRow2[0]];tempSbox2[1] = inv_sbox[tempRow2[1]];tempSbox2[2] = inv_sbox[tempRow2[2]];tempSbox2[3] = inv_sbox[tempRow2[3]];
        tempSbox2[4] = inv_sbox[tempRow2[4]];tempSbox2[5] = inv_sbox[tempRow2[5]];tempSbox2[6] = inv_sbox[tempRow2[6]];tempSbox2[7] = inv_sbox[tempRow2[7]];
        tempSbox2[8] = inv_sbox[tempRow2[8]];tempSbox2[9] = inv_sbox[tempRow2[9]];tempSbox2[10] = inv_sbox[tempRow2[10]];tempSbox2[11] = inv_sbox[tempRow2[11]];
        tempSbox2[12] = inv_sbox[tempRow2[12]];tempSbox2[13] = inv_sbox[tempRow2[13]];tempSbox2[14] = inv_sbox[tempRow2[14]];tempSbox2[15] = inv_sbox[tempRow2[15]];
		next_state = 20;
	end
	20:begin
        d4[0] = tempSbox2[0]^k[44][31:24];
        d4[1] = tempSbox2[1]^k[44][23:16];
        d4[2] = tempSbox2[2]^k[44][15:8];
        d4[3] = tempSbox2[3]^k[44][7:0];
        d4[4] = tempSbox2[4]^k[45][31:24];
        d4[5] = tempSbox2[5]^k[45][23:16];
        d4[6] = tempSbox2[6]^k[45][15:8];
        d4[7] = tempSbox2[7]^k[45][7:0];
        d4[8] = tempSbox2[8]^k[46][31:24];
        d4[9] = tempSbox2[9]^k[46][23:16];
        d4[10] = tempSbox2[10]^k[46][15:8];
        d4[11] = tempSbox2[11]^k[46][7:0];
        d4[12] = tempSbox2[12]^k[47][31:24];
        d4[13] = tempSbox2[13]^k[47][23:16];
        d4[14] = tempSbox2[14]^k[47][15:8];
        d4[15] = tempSbox2[15]^k[47][7:0];
		next_state = 21;
	end
	21:begin 
	    /* For b0 & b4*/
		if(d4[0] == 0)begin LT2[0] = 0; LT2[4] = 0; LT2[8] = 0; LT2[12] = 0 ;end
		else begin LT2[0] = lTable[d4[0]] + lTable[8'h0e];LT2[4] = lTable[d4[0]] + lTable[8'h09];LT2[8] =  lTable[d4[0]] + lTable[8'h0d];LT2[12] = lTable[d4[0]] + lTable[8'h0b];end
	    /* For b1 & b2*/
		if(d4[1] == 0)begin LT2[1] = 0;LT2[5] = 0;LT2[9] =0; LT2[13] = 0;end
		else begin LT2[1] = lTable[d4[1]] + lTable[8'h0b];LT2[5] = lTable[d4[1]] + lTable[8'h0e];LT2[9] = lTable[d4[1]] + lTable[8'h09]; LT2[13] = lTable[d4[1]] + lTable[8'h0d];end
	    /* For b3 & b4*/
		if(d4[2] == 0)begin LT2[2] = 0;LT2[6] = 0;LT2[10] = 0;LT2[14] = 0;end
		else begin LT2[2] = lTable[d4[2]] + lTable[8'h0d];LT2[6] = lTable[d4[2]] + lTable[8'h0b];LT2[10] = lTable[d4[2]] + lTable[8'h0e];LT2[14] = lTable[d4[2]] + lTable[8'h09];end
	    /* For b5 & b7*/			
		if(d4[3] == 0)begin LT2[3] = 0;LT2[7] = 0;LT2[11] = 0;LT2[15] = 0;end 
		else begin  LT2[3] = lTable[d4[3]] + lTable[8'h09];LT2[7] = lTable[d4[3]] + lTable[8'h0d];LT2[11] = lTable[d4[3]] + lTable[8'h0b];LT2[15] = lTable[d4[3]] + lTable[8'h0e];end
	    /* For b8 & b14 */				
		if(d4[4] == 0)begin LT2[16] = 0; LT2[20] = 0; LT2[24] = 0; LT2[28] = 0;end
		else begin LT2[16] = lTable[d4[4]] + lTable[8'h0e]; LT2[20] = lTable[d4[4]] + lTable[8'h09]; LT2[24] = lTable[d4[4]] + lTable[8'h0d]; LT2[28] = lTable[d4[4]] + lTable[8'h0b];end
		/* For b9 & b10 */
		if(d4[5] == 0)begin LT2[17] = 0;LT2[21] = 0; LT2[25] = 0;LT2[29] = 0;end
		else begin LT2[17] = lTable[d4[5]] + lTable[8'h0b];LT2[21] = lTable[d4[5]] + lTable[8'h0e]; LT2[25] = lTable[d4[5]] + lTable[8'h09];LT2[29] = lTable[d4[5]] + lTable[8'h0d];end
		/* For b11 & b12*/
		if(d4[6] == 0)begin LT2[18] = 0;LT2[22] = 0; LT2[26] = 0;LT2[30] = 0;end
		else begin LT2[18] = lTable[d4[6]] + lTable[8'h0d];LT2[22] = lTable[d4[6]] + lTable[8'h0b]; LT2[26] = lTable[d4[6]] + lTable[8'h0e];LT2[30] = lTable[d4[6]] + lTable[8'h09];end
		/* For b13 & b15 */
		if(d4[7] == 0)begin LT2[19] = 0;LT2[23] = 0; LT2[27] = 0;LT2[31] = 0;end
		else begin LT2[19] = lTable[d4[7]] + lTable[8'h09];LT2[23] = lTable[d4[7]] + lTable[8'h0d]; LT2[27] = lTable[d4[7]] + lTable[8'h0b];LT2[31] = lTable[d4[7]] + lTable[8'h0e];end
		/* For b16 & b22 */
		if(d4[8] == 0)begin LT2[32] = 0;LT2[36] = 0; LT2[40] = 0;LT2[44] = 0;end
		else begin LT2[32] = lTable[d4[8]] + lTable[8'h0e];LT2[36] = lTable[d4[8]] + lTable[8'h09];LT2[40] = lTable[d4[8]] + lTable[8'h0d];LT2[44] = lTable[d4[8]] + lTable[8'h0b];end
		/* For b17 & 18 */
		if(d4[9] == 0)begin LT2[33] = 0;LT2[37] = 0; LT2[41] = 0;LT2[45] = 0;end
		else begin LT2[33] = lTable[d4[9]] + lTable[8'h0b];LT2[37] = lTable[d4[9]] + lTable[8'h0e]; LT2[41] = lTable[d4[9]] + lTable[8'h09];LT2[45] = lTable[d4[9]] + lTable[8'h0d];end
		/* For b19 & b20 */
		if(d4[10] == 0)begin LT2[34] = 0;LT2[38] = 0;LT2[42] = 0;LT2[46] = 0;end
		else begin LT2[34] = lTable[d4[10]] + lTable[8'h0d];LT2[38] = lTable[d4[10]] + lTable[8'h0b];LT2[42] = lTable[d4[10]] + lTable[8'h0e];LT2[46] = lTable[d4[10]] + lTable[8'h09];end
		/* For b21 & b23 */
		if(d4[11] == 0)begin LT2[35] = 0; LT2[39] =0;LT2[43] = 0; LT2[47] =0;end
		else begin  LT2[35] = lTable[d4[11]] + lTable[8'h09]; LT2[39] =lTable[d4[11]] + lTable[8'h0d];LT2[43] = lTable[d4[11]] + lTable[8'h0b]; LT2[47] =lTable[d4[11]] + lTable[8'h0e];end	
		/* For b24 & b30 */
		if(d4[12] == 0)begin LT2[48] = 0;LT2[52] = 0; LT2[56] = 0;LT2[60] = 0;end 
		else begin LT2[48] = lTable[d4[12]] + lTable[8'h0e];LT2[52] = lTable[d4[12]] + lTable[8'h09]; LT2[56] = lTable[d4[12]] + lTable[8'h0d];LT2[60] = lTable[d4[12]] + lTable[8'h0b];end 		
		/* For b25 & b26 */		
		if(d4[13] == 0)begin LT2[49] = 0;LT2[53] = 0; LT2[57] = 0;LT2[61] = 0;end 
		else begin  LT2[49] = lTable[d4[13]] + lTable[8'h0b];LT2[53] = lTable[d4[13]] + lTable[8'h0e]; LT2[57] = lTable[d4[13]] + lTable[8'h09];LT2[61] = lTable[d4[13]] + lTable[8'h0d];end 
		/* For b27 & b28 */
		if(d4[14] == 0)begin LT2[50] = 0;LT2[54] = 0; LT2[58] = 0;LT2[62] = 0;end 
		else begin LT2[50] = lTable[d4[14]] + lTable[8'h0d];LT2[54] = lTable[d4[14]] + lTable[8'h0b]; LT2[58] = lTable[d4[14]] + lTable[8'h0e];LT2[62] = lTable[d4[14]] + lTable[8'h09];end 
		/* For b29 & b31 */
		if(d4[15] == 0)begin LT2[51] = 0;LT2[55] = 0; LT2[59] = 0;LT2[63] = 0;end 
		else begin LT2[51] = lTable[d4[15]] + lTable[8'h09];LT2[55] = lTable[d4[15]] + lTable[8'h0d]; LT2[59] = lTable[d4[15]] + lTable[8'h0b];LT2[63] = lTable[d4[15]] + lTable[8'h0e];end 

        next_state = 22;
    end
    22:begin
		if(LT2[0] > 255)begin l2[0] = LT2[0] - 255;end
		else begin l2[0] = LT2[0];end
		if(LT2[1] > 255)begin l2[1] = LT2[1] - 255;end
		else  begin l2[1] = LT2[1];end
		if(LT2[2] > 255)begin l2[2] = LT2[2] - 255;end
		else  begin l2[2] = LT2[2];end
		if(LT2[3] > 255)begin l2[3] = LT2[3] - 255;end
		else  begin l2[3] = LT2[3];end
		if(LT2[4] > 255)begin l2[4] = LT2[4] - 255;end
		else  begin l2[4] = LT2[4];end
		if(LT2[5] > 255)begin l2[5] = LT2[5] - 255;end
		else  begin l2[5] = LT2[5];end
		if(LT2[6] > 255)begin l2[6] = LT2[6] - 255;end
		else  begin l2[6] = LT2[6];end
		if(LT2[7] > 255)begin l2[7] = LT2[7] - 255;end
		else  begin l2[7] = LT2[7];end
		if(LT2[8] > 255)begin l2[8] = LT2[8] - 255;end
		else  begin l2[8] = LT2[8];end
		if(LT2[9] > 255)begin l2[9] = LT2[9] - 255;end
		else  begin l2[9] = LT2[9];end
		if(LT2[10] > 255)begin l2[10] = LT2[10] - 255;end
		else  begin l2[10] = LT2[10];end
		if(LT2[11] > 255)begin l2[11] = LT2[11] - 255;end
		else  begin l2[11] = LT2[11];end
		if(LT2[12] > 255)begin l2[12] = LT2[12] - 255;end
		else  begin l2[12] = LT2[12];end
		if(LT2[13] > 255)begin l2[13] = LT2[13] - 255;end
		else  begin l2[13] = LT2[13];end
		if(LT2[14] > 255)begin l2[14] = LT2[14] - 255;end
		else  begin l2[14] = LT2[14];end
		if(LT2[15] > 255)begin l2[15] = LT2[15] - 255;end
		else  begin l2[15] = LT2[15];end
		if(LT2[16] > 255)begin l2[16] = LT2[16] - 255;end
		else  begin l2[16] = LT2[16];end
		if(LT2[17] > 255)begin l2[17] = LT2[17] - 255;end
		else  begin l2[17] = LT2[17];end
		if(LT2[18] > 255)begin l2[18] = LT2[18] - 255;end
		else  begin l2[18] = LT2[18];end
		if(LT2[19] > 255)begin l2[19] = LT2[19] - 255;end
		else  begin l2[19] = LT2[19];end
		if(LT2[20] > 255)begin l2[20] = LT2[20] - 255;end
		else  begin l2[20] = LT2[20];end
		if(LT2[21] > 255)begin l2[21] = LT2[21] - 255;end
		else  begin l2[21] = LT2[21];end
		if(LT2[22] > 255)begin l2[22] = LT2[22] - 255;end
		else  begin l2[22] = LT2[22];end
		if(LT2[23] > 255)begin l2[23] = LT2[23] - 255;end
		else  begin l2[23] = LT2[23];end
		if(LT2[24] > 255)begin l2[24] = LT2[24] - 255;end
		else  begin l2[24] = LT2[24];end
		if(LT2[25] > 255)begin l2[25] = LT2[25] - 255;end
		else  begin l2[25] = LT2[25];end
		if(LT2[26] > 255)begin l2[26] = LT2[26] - 255;end
		else  begin l2[26] = LT2[26];end
		if(LT2[27] > 255)begin l2[27] = LT2[27] - 255;end
		else  begin l2[27] = LT2[27];end
		if(LT2[28] > 255)begin l2[28] = LT2[28] - 255;end
		else  begin l2[28] = LT2[28];end
		if(LT2[29] > 255)begin l2[29] = LT2[29] - 255;end
		else  begin l2[29] = LT2[29];end
		if(LT2[30] > 255)begin l2[30] = LT2[30] - 255;end
		else  begin l2[30] = LT2[30];end
		if(LT2[31] > 255)begin l2[31] = LT2[31] - 255;end
		else  begin l2[31] = LT2[31];end
		if(LT2[32] > 255)begin l2[32] = LT2[32] - 255;end
		else  begin l2[32] = LT2[32];end
		if(LT2[33] > 255)begin l2[33] = LT2[33] - 255;end
		else  begin l2[33] = LT2[33];end
		if(LT2[34] > 255)begin l2[34] = LT2[34] - 255;end
		else  begin l2[34] = LT2[34];end
		if(LT2[35] > 255)begin l2[35] = LT2[35] - 255;end
		else  begin l2[35] = LT2[35];end
		if(LT2[36] > 255)begin l2[36] = LT2[36] - 255;end
		else  begin l2[36] = LT2[36];end
		if(LT2[37] > 255)begin l2[37] = LT2[37] - 255;end
		else  begin l2[37] = LT2[37];end
		if(LT2[38] > 255)begin l2[38] = LT2[38] - 255;end
		else  begin l2[38] = LT2[38];end
		if(LT2[39] > 255)begin l2[39] = LT2[39] - 255;end
		else  begin l2[39] = LT2[39];end
		if(LT2[40] > 255)begin l2[40] = LT2[40] - 255;end
		else  begin l2[40] = LT2[40];end
		if(LT2[41] > 255)begin l2[41] = LT2[41] - 255;end
		else  begin l2[41] = LT2[41];end
		if(LT2[42] > 255)begin l2[42] = LT2[42] - 255;end
		else  begin l2[42] = LT2[42];end
		if(LT2[43] > 255)begin l2[43] = LT2[43] - 255;end
		else  begin l2[43] = LT2[43];end
		if(LT2[44] > 255)begin l2[44] = LT2[44] - 255;end
		else  begin l2[44] = LT2[44];end
		if(LT2[45] > 255)begin l2[45] = LT2[45] - 255;end
		else  begin l2[45] = LT2[45];end
		if(LT2[46] > 255)begin l2[46] = LT2[46] - 255;end
		else  begin l2[46] = LT2[46];end
		if(LT2[47] > 255)begin l2[47] = LT2[47] - 255;end
		else  begin l2[47] = LT2[47];end
		if(LT2[48] > 255)begin l2[48] = LT2[48] - 255;end
		else  begin l2[48] = LT2[48];end
		if(LT2[49] > 255)begin l2[49] = LT2[49] - 255;end
		else  begin l2[49] = LT2[49];end
		if(LT2[50] > 255)begin l2[50] = LT2[50] - 255;end
		else  begin l2[50] = LT2[50];end
		if(LT2[51] > 255)begin l2[51] = LT2[51] - 255;end
		else  begin l2[51] = LT2[51];end
		if(LT2[52] > 255)begin l2[52] = LT2[52] - 255;end
		else  begin l2[52] = LT2[52];end
		if(LT2[53] > 255)begin l2[53] = LT2[53] - 255;end
		else  begin l2[53] = LT2[53];end
		if(LT2[54] > 255)begin l2[54] = LT2[54] - 255;end
		else  begin l2[54] = LT2[54];end
		if(LT2[55] > 255)begin l2[55] = LT2[55] - 255;end
		else  begin l2[55] = LT2[55];end
		if(LT2[56] > 255)begin l2[56] = LT2[56] - 255;end
		else  begin l2[56] = LT2[56];end
		if(LT2[57] > 255)begin l2[57] = LT2[57] - 255;end
		else  begin l2[57] = LT2[57];end
		if(LT2[58] > 255)begin l2[58] = LT2[58] - 255;end
		else  begin l2[58] = LT2[58];end
		if(LT2[59] > 255)begin l2[59] = LT2[59] - 255;end
		else  begin l2[59] = LT2[59];end
		if(LT2[60] > 255)begin l2[60] = LT2[60] - 255;end
		else  begin l2[60] = LT2[60];end
		if(LT2[61] > 255)begin l2[61] = LT2[61] - 255;end
		else  begin l2[61] = LT2[61];end
		if(LT2[62] > 255)begin l2[62] = LT2[62] - 255;end
		else  begin l2[62] = LT2[62];end
		if(LT2[63] > 255)begin l2[63] = LT2[63] - 255;end
		else  begin l2[63] = LT2[63];end		
		next_state = 23;
	end
	23:begin
		/* for d0 */
		if(l2[0] == 0)begin ET2[0] = 0;end
		else begin ET2[0] = eTable[l2[0]];end
		if(l2[1] == 0)begin ET2[1] = 0;end
		else begin ET2[1] = eTable[l2[1]];end
		/* for d4 */
		if(l2[2] == 0)begin ET2[2] = 0;end
		else begin ET2[2] = eTable[l2[2]];end
		if(l2[3] == 0)begin ET2[3] = 0;end
		else begin ET2[3] = eTable[l2[3]];end
		/* for d4 */
		if(l2[4] == 0)begin ET2[4] = 0;end
		else begin ET2[4] = eTable[l2[4]];end
		if(l2[5] == 0)begin ET2[5] = 0;end
		else begin ET2[5] = eTable[l2[5]];end
		/* for d3 */
		if(l2[6] == 0)begin ET2[6] = 0;end
		else begin ET2[6] = eTable[l2[6]];end
		if(l2[7] == 0)begin ET2[7] = 0;end
		else begin ET2[7] = eTable[l2[7]];end
		/* for d4 */
		if(l2[8] == 0)begin ET2[8] = 0;end
		else begin ET2[8] = eTable[l2[8]];end
		if(l2[9] == 0)begin ET2[9] = 0;end
		else begin ET2[9] = eTable[l2[9]];end
		/* for d5 */
		if(l2[10] == 0)begin ET2[10] = 0;end
		else begin ET2[10] = eTable[l2[10]];end
		if(l2[11] == 0)begin ET2[11] = 0;end
		else begin ET2[11] = eTable[l2[11]];end
		/* for d6 */
		if(l2[12] == 0)begin ET2[12] = 0;end
		else begin ET2[12] = eTable[l2[12]];end
		if(l2[13] == 0)begin ET2[13] = 0;end
		else begin ET2[13] = eTable[l2[13]];end
		/* for d7 */
		if(l2[14] == 0)begin ET2[14] = 0;end
		else begin ET2[14] = eTable[l2[14]];end
		if(l2[15] == 0)begin ET2[15] = 0;end
		else begin ET2[15] = eTable[l2[15]];end
		/* for d8 */
		if(l2[16] == 0)begin ET2[16] = 0;end
		else begin ET2[16] = eTable[l2[16]];end
		if(l2[17] == 0)begin ET2[17] = 0;end
		else begin ET2[17] = eTable[l2[17]];end
		/* for d9 */
		if(l2[18] == 0)begin ET2[18] = 0;end
		else begin ET2[18] = eTable[l2[18]];end
		if(l2[19] == 0)begin ET2[19] = 0;end
		else begin ET2[19] = eTable[l2[19]];end
		/* for d10 */
		if(l2[20] == 0)begin ET2[20] = 0;end
		else begin ET2[20] = eTable[l2[20]];end
		if(l2[21] == 0)begin ET2[21] = 0;end
		else begin ET2[21] = eTable[l2[21]];end
		/* for d11 */
		if(l2[22] == 0)begin ET2[22] = 0;end
		else begin ET2[22] = eTable[l2[22]];end
		if(l2[23] == 0)begin ET2[23] = 0;end
		else begin ET2[23] = eTable[l2[23]];end
		/* for d12 */
		if(l2[24] == 0)begin ET2[24] = 0;end
		else begin ET2[24] = eTable[l2[24]];end
		if(l2[25] == 0)begin ET2[25] = 0;end
		else begin ET2[25] = eTable[l2[25]];end
		/* for d13 */
		if(l2[26] == 0)begin ET2[26] = 0;end
		else begin ET2[26] = eTable[l2[26]];end
		if(l2[27] == 0)begin ET2[27] = 0;end
		else begin ET2[27] = eTable[l2[27]];end
		/* for d14 */
		if(l2[28] == 0)begin ET2[28] = 0;end
		else begin ET2[28] = eTable[l2[28]];end
		if(l2[29] == 0)begin ET2[29] = 0;end
		else begin ET2[29] = eTable[l2[29]];end
		/* for d15 */
		if(l2[30] == 0)begin ET2[30] = 0;end
		else begin ET2[30] = eTable[l2[30]];end
		if(l2[31] == 0)begin ET2[31] = 0;end
		else begin ET2[31] = eTable[l2[31]];end
		if(l2[32] == 0)begin ET2[32] = 0;end
		else begin ET2[32] = eTable[l2[32]];end
		if(l2[33] == 0)begin ET2[33] = 0;end
		else begin ET2[33] = eTable[l2[33]];end
		if(l2[34] == 0)begin ET2[34] = 0;end
		else begin ET2[34] = eTable[l2[34]];end
		if(l2[35] == 0)begin ET2[35] = 0;end
		else begin ET2[35] = eTable[l2[35]];end
		if(l2[36] == 0)begin ET2[36] = 0;end
		else begin ET2[36] = eTable[l2[36]];end
		if(l2[37] == 0)begin ET2[37] = 0;end
		else begin ET2[37] = eTable[l2[37]];end
		if(l2[38] == 0)begin ET2[38] = 0;end
		else begin ET2[38] = eTable[l2[38]];end
		if(l2[39] == 0)begin ET2[39] = 0;end
		else begin ET2[39] = eTable[l2[39]];end
		if(l2[40] == 0)begin ET2[40] = 0;end
		else begin ET2[40] = eTable[l2[40]];end
		if(l2[41] == 0)begin ET2[41] = 0;end
		else begin ET2[41] = eTable[l2[41]];end
		if(l2[42] == 0)begin ET2[42] = 0;end
		else begin ET2[42] = eTable[l2[42]];end
		if(l2[43] == 0)begin ET2[43] = 0;end
		else begin ET2[43] = eTable[l2[43]];end
		if(l2[44] == 0)begin ET2[44] = 0;end
		else begin ET2[44] = eTable[l2[44]];end
		if(l2[45] == 0)begin ET2[45] = 0;end
		else begin ET2[45] = eTable[l2[45]];end
		if(l2[46] == 0)begin ET2[46] = 0;end
		else begin ET2[46] = eTable[l2[46]];end
		if(l2[47] == 0)begin ET2[47] = 0;end
		else begin ET2[47] = eTable[l2[47]];end
		if(l2[48] == 0)begin ET2[48] = 0;end
		else begin ET2[48] = eTable[l2[48]];end
		if(l2[49] == 0)begin ET2[49] = 0;end
		else begin ET2[49] = eTable[l2[49]];end
		if(l2[50] == 0)begin ET2[50] = 0;end
		else begin ET2[50] = eTable[l2[50]];end		
		if(l2[51] == 0)begin ET2[51] = 0;end
		else begin ET2[51] = eTable[l2[51]];end
		if(l2[52] == 0)begin ET2[52] = 0;end
		else begin ET2[52] = eTable[l2[52]];end
		if(l2[53] == 0)begin ET2[53] = 0;end
		else begin ET2[53] = eTable[l2[53]];end
		if(l2[54] == 0)begin ET2[54] = 0;end
		else begin ET2[54] = eTable[l2[54]];end
		if(l2[55] == 0)begin ET2[55] = 0;end
		else begin ET2[55] = eTable[l2[55]];end
		if(l2[56] == 0)begin ET2[56] = 0;end
		else begin ET2[56] = eTable[l2[56]];end
		if(l2[57] == 0)begin ET2[57] = 0;end
		else begin ET2[57] = eTable[l2[57]];end
		if(l2[58] == 0)begin ET2[58] = 0;end
		else begin ET2[58] = eTable[l2[58]];end
		if(l2[59] == 0)begin ET2[59] = 0;end
		else begin ET2[59] = eTable[l2[59]];end
		if(l2[60] == 0)begin ET2[60] = 0;end
		else begin ET2[60] = eTable[l2[60]];end	
		if(l2[61] == 0)begin ET2[61] = 0;end
		else begin ET2[61] = eTable[l2[61]];end
		if(l2[62] == 0)begin ET2[62] = 0;end
		else begin ET2[62] = eTable[l2[62]];end
		if(l2[63] == 0)begin ET2[63] = 0;end
		else begin ET2[63] = eTable[l2[63]];end
		next_state = 24;
	end
    24:begin
        d5[0] = ET2[0]^ET2[1]^ET2[2]^ET2[3];
        d5[1] = ET2[4]^ET2[5]^ET2[6]^ET2[7];
        d5[2] = ET2[8]^ET2[9]^ET2[10]^ET2[11];
        d5[3] = ET2[12]^ET2[13]^ET2[14]^ET2[15];
        d5[4] = ET2[16]^ET2[17]^ET2[18]^ET2[19];
        d5[5] = ET2[20]^ET2[21]^ET2[22]^ET2[23];
        d5[6] = ET2[24]^ET2[25]^ET2[26]^ET2[27];
        d5[7] = ET2[28]^ET2[29]^ET2[30]^ET2[31];
        d5[8] = ET2[32]^ET2[33]^ET2[34]^ET2[35];
        d5[9] = ET2[36]^ET2[37]^ET2[38]^ET2[39];
        d5[10] = ET2[40]^ET2[41]^ET2[42]^ET2[43];
        d5[11] = ET2[44]^ET2[45]^ET2[46]^ET2[47];
        d5[12] = ET2[48]^ET2[49]^ET2[50]^ET2[51];
        d5[13] = ET2[52]^ET2[53]^ET2[54]^ET2[55];
        d5[14] = ET2[56]^ET2[57]^ET2[58]^ET2[59];
        d5[15] =ET2[60]^ET2[61]^ET2[62]^ET2[63]; 
        next_state = 25;
    end
	25:begin
        tempRow3[0] = d5[0];tempRow3[4] = d5[4];tempRow3[8] = d5[8];tempRow3[12] = d5[12];
        tempRow3[1] = d5[13];tempRow3[5] = d5[1];tempRow3[9] = d5[5];tempRow3[13] = d5[9];
        tempRow3[2] = d5[10];tempRow3[6] = d5[14];tempRow3[10] = d5[2];tempRow3[14] = d5[6];
        tempRow3[3] = d5[7];tempRow3[7] = d5[11];tempRow3[11] = d5[15];tempRow3[15] = d5[3];
        next_state = 26;
	end
	26:begin
        tempSbox3[0] = inv_sbox[tempRow3[0]];tempSbox3[1] = inv_sbox[tempRow3[1]];tempSbox3[2] = inv_sbox[tempRow3[2]];tempSbox3[3] = inv_sbox[tempRow3[3]];
        tempSbox3[4] = inv_sbox[tempRow3[4]];tempSbox3[5] = inv_sbox[tempRow3[5]];tempSbox3[6] = inv_sbox[tempRow3[6]];tempSbox3[7] = inv_sbox[tempRow3[7]];
        tempSbox3[8] = inv_sbox[tempRow3[8]];tempSbox3[9] = inv_sbox[tempRow3[9]];tempSbox3[10] = inv_sbox[tempRow3[10]];tempSbox3[11] = inv_sbox[tempRow3[11]];
        tempSbox3[12] = inv_sbox[tempRow3[12]];tempSbox3[13] = inv_sbox[tempRow3[13]];tempSbox3[14] = inv_sbox[tempRow3[14]];tempSbox3[15] = inv_sbox[tempRow3[15]];
		next_state = 27;
	end
	27:begin
        d6[0] = tempSbox3[0]^k[40][31:24];
        d6[1] = tempSbox3[1]^k[40][23:16];
        d6[2] = tempSbox3[2]^k[40][15:8];
        d6[3] = tempSbox3[3]^k[40][7:0];
        d6[4] = tempSbox3[4]^k[41][31:24];
        d6[5] = tempSbox3[5]^k[41][23:16];
        d6[6] = tempSbox3[6]^k[41][15:8];
        d6[7] = tempSbox3[7]^k[41][7:0];
        d6[8] = tempSbox3[8]^k[42][31:24];
        d6[9] = tempSbox3[9]^k[42][23:16];
        d6[10] = tempSbox3[10]^k[42][15:8];
        d6[11] = tempSbox3[11]^k[42][7:0];
        d6[12] = tempSbox3[12]^k[43][31:24];
        d6[13] = tempSbox3[13]^k[43][23:16];
        d6[14] = tempSbox3[14]^k[43][15:8];
        d6[15] = tempSbox3[15]^k[43][7:0];
		next_state = 28;
	end
	28:begin 
	    /* For b0 & b4*/
		if(d6[0] == 0)begin LT3[0] = 0; LT3[4] = 0; LT3[8] = 0; LT3[12] = 0 ;end
		else begin LT3[0] = lTable[d6[0]] + lTable[8'h0e];LT3[4] = lTable[d6[0]] + lTable[8'h09];LT3[8] =  lTable[d6[0]] + lTable[8'h0d];LT3[12] = lTable[d6[0]] + lTable[8'h0b];end
	    /* For b1 & b2*/
		if(d6[1] == 0)begin LT3[1] = 0;LT3[5] = 0;LT3[9] =0; LT3[13] = 0;end
		else begin LT3[1] = lTable[d6[1]] + lTable[8'h0b];LT3[5] = lTable[d6[1]] + lTable[8'h0e];LT3[9] = lTable[d6[1]] + lTable[8'h09]; LT3[13] = lTable[d6[1]] + lTable[8'h0d];end
	    /* For b3 & b4*/
		if(d6[2] == 0)begin LT3[2] = 0;LT3[6] = 0;LT3[10] = 0;LT3[14] = 0;end
		else begin LT3[2] = lTable[d6[2]] + lTable[8'h0d];LT3[6] = lTable[d6[2]] + lTable[8'h0b];LT3[10] = lTable[d6[2]] + lTable[8'h0e];LT3[14] = lTable[d6[2]] + lTable[8'h09];end
	    /* For b5 & b7*/			
		if(d6[3] == 0)begin LT3[3] = 0;LT3[7] = 0;LT3[11] = 0;LT3[15] = 0;end 
		else begin  LT3[3] = lTable[d6[3]] + lTable[8'h09];LT3[7] = lTable[d6[3]] + lTable[8'h0d];LT3[11] = lTable[d6[3]] + lTable[8'h0b];LT3[15] = lTable[d6[3]] + lTable[8'h0e];end
	    /* For b8 & b14 */				
		if(d6[4] == 0)begin LT3[16] = 0; LT3[20] = 0; LT3[24] = 0; LT3[28] = 0;end
		else begin LT3[16] = lTable[d6[4]] + lTable[8'h0e]; LT3[20] = lTable[d6[4]] + lTable[8'h09]; LT3[24] = lTable[d6[4]] + lTable[8'h0d]; LT3[28] = lTable[d6[4]] + lTable[8'h0b];end
		/* For b9 & b10 */
		if(d6[5] == 0)begin LT3[17] = 0;LT3[21] = 0; LT3[25] = 0;LT3[29] = 0;end
		else begin LT3[17] = lTable[d6[5]] + lTable[8'h0b];LT3[21] = lTable[d6[5]] + lTable[8'h0e]; LT3[25] = lTable[d6[5]] + lTable[8'h09];LT3[29] = lTable[d6[5]] + lTable[8'h0d];end
		/* For b11 & b12*/
		if(d6[6] == 0)begin LT3[18] = 0;LT3[22] = 0; LT3[26] = 0;LT3[30] = 0;end
		else begin LT3[18] = lTable[d6[6]] + lTable[8'h0d];LT3[22] = lTable[d6[6]] + lTable[8'h0b]; LT3[26] = lTable[d6[6]] + lTable[8'h0e];LT3[30] = lTable[d6[6]] + lTable[8'h09];end
		/* For b13 & b15 */
		if(d6[7] == 0)begin LT3[19] = 0;LT3[23] = 0; LT3[27] = 0;LT3[31] = 0;end
		else begin LT3[19] = lTable[d6[7]] + lTable[8'h09];LT3[23] = lTable[d6[7]] + lTable[8'h0d]; LT3[27] = lTable[d6[7]] + lTable[8'h0b];LT3[31] = lTable[d6[7]] + lTable[8'h0e];end
		/* For b16 & b22 */
		if(d6[8] == 0)begin LT3[32] = 0;LT3[36] = 0; LT3[40] = 0;LT3[44] = 0;end
		else begin LT3[32] = lTable[d6[8]] + lTable[8'h0e];LT3[36] = lTable[d6[8]] + lTable[8'h09];LT3[40] = lTable[d6[8]] + lTable[8'h0d];LT3[44] = lTable[d6[8]] + lTable[8'h0b];end
		/* For b17 & 18 */
		if(d6[9] == 0)begin LT3[33] = 0;LT3[37] = 0; LT3[41] = 0;LT3[45] = 0;end
		else begin LT3[33] = lTable[d6[9]] + lTable[8'h0b];LT3[37] = lTable[d6[9]] + lTable[8'h0e]; LT3[41] = lTable[d6[9]] + lTable[8'h09];LT3[45] = lTable[d6[9]] + lTable[8'h0d];end
		/* For b19 & b20 */
		if(d6[10] == 0)begin LT3[34] = 0;LT3[38] = 0;LT3[42] = 0;LT3[46] = 0;end
		else begin LT3[34] = lTable[d6[10]] + lTable[8'h0d];LT3[38] = lTable[d6[10]] + lTable[8'h0b];LT3[42] = lTable[d6[10]] + lTable[8'h0e];LT3[46] = lTable[d6[10]] + lTable[8'h09];end
		/* For b21 & b23 */
		if(d6[11] == 0)begin LT3[35] = 0; LT3[39] =0;LT3[43] = 0; LT3[47] =0;end
		else begin  LT3[35] = lTable[d6[11]] + lTable[8'h09]; LT3[39] =lTable[d6[11]] + lTable[8'h0d];LT3[43] = lTable[d6[11]] + lTable[8'h0b]; LT3[47] =lTable[d6[11]] + lTable[8'h0e];end	
		/* For b24 & b30 */
		if(d6[12] == 0)begin LT3[48] = 0;LT3[52] = 0; LT3[56] = 0;LT3[60] = 0;end 
		else begin LT3[48] = lTable[d6[12]] + lTable[8'h0e];LT3[52] = lTable[d6[12]] + lTable[8'h09]; LT3[56] = lTable[d6[12]] + lTable[8'h0d];LT3[60] = lTable[d6[12]] + lTable[8'h0b];end 		
		/* For b25 & b26 */		
		if(d6[13] == 0)begin LT3[49] = 0;LT3[53] = 0; LT3[57] = 0;LT3[61] = 0;end 
		else begin  LT3[49] = lTable[d6[13]] + lTable[8'h0b];LT3[53] = lTable[d6[13]] + lTable[8'h0e]; LT3[57] = lTable[d6[13]] + lTable[8'h09];LT3[61] = lTable[d6[13]] + lTable[8'h0d];end 
		/* For b27 & b28 */
		if(d6[14] == 0)begin LT3[50] = 0;LT3[54] = 0; LT3[58] = 0;LT3[62] = 0;end 
		else begin LT3[50] = lTable[d6[14]] + lTable[8'h0d];LT3[54] = lTable[d6[14]] + lTable[8'h0b]; LT3[58] = lTable[d6[14]] + lTable[8'h0e];LT3[62] = lTable[d6[14]] + lTable[8'h09];end 
		/* For b29 & b31 */
		if(d6[15] == 0)begin LT3[51] = 0;LT3[55] = 0; LT3[59] = 0;LT3[63] = 0;end 
		else begin LT3[51] = lTable[d6[15]] + lTable[8'h09];LT3[55] = lTable[d6[15]] + lTable[8'h0d]; LT3[59] = lTable[d6[15]] + lTable[8'h0b];LT3[63] = lTable[d6[15]] + lTable[8'h0e];end 

        next_state = 29;
    end
    29:begin
		if(LT3[0] > 255)begin l3[0] = LT3[0] - 255;end
		else begin l3[0] = LT3[0];end
		if(LT3[1] > 255)begin l3[1] = LT3[1] - 255;end
		else  begin l3[1] = LT3[1];end
		if(LT3[2] > 255)begin l3[2] = LT3[2] - 255;end
		else  begin l3[2] = LT3[2];end
		if(LT3[3] > 255)begin l3[3] = LT3[3] - 255;end
		else  begin l3[3] = LT3[3];end
		if(LT3[4] > 255)begin l3[4] = LT3[4] - 255;end
		else  begin l3[4] = LT3[4];end
		if(LT3[5] > 255)begin l3[5] = LT3[5] - 255;end
		else  begin l3[5] = LT3[5];end
		if(LT3[6] > 255)begin l3[6] = LT3[6] - 255;end
		else  begin l3[6] = LT3[6];end
		if(LT3[7] > 255)begin l3[7] = LT3[7] - 255;end
		else  begin l3[7] = LT3[7];end
		if(LT3[8] > 255)begin l3[8] = LT3[8] - 255;end
		else  begin l3[8] = LT3[8];end
		if(LT3[9] > 255)begin l3[9] = LT3[9] - 255;end
		else  begin l3[9] = LT3[9];end
		if(LT3[10] > 255)begin l3[10] = LT3[10] - 255;end
		else  begin l3[10] = LT3[10];end
		if(LT3[11] > 255)begin l3[11] = LT3[11] - 255;end
		else  begin l3[11] = LT3[11];end
		if(LT3[12] > 255)begin l3[12] = LT3[12] - 255;end
		else  begin l3[12] = LT3[12];end
		if(LT3[13] > 255)begin l3[13] = LT3[13] - 255;end
		else  begin l3[13] = LT3[13];end
		if(LT3[14] > 255)begin l3[14] = LT3[14] - 255;end
		else  begin l3[14] = LT3[14];end
		if(LT3[15] > 255)begin l3[15] = LT3[15] - 255;end
		else  begin l3[15] = LT3[15];end
		if(LT3[16] > 255)begin l3[16] = LT3[16] - 255;end
		else  begin l3[16] = LT3[16];end
		if(LT3[17] > 255)begin l3[17] = LT3[17] - 255;end
		else  begin l3[17] = LT3[17];end
		if(LT3[18] > 255)begin l3[18] = LT3[18] - 255;end
		else  begin l3[18] = LT3[18];end
		if(LT3[19] > 255)begin l3[19] = LT3[19] - 255;end
		else  begin l3[19] = LT3[19];end
		if(LT3[20] > 255)begin l3[20] = LT3[20] - 255;end
		else  begin l3[20] = LT3[20];end
		if(LT3[21] > 255)begin l3[21] = LT3[21] - 255;end
		else  begin l3[21] = LT3[21];end
		if(LT3[22] > 255)begin l3[22] = LT3[22] - 255;end
		else  begin l3[22] = LT3[22];end
		if(LT3[23] > 255)begin l3[23] = LT3[23] - 255;end
		else  begin l3[23] = LT3[23];end
		if(LT3[24] > 255)begin l3[24] = LT3[24] - 255;end
		else  begin l3[24] = LT3[24];end
		if(LT3[25] > 255)begin l3[25] = LT3[25] - 255;end
		else  begin l3[25] = LT3[25];end
		if(LT3[26] > 255)begin l3[26] = LT3[26] - 255;end
		else  begin l3[26] = LT3[26];end
		if(LT3[27] > 255)begin l3[27] = LT3[27] - 255;end
		else  begin l3[27] = LT3[27];end
		if(LT3[28] > 255)begin l3[28] = LT3[28] - 255;end
		else  begin l3[28] = LT3[28];end
		if(LT3[29] > 255)begin l3[29] = LT3[29] - 255;end
		else  begin l3[29] = LT3[29];end
		if(LT3[30] > 255)begin l3[30] = LT3[30] - 255;end
		else  begin l3[30] = LT3[30];end
		if(LT3[31] > 255)begin l3[31] = LT3[31] - 255;end
		else  begin l3[31] = LT3[31];end
		if(LT3[32] > 255)begin l3[32] = LT3[32] - 255;end
		else  begin l3[32] = LT3[32];end
		if(LT3[33] > 255)begin l3[33] = LT3[33] - 255;end
		else  begin l3[33] = LT3[33];end
		if(LT3[34] > 255)begin l3[34] = LT3[34] - 255;end
		else  begin l3[34] = LT3[34];end
		if(LT3[35] > 255)begin l3[35] = LT3[35] - 255;end
		else  begin l3[35] = LT3[35];end
		if(LT3[36] > 255)begin l3[36] = LT3[36] - 255;end
		else  begin l3[36] = LT3[36];end
		if(LT3[37] > 255)begin l3[37] = LT3[37] - 255;end
		else  begin l3[37] = LT3[37];end
		if(LT3[38] > 255)begin l3[38] = LT3[38] - 255;end
		else  begin l3[38] = LT3[38];end
		if(LT3[39] > 255)begin l3[39] = LT3[39] - 255;end
		else  begin l3[39] = LT3[39];end
		if(LT3[40] > 255)begin l3[40] = LT3[40] - 255;end
		else  begin l3[40] = LT3[40];end
		if(LT3[41] > 255)begin l3[41] = LT3[41] - 255;end
		else  begin l3[41] = LT3[41];end
		if(LT3[42] > 255)begin l3[42] = LT3[42] - 255;end
		else  begin l3[42] = LT3[42];end
		if(LT3[43] > 255)begin l3[43] = LT3[43] - 255;end
		else  begin l3[43] = LT3[43];end
		if(LT3[44] > 255)begin l3[44] = LT3[44] - 255;end
		else  begin l3[44] = LT3[44];end
		if(LT3[45] > 255)begin l3[45] = LT3[45] - 255;end
		else  begin l3[45] = LT3[45];end
		if(LT3[46] > 255)begin l3[46] = LT3[46] - 255;end
		else  begin l3[46] = LT3[46];end
		if(LT3[47] > 255)begin l3[47] = LT3[47] - 255;end
		else  begin l3[47] = LT3[47];end
		if(LT3[48] > 255)begin l3[48] = LT3[48] - 255;end
		else  begin l3[48] = LT3[48];end
		if(LT3[49] > 255)begin l3[49] = LT3[49] - 255;end
		else  begin l3[49] = LT3[49];end
		if(LT3[50] > 255)begin l3[50] = LT3[50] - 255;end
		else  begin l3[50] = LT3[50];end
		if(LT3[51] > 255)begin l3[51] = LT3[51] - 255;end
		else  begin l3[51] = LT3[51];end
		if(LT3[52] > 255)begin l3[52] = LT3[52] - 255;end
		else  begin l3[52] = LT3[52];end
		if(LT3[53] > 255)begin l3[53] = LT3[53] - 255;end
		else  begin l3[53] = LT3[53];end
		if(LT3[54] > 255)begin l3[54] = LT3[54] - 255;end
		else  begin l3[54] = LT3[54];end
		if(LT3[55] > 255)begin l3[55] = LT3[55] - 255;end
		else  begin l3[55] = LT3[55];end
		if(LT3[56] > 255)begin l3[56] = LT3[56] - 255;end
		else  begin l3[56] = LT3[56];end
		if(LT3[57] > 255)begin l3[57] = LT3[57] - 255;end
		else  begin l3[57] = LT3[57];end
		if(LT3[58] > 255)begin l3[58] = LT3[58] - 255;end
		else  begin l3[58] = LT3[58];end
		if(LT3[59] > 255)begin l3[59] = LT3[59] - 255;end
		else  begin l3[59] = LT3[59];end
		if(LT3[60] > 255)begin l3[60] = LT3[60] - 255;end
		else  begin l3[60] = LT3[60];end
		if(LT3[61] > 255)begin l3[61] = LT3[61] - 255;end
		else  begin l3[61] = LT3[61];end
		if(LT3[62] > 255)begin l3[62] = LT3[62] - 255;end
		else  begin l3[62] = LT3[62];end
		if(LT3[63] > 255)begin l3[63] = LT3[63] - 255;end
		else  begin l3[63] = LT3[63];end		
		next_state = 30;
	end
	30:begin
		/* for d0 */
		if(l3[0] == 0)begin ET3[0] = 0;end
		else begin ET3[0] = eTable[l3[0]];end
		if(l3[1] == 0)begin ET3[1] = 0;end
		else begin ET3[1] = eTable[l3[1]];end
		/* for d6 */
		if(l3[2] == 0)begin ET3[2] = 0;end
		else begin ET3[2] = eTable[l3[2]];end
		if(l3[3] == 0)begin ET3[3] = 0;end
		else begin ET3[3] = eTable[l3[3]];end
		/* for d6 */
		if(l3[4] == 0)begin ET3[4] = 0;end
		else begin ET3[4] = eTable[l3[4]];end
		if(l3[5] == 0)begin ET3[5] = 0;end
		else begin ET3[5] = eTable[l3[5]];end
		/* for d3 */
		if(l3[6] == 0)begin ET3[6] = 0;end
		else begin ET3[6] = eTable[l3[6]];end
		if(l3[7] == 0)begin ET3[7] = 0;end
		else begin ET3[7] = eTable[l3[7]];end
		/* for d6 */
		if(l3[8] == 0)begin ET3[8] = 0;end
		else begin ET3[8] = eTable[l3[8]];end
		if(l3[9] == 0)begin ET3[9] = 0;end
		else begin ET3[9] = eTable[l3[9]];end
		/* for d6 */
		if(l3[10] == 0)begin ET3[10] = 0;end
		else begin ET3[10] = eTable[l3[10]];end
		if(l3[11] == 0)begin ET3[11] = 0;end
		else begin ET3[11] = eTable[l3[11]];end
		/* for d6 */
		if(l3[12] == 0)begin ET3[12] = 0;end
		else begin ET3[12] = eTable[l3[12]];end
		if(l3[13] == 0)begin ET3[13] = 0;end
		else begin ET3[13] = eTable[l3[13]];end
		/* for d7 */
		if(l3[14] == 0)begin ET3[14] = 0;end
		else begin ET3[14] = eTable[l3[14]];end
		if(l3[15] == 0)begin ET3[15] = 0;end
		else begin ET3[15] = eTable[l3[15]];end
		/* for d8 */
		if(l3[16] == 0)begin ET3[16] = 0;end
		else begin ET3[16] = eTable[l3[16]];end
		if(l3[17] == 0)begin ET3[17] = 0;end
		else begin ET3[17] = eTable[l3[17]];end
		/* for d9 */
		if(l3[18] == 0)begin ET3[18] = 0;end
		else begin ET3[18] = eTable[l3[18]];end
		if(l3[19] == 0)begin ET3[19] = 0;end
		else begin ET3[19] = eTable[l3[19]];end
		/* for d10 */
		if(l3[20] == 0)begin ET3[20] = 0;end
		else begin ET3[20] = eTable[l3[20]];end
		if(l3[21] == 0)begin ET3[21] = 0;end
		else begin ET3[21] = eTable[l3[21]];end
		/* for d11 */
		if(l3[22] == 0)begin ET3[22] = 0;end
		else begin ET3[22] = eTable[l3[22]];end
		if(l3[23] == 0)begin ET3[23] = 0;end
		else begin ET3[23] = eTable[l3[23]];end
		/* for d12 */
		if(l3[24] == 0)begin ET3[24] = 0;end
		else begin ET3[24] = eTable[l3[24]];end
		if(l3[25] == 0)begin ET3[25] = 0;end
		else begin ET3[25] = eTable[l3[25]];end
		/* for d13 */
		if(l3[26] == 0)begin ET3[26] = 0;end
		else begin ET3[26] = eTable[l3[26]];end
		if(l3[27] == 0)begin ET3[27] = 0;end
		else begin ET3[27] = eTable[l3[27]];end
		/* for d14 */
		if(l3[28] == 0)begin ET3[28] = 0;end
		else begin ET3[28] = eTable[l3[28]];end
		if(l3[29] == 0)begin ET3[29] = 0;end
		else begin ET3[29] = eTable[l3[29]];end
		/* for d15 */
		if(l3[30] == 0)begin ET3[30] = 0;end
		else begin ET3[30] = eTable[l3[30]];end
		if(l3[31] == 0)begin ET3[31] = 0;end
		else begin ET3[31] = eTable[l3[31]];end
		if(l3[32] == 0)begin ET3[32] = 0;end
		else begin ET3[32] = eTable[l3[32]];end
		if(l3[33] == 0)begin ET3[33] = 0;end
		else begin ET3[33] = eTable[l3[33]];end
		if(l3[34] == 0)begin ET3[34] = 0;end
		else begin ET3[34] = eTable[l3[34]];end
		if(l3[35] == 0)begin ET3[35] = 0;end
		else begin ET3[35] = eTable[l3[35]];end
		if(l3[36] == 0)begin ET3[36] = 0;end
		else begin ET3[36] = eTable[l3[36]];end
		if(l3[37] == 0)begin ET3[37] = 0;end
		else begin ET3[37] = eTable[l3[37]];end
		if(l3[38] == 0)begin ET3[38] = 0;end
		else begin ET3[38] = eTable[l3[38]];end
		if(l3[39] == 0)begin ET3[39] = 0;end
		else begin ET3[39] = eTable[l3[39]];end
		if(l3[40] == 0)begin ET3[40] = 0;end
		else begin ET3[40] = eTable[l3[40]];end
		if(l3[41] == 0)begin ET3[41] = 0;end
		else begin ET3[41] = eTable[l3[41]];end
		if(l3[42] == 0)begin ET3[42] = 0;end
		else begin ET3[42] = eTable[l3[42]];end
		if(l3[43] == 0)begin ET3[43] = 0;end
		else begin ET3[43] = eTable[l3[43]];end
		if(l3[44] == 0)begin ET3[44] = 0;end
		else begin ET3[44] = eTable[l3[44]];end
		if(l3[45] == 0)begin ET3[45] = 0;end
		else begin ET3[45] = eTable[l3[45]];end
		if(l3[46] == 0)begin ET3[46] = 0;end
		else begin ET3[46] = eTable[l3[46]];end
		if(l3[47] == 0)begin ET3[47] = 0;end
		else begin ET3[47] = eTable[l3[47]];end
		if(l3[48] == 0)begin ET3[48] = 0;end
		else begin ET3[48] = eTable[l3[48]];end
		if(l3[49] == 0)begin ET3[49] = 0;end
		else begin ET3[49] = eTable[l3[49]];end
		if(l3[50] == 0)begin ET3[50] = 0;end
		else begin ET3[50] = eTable[l3[50]];end		
		if(l3[51] == 0)begin ET3[51] = 0;end
		else begin ET3[51] = eTable[l3[51]];end
		if(l3[52] == 0)begin ET3[52] = 0;end
		else begin ET3[52] = eTable[l3[52]];end
		if(l3[53] == 0)begin ET3[53] = 0;end
		else begin ET3[53] = eTable[l3[53]];end
		if(l3[54] == 0)begin ET3[54] = 0;end
		else begin ET3[54] = eTable[l3[54]];end
		if(l3[55] == 0)begin ET3[55] = 0;end
		else begin ET3[55] = eTable[l3[55]];end
		if(l3[56] == 0)begin ET3[56] = 0;end
		else begin ET3[56] = eTable[l3[56]];end
		if(l3[57] == 0)begin ET3[57] = 0;end
		else begin ET3[57] = eTable[l3[57]];end
		if(l3[58] == 0)begin ET3[58] = 0;end
		else begin ET3[58] = eTable[l3[58]];end
		if(l3[59] == 0)begin ET3[59] = 0;end
		else begin ET3[59] = eTable[l3[59]];end
		if(l3[60] == 0)begin ET3[60] = 0;end
		else begin ET3[60] = eTable[l3[60]];end	
		if(l3[61] == 0)begin ET3[61] = 0;end
		else begin ET3[61] = eTable[l3[61]];end
		if(l3[62] == 0)begin ET3[62] = 0;end
		else begin ET3[62] = eTable[l3[62]];end
		if(l3[63] == 0)begin ET3[63] = 0;end
		else begin ET3[63] = eTable[l3[63]];end
		next_state = 31;
	end
    31:begin
        d7[0] = ET3[0]^ET3[1]^ET3[2]^ET3[3];
        d7[1] = ET3[4]^ET3[5]^ET3[6]^ET3[7];
        d7[2] = ET3[8]^ET3[9]^ET3[10]^ET3[11];
        d7[3] = ET3[12]^ET3[13]^ET3[14]^ET3[15];
        d7[4] = ET3[16]^ET3[17]^ET3[18]^ET3[19];
        d7[5] = ET3[20]^ET3[21]^ET3[22]^ET3[23];
        d7[6] = ET3[24]^ET3[25]^ET3[26]^ET3[27];
        d7[7] = ET3[28]^ET3[29]^ET3[30]^ET3[31];
        d7[8] = ET3[32]^ET3[33]^ET3[34]^ET3[35];
        d7[9] = ET3[36]^ET3[37]^ET3[38]^ET3[39];
        d7[10] = ET3[40]^ET3[41]^ET3[42]^ET3[43];
        d7[11] = ET3[44]^ET3[45]^ET3[46]^ET3[47];
        d7[12] = ET3[48]^ET3[49]^ET3[50]^ET3[51];
        d7[13] = ET3[52]^ET3[53]^ET3[54]^ET3[55];
        d7[14] = ET3[56]^ET3[57]^ET3[58]^ET3[59];
        d7[15] =ET3[60]^ET3[61]^ET3[62]^ET3[63]; 
        next_state = 32;
    end
	32:begin
        tempRow4[0] = d7[0];tempRow4[4] = d7[4];tempRow4[8] = d7[8];tempRow4[12] = d7[12];
        tempRow4[1] = d7[13];tempRow4[5] = d7[1];tempRow4[9] = d7[5];tempRow4[13] = d7[9];
        tempRow4[2] = d7[10];tempRow4[6] = d7[14];tempRow4[10] = d7[2];tempRow4[14] = d7[6];
        tempRow4[3] = d7[7];tempRow4[7] = d7[11];tempRow4[11] = d7[15];tempRow4[15] = d7[3];
        next_state = 33;
	end
	33:begin
        tempSbox4[0] = inv_sbox[tempRow4[0]];tempSbox4[1] = inv_sbox[tempRow4[1]];tempSbox4[2] = inv_sbox[tempRow4[2]];tempSbox4[3] = inv_sbox[tempRow4[3]];
        tempSbox4[4] = inv_sbox[tempRow4[4]];tempSbox4[5] = inv_sbox[tempRow4[5]];tempSbox4[6] = inv_sbox[tempRow4[6]];tempSbox4[7] = inv_sbox[tempRow4[7]];
        tempSbox4[8] = inv_sbox[tempRow4[8]];tempSbox4[9] = inv_sbox[tempRow4[9]];tempSbox4[10] = inv_sbox[tempRow4[10]];tempSbox4[11] = inv_sbox[tempRow4[11]];
        tempSbox4[12] = inv_sbox[tempRow4[12]];tempSbox4[13] = inv_sbox[tempRow4[13]];tempSbox4[14] = inv_sbox[tempRow4[14]];tempSbox4[15] = inv_sbox[tempRow4[15]];
		next_state = 34;
	end
	34:begin
        d8[0] = tempSbox4[0]^k[36][31:24];
        d8[1] = tempSbox4[1]^k[36][23:16];
        d8[2] = tempSbox4[2]^k[36][15:8];
        d8[3] = tempSbox4[3]^k[36][7:0];
        d8[4] = tempSbox4[4]^k[37][31:24];
        d8[5] = tempSbox4[5]^k[37][23:16];
        d8[6] = tempSbox4[6]^k[37][15:8];
        d8[7] = tempSbox4[7]^k[37][7:0];
        d8[8] = tempSbox4[8]^k[38][31:24];
        d8[9] = tempSbox4[9]^k[38][23:16];
        d8[10] = tempSbox4[10]^k[38][15:8];
        d8[11] = tempSbox4[11]^k[38][7:0];
        d8[12] = tempSbox4[12]^k[39][31:24];
        d8[13] = tempSbox4[13]^k[39][23:16];
        d8[14] = tempSbox4[14]^k[39][15:8];
        d8[15] = tempSbox4[15]^k[39][7:0];
		next_state = 35;
	end
	35:begin 
	    /* For b0 & b4*/
		if(d8[0] == 0)begin LT4[0] = 0; LT4[4] = 0; LT4[8] = 0; LT4[12] = 0 ;end
		else begin LT4[0] = lTable[d8[0]] + lTable[8'h0e];LT4[4] = lTable[d8[0]] + lTable[8'h09];LT4[8] =  lTable[d8[0]] + lTable[8'h0d];LT4[12] = lTable[d8[0]] + lTable[8'h0b];end
	    /* For b1 & b2*/
		if(d8[1] == 0)begin LT4[1] = 0;LT4[5] = 0;LT4[9] =0; LT4[13] = 0;end
		else begin LT4[1] = lTable[d8[1]] + lTable[8'h0b];LT4[5] = lTable[d8[1]] + lTable[8'h0e];LT4[9] = lTable[d8[1]] + lTable[8'h09]; LT4[13] = lTable[d8[1]] + lTable[8'h0d];end
	    /* For b3 & b4*/
		if(d8[2] == 0)begin LT4[2] = 0;LT4[6] = 0;LT4[10] = 0;LT4[14] = 0;end
		else begin LT4[2] = lTable[d8[2]] + lTable[8'h0d];LT4[6] = lTable[d8[2]] + lTable[8'h0b];LT4[10] = lTable[d8[2]] + lTable[8'h0e];LT4[14] = lTable[d8[2]] + lTable[8'h09];end
	    /* For b5 & b7*/			
		if(d8[3] == 0)begin LT4[3] = 0;LT4[7] = 0;LT4[11] = 0;LT4[15] = 0;end 
		else begin  LT4[3] = lTable[d8[3]] + lTable[8'h09];LT4[7] = lTable[d8[3]] + lTable[8'h0d];LT4[11] = lTable[d8[3]] + lTable[8'h0b];LT4[15] = lTable[d8[3]] + lTable[8'h0e];end
	    /* For b8 & b14 */				
		if(d8[4] == 0)begin LT4[16] = 0; LT4[20] = 0; LT4[24] = 0; LT4[28] = 0;end
		else begin LT4[16] = lTable[d8[4]] + lTable[8'h0e]; LT4[20] = lTable[d8[4]] + lTable[8'h09]; LT4[24] = lTable[d8[4]] + lTable[8'h0d]; LT4[28] = lTable[d8[4]] + lTable[8'h0b];end
		/* For b9 & b10 */
		if(d8[5] == 0)begin LT4[17] = 0;LT4[21] = 0; LT4[25] = 0;LT4[29] = 0;end
		else begin LT4[17] = lTable[d8[5]] + lTable[8'h0b];LT4[21] = lTable[d8[5]] + lTable[8'h0e]; LT4[25] = lTable[d8[5]] + lTable[8'h09];LT4[29] = lTable[d8[5]] + lTable[8'h0d];end
		/* For b11 & b12*/
		if(d8[6] == 0)begin LT4[18] = 0;LT4[22] = 0; LT4[26] = 0;LT4[30] = 0;end
		else begin LT4[18] = lTable[d8[6]] + lTable[8'h0d];LT4[22] = lTable[d8[6]] + lTable[8'h0b]; LT4[26] = lTable[d8[6]] + lTable[8'h0e];LT4[30] = lTable[d8[6]] + lTable[8'h09];end
		/* For b13 & b15 */
		if(d8[7] == 0)begin LT4[19] = 0;LT4[23] = 0; LT4[27] = 0;LT4[31] = 0;end
		else begin LT4[19] = lTable[d8[7]] + lTable[8'h09];LT4[23] = lTable[d8[7]] + lTable[8'h0d]; LT4[27] = lTable[d8[7]] + lTable[8'h0b];LT4[31] = lTable[d8[7]] + lTable[8'h0e];end
		/* For b16 & b22 */
		if(d8[8] == 0)begin LT4[32] = 0;LT4[36] = 0; LT4[40] = 0;LT4[44] = 0;end
		else begin LT4[32] = lTable[d8[8]] + lTable[8'h0e];LT4[36] = lTable[d8[8]] + lTable[8'h09];LT4[40] = lTable[d8[8]] + lTable[8'h0d];LT4[44] = lTable[d8[8]] + lTable[8'h0b];end
		/* For b17 & 18 */
		if(d8[9] == 0)begin LT4[33] = 0;LT4[37] = 0; LT4[41] = 0;LT4[45] = 0;end
		else begin LT4[33] = lTable[d8[9]] + lTable[8'h0b];LT4[37] = lTable[d8[9]] + lTable[8'h0e]; LT4[41] = lTable[d8[9]] + lTable[8'h09];LT4[45] = lTable[d8[9]] + lTable[8'h0d];end
		/* For b19 & b20 */
		if(d8[10] == 0)begin LT4[34] = 0;LT4[38] = 0;LT4[42] = 0;LT4[46] = 0;end
		else begin LT4[34] = lTable[d8[10]] + lTable[8'h0d];LT4[38] = lTable[d8[10]] + lTable[8'h0b];LT4[42] = lTable[d8[10]] + lTable[8'h0e];LT4[46] = lTable[d8[10]] + lTable[8'h09];end
		/* For b21 & b23 */
		if(d8[11] == 0)begin LT4[35] = 0; LT4[39] =0;LT4[43] = 0; LT4[47] =0;end
		else begin  LT4[35] = lTable[d8[11]] + lTable[8'h09]; LT4[39] =lTable[d8[11]] + lTable[8'h0d];LT4[43] = lTable[d8[11]] + lTable[8'h0b]; LT4[47] =lTable[d8[11]] + lTable[8'h0e];end	
		/* For b24 & b30 */
		if(d8[12] == 0)begin LT4[48] = 0;LT4[52] = 0; LT4[56] = 0;LT4[60] = 0;end 
		else begin LT4[48] = lTable[d8[12]] + lTable[8'h0e];LT4[52] = lTable[d8[12]] + lTable[8'h09]; LT4[56] = lTable[d8[12]] + lTable[8'h0d];LT4[60] = lTable[d8[12]] + lTable[8'h0b];end 		
		/* For b25 & b26 */		
		if(d8[13] == 0)begin LT4[49] = 0;LT4[53] = 0; LT4[57] = 0;LT4[61] = 0;end 
		else begin  LT4[49] = lTable[d8[13]] + lTable[8'h0b];LT4[53] = lTable[d8[13]] + lTable[8'h0e]; LT4[57] = lTable[d8[13]] + lTable[8'h09];LT4[61] = lTable[d8[13]] + lTable[8'h0d];end 
		/* For b27 & b28 */
		if(d8[14] == 0)begin LT4[50] = 0;LT4[54] = 0; LT4[58] = 0;LT4[62] = 0;end 
		else begin LT4[50] = lTable[d8[14]] + lTable[8'h0d];LT4[54] = lTable[d8[14]] + lTable[8'h0b]; LT4[58] = lTable[d8[14]] + lTable[8'h0e];LT4[62] = lTable[d8[14]] + lTable[8'h09];end 
		/* For b29 & b31 */
		if(d8[15] == 0)begin LT4[51] = 0;LT4[55] = 0; LT4[59] = 0;LT4[63] = 0;end 
		else begin LT4[51] = lTable[d8[15]] + lTable[8'h09];LT4[55] = lTable[d8[15]] + lTable[8'h0d]; LT4[59] = lTable[d8[15]] + lTable[8'h0b];LT4[63] = lTable[d8[15]] + lTable[8'h0e];end 

        next_state = 36;
    end
    36:begin
		if(LT4[0] > 255)begin l4[0] = LT4[0] - 255;end
		else begin l4[0] = LT4[0];end
		if(LT4[1] > 255)begin l4[1] = LT4[1] - 255;end
		else  begin l4[1] = LT4[1];end
		if(LT4[2] > 255)begin l4[2] = LT4[2] - 255;end
		else  begin l4[2] = LT4[2];end
		if(LT4[3] > 255)begin l4[3] = LT4[3] - 255;end
		else  begin l4[3] = LT4[3];end
		if(LT4[4] > 255)begin l4[4] = LT4[4] - 255;end
		else  begin l4[4] = LT4[4];end
		if(LT4[5] > 255)begin l4[5] = LT4[5] - 255;end
		else  begin l4[5] = LT4[5];end
		if(LT4[6] > 255)begin l4[6] = LT4[6] - 255;end
		else  begin l4[6] = LT4[6];end
		if(LT4[7] > 255)begin l4[7] = LT4[7] - 255;end
		else  begin l4[7] = LT4[7];end
		if(LT4[8] > 255)begin l4[8] = LT4[8] - 255;end
		else  begin l4[8] = LT4[8];end
		if(LT4[9] > 255)begin l4[9] = LT4[9] - 255;end
		else  begin l4[9] = LT4[9];end
		if(LT4[10] > 255)begin l4[10] = LT4[10] - 255;end
		else  begin l4[10] = LT4[10];end
		if(LT4[11] > 255)begin l4[11] = LT4[11] - 255;end
		else  begin l4[11] = LT4[11];end
		if(LT4[12] > 255)begin l4[12] = LT4[12] - 255;end
		else  begin l4[12] = LT4[12];end
		if(LT4[13] > 255)begin l4[13] = LT4[13] - 255;end
		else  begin l4[13] = LT4[13];end
		if(LT4[14] > 255)begin l4[14] = LT4[14] - 255;end
		else  begin l4[14] = LT4[14];end
		if(LT4[15] > 255)begin l4[15] = LT4[15] - 255;end
		else  begin l4[15] = LT4[15];end
		if(LT4[16] > 255)begin l4[16] = LT4[16] - 255;end
		else  begin l4[16] = LT4[16];end
		if(LT4[17] > 255)begin l4[17] = LT4[17] - 255;end
		else  begin l4[17] = LT4[17];end
		if(LT4[18] > 255)begin l4[18] = LT4[18] - 255;end
		else  begin l4[18] = LT4[18];end
		if(LT4[19] > 255)begin l4[19] = LT4[19] - 255;end
		else  begin l4[19] = LT4[19];end
		if(LT4[20] > 255)begin l4[20] = LT4[20] - 255;end
		else  begin l4[20] = LT4[20];end
		if(LT4[21] > 255)begin l4[21] = LT4[21] - 255;end
		else  begin l4[21] = LT4[21];end
		if(LT4[22] > 255)begin l4[22] = LT4[22] - 255;end
		else  begin l4[22] = LT4[22];end
		if(LT4[23] > 255)begin l4[23] = LT4[23] - 255;end
		else  begin l4[23] = LT4[23];end
		if(LT4[24] > 255)begin l4[24] = LT4[24] - 255;end
		else  begin l4[24] = LT4[24];end
		if(LT4[25] > 255)begin l4[25] = LT4[25] - 255;end
		else  begin l4[25] = LT4[25];end
		if(LT4[26] > 255)begin l4[26] = LT4[26] - 255;end
		else  begin l4[26] = LT4[26];end
		if(LT4[27] > 255)begin l4[27] = LT4[27] - 255;end
		else  begin l4[27] = LT4[27];end
		if(LT4[28] > 255)begin l4[28] = LT4[28] - 255;end
		else  begin l4[28] = LT4[28];end
		if(LT4[29] > 255)begin l4[29] = LT4[29] - 255;end
		else  begin l4[29] = LT4[29];end
		if(LT4[30] > 255)begin l4[30] = LT4[30] - 255;end
		else  begin l4[30] = LT4[30];end
		if(LT4[31] > 255)begin l4[31] = LT4[31] - 255;end
		else  begin l4[31] = LT4[31];end
		if(LT4[32] > 255)begin l4[32] = LT4[32] - 255;end
		else  begin l4[32] = LT4[32];end
		if(LT4[33] > 255)begin l4[33] = LT4[33] - 255;end
		else  begin l4[33] = LT4[33];end
		if(LT4[34] > 255)begin l4[34] = LT4[34] - 255;end
		else  begin l4[34] = LT4[34];end
		if(LT4[35] > 255)begin l4[35] = LT4[35] - 255;end
		else  begin l4[35] = LT4[35];end
		if(LT4[36] > 255)begin l4[36] = LT4[36] - 255;end
		else  begin l4[36] = LT4[36];end
		if(LT4[37] > 255)begin l4[37] = LT4[37] - 255;end
		else  begin l4[37] = LT4[37];end
		if(LT4[38] > 255)begin l4[38] = LT4[38] - 255;end
		else  begin l4[38] = LT4[38];end
		if(LT4[39] > 255)begin l4[39] = LT4[39] - 255;end
		else  begin l4[39] = LT4[39];end
		if(LT4[40] > 255)begin l4[40] = LT4[40] - 255;end
		else  begin l4[40] = LT4[40];end
		if(LT4[41] > 255)begin l4[41] = LT4[41] - 255;end
		else  begin l4[41] = LT4[41];end
		if(LT4[42] > 255)begin l4[42] = LT4[42] - 255;end
		else  begin l4[42] = LT4[42];end
		if(LT4[43] > 255)begin l4[43] = LT4[43] - 255;end
		else  begin l4[43] = LT4[43];end
		if(LT4[44] > 255)begin l4[44] = LT4[44] - 255;end
		else  begin l4[44] = LT4[44];end
		if(LT4[45] > 255)begin l4[45] = LT4[45] - 255;end
		else  begin l4[45] = LT4[45];end
		if(LT4[46] > 255)begin l4[46] = LT4[46] - 255;end
		else  begin l4[46] = LT4[46];end
		if(LT4[47] > 255)begin l4[47] = LT4[47] - 255;end
		else  begin l4[47] = LT4[47];end
		if(LT4[48] > 255)begin l4[48] = LT4[48] - 255;end
		else  begin l4[48] = LT4[48];end
		if(LT4[49] > 255)begin l4[49] = LT4[49] - 255;end
		else  begin l4[49] = LT4[49];end
		if(LT4[50] > 255)begin l4[50] = LT4[50] - 255;end
		else  begin l4[50] = LT4[50];end
		if(LT4[51] > 255)begin l4[51] = LT4[51] - 255;end
		else  begin l4[51] = LT4[51];end
		if(LT4[52] > 255)begin l4[52] = LT4[52] - 255;end
		else  begin l4[52] = LT4[52];end
		if(LT4[53] > 255)begin l4[53] = LT4[53] - 255;end
		else  begin l4[53] = LT4[53];end
		if(LT4[54] > 255)begin l4[54] = LT4[54] - 255;end
		else  begin l4[54] = LT4[54];end
		if(LT4[55] > 255)begin l4[55] = LT4[55] - 255;end
		else  begin l4[55] = LT4[55];end
		if(LT4[56] > 255)begin l4[56] = LT4[56] - 255;end
		else  begin l4[56] = LT4[56];end
		if(LT4[57] > 255)begin l4[57] = LT4[57] - 255;end
		else  begin l4[57] = LT4[57];end
		if(LT4[58] > 255)begin l4[58] = LT4[58] - 255;end
		else  begin l4[58] = LT4[58];end
		if(LT4[59] > 255)begin l4[59] = LT4[59] - 255;end
		else  begin l4[59] = LT4[59];end
		if(LT4[60] > 255)begin l4[60] = LT4[60] - 255;end
		else  begin l4[60] = LT4[60];end
		if(LT4[61] > 255)begin l4[61] = LT4[61] - 255;end
		else  begin l4[61] = LT4[61];end
		if(LT4[62] > 255)begin l4[62] = LT4[62] - 255;end
		else  begin l4[62] = LT4[62];end
		if(LT4[63] > 255)begin l4[63] = LT4[63] - 255;end
		else  begin l4[63] = LT4[63];end		
		next_state = 37;
	end
	37:begin
		/* for d0 */
		if(l4[0] == 0)begin ET4[0] = 0;end
		else begin ET4[0] = eTable[l4[0]];end
		if(l4[1] == 0)begin ET4[1] = 0;end
		else begin ET4[1] = eTable[l4[1]];end
		/* for d8 */
		if(l4[2] == 0)begin ET4[2] = 0;end
		else begin ET4[2] = eTable[l4[2]];end
		if(l4[3] == 0)begin ET4[3] = 0;end
		else begin ET4[3] = eTable[l4[3]];end
		/* for d8 */
		if(l4[4] == 0)begin ET4[4] = 0;end
		else begin ET4[4] = eTable[l4[4]];end
		if(l4[5] == 0)begin ET4[5] = 0;end
		else begin ET4[5] = eTable[l4[5]];end
		/* for d3 */
		if(l4[6] == 0)begin ET4[6] = 0;end
		else begin ET4[6] = eTable[l4[6]];end
		if(l4[7] == 0)begin ET4[7] = 0;end
		else begin ET4[7] = eTable[l4[7]];end
		/* for d8 */
		if(l4[8] == 0)begin ET4[8] = 0;end
		else begin ET4[8] = eTable[l4[8]];end
		if(l4[9] == 0)begin ET4[9] = 0;end
		else begin ET4[9] = eTable[l4[9]];end
		/* for d8 */
		if(l4[10] == 0)begin ET4[10] = 0;end
		else begin ET4[10] = eTable[l4[10]];end
		if(l4[11] == 0)begin ET4[11] = 0;end
		else begin ET4[11] = eTable[l4[11]];end
		/* for d8 */
		if(l4[12] == 0)begin ET4[12] = 0;end
		else begin ET4[12] = eTable[l4[12]];end
		if(l4[13] == 0)begin ET4[13] = 0;end
		else begin ET4[13] = eTable[l4[13]];end
		/* for d7 */
		if(l4[14] == 0)begin ET4[14] = 0;end
		else begin ET4[14] = eTable[l4[14]];end
		if(l4[15] == 0)begin ET4[15] = 0;end
		else begin ET4[15] = eTable[l4[15]];end
		/* for d8 */
		if(l4[16] == 0)begin ET4[16] = 0;end
		else begin ET4[16] = eTable[l4[16]];end
		if(l4[17] == 0)begin ET4[17] = 0;end
		else begin ET4[17] = eTable[l4[17]];end
		/* for d9 */
		if(l4[18] == 0)begin ET4[18] = 0;end
		else begin ET4[18] = eTable[l4[18]];end
		if(l4[19] == 0)begin ET4[19] = 0;end
		else begin ET4[19] = eTable[l4[19]];end
		/* for d10 */
		if(l4[20] == 0)begin ET4[20] = 0;end
		else begin ET4[20] = eTable[l4[20]];end
		if(l4[21] == 0)begin ET4[21] = 0;end
		else begin ET4[21] = eTable[l4[21]];end
		/* for d11 */
		if(l4[22] == 0)begin ET4[22] = 0;end
		else begin ET4[22] = eTable[l4[22]];end
		if(l4[23] == 0)begin ET4[23] = 0;end
		else begin ET4[23] = eTable[l4[23]];end
		/* for d12 */
		if(l4[24] == 0)begin ET4[24] = 0;end
		else begin ET4[24] = eTable[l4[24]];end
		if(l4[25] == 0)begin ET4[25] = 0;end
		else begin ET4[25] = eTable[l4[25]];end
		/* for d13 */
		if(l4[26] == 0)begin ET4[26] = 0;end
		else begin ET4[26] = eTable[l4[26]];end
		if(l4[27] == 0)begin ET4[27] = 0;end
		else begin ET4[27] = eTable[l4[27]];end
		/* for d14 */
		if(l4[28] == 0)begin ET4[28] = 0;end
		else begin ET4[28] = eTable[l4[28]];end
		if(l4[29] == 0)begin ET4[29] = 0;end
		else begin ET4[29] = eTable[l4[29]];end
		/* for d15 */
		if(l4[30] == 0)begin ET4[30] = 0;end
		else begin ET4[30] = eTable[l4[30]];end
		if(l4[31] == 0)begin ET4[31] = 0;end
		else begin ET4[31] = eTable[l4[31]];end
		if(l4[32] == 0)begin ET4[32] = 0;end
		else begin ET4[32] = eTable[l4[32]];end
		if(l4[33] == 0)begin ET4[33] = 0;end
		else begin ET4[33] = eTable[l4[33]];end
		if(l4[34] == 0)begin ET4[34] = 0;end
		else begin ET4[34] = eTable[l4[34]];end
		if(l4[35] == 0)begin ET4[35] = 0;end
		else begin ET4[35] = eTable[l4[35]];end
		if(l4[36] == 0)begin ET4[36] = 0;end
		else begin ET4[36] = eTable[l4[36]];end
		if(l4[37] == 0)begin ET4[37] = 0;end
		else begin ET4[37] = eTable[l4[37]];end
		if(l4[38] == 0)begin ET4[38] = 0;end
		else begin ET4[38] = eTable[l4[38]];end
		if(l4[39] == 0)begin ET4[39] = 0;end
		else begin ET4[39] = eTable[l4[39]];end
		if(l4[40] == 0)begin ET4[40] = 0;end
		else begin ET4[40] = eTable[l4[40]];end
		if(l4[41] == 0)begin ET4[41] = 0;end
		else begin ET4[41] = eTable[l4[41]];end
		if(l4[42] == 0)begin ET4[42] = 0;end
		else begin ET4[42] = eTable[l4[42]];end
		if(l4[43] == 0)begin ET4[43] = 0;end
		else begin ET4[43] = eTable[l4[43]];end
		if(l4[44] == 0)begin ET4[44] = 0;end
		else begin ET4[44] = eTable[l4[44]];end
		if(l4[45] == 0)begin ET4[45] = 0;end
		else begin ET4[45] = eTable[l4[45]];end
		if(l4[46] == 0)begin ET4[46] = 0;end
		else begin ET4[46] = eTable[l4[46]];end
		if(l4[47] == 0)begin ET4[47] = 0;end
		else begin ET4[47] = eTable[l4[47]];end
		if(l4[48] == 0)begin ET4[48] = 0;end
		else begin ET4[48] = eTable[l4[48]];end
		if(l4[49] == 0)begin ET4[49] = 0;end
		else begin ET4[49] = eTable[l4[49]];end
		if(l4[50] == 0)begin ET4[50] = 0;end
		else begin ET4[50] = eTable[l4[50]];end		
		if(l4[51] == 0)begin ET4[51] = 0;end
		else begin ET4[51] = eTable[l4[51]];end
		if(l4[52] == 0)begin ET4[52] = 0;end
		else begin ET4[52] = eTable[l4[52]];end
		if(l4[53] == 0)begin ET4[53] = 0;end
		else begin ET4[53] = eTable[l4[53]];end
		if(l4[54] == 0)begin ET4[54] = 0;end
		else begin ET4[54] = eTable[l4[54]];end
		if(l4[55] == 0)begin ET4[55] = 0;end
		else begin ET4[55] = eTable[l4[55]];end
		if(l4[56] == 0)begin ET4[56] = 0;end
		else begin ET4[56] = eTable[l4[56]];end
		if(l4[57] == 0)begin ET4[57] = 0;end
		else begin ET4[57] = eTable[l4[57]];end
		if(l4[58] == 0)begin ET4[58] = 0;end
		else begin ET4[58] = eTable[l4[58]];end
		if(l4[59] == 0)begin ET4[59] = 0;end
		else begin ET4[59] = eTable[l4[59]];end
		if(l4[60] == 0)begin ET4[60] = 0;end
		else begin ET4[60] = eTable[l4[60]];end	
		if(l4[61] == 0)begin ET4[61] = 0;end
		else begin ET4[61] = eTable[l4[61]];end
		if(l4[62] == 0)begin ET4[62] = 0;end
		else begin ET4[62] = eTable[l4[62]];end
		if(l4[63] == 0)begin ET4[63] = 0;end
		else begin ET4[63] = eTable[l4[63]];end
		next_state = 38;
	end
    38:begin
        d9[0] = ET4[0]^ET4[1]^ET4[2]^ET4[3];
        d9[1] = ET4[4]^ET4[5]^ET4[6]^ET4[7];
        d9[2] = ET4[8]^ET4[9]^ET4[10]^ET4[11];
        d9[3] = ET4[12]^ET4[13]^ET4[14]^ET4[15];
        d9[4] = ET4[16]^ET4[17]^ET4[18]^ET4[19];
        d9[5] = ET4[20]^ET4[21]^ET4[22]^ET4[23];
        d9[6] = ET4[24]^ET4[25]^ET4[26]^ET4[27];
        d9[7] = ET4[28]^ET4[29]^ET4[30]^ET4[31];
        d9[8] = ET4[32]^ET4[33]^ET4[34]^ET4[35];
        d9[9] = ET4[36]^ET4[37]^ET4[38]^ET4[39];
        d9[10] = ET4[40]^ET4[41]^ET4[42]^ET4[43];
        d9[11] = ET4[44]^ET4[45]^ET4[46]^ET4[47];
        d9[12] = ET4[48]^ET4[49]^ET4[50]^ET4[51];
        d9[13] = ET4[52]^ET4[53]^ET4[54]^ET4[55];
        d9[14] = ET4[56]^ET4[57]^ET4[58]^ET4[59];
        d9[15] =ET4[60]^ET4[61]^ET4[62]^ET4[63]; 
        next_state = 39;
    end
	39:begin
        tempRow5[0] = d9[0];tempRow5[4] = d9[4];tempRow5[8] = d9[8];tempRow5[12] = d9[12];
        tempRow5[1] = d9[13];tempRow5[5] = d9[1];tempRow5[9] = d9[5];tempRow5[13] = d9[9];
        tempRow5[2] = d9[10];tempRow5[6] = d9[14];tempRow5[10] = d9[2];tempRow5[14] = d9[6];
        tempRow5[3] = d9[7];tempRow5[7] = d9[11];tempRow5[11] = d9[15];tempRow5[15] = d9[3];
        next_state = 40;
	end
	40:begin
        tempSbox5[0] = inv_sbox[tempRow5[0]];tempSbox5[1] = inv_sbox[tempRow5[1]];tempSbox5[2] = inv_sbox[tempRow5[2]];tempSbox5[3] = inv_sbox[tempRow5[3]];
        tempSbox5[4] = inv_sbox[tempRow5[4]];tempSbox5[5] = inv_sbox[tempRow5[5]];tempSbox5[6] = inv_sbox[tempRow5[6]];tempSbox5[7] = inv_sbox[tempRow5[7]];
        tempSbox5[8] = inv_sbox[tempRow5[8]];tempSbox5[9] = inv_sbox[tempRow5[9]];tempSbox5[10] = inv_sbox[tempRow5[10]];tempSbox5[11] = inv_sbox[tempRow5[11]];
        tempSbox5[12] = inv_sbox[tempRow5[12]];tempSbox5[13] = inv_sbox[tempRow5[13]];tempSbox5[14] = inv_sbox[tempRow5[14]];tempSbox5[15] = inv_sbox[tempRow5[15]];
		next_state = 41;
	end
	41:begin
        d10[0] = tempSbox5[0]^k[32][31:24];
        d10[1] = tempSbox5[1]^k[32][23:16];
        d10[2] = tempSbox5[2]^k[32][15:8];
        d10[3] = tempSbox5[3]^k[32][7:0];
        d10[4] = tempSbox5[4]^k[33][31:24];
        d10[5] = tempSbox5[5]^k[33][23:16];
        d10[6] = tempSbox5[6]^k[33][15:8];
        d10[7] = tempSbox5[7]^k[33][7:0];
        d10[8] = tempSbox5[8]^k[34][31:24];
        d10[9] = tempSbox5[9]^k[34][23:16];
        d10[10] = tempSbox5[10]^k[34][15:8];
        d10[11] = tempSbox5[11]^k[34][7:0];
        d10[12] = tempSbox5[12]^k[35][31:24];
        d10[13] = tempSbox5[13]^k[35][23:16];
        d10[14] = tempSbox5[14]^k[35][15:8];
        d10[15] = tempSbox5[15]^k[35][7:0];
		next_state = 98;
	end
    98:begin
         w1[0] = {d10[0],d10[1],d10[2],d10[3]};
         w1[1] = {d10[4],d10[5],d10[6],d10[7]};
         w1[2] = {d10[8],d10[9],d10[10],d10[11]};
         w1[3] = {d10[12],d10[13],d10[14],d10[15]};
         next_state = 99;
    end
    99: begin
		plaintext = {w1[0],w1[1],w1[2],w1[3]};
       //plaintext = {tempRow1[0],tempRow1[1],tempRow1[2],tempRow1[3],tempRow1[4],tempRow1[5],tempRow1[6],tempRow1[7],tempRow1[8],tempRow1[9],tempRow1[10],tempRow1[11],tempRow1[12],tempRow1[13],tempRow1[14],tempRow1[15]};
       //  plaintext = {tempSbox[0],tempSbox[1],tempSbox[2],tempSbox[3],tempSbox[4],tempSbox[5],tempSbox[6],tempSbox[7],tempSbox[8],tempSbox[9],tempSbox[10],tempSbox[11],tempSbox[12],tempSbox[13],tempSbox[14],tempSbox[15]};
        encDone =  1;  
        next_state = 100;
    end
    100:begin
          encDone =  1;
          ledDone = 1;  
          next_state = 100;
     end
        default:begin
                    next_state = 0;
                end
    
    endcase
    end
endmodule
