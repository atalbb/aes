`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2018 04:49:49 PM
// Design Name: 
// Module Name: aes_enc_core
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
                  input dstart,
                  input [1:0]enc_dec,
                  input [1919:0]keyIn, // 60 words(32-bit) expanded key
                  input [127:0]dataIn, // 4 word(32-bit) data block
                  output reg encDone,
                  output reg [127:0]cipher,
                  output reg ledDone

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
reg [7:0]d11[15:0];
reg [7:0]d12[15:0];
reg [7:0]d13[15:0];
reg [7:0]d14[15:0];
reg [7:0]d15[15:0];

//reg [7:0]d1[15:0];
reg [31:0]w[3:0];
reg [31:0]w1[3:0];
reg [31:0]w2[3:0];
reg [31:0]w3[3:0];
reg [31:0]w4[3:0];
reg [31:0]w5[3:0];
reg [31:0]w6[3:0];
reg [31:0]w7[3:0];
reg [31:0]w8[3:0];
reg [31:0]w9[3:0];
reg [31:0]w10[3:0];
reg [31:0]w11[3:0];
reg [31:0]w12[3:0];
reg [31:0]w13[3:0];
reg [31:0]w14[3:0];
reg [31:0]w15[3:0];

reg [31:0]k[59:0];
wire [7:0]sbox[255:0];
reg [31:0]tempStart[3:0];
reg [31:0]tempStart1[3:0];
reg [31:0]tempStart2[3:0];
reg [31:0]tempStart3[3:0];
reg [31:0]tempStart4[3:0];
reg [31:0]tempStart5[3:0];
reg [31:0]tempStart6[3:0];
reg [31:0]tempStart7[3:0];
reg [31:0]tempStart8[3:0];
reg [31:0]tempStart9[3:0];
reg [31:0]tempStart10[3:0];
reg [31:0]tempStart11[3:0];
reg [31:0]tempStart12[3:0];
reg [31:0]tempStart13[3:0];
reg [31:0]tempStart14[3:0];
reg [31:0]tempStart15[3:0];
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
reg [7:0]tempSbox10[15:0];
reg [7:0]tempSbox11[15:0];
reg [7:0]tempSbox12[15:0];
reg [7:0]tempSbox13[15:0];
reg [7:0]tempSbox14[15:0];
reg [7:0]tempSbox15[15:0];
reg [7:0]tempRow[15:0];
reg [7:0]tempRow1[15:0];
reg [7:0]tempRow2[15:0];
reg [7:0]tempRow3[15:0];
reg [7:0]tempRow4[15:0];
reg [7:0]tempRow5[15:0];
reg [7:0]tempRow6[15:0];
reg [7:0]tempRow7[15:0];
reg [7:0]tempRow8[15:0];
reg [7:0]tempRow9[15:0];
reg [7:0]tempRow10[15:0];
reg [7:0]tempRow11[15:0];
reg [7:0]tempRow12[15:0];
reg [7:0]tempRow13[15:0];
reg [7:0]tempRow14[15:0];
reg [7:0]tempRow15[15:0];

wire [7 : 0] mul2 [0 : 255];
wire [7 : 0] mul3 [0 : 255];

assign mul2[8'h00] = 8'h00;
assign mul2[8'h01] = 8'h02;
assign mul2[8'h02] = 8'h04;
assign mul2[8'h03] = 8'h06;
assign mul2[8'h04] = 8'h08;
assign mul2[8'h05] = 8'h0a;
assign mul2[8'h06] = 8'h0c;
assign mul2[8'h07] = 8'h0e;
assign mul2[8'h08] = 8'h10;
assign mul2[8'h09] = 8'h12;
assign mul2[8'h0a] = 8'h14;
assign mul2[8'h0b] = 8'h16;
assign mul2[8'h0c] = 8'h18;
assign mul2[8'h0d] = 8'h1a;
assign mul2[8'h0e] = 8'h1c;
assign mul2[8'h0f] = 8'h1e;
assign mul2[8'h10] = 8'h20;
assign mul2[8'h11] = 8'h22;
assign mul2[8'h12] = 8'h24;
assign mul2[8'h13] = 8'h26;
assign mul2[8'h14] = 8'h28;
assign mul2[8'h15] = 8'h2a;
assign mul2[8'h16] = 8'h2c;
assign mul2[8'h17] = 8'h2e;
assign mul2[8'h18] = 8'h30;
assign mul2[8'h19] = 8'h32;
assign mul2[8'h1a] = 8'h34;
assign mul2[8'h1b] = 8'h36;
assign mul2[8'h1c] = 8'h38;
assign mul2[8'h1d] = 8'h3a;
assign mul2[8'h1e] = 8'h3c;
assign mul2[8'h1f] = 8'h3e;
assign mul2[8'h20] = 8'h40;
assign mul2[8'h21] = 8'h42;
assign mul2[8'h22] = 8'h44;
assign mul2[8'h23] = 8'h46;
assign mul2[8'h24] = 8'h48;
assign mul2[8'h25] = 8'h4a;
assign mul2[8'h26] = 8'h4c;
assign mul2[8'h27] = 8'h4e;
assign mul2[8'h28] = 8'h50;
assign mul2[8'h29] = 8'h52;
assign mul2[8'h2a] = 8'h54;
assign mul2[8'h2b] = 8'h56;
assign mul2[8'h2c] = 8'h58;
assign mul2[8'h2d] = 8'h5a;
assign mul2[8'h2e] = 8'h5c;
assign mul2[8'h2f] = 8'h5e;
assign mul2[8'h30] = 8'h60;
assign mul2[8'h31] = 8'h62;
assign mul2[8'h32] = 8'h64;
assign mul2[8'h33] = 8'h66;
assign mul2[8'h34] = 8'h68;
assign mul2[8'h35] = 8'h6a;
assign mul2[8'h36] = 8'h6c;
assign mul2[8'h37] = 8'h6e;
assign mul2[8'h38] = 8'h70;
assign mul2[8'h39] = 8'h72;
assign mul2[8'h3a] = 8'h74;
assign mul2[8'h3b] = 8'h76;
assign mul2[8'h3c] = 8'h78;
assign mul2[8'h3d] = 8'h7a;
assign mul2[8'h3e] = 8'h7c;
assign mul2[8'h3f] = 8'h7e;
assign mul2[8'h40] = 8'h80;
assign mul2[8'h41] = 8'h82;
assign mul2[8'h42] = 8'h84;
assign mul2[8'h43] = 8'h86;
assign mul2[8'h44] = 8'h88;
assign mul2[8'h45] = 8'h8a;
assign mul2[8'h46] = 8'h8c;
assign mul2[8'h47] = 8'h8e;
assign mul2[8'h48] = 8'h90;
assign mul2[8'h49] = 8'h92;
assign mul2[8'h4a] = 8'h94;
assign mul2[8'h4b] = 8'h96;
assign mul2[8'h4c] = 8'h98;
assign mul2[8'h4d] = 8'h9a;
assign mul2[8'h4e] = 8'h9c;
assign mul2[8'h4f] = 8'h9e;
assign mul2[8'h50] = 8'ha0;
assign mul2[8'h51] = 8'ha2;
assign mul2[8'h52] = 8'ha4;
assign mul2[8'h53] = 8'ha6;
assign mul2[8'h54] = 8'ha8;
assign mul2[8'h55] = 8'haa;
assign mul2[8'h56] = 8'hac;
assign mul2[8'h57] = 8'hae;
assign mul2[8'h58] = 8'hb0;
assign mul2[8'h59] = 8'hb2;
assign mul2[8'h5a] = 8'hb4;
assign mul2[8'h5b] = 8'hb6;
assign mul2[8'h5c] = 8'hb8;
assign mul2[8'h5d] = 8'hba;
assign mul2[8'h5e] = 8'hbc;
assign mul2[8'h5f] = 8'hbe;
assign mul2[8'h60] = 8'hc0;
assign mul2[8'h61] = 8'hc2;
assign mul2[8'h62] = 8'hc4;
assign mul2[8'h63] = 8'hc6;
assign mul2[8'h64] = 8'hc8;
assign mul2[8'h65] = 8'hca;
assign mul2[8'h66] = 8'hcc;
assign mul2[8'h67] = 8'hce;
assign mul2[8'h68] = 8'hd0;
assign mul2[8'h69] = 8'hd2;
assign mul2[8'h6a] = 8'hd4;
assign mul2[8'h6b] = 8'hd6;
assign mul2[8'h6c] = 8'hd8;
assign mul2[8'h6d] = 8'hda;
assign mul2[8'h6e] = 8'hdc;
assign mul2[8'h6f] = 8'hde;
assign mul2[8'h70] = 8'he0;
assign mul2[8'h71] = 8'he2;
assign mul2[8'h72] = 8'he4;
assign mul2[8'h73] = 8'he6;
assign mul2[8'h74] = 8'he8;
assign mul2[8'h75] = 8'hea;
assign mul2[8'h76] = 8'hec;
assign mul2[8'h77] = 8'hee;
assign mul2[8'h78] = 8'hf0;
assign mul2[8'h79] = 8'hf2;
assign mul2[8'h7a] = 8'hf4;
assign mul2[8'h7b] = 8'hf6;
assign mul2[8'h7c] = 8'hf8;
assign mul2[8'h7d] = 8'hfa;
assign mul2[8'h7e] = 8'hfc;
assign mul2[8'h7f] = 8'hfe;
assign mul2[8'h80] = 8'h1b;
assign mul2[8'h81] = 8'h19;
assign mul2[8'h82] = 8'h1f;
assign mul2[8'h83] = 8'h1d;
assign mul2[8'h84] = 8'h13;
assign mul2[8'h85] = 8'h11;
assign mul2[8'h86] = 8'h17;
assign mul2[8'h87] = 8'h15;
assign mul2[8'h88] = 8'h0b;
assign mul2[8'h89] = 8'h09;
assign mul2[8'h8a] = 8'h0f;
assign mul2[8'h8b] = 8'h0d;
assign mul2[8'h8c] = 8'h03;
assign mul2[8'h8d] = 8'h01;
assign mul2[8'h8e] = 8'h07;
assign mul2[8'h8f] = 8'h05;
assign mul2[8'h90] = 8'h3b;
assign mul2[8'h91] = 8'h39;
assign mul2[8'h92] = 8'h3f;
assign mul2[8'h93] = 8'h3d;
assign mul2[8'h94] = 8'h33;
assign mul2[8'h95] = 8'h31;
assign mul2[8'h96] = 8'h37;
assign mul2[8'h97] = 8'h35;
assign mul2[8'h98] = 8'h2b;
assign mul2[8'h99] = 8'h29;
assign mul2[8'h9a] = 8'h2f;
assign mul2[8'h9b] = 8'h2d;
assign mul2[8'h9c] = 8'h23;
assign mul2[8'h9d] = 8'h21;
assign mul2[8'h9e] = 8'h27;
assign mul2[8'h9f] = 8'h25;
assign mul2[8'ha0] = 8'h5b;
assign mul2[8'ha1] = 8'h59;
assign mul2[8'ha2] = 8'h5f;
assign mul2[8'ha3] = 8'h5d;
assign mul2[8'ha4] = 8'h53;
assign mul2[8'ha5] = 8'h51;
assign mul2[8'ha6] = 8'h57;
assign mul2[8'ha7] = 8'h55;
assign mul2[8'ha8] = 8'h4b;
assign mul2[8'ha9] = 8'h49;
assign mul2[8'haa] = 8'h4f;
assign mul2[8'hab] = 8'h4d;
assign mul2[8'hac] = 8'h43;
assign mul2[8'had] = 8'h41;
assign mul2[8'hae] = 8'h47;
assign mul2[8'haf] = 8'h45;
assign mul2[8'hb0] = 8'h7b;
assign mul2[8'hb1] = 8'h79;
assign mul2[8'hb2] = 8'h7f;
assign mul2[8'hb3] = 8'h7d;
assign mul2[8'hb4] = 8'h73;
assign mul2[8'hb5] = 8'h71;
assign mul2[8'hb6] = 8'h77;
assign mul2[8'hb7] = 8'h75;
assign mul2[8'hb8] = 8'h6b;
assign mul2[8'hb9] = 8'h69;
assign mul2[8'hba] = 8'h6f;
assign mul2[8'hbb] = 8'h6d;
assign mul2[8'hbc] = 8'h63;
assign mul2[8'hbd] = 8'h61;
assign mul2[8'hbe] = 8'h67;
assign mul2[8'hbf] = 8'h65;
assign mul2[8'hc0] = 8'h9b;
assign mul2[8'hc1] = 8'h99;
assign mul2[8'hc2] = 8'h9f;
assign mul2[8'hc3] = 8'h9d;
assign mul2[8'hc4] = 8'h93;
assign mul2[8'hc5] = 8'h91;
assign mul2[8'hc6] = 8'h97;
assign mul2[8'hc7] = 8'h95;
assign mul2[8'hc8] = 8'h8b;
assign mul2[8'hc9] = 8'h89;
assign mul2[8'hca] = 8'h8f;
assign mul2[8'hcb] = 8'h8d;
assign mul2[8'hcc] = 8'h83;
assign mul2[8'hcd] = 8'h81;
assign mul2[8'hce] = 8'h87;
assign mul2[8'hcf] = 8'h85;
assign mul2[8'hd0] = 8'hbb;
assign mul2[8'hd1] = 8'hb9;
assign mul2[8'hd2] = 8'hbf;
assign mul2[8'hd3] = 8'hbd;
assign mul2[8'hd4] = 8'hb3;
assign mul2[8'hd5] = 8'hb1;
assign mul2[8'hd6] = 8'hb7;
assign mul2[8'hd7] = 8'hb5;
assign mul2[8'hd8] = 8'hab;
assign mul2[8'hd9] = 8'ha9;
assign mul2[8'hda] = 8'haf;
assign mul2[8'hdb] = 8'had;
assign mul2[8'hdc] = 8'ha3;
assign mul2[8'hdd] = 8'ha1;
assign mul2[8'hde] = 8'ha7;
assign mul2[8'hdf] = 8'ha5;
assign mul2[8'he0] = 8'hdb;
assign mul2[8'he1] = 8'hd9;
assign mul2[8'he2] = 8'hdf;
assign mul2[8'he3] = 8'hdd;
assign mul2[8'he4] = 8'hd3;
assign mul2[8'he5] = 8'hd1;
assign mul2[8'he6] = 8'hd7;
assign mul2[8'he7] = 8'hd5;
assign mul2[8'he8] = 8'hcb;
assign mul2[8'he9] = 8'hc9;
assign mul2[8'hea] = 8'hcf;
assign mul2[8'heb] = 8'hcd;
assign mul2[8'hec] = 8'hc3;
assign mul2[8'hed] = 8'hc1;
assign mul2[8'hee] = 8'hc7;
assign mul2[8'hef] = 8'hc5;
assign mul2[8'hf0] = 8'hfb;
assign mul2[8'hf1] = 8'hf9;
assign mul2[8'hf2] = 8'hff;
assign mul2[8'hf3] = 8'hfd;
assign mul2[8'hf4] = 8'hf3;
assign mul2[8'hf5] = 8'hf1;
assign mul2[8'hf6] = 8'hf7;
assign mul2[8'hf7] = 8'hf5;
assign mul2[8'hf8] = 8'heb;
assign mul2[8'hf9] = 8'he9;
assign mul2[8'hfa] = 8'hef;
assign mul2[8'hfb] = 8'hed;
assign mul2[8'hfc] = 8'he3;
assign mul2[8'hfd] = 8'he1;
assign mul2[8'hfe] = 8'he7;
assign mul2[8'hff] = 8'he5;

assign mul3[8'h00] = 8'h00;
assign mul3[8'h01] = 8'h03;
assign mul3[8'h02] = 8'h06;
assign mul3[8'h03] = 8'h05;
assign mul3[8'h04] = 8'h0c;
assign mul3[8'h05] = 8'h0f;
assign mul3[8'h06] = 8'h0a;
assign mul3[8'h07] = 8'h09;
assign mul3[8'h08] = 8'h18;
assign mul3[8'h09] = 8'h1b;
assign mul3[8'h0a] = 8'h1e;
assign mul3[8'h0b] = 8'h1d;
assign mul3[8'h0c] = 8'h14;
assign mul3[8'h0d] = 8'h17;
assign mul3[8'h0e] = 8'h12;
assign mul3[8'h0f] = 8'h11;
assign mul3[8'h10] = 8'h30;
assign mul3[8'h11] = 8'h33;
assign mul3[8'h12] = 8'h36;
assign mul3[8'h13] = 8'h35;
assign mul3[8'h14] = 8'h3c;
assign mul3[8'h15] = 8'h3f;
assign mul3[8'h16] = 8'h3a;
assign mul3[8'h17] = 8'h39;
assign mul3[8'h18] = 8'h28;
assign mul3[8'h19] = 8'h2b;
assign mul3[8'h1a] = 8'h2e;
assign mul3[8'h1b] = 8'h2d;
assign mul3[8'h1c] = 8'h24;
assign mul3[8'h1d] = 8'h27;
assign mul3[8'h1e] = 8'h22;
assign mul3[8'h1f] = 8'h21;
assign mul3[8'h20] = 8'h60;
assign mul3[8'h21] = 8'h63;
assign mul3[8'h22] = 8'h66;
assign mul3[8'h23] = 8'h65;
assign mul3[8'h24] = 8'h6c;
assign mul3[8'h25] = 8'h6f;
assign mul3[8'h26] = 8'h6a;
assign mul3[8'h27] = 8'h69;
assign mul3[8'h28] = 8'h78;
assign mul3[8'h29] = 8'h7b;
assign mul3[8'h2a] = 8'h7e;
assign mul3[8'h2b] = 8'h7d;
assign mul3[8'h2c] = 8'h74;
assign mul3[8'h2d] = 8'h77;
assign mul3[8'h2e] = 8'h72;
assign mul3[8'h2f] = 8'h71;
assign mul3[8'h30] = 8'h50;
assign mul3[8'h31] = 8'h53;
assign mul3[8'h32] = 8'h56;
assign mul3[8'h33] = 8'h55;
assign mul3[8'h34] = 8'h5c;
assign mul3[8'h35] = 8'h5f;
assign mul3[8'h36] = 8'h5a;
assign mul3[8'h37] = 8'h59;
assign mul3[8'h38] = 8'h48;
assign mul3[8'h39] = 8'h4b;
assign mul3[8'h3a] = 8'h4e;
assign mul3[8'h3b] = 8'h4d;
assign mul3[8'h3c] = 8'h44;
assign mul3[8'h3d] = 8'h47;
assign mul3[8'h3e] = 8'h42;
assign mul3[8'h3f] = 8'h41;
assign mul3[8'h40] = 8'hc0;
assign mul3[8'h41] = 8'hc3;
assign mul3[8'h42] = 8'hc6;
assign mul3[8'h43] = 8'hc5;
assign mul3[8'h44] = 8'hcc;
assign mul3[8'h45] = 8'hcf;
assign mul3[8'h46] = 8'hca;
assign mul3[8'h47] = 8'hc9;
assign mul3[8'h48] = 8'hd8;
assign mul3[8'h49] = 8'hdb;
assign mul3[8'h4a] = 8'hde;
assign mul3[8'h4b] = 8'hdd;
assign mul3[8'h4c] = 8'hd4;
assign mul3[8'h4d] = 8'hd7;
assign mul3[8'h4e] = 8'hd2;
assign mul3[8'h4f] = 8'hd1;
assign mul3[8'h50] = 8'hf0;
assign mul3[8'h51] = 8'hf3;
assign mul3[8'h52] = 8'hf6;
assign mul3[8'h53] = 8'hf5;
assign mul3[8'h54] = 8'hfc;
assign mul3[8'h55] = 8'hff;
assign mul3[8'h56] = 8'hfa;
assign mul3[8'h57] = 8'hf9;
assign mul3[8'h58] = 8'he8;
assign mul3[8'h59] = 8'heb;
assign mul3[8'h5a] = 8'hee;
assign mul3[8'h5b] = 8'hed;
assign mul3[8'h5c] = 8'he4;
assign mul3[8'h5d] = 8'he7;
assign mul3[8'h5e] = 8'he2;
assign mul3[8'h5f] = 8'he1;
assign mul3[8'h60] = 8'ha0;
assign mul3[8'h61] = 8'ha3;
assign mul3[8'h62] = 8'ha6;
assign mul3[8'h63] = 8'ha5;
assign mul3[8'h64] = 8'hac;
assign mul3[8'h65] = 8'haf;
assign mul3[8'h66] = 8'haa;
assign mul3[8'h67] = 8'ha9;
assign mul3[8'h68] = 8'hb8;
assign mul3[8'h69] = 8'hbb;
assign mul3[8'h6a] = 8'hbe;
assign mul3[8'h6b] = 8'hbd;
assign mul3[8'h6c] = 8'hb4;
assign mul3[8'h6d] = 8'hb7;
assign mul3[8'h6e] = 8'hb2;
assign mul3[8'h6f] = 8'hb1;
assign mul3[8'h70] = 8'h90;
assign mul3[8'h71] = 8'h93;
assign mul3[8'h72] = 8'h96;
assign mul3[8'h73] = 8'h95;
assign mul3[8'h74] = 8'h9c;
assign mul3[8'h75] = 8'h9f;
assign mul3[8'h76] = 8'h9a;
assign mul3[8'h77] = 8'h99;
assign mul3[8'h78] = 8'h88;
assign mul3[8'h79] = 8'h8b;
assign mul3[8'h7a] = 8'h8e;
assign mul3[8'h7b] = 8'h8d;
assign mul3[8'h7c] = 8'h84;
assign mul3[8'h7d] = 8'h87;
assign mul3[8'h7e] = 8'h82;
assign mul3[8'h7f] = 8'h81;
assign mul3[8'h80] = 8'h9b;
assign mul3[8'h81] = 8'h98;
assign mul3[8'h82] = 8'h9d;
assign mul3[8'h83] = 8'h9e;
assign mul3[8'h84] = 8'h97;
assign mul3[8'h85] = 8'h94;
assign mul3[8'h86] = 8'h91;
assign mul3[8'h87] = 8'h92;
assign mul3[8'h88] = 8'h83;
assign mul3[8'h89] = 8'h80;
assign mul3[8'h8a] = 8'h85;
assign mul3[8'h8b] = 8'h86;
assign mul3[8'h8c] = 8'h8f;
assign mul3[8'h8d] = 8'h8c;
assign mul3[8'h8e] = 8'h89;
assign mul3[8'h8f] = 8'h8a;
assign mul3[8'h90] = 8'hab;
assign mul3[8'h91] = 8'ha8;
assign mul3[8'h92] = 8'had;
assign mul3[8'h93] = 8'hae;
assign mul3[8'h94] = 8'ha7;
assign mul3[8'h95] = 8'ha4;
assign mul3[8'h96] = 8'ha1;
assign mul3[8'h97] = 8'ha2;
assign mul3[8'h98] = 8'hb3;
assign mul3[8'h99] = 8'hb0;
assign mul3[8'h9a] = 8'hb5;
assign mul3[8'h9b] = 8'hb6;
assign mul3[8'h9c] = 8'hbf;
assign mul3[8'h9d] = 8'hbc;
assign mul3[8'h9e] = 8'hb9;
assign mul3[8'h9f] = 8'hba;
assign mul3[8'ha0] = 8'hfb;
assign mul3[8'ha1] = 8'hf8;
assign mul3[8'ha2] = 8'hfd;
assign mul3[8'ha3] = 8'hfe;
assign mul3[8'ha4] = 8'hf7;
assign mul3[8'ha5] = 8'hf4;
assign mul3[8'ha6] = 8'hf1;
assign mul3[8'ha7] = 8'hf2;
assign mul3[8'ha8] = 8'he3;
assign mul3[8'ha9] = 8'he0;
assign mul3[8'haa] = 8'he5;
assign mul3[8'hab] = 8'he6;
assign mul3[8'hac] = 8'hef;
assign mul3[8'had] = 8'hec;
assign mul3[8'hae] = 8'he9;
assign mul3[8'haf] = 8'hea;
assign mul3[8'hb0] = 8'hcb;
assign mul3[8'hb1] = 8'hc8;
assign mul3[8'hb2] = 8'hcd;
assign mul3[8'hb3] = 8'hce;
assign mul3[8'hb4] = 8'hc7;
assign mul3[8'hb5] = 8'hc4;
assign mul3[8'hb6] = 8'hc1;
assign mul3[8'hb7] = 8'hc2;
assign mul3[8'hb8] = 8'hd3;
assign mul3[8'hb9] = 8'hd0;
assign mul3[8'hba] = 8'hd5;
assign mul3[8'hbb] = 8'hd6;
assign mul3[8'hbc] = 8'hdf;
assign mul3[8'hbd] = 8'hdc;
assign mul3[8'hbe] = 8'hd9;
assign mul3[8'hbf] = 8'hda;
assign mul3[8'hc0] = 8'h5b;
assign mul3[8'hc1] = 8'h58;
assign mul3[8'hc2] = 8'h5d;
assign mul3[8'hc3] = 8'h5e;
assign mul3[8'hc4] = 8'h57;
assign mul3[8'hc5] = 8'h54;
assign mul3[8'hc6] = 8'h51;
assign mul3[8'hc7] = 8'h52;
assign mul3[8'hc8] = 8'h43;
assign mul3[8'hc9] = 8'h40;
assign mul3[8'hca] = 8'h45;
assign mul3[8'hcb] = 8'h46;
assign mul3[8'hcc] = 8'h4f;
assign mul3[8'hcd] = 8'h4c;
assign mul3[8'hce] = 8'h49;
assign mul3[8'hcf] = 8'h4a;
assign mul3[8'hd0] = 8'h6b;
assign mul3[8'hd1] = 8'h68;
assign mul3[8'hd2] = 8'h6d;
assign mul3[8'hd3] = 8'h6e;
assign mul3[8'hd4] = 8'h67;
assign mul3[8'hd5] = 8'h64;
assign mul3[8'hd6] = 8'h61;
assign mul3[8'hd7] = 8'h62;
assign mul3[8'hd8] = 8'h73;
assign mul3[8'hd9] = 8'h70;
assign mul3[8'hda] = 8'h75;
assign mul3[8'hdb] = 8'h76;
assign mul3[8'hdc] = 8'h7f;
assign mul3[8'hdd] = 8'h7c;
assign mul3[8'hde] = 8'h79;
assign mul3[8'hdf] = 8'h7a;
assign mul3[8'he0] = 8'h3b;
assign mul3[8'he1] = 8'h38;
assign mul3[8'he2] = 8'h3d;
assign mul3[8'he3] = 8'h3e;
assign mul3[8'he4] = 8'h37;
assign mul3[8'he5] = 8'h34;
assign mul3[8'he6] = 8'h31;
assign mul3[8'he7] = 8'h32;
assign mul3[8'he8] = 8'h23;
assign mul3[8'he9] = 8'h20;
assign mul3[8'hea] = 8'h25;
assign mul3[8'heb] = 8'h26;
assign mul3[8'hec] = 8'h2f;
assign mul3[8'hed] = 8'h2c;
assign mul3[8'hee] = 8'h29;
assign mul3[8'hef] = 8'h2a;
assign mul3[8'hf0] = 8'h0b;
assign mul3[8'hf1] = 8'h08;
assign mul3[8'hf2] = 8'h0d;
assign mul3[8'hf3] = 8'h0e;
assign mul3[8'hf4] = 8'h07;
assign mul3[8'hf5] = 8'h04;
assign mul3[8'hf6] = 8'h01;
assign mul3[8'hf7] = 8'h02;
assign mul3[8'hf8] = 8'h13;
assign mul3[8'hf9] = 8'h10;
assign mul3[8'hfa] = 8'h15;
assign mul3[8'hfb] = 8'h16;
assign mul3[8'hfc] = 8'h1f;
assign mul3[8'hfd] = 8'h1c;
assign mul3[8'hfe] = 8'h19;
assign mul3[8'hff] = 8'h1a;

assign sbox[8'h00] = 8'h63;
assign sbox[8'h01] = 8'h7c;
assign sbox[8'h02] = 8'h77;
assign sbox[8'h03] = 8'h7b;
assign sbox[8'h04] = 8'hf2;
assign sbox[8'h05] = 8'h6b;
assign sbox[8'h06] = 8'h6f;
assign sbox[8'h07] = 8'hc5;
assign sbox[8'h08] = 8'h30;
assign sbox[8'h09] = 8'h01;
assign sbox[8'h0a] = 8'h67;
assign sbox[8'h0b] = 8'h2b;
assign sbox[8'h0c] = 8'hfe;
assign sbox[8'h0d] = 8'hd7;
assign sbox[8'h0e] = 8'hab;
assign sbox[8'h0f] = 8'h76;
assign sbox[8'h10] = 8'hca;
assign sbox[8'h11] = 8'h82;
assign sbox[8'h12] = 8'hc9;
assign sbox[8'h13] = 8'h7d;
assign sbox[8'h14] = 8'hfa;
assign sbox[8'h15] = 8'h59;
assign sbox[8'h16] = 8'h47;
assign sbox[8'h17] = 8'hf0;
assign sbox[8'h18] = 8'had;
assign sbox[8'h19] = 8'hd4;
assign sbox[8'h1a] = 8'ha2;
assign sbox[8'h1b] = 8'haf;
assign sbox[8'h1c] = 8'h9c;
assign sbox[8'h1d] = 8'ha4;
assign sbox[8'h1e] = 8'h72;
assign sbox[8'h1f] = 8'hc0;
assign sbox[8'h20] = 8'hb7;
assign sbox[8'h21] = 8'hfd;
assign sbox[8'h22] = 8'h93;
assign sbox[8'h23] = 8'h26;
assign sbox[8'h24] = 8'h36;
assign sbox[8'h25] = 8'h3f;
assign sbox[8'h26] = 8'hf7;
assign sbox[8'h27] = 8'hcc;
assign sbox[8'h28] = 8'h34;
assign sbox[8'h29] = 8'ha5;
assign sbox[8'h2a] = 8'he5;
assign sbox[8'h2b] = 8'hf1;
assign sbox[8'h2c] = 8'h71;
assign sbox[8'h2d] = 8'hd8;
assign sbox[8'h2e] = 8'h31;
assign sbox[8'h2f] = 8'h15;
assign sbox[8'h30] = 8'h04;
assign sbox[8'h31] = 8'hc7;
assign sbox[8'h32] = 8'h23;
assign sbox[8'h33] = 8'hc3;
assign sbox[8'h34] = 8'h18;
assign sbox[8'h35] = 8'h96;
assign sbox[8'h36] = 8'h05;
assign sbox[8'h37] = 8'h9a;
assign sbox[8'h38] = 8'h07;
assign sbox[8'h39] = 8'h12;
assign sbox[8'h3a] = 8'h80;
assign sbox[8'h3b] = 8'he2;
assign sbox[8'h3c] = 8'heb;
assign sbox[8'h3d] = 8'h27;
assign sbox[8'h3e] = 8'hb2;
assign sbox[8'h3f] = 8'h75;
assign sbox[8'h40] = 8'h09;
assign sbox[8'h41] = 8'h83;
assign sbox[8'h42] = 8'h2c;
assign sbox[8'h43] = 8'h1a;
assign sbox[8'h44] = 8'h1b;
assign sbox[8'h45] = 8'h6e;
assign sbox[8'h46] = 8'h5a;
assign sbox[8'h47] = 8'ha0;
assign sbox[8'h48] = 8'h52;
assign sbox[8'h49] = 8'h3b;
assign sbox[8'h4a] = 8'hd6;
assign sbox[8'h4b] = 8'hb3;
assign sbox[8'h4c] = 8'h29;
assign sbox[8'h4d] = 8'he3;
assign sbox[8'h4e] = 8'h2f;
assign sbox[8'h4f] = 8'h84;
assign sbox[8'h50] = 8'h53;
assign sbox[8'h51] = 8'hd1;
assign sbox[8'h52] = 8'h00;
assign sbox[8'h53] = 8'hed;
assign sbox[8'h54] = 8'h20;
assign sbox[8'h55] = 8'hfc;
assign sbox[8'h56] = 8'hb1;
assign sbox[8'h57] = 8'h5b;
assign sbox[8'h58] = 8'h6a;
assign sbox[8'h59] = 8'hcb;
assign sbox[8'h5a] = 8'hbe;
assign sbox[8'h5b] = 8'h39;
assign sbox[8'h5c] = 8'h4a;
assign sbox[8'h5d] = 8'h4c;
assign sbox[8'h5e] = 8'h58;
assign sbox[8'h5f] = 8'hcf;
assign sbox[8'h60] = 8'hd0;
assign sbox[8'h61] = 8'hef;
assign sbox[8'h62] = 8'haa;
assign sbox[8'h63] = 8'hfb;
assign sbox[8'h64] = 8'h43;
assign sbox[8'h65] = 8'h4d;
assign sbox[8'h66] = 8'h33;
assign sbox[8'h67] = 8'h85;
assign sbox[8'h68] = 8'h45;
assign sbox[8'h69] = 8'hf9;
assign sbox[8'h6a] = 8'h02;
assign sbox[8'h6b] = 8'h7f;
assign sbox[8'h6c] = 8'h50;
assign sbox[8'h6d] = 8'h3c;
assign sbox[8'h6e] = 8'h9f;
assign sbox[8'h6f] = 8'ha8;
assign sbox[8'h70] = 8'h51;
assign sbox[8'h71] = 8'ha3;
assign sbox[8'h72] = 8'h40;
assign sbox[8'h73] = 8'h8f;
assign sbox[8'h74] = 8'h92;
assign sbox[8'h75] = 8'h9d;
assign sbox[8'h76] = 8'h38;
assign sbox[8'h77] = 8'hf5;
assign sbox[8'h78] = 8'hbc;
assign sbox[8'h79] = 8'hb6;
assign sbox[8'h7a] = 8'hda;
assign sbox[8'h7b] = 8'h21;
assign sbox[8'h7c] = 8'h10;
assign sbox[8'h7d] = 8'hff;
assign sbox[8'h7e] = 8'hf3;
assign sbox[8'h7f] = 8'hd2;
assign sbox[8'h80] = 8'hcd;
assign sbox[8'h81] = 8'h0c;
assign sbox[8'h82] = 8'h13;
assign sbox[8'h83] = 8'hec;
assign sbox[8'h84] = 8'h5f;
assign sbox[8'h85] = 8'h97;
assign sbox[8'h86] = 8'h44;
assign sbox[8'h87] = 8'h17;
assign sbox[8'h88] = 8'hc4;
assign sbox[8'h89] = 8'ha7;
assign sbox[8'h8a] = 8'h7e;
assign sbox[8'h8b] = 8'h3d;
assign sbox[8'h8c] = 8'h64;
assign sbox[8'h8d] = 8'h5d;
assign sbox[8'h8e] = 8'h19;
assign sbox[8'h8f] = 8'h73;
assign sbox[8'h90] = 8'h60;
assign sbox[8'h91] = 8'h81;
assign sbox[8'h92] = 8'h4f;
assign sbox[8'h93] = 8'hdc;
assign sbox[8'h94] = 8'h22;
assign sbox[8'h95] = 8'h2a;
assign sbox[8'h96] = 8'h90;
assign sbox[8'h97] = 8'h88;
assign sbox[8'h98] = 8'h46;
assign sbox[8'h99] = 8'hee;
assign sbox[8'h9a] = 8'hb8;
assign sbox[8'h9b] = 8'h14;
assign sbox[8'h9c] = 8'hde;
assign sbox[8'h9d] = 8'h5e;
assign sbox[8'h9e] = 8'h0b;
assign sbox[8'h9f] = 8'hdb;
assign sbox[8'ha0] = 8'he0;
assign sbox[8'ha1] = 8'h32;
assign sbox[8'ha2] = 8'h3a;
assign sbox[8'ha3] = 8'h0a;
assign sbox[8'ha4] = 8'h49;
assign sbox[8'ha5] = 8'h06;
assign sbox[8'ha6] = 8'h24;
assign sbox[8'ha7] = 8'h5c;
assign sbox[8'ha8] = 8'hc2;
assign sbox[8'ha9] = 8'hd3;
assign sbox[8'haa] = 8'hac;
assign sbox[8'hab] = 8'h62;
assign sbox[8'hac] = 8'h91;
assign sbox[8'had] = 8'h95;
assign sbox[8'hae] = 8'he4;
assign sbox[8'haf] = 8'h79;
assign sbox[8'hb0] = 8'he7;
assign sbox[8'hb1] = 8'hc8;
assign sbox[8'hb2] = 8'h37;
assign sbox[8'hb3] = 8'h6d;
assign sbox[8'hb4] = 8'h8d;
assign sbox[8'hb5] = 8'hd5;
assign sbox[8'hb6] = 8'h4e;
assign sbox[8'hb7] = 8'ha9;
assign sbox[8'hb8] = 8'h6c;
assign sbox[8'hb9] = 8'h56;
assign sbox[8'hba] = 8'hf4;
assign sbox[8'hbb] = 8'hea;
assign sbox[8'hbc] = 8'h65;
assign sbox[8'hbd] = 8'h7a;
assign sbox[8'hbe] = 8'hae;
assign sbox[8'hbf] = 8'h08;
assign sbox[8'hc0] = 8'hba;
assign sbox[8'hc1] = 8'h78;
assign sbox[8'hc2] = 8'h25;
assign sbox[8'hc3] = 8'h2e;
assign sbox[8'hc4] = 8'h1c;
assign sbox[8'hc5] = 8'ha6;
assign sbox[8'hc6] = 8'hb4;
assign sbox[8'hc7] = 8'hc6;
assign sbox[8'hc8] = 8'he8;
assign sbox[8'hc9] = 8'hdd;
assign sbox[8'hca] = 8'h74;
assign sbox[8'hcb] = 8'h1f;
assign sbox[8'hcc] = 8'h4b;
assign sbox[8'hcd] = 8'hbd;
assign sbox[8'hce] = 8'h8b;
assign sbox[8'hcf] = 8'h8a;
assign sbox[8'hd0] = 8'h70;
assign sbox[8'hd1] = 8'h3e;
assign sbox[8'hd2] = 8'hb5;
assign sbox[8'hd3] = 8'h66;
assign sbox[8'hd4] = 8'h48;
assign sbox[8'hd5] = 8'h03;
assign sbox[8'hd6] = 8'hf6;
assign sbox[8'hd7] = 8'h0e;
assign sbox[8'hd8] = 8'h61;
assign sbox[8'hd9] = 8'h35;
assign sbox[8'hda] = 8'h57;
assign sbox[8'hdb] = 8'hb9;
assign sbox[8'hdc] = 8'h86;
assign sbox[8'hdd] = 8'hc1;
assign sbox[8'hde] = 8'h1d;
assign sbox[8'hdf] = 8'h9e;
assign sbox[8'he0] = 8'he1;
assign sbox[8'he1] = 8'hf8;
assign sbox[8'he2] = 8'h98;
assign sbox[8'he3] = 8'h11;
assign sbox[8'he4] = 8'h69;
assign sbox[8'he5] = 8'hd9;
assign sbox[8'he6] = 8'h8e;
assign sbox[8'he7] = 8'h94;
assign sbox[8'he8] = 8'h9b;
assign sbox[8'he9] = 8'h1e;
assign sbox[8'hea] = 8'h87;
assign sbox[8'heb] = 8'he9;
assign sbox[8'hec] = 8'hce;
assign sbox[8'hed] = 8'h55;
assign sbox[8'hee] = 8'h28;
assign sbox[8'hef] = 8'hdf;
assign sbox[8'hf0] = 8'h8c;
assign sbox[8'hf1] = 8'ha1;
assign sbox[8'hf2] = 8'h89;
assign sbox[8'hf3] = 8'h0d;
assign sbox[8'hf4] = 8'hbf;
assign sbox[8'hf5] = 8'he6;
assign sbox[8'hf6] = 8'h42;
assign sbox[8'hf7] = 8'h68;
assign sbox[8'hf8] = 8'h41;
assign sbox[8'hf9] = 8'h99;
assign sbox[8'hfa] = 8'h2d;
assign sbox[8'hfb] = 8'h0f;
assign sbox[8'hfc] = 8'hb0;
assign sbox[8'hfd] = 8'h54;
assign sbox[8'hfe] = 8'hbb;
assign sbox[8'hff] = 8'h16;
    
/* always block to update state every 1 clock cycle */   
always @ (posedge clk or negedge rst)begin
    if(!rst)
        curr_state <=  0;
    else
        curr_state <=  next_state;
end    
 
always @(curr_state or start or dstart or enc_dec)begin
    case(curr_state)
    0: begin
        ledDone = 0;    
        encDone = 0;
        if(enc_dec == 2'b01)begin        
            next_state = 1; 
        end 
//        else begin
//            next_state = 0;
//        end
     end
    1: begin
       if(start) begin
            next_state = 145;
       end
     end  
    145: begin
        if(start) begin
             next_state = 146;
        end
      end  
     146:begin
        if(start) begin
          next_state = 147;
     end
         end         
     147:begin
       if(start) begin
          next_state = 148;
     end     
     end
    148: begin
        if(start) begin
             next_state = 149;
        end
      end  
     149:begin
       if(start) begin
          next_state = 150;
         end
     end
     150:begin
            if(start) begin
     next_state = 151;
     end
     end 
     151:begin
            if(start) begin
              k[59] = keyIn[31:0];k[58] = keyIn[63:32];k[57] = keyIn[95:64];k[56] = keyIn[127:96];
              k[55] = keyIn[159:128];k[54] = keyIn[191:160];k[53] = keyIn[223:192];k[52] = keyIn[255:224];

        next_state = 152;
        end
     end
     152:begin
            if(start) begin
              k[51] = keyIn[287:256];k[50] = keyIn[319:288];k[49] = keyIn[351:320];k[48] = keyIn[383:352];
              k[47] = keyIn[415:384];k[46] = keyIn[447:416];k[45] = keyIn[479:448];k[44] = keyIn[511:480]; 
              next_state = 153;
                  end
     end
     153:begin
            if(start) begin
        k[43] = keyIn[543:512];k[42] = keyIn[575:544];k[41] = keyIn[607:576];k[40] = keyIn[639:608];
        k[39] = keyIn[671:640];k[38] = keyIn[703:672];k[37] = keyIn[735:704];k[36] = keyIn[767:736];
        next_state = 154;
        end
     end
     154:begin
       if(start) begin
             k[35] = keyIn[799:768];k[34] = keyIn[831:800];k[33] = keyIn[863:832];k[32] = keyIn[895:864];
             k[31] = keyIn[927:896];k[30] = keyIn[959:928];k[29] = keyIn[991:960];k[28] = keyIn[1023:992];
     next_state = 155;
     end
     end     
     155:begin
       if(start) begin
              k[27] = keyIn[1055:1024];k[26] = keyIn[1087:1056];k[25] = keyIn[1119:1088];k[24] = keyIn[1151:1120];
              k[23] = keyIn[1183:1152];k[22] = keyIn[1215:1184];k[21] = keyIn[1247:1216];k[20] = keyIn[1279:1248];
        next_state = 156;
        end
     end
     156:begin
                if(start) begin
         k[19] = keyIn[1311:1280];k[18] = keyIn[1343:1312];k[17] = keyIn[1375:1344];k[16] = keyIn[1407:1376];
         k[15] = keyIn[1439:1408];k[14] = keyIn[1471:1440];k[13] = keyIn[1503:1472];k[12] = keyIn[1535:1504];
     next_state = 2;
     end
     end
    2:begin
//         if(start) begin

           if(start) begin
            k[11] = keyIn[1567:1536];k[10] = keyIn[1599:1568];k[9] = keyIn[1631:1600];k[8] = keyIn[1663:1632];
            k[7] = keyIn[1695:1664];k[6] = keyIn[1727:1696];k[5] = keyIn[1759:1728];k[4] = keyIn[1791:1760];
            k[3] = keyIn[1823:1792];k[2] = keyIn[1855:1824];k[1] = keyIn[1887:1856];k[0] = keyIn[1919:1888];
            
           // w[0] = 32'h00112233;w[1] = 32'h44556677;w[2] = 32'h8899aabb;w[3] = 32'hccddeeff;
            next_state = 157;
            end
          end  
          157:begin
          if(dstart) begin
            w[3] = dataIn[31:0];
                      w[2] = dataIn[63:32];
                      w[1] = dataIn[95:64];
                      w[0] = dataIn[127:96];
          next_state = 3;
          end
          end  
    //end
    3:begin
          /* round[0].input => w[n] */
          /* round[0].sch => k[n] */
          /* round[1].start => tempStart[n] */
          /* round[1].start = round[0].input XOR round[0].k_sch */
          tempStart[0] = w[0] ^ k[0];
          tempStart[1] = w[1] ^ k[1];
          tempStart[2] = w[2] ^ k[2];
          tempStart[3] = w[3] ^ k[3];
          next_state =  4;         
      end
      4:begin // Round1 Sbox
          /* round[1].s_box => tempSbox[n] */
          tempSbox[0] = sbox[tempStart[0][31:24]];tempSbox[1] = sbox[tempStart[0][23:16]];tempSbox[2] = sbox[tempStart[0][15:8]];tempSbox[3] = sbox[tempStart[0][7:0]];
          tempSbox[4] = sbox[tempStart[1][31:24]];tempSbox[5] = sbox[tempStart[1][23:16]];tempSbox[6] = sbox[tempStart[1][15:8]];tempSbox[7] = sbox[tempStart[1][7:0]];
          tempSbox[8] = sbox[tempStart[2][31:24]];tempSbox[9] = sbox[tempStart[2][23:16]];tempSbox[10] = sbox[tempStart[2][15:8]];tempSbox[11] = sbox[tempStart[2][7:0]];
          tempSbox[12] = sbox[tempStart[3][31:24]];tempSbox[13] = sbox[tempStart[3][23:16]];tempSbox[14] = sbox[tempStart[3][15:8]];tempSbox[15] = sbox[tempStart[3][7:0]];
          next_state = 5;
      end
      5:begin // Round1 shift row
         /* round[1].s_row => tempRow[n] */
          tempRow[0] = tempSbox[0];tempRow[1] = tempSbox[5];tempRow[2] = tempSbox[10];tempRow[3] = tempSbox[15];
          tempRow[4] = tempSbox[4];tempRow[5] = tempSbox[9];tempRow[6] = tempSbox[14];tempRow[7] = tempSbox[3];
          tempRow[8] = tempSbox[8];tempRow[9] = tempSbox[13];tempRow[10] = tempSbox[2];tempRow[11] = tempSbox[7];
          tempRow[12] = tempSbox[12];tempRow[13] = tempSbox[1];tempRow[14] = tempSbox[6];tempRow[15] = tempSbox[11];
          next_state = 6;
      end
      6:begin // Round1 mix column
          d[0] =  mul2[tempRow[0]] ^ mul3[tempRow[1]] ^ tempRow[2] ^ tempRow[3];//s
          d[1] =  tempRow[0] ^ mul2[tempRow[1]] ^ mul3[tempRow[2]] ^ tempRow[3];//s
          d[2] =  tempRow[0] ^ tempRow[1] ^ mul2[tempRow[2]] ^ mul3[tempRow[3]];//s
          d[3] =  mul3[tempRow[0]] ^ tempRow[1] ^ tempRow[2] ^ mul2[tempRow[3]];//s
          d[4] =  mul2[tempRow[4]] ^ mul3[tempRow[5]] ^ tempRow[6] ^ tempRow[7];//state4
          d[5] =  tempRow[4] ^ mul2[tempRow[5]] ^ mul3[tempRow[6]] ^ tempRow[7];//state5
          d[6] =  tempRow[4] ^ tempRow[5] ^ mul2[tempRow[6]] ^ mul3[tempRow[7]];//state6
          d[7] =  mul3[tempRow[4]] ^ tempRow[5] ^ tempRow[6] ^ mul2[tempRow[7]];//state7
          d[8] =  mul2[tempRow[8]] ^ mul3[tempRow[9]] ^ tempRow[10] ^ tempRow[11];//state8
          d[9] =  tempRow[8] ^ mul2[tempRow[9]] ^ mul3[tempRow[10]] ^ tempRow[11];//state9
          d[10] = tempRow[8] ^ tempRow[9] ^ mul2[tempRow[10]] ^ mul3[tempRow[11]];//state10
          d[11] = mul3[tempRow[8]] ^ tempRow[9] ^ tempRow[10] ^ mul2[tempRow[11]];//state11
          d[12] = mul2[tempRow[12]] ^ mul3[tempRow[13]] ^ tempRow[14] ^ tempRow[15];//state12
          d[13] = tempRow[12] ^ mul2[tempRow[13]] ^ mul3[tempRow[14]] ^ tempRow[15];//state13
          d[14] = tempRow[12] ^ tempRow[13] ^ mul2[tempRow[14]] ^ mul3[tempRow[15]];//state14
          d[15] = mul3[tempRow[12]] ^ tempRow[13] ^ tempRow[14] ^ mul2[tempRow[15]];//state15
          next_state = 7;
      end
  
      7:begin
          /* round[1].m_col => w1[0] */
           w1[0] = {d[0],d[1],d[2],d[3]};
           w1[1] = {d[4],d[5],d[6],d[7]};
           w1[2] = {d[8],d[9],d[10],d[11]};
           w1[3] = {d[12],d[13],d[14],d[15]};
           next_state = 8;
       end
     8:begin // Round1 Add round key
          /* round[1].input => w1[n] */
          /* round[1].sch => k[n] */
          /* round[2].start => tempStart1[n] */
          /* round[2].start = round[0].input XOR round[0].k_sch */
          tempStart1[0] = w1[0] ^ k[4];
          tempStart1[1] = w1[1] ^ k[5];
          tempStart1[2] = w1[2] ^ k[6];
          tempStart1[3] = w1[3] ^ k[7];
          next_state =  9;         
      end
      9:begin //Round2 Sbox
          /* round[2].s_box => tempSbox1[n] */
          tempSbox1[0] = sbox[tempStart1[0][31:24]];tempSbox1[1] = sbox[tempStart1[0][23:16]];tempSbox1[2] = sbox[tempStart1[0][15:8]];tempSbox1[3] = sbox[tempStart1[0][7:0]];
          tempSbox1[4] = sbox[tempStart1[1][31:24]];tempSbox1[5] = sbox[tempStart1[1][23:16]];tempSbox1[6] = sbox[tempStart1[1][15:8]];tempSbox1[7] = sbox[tempStart1[1][7:0]];
          tempSbox1[8] = sbox[tempStart1[2][31:24]];tempSbox1[9] = sbox[tempStart1[2][23:16]];tempSbox1[10] = sbox[tempStart1[2][15:8]];tempSbox1[11] = sbox[tempStart1[2][7:0]];
          tempSbox1[12] = sbox[tempStart1[3][31:24]];tempSbox1[13] = sbox[tempStart1[3][23:16]];tempSbox1[14] = sbox[tempStart1[3][15:8]];tempSbox1[15] = sbox[tempStart1[3][7:0]];
          next_state = 10;
      end
      10:begin //Round2 Shift row
         /* round[2].s_row => tempRow1[n] */
          tempRow1[0] = tempSbox1[0];tempRow1[1] = tempSbox1[5];tempRow1[2] = tempSbox1[10];tempRow1[3] = tempSbox1[15];
          tempRow1[4] = tempSbox1[4];tempRow1[5] = tempSbox1[9];tempRow1[6] = tempSbox1[14];tempRow1[7] = tempSbox1[3];
          tempRow1[8] = tempSbox1[8];tempRow1[9] = tempSbox1[13];tempRow1[10] = tempSbox1[2];tempRow1[11] = tempSbox1[7];
          tempRow1[12] = tempSbox1[12];tempRow1[13] = tempSbox1[1];tempRow1[14] = tempSbox1[6];tempRow1[15] = tempSbox1[11];
          next_state = 11;
      end
      11:begin // Round2 mix column
          d1[0] =  mul2[tempRow1[0]] ^ mul3[tempRow1[1]] ^ tempRow1[2] ^ tempRow1[3];//s
          d1[1] =  tempRow1[0] ^ mul2[tempRow1[1]] ^ mul3[tempRow1[2]] ^ tempRow1[3];//s
          d1[2] =  tempRow1[0] ^ tempRow1[1] ^ mul2[tempRow1[2]] ^ mul3[tempRow1[3]];//s
          d1[3] =  mul3[tempRow1[0]] ^ tempRow1[1] ^ tempRow1[2] ^ mul2[tempRow1[3]];//s
          d1[4] =  mul2[tempRow1[4]] ^ mul3[tempRow1[5]] ^ tempRow1[6] ^ tempRow1[7];//state4
          d1[5] =  tempRow1[4] ^ mul2[tempRow1[5]] ^ mul3[tempRow1[6]] ^ tempRow1[7];//state5
          d1[6] =  tempRow1[4] ^ tempRow1[5] ^ mul2[tempRow1[6]] ^ mul3[tempRow1[7]];//state6
          d1[7] =  mul3[tempRow1[4]] ^ tempRow1[5] ^ tempRow1[6] ^ mul2[tempRow1[7]];//state7
          d1[8] =  mul2[tempRow1[8]] ^ mul3[tempRow1[9]] ^ tempRow1[10] ^ tempRow1[11];//state8
          d1[9] =  tempRow1[8] ^ mul2[tempRow1[9]] ^ mul3[tempRow1[10]] ^ tempRow1[11];//state9
          d1[10] = tempRow1[8] ^ tempRow1[9] ^ mul2[tempRow1[10]] ^ mul3[tempRow1[11]];//state10
          d1[11] = mul3[tempRow1[8]] ^ tempRow1[9] ^ tempRow1[10] ^ mul2[tempRow1[11]];//state11
          d1[12] = mul2[tempRow1[12]] ^ mul3[tempRow1[13]] ^ tempRow1[14] ^ tempRow1[15];//state12
          d1[13] = tempRow1[12] ^ mul2[tempRow1[13]] ^ mul3[tempRow1[14]] ^ tempRow1[15];//state13
          d1[14] = tempRow1[12] ^ tempRow1[13] ^ mul2[tempRow1[14]] ^ mul3[tempRow1[15]];//state14
          d1[15] = mul3[tempRow1[12]] ^ tempRow1[13] ^ tempRow1[14] ^ mul2[tempRow1[15]];//state15
          next_state = 12;
      end
      12:begin 
          /* round[2].m_col => w2[0] */
           w2[0] = {d1[0],d1[1],d1[2],d1[3]};
           w2[1] = {d1[4],d1[5],d1[6],d1[7]};
           w2[2] = {d1[8],d1[9],d1[10],d1[11]};
           w2[3] = {d1[12],d1[13],d1[14],d1[15]};
           next_state = 13;
       end
     13:begin // Round2 Add round key
          /* round[2].input => w2[n] */
          /* round[2].sch => k[n] */
          /* round[3].start => tempStart2[n] */
          /* round[3].start = round[2].input XOR round[2].k_sch */
          tempStart2[0] = w2[0] ^ k[8];
          tempStart2[1] = w2[1] ^ k[9];
          tempStart2[2] = w2[2] ^ k[10];
          tempStart2[3] = w2[3] ^ k[11];
          next_state =  14;         
      end
      14:begin //Round3 Sbox
          /* round[3].s_box => tempSbox2[n] */
          tempSbox2[0] = sbox[tempStart2[0][31:24]];tempSbox2[1] = sbox[tempStart2[0][23:16]];tempSbox2[2] = sbox[tempStart2[0][15:8]];tempSbox2[3] = sbox[tempStart2[0][7:0]];
          tempSbox2[4] = sbox[tempStart2[1][31:24]];tempSbox2[5] = sbox[tempStart2[1][23:16]];tempSbox2[6] = sbox[tempStart2[1][15:8]];tempSbox2[7] = sbox[tempStart2[1][7:0]];
          tempSbox2[8] = sbox[tempStart2[2][31:24]];tempSbox2[9] = sbox[tempStart2[2][23:16]];tempSbox2[10] = sbox[tempStart2[2][15:8]];tempSbox2[11] = sbox[tempStart2[2][7:0]];
          tempSbox2[12] = sbox[tempStart2[3][31:24]];tempSbox2[13] = sbox[tempStart2[3][23:16]];tempSbox2[14] = sbox[tempStart2[3][15:8]];tempSbox2[15] = sbox[tempStart2[3][7:0]];
          next_state = 15;
      end
      15:begin //Round3 Shift row
         /* round[3].s_row => tempRow2[n] */
          tempRow2[0] = tempSbox2[0];tempRow2[1] = tempSbox2[5];tempRow2[2] = tempSbox2[10];tempRow2[3] = tempSbox2[15];
          tempRow2[4] = tempSbox2[4];tempRow2[5] = tempSbox2[9];tempRow2[6] = tempSbox2[14];tempRow2[7] = tempSbox2[3];
          tempRow2[8] = tempSbox2[8];tempRow2[9] = tempSbox2[13];tempRow2[10] = tempSbox2[2];tempRow2[11] = tempSbox2[7];
          tempRow2[12] = tempSbox2[12];tempRow2[13] = tempSbox2[1];tempRow2[14] = tempSbox2[6];tempRow2[15] = tempSbox2[11];
          next_state = 16;
      end    
     16:begin //Round3 Mix column
          d2[0] =  mul2[tempRow2[0]] ^ mul3[tempRow2[1]] ^ tempRow2[2] ^ tempRow2[3];//state0
          d2[1] =  tempRow2[0] ^ mul2[tempRow2[1]] ^ mul3[tempRow2[2]] ^ tempRow2[3];//state1
          d2[2] =  tempRow2[0] ^ tempRow2[1] ^ mul2[tempRow2[2]] ^ mul3[tempRow2[3]];//state2
          d2[3] =  mul3[tempRow2[0]] ^ tempRow2[1] ^ tempRow2[2] ^ mul2[tempRow2[3]];//state3
          d2[4] =  mul2[tempRow2[4]] ^ mul3[tempRow2[5]] ^ tempRow2[6] ^ tempRow2[7];//state4
          d2[5] =  tempRow2[4] ^ mul2[tempRow2[5]] ^ mul3[tempRow2[6]] ^ tempRow2[7];//state5
          d2[6] =  tempRow2[4] ^ tempRow2[5] ^ mul2[tempRow2[6]] ^ mul3[tempRow2[7]];//state6
          d2[7] =  mul3[tempRow2[4]] ^ tempRow2[5] ^ tempRow2[6] ^ mul2[tempRow2[7]];//state7
          d2[8] =  mul2[tempRow2[8]] ^ mul3[tempRow2[9]] ^ tempRow2[10] ^ tempRow2[11];//state8
          d2[9] =  tempRow2[8] ^ mul2[tempRow2[9]] ^ mul3[tempRow2[10]] ^ tempRow2[11];//state9
          d2[10] = tempRow2[8] ^ tempRow2[9] ^ mul2[tempRow2[10]] ^ mul3[tempRow2[11]];//state10
          d2[11] = mul3[tempRow2[8]] ^ tempRow2[9] ^ tempRow2[10] ^ mul2[tempRow2[11]];//state11
          d2[12] = mul2[tempRow2[12]] ^ mul3[tempRow2[13]] ^ tempRow2[14] ^ tempRow2[15];//state12
          d2[13] = tempRow2[12] ^ mul2[tempRow2[13]] ^ mul3[tempRow2[14]] ^ tempRow2[15];//state13
          d2[14] = tempRow2[12] ^ tempRow2[13] ^ mul2[tempRow2[14]] ^ mul3[tempRow2[15]];//state14
          d2[15] = mul3[tempRow2[12]] ^ tempRow2[13] ^ tempRow2[14] ^ mul2[tempRow2[15]];//state15                
          next_state = 17;
      end
      17:begin 
          /* round[3].m_col => w3[0] */
           w3[0] = {d2[0],d2[1],d2[2],d2[3]};
           w3[1] = {d2[4],d2[5],d2[6],d2[7]};
           w3[2] = {d2[8],d2[9],d2[10],d2[11]};
           w3[3] = {d2[12],d2[13],d2[14],d2[15]};
           next_state = 18;
       end
     18:begin // Round3 Add round key
          /* round[3].input => w3[n] */
          /* round[3].sch => k[n] */
          /* round[4].start => tempStart3[n] */
          /* round[4].start = round[2].input XOR round[2].k_sch */
          tempStart3[0] = w3[0] ^ k[12];
          tempStart3[1] = w3[1] ^ k[13];
          tempStart3[2] = w3[2] ^ k[14];
          tempStart3[3] = w3[3] ^ k[15];
          next_state =  19;         
      end
      19:begin // Round4 Sbox
          /* round[4].s_box => tempSbox3[n] */
          tempSbox3[0] = sbox[tempStart3[0][31:24]];tempSbox3[1] = sbox[tempStart3[0][23:16]];tempSbox3[2] = sbox[tempStart3[0][15:8]];tempSbox3[3] = sbox[tempStart3[0][7:0]];
          tempSbox3[4] = sbox[tempStart3[1][31:24]];tempSbox3[5] = sbox[tempStart3[1][23:16]];tempSbox3[6] = sbox[tempStart3[1][15:8]];tempSbox3[7] = sbox[tempStart3[1][7:0]];
          tempSbox3[8] = sbox[tempStart3[2][31:24]];tempSbox3[9] = sbox[tempStart3[2][23:16]];tempSbox3[10] = sbox[tempStart3[2][15:8]];tempSbox3[11] = sbox[tempStart3[2][7:0]];
          tempSbox3[12] = sbox[tempStart3[3][31:24]];tempSbox3[13] = sbox[tempStart3[3][23:16]];tempSbox3[14] = sbox[tempStart3[3][15:8]];tempSbox3[15] = sbox[tempStart3[3][7:0]];
          next_state = 20;
      end
      20:begin // Round4 shift row
         /* round[4].s_row => tempRow3[n] */
          tempRow3[0] = tempSbox3[0];tempRow3[1] = tempSbox3[5];tempRow3[2] = tempSbox3[10];tempRow3[3] = tempSbox3[15];
          tempRow3[4] = tempSbox3[4];tempRow3[5] = tempSbox3[9];tempRow3[6] = tempSbox3[14];tempRow3[7] = tempSbox3[3];
          tempRow3[8] = tempSbox3[8];tempRow3[9] = tempSbox3[13];tempRow3[10] = tempSbox3[2];tempRow3[11] = tempSbox3[7];
          tempRow3[12] = tempSbox3[12];tempRow3[13] = tempSbox3[1];tempRow3[14] = tempSbox3[6];tempRow3[15] = tempSbox3[11];
          next_state = 21;
      end    
     21:begin
          d3[0] =  mul2[tempRow3[0]] ^ mul3[tempRow3[1]] ^ tempRow3[2] ^ tempRow3[3];//state0
          d3[1] =  tempRow3[0] ^ mul2[tempRow3[1]] ^ mul3[tempRow3[2]] ^ tempRow3[3];//state1
          d3[2] =  tempRow3[0] ^ tempRow3[1] ^ mul2[tempRow3[2]] ^ mul3[tempRow3[3]];//state2
          d3[3] =  mul3[tempRow3[0]] ^ tempRow3[1] ^ tempRow3[2] ^ mul2[tempRow3[3]];//state3
          d3[4] =  mul2[tempRow3[4]] ^ mul3[tempRow3[5]] ^ tempRow3[6] ^ tempRow3[7];//state4
          d3[5] =  tempRow3[4] ^ mul2[tempRow3[5]] ^ mul3[tempRow3[6]] ^ tempRow3[7];//state5
          d3[6] =  tempRow3[4] ^ tempRow3[5] ^ mul2[tempRow3[6]] ^ mul3[tempRow3[7]];//state6
          d3[7] =  mul3[tempRow3[4]] ^ tempRow3[5] ^ tempRow3[6] ^ mul2[tempRow3[7]];//state7
          d3[8] =  mul2[tempRow3[8]] ^ mul3[tempRow3[9]] ^ tempRow3[10] ^ tempRow3[11];//state8
          d3[9] =  tempRow3[8] ^ mul2[tempRow3[9]] ^ mul3[tempRow3[10]] ^ tempRow3[11];//state9
          d3[10] = tempRow3[8] ^ tempRow3[9] ^ mul2[tempRow3[10]] ^ mul3[tempRow3[11]];//state10
          d3[11] = mul3[tempRow3[8]] ^ tempRow3[9] ^ tempRow3[10] ^ mul2[tempRow3[11]];//state11
          d3[12] = mul2[tempRow3[12]] ^ mul3[tempRow3[13]] ^ tempRow3[14] ^ tempRow3[15];//state12
          d3[13] = tempRow3[12] ^ mul2[tempRow3[13]] ^ mul3[tempRow3[14]] ^ tempRow3[15];//state13
          d3[14] = tempRow3[12] ^ tempRow3[13] ^ mul2[tempRow3[14]] ^ mul3[tempRow3[15]];//state14
          d3[15] = mul3[tempRow3[12]] ^ tempRow3[13] ^ tempRow3[14] ^ mul2[tempRow3[15]];//state15                 
          next_state = 22;
      end
      22:begin
          /* round[4].m_col => w4[0] */
           w4[0] = {d3[0],d3[1],d3[2],d3[3]};
           w4[1] = {d3[4],d3[5],d3[6],d3[7]};
           w4[2] = {d3[8],d3[9],d3[10],d3[11]};
           w4[3] = {d3[12],d3[13],d3[14],d3[15]};
           next_state = 23;
       end
     23:begin
          /* round[4].input => w4[n] */
          /* round[4].sch => k[n] */
          /* round[5].start => tempStart4[n] */
          /* round[5].start = round[2].input XOR round[2].k_sch */
          tempStart4[0] = w4[0] ^ k[16];
          tempStart4[1] = w4[1] ^ k[17];
          tempStart4[2] = w4[2] ^ k[18];
          tempStart4[3] = w4[3] ^ k[19];
          next_state =  24;         
      end
      24:begin
          /* round[5].s_box => tempSbox4[n] */
          tempSbox4[0] = sbox[tempStart4[0][31:24]];tempSbox4[1] = sbox[tempStart4[0][23:16]];tempSbox4[2] = sbox[tempStart4[0][15:8]];tempSbox4[3] = sbox[tempStart4[0][7:0]];
          tempSbox4[4] = sbox[tempStart4[1][31:24]];tempSbox4[5] = sbox[tempStart4[1][23:16]];tempSbox4[6] = sbox[tempStart4[1][15:8]];tempSbox4[7] = sbox[tempStart4[1][7:0]];
          tempSbox4[8] = sbox[tempStart4[2][31:24]];tempSbox4[9] = sbox[tempStart4[2][23:16]];tempSbox4[10] = sbox[tempStart4[2][15:8]];tempSbox4[11] = sbox[tempStart4[2][7:0]];
          tempSbox4[12] = sbox[tempStart4[3][31:24]];tempSbox4[13] = sbox[tempStart4[3][23:16]];tempSbox4[14] = sbox[tempStart4[3][15:8]];tempSbox4[15] = sbox[tempStart4[3][7:0]];
          next_state = 25;
      end
      25:begin
         /* round[5].s_row => tempRow4[n] */
          tempRow4[0] = tempSbox4[0];tempRow4[1] = tempSbox4[5];tempRow4[2] = tempSbox4[10];tempRow4[3] = tempSbox4[15];
          tempRow4[4] = tempSbox4[4];tempRow4[5] = tempSbox4[9];tempRow4[6] = tempSbox4[14];tempRow4[7] = tempSbox4[3];
          tempRow4[8] = tempSbox4[8];tempRow4[9] = tempSbox4[13];tempRow4[10] = tempSbox4[2];tempRow4[11] = tempSbox4[7];
          tempRow4[12] = tempSbox4[12];tempRow4[13] = tempSbox4[1];tempRow4[14] = tempSbox4[6];tempRow4[15] = tempSbox4[11];
          next_state = 26;
      end    
     26:begin
          d4[0] =  mul2[tempRow4[0]] ^ mul3[tempRow4[1]] ^ tempRow4[2] ^ tempRow4[3];//state0
          d4[1] =  tempRow4[0] ^ mul2[tempRow4[1]] ^ mul3[tempRow4[2]] ^ tempRow4[3];//state1
          d4[2] =  tempRow4[0] ^ tempRow4[1] ^ mul2[tempRow4[2]] ^ mul3[tempRow4[3]];//state2
          d4[3] =  mul3[tempRow4[0]] ^ tempRow4[1] ^ tempRow4[2] ^ mul2[tempRow4[3]];//state3
          d4[4] =  mul2[tempRow4[4]] ^ mul3[tempRow4[5]] ^ tempRow4[6] ^ tempRow4[7];//state4
          d4[5] =  tempRow4[4] ^ mul2[tempRow4[5]] ^ mul3[tempRow4[6]] ^ tempRow4[7];//state5
          d4[6] =  tempRow4[4] ^ tempRow4[5] ^ mul2[tempRow4[6]] ^ mul3[tempRow4[7]];//state6
          d4[7] =  mul3[tempRow4[4]] ^ tempRow4[5] ^ tempRow4[6] ^ mul2[tempRow4[7]];//state7
          d4[8] =  mul2[tempRow4[8]] ^ mul3[tempRow4[9]] ^ tempRow4[10] ^ tempRow4[11];//state8
          d4[9] =  tempRow4[8] ^ mul2[tempRow4[9]] ^ mul3[tempRow4[10]] ^ tempRow4[11];//state9
          d4[10] = tempRow4[8] ^ tempRow4[9] ^ mul2[tempRow4[10]] ^ mul3[tempRow4[11]];//state10
          d4[11] = mul3[tempRow4[8]] ^ tempRow4[9] ^ tempRow4[10] ^ mul2[tempRow4[11]];//state11
          d4[12] = mul2[tempRow4[12]] ^ mul3[tempRow4[13]] ^ tempRow4[14] ^ tempRow4[15];//state12
          d4[13] = tempRow4[12] ^ mul2[tempRow4[13]] ^ mul3[tempRow4[14]] ^ tempRow4[15];//state13
          d4[14] = tempRow4[12] ^ tempRow4[13] ^ mul2[tempRow4[14]] ^ mul3[tempRow4[15]];//state14
          d4[15] = mul3[tempRow4[12]] ^ tempRow4[13] ^ tempRow4[14] ^ mul2[tempRow4[15]];//state15                 
          next_state = 27;
          end
      27:begin
          /* round[5].m_col => w5[0] */
           w5[0] = {d4[0],d4[1],d4[2],d4[3]};
           w5[1] = {d4[4],d4[5],d4[6],d4[7]};
           w5[2] = {d4[8],d4[9],d4[10],d4[11]};
           w5[3] = {d4[12],d4[13],d4[14],d4[15]};
           next_state = 28;
       end
     28:begin
          /* round[5].input => w5[n] */
          /* round[5].sch => k[n] */
          /* round[6].start => tempStart5[n] */
          /* round[6].start = round[5].input XOR round[5].k_sch */
          tempStart5[0] = w5[0] ^ k[20];
          tempStart5[1] = w5[1] ^ k[21];
          tempStart5[2] = w5[2] ^ k[22];
          tempStart5[3] = w5[3] ^ k[23];
          next_state =  29;         
      end
      29:begin
          /* round[6].s_box => tempSbox5[n] */
          tempSbox5[0] = sbox[tempStart5[0][31:24]];tempSbox5[1] = sbox[tempStart5[0][23:16]];tempSbox5[2] = sbox[tempStart5[0][15:8]];tempSbox5[3] = sbox[tempStart5[0][7:0]];
          tempSbox5[4] = sbox[tempStart5[1][31:24]];tempSbox5[5] = sbox[tempStart5[1][23:16]];tempSbox5[6] = sbox[tempStart5[1][15:8]];tempSbox5[7] = sbox[tempStart5[1][7:0]];
          tempSbox5[8] = sbox[tempStart5[2][31:24]];tempSbox5[9] = sbox[tempStart5[2][23:16]];tempSbox5[10] = sbox[tempStart5[2][15:8]];tempSbox5[11] = sbox[tempStart5[2][7:0]];
          tempSbox5[12] = sbox[tempStart5[3][31:24]];tempSbox5[13] = sbox[tempStart5[3][23:16]];tempSbox5[14] = sbox[tempStart5[3][15:8]];tempSbox5[15] = sbox[tempStart5[3][7:0]];
          next_state = 30;
      end
      30:begin
         /* round[6].s_row => tempRow5[n] */
          tempRow5[0] = tempSbox5[0];tempRow5[1] = tempSbox5[5];tempRow5[2] = tempSbox5[10];tempRow5[3] = tempSbox5[15];
          tempRow5[4] = tempSbox5[4];tempRow5[5] = tempSbox5[9];tempRow5[6] = tempSbox5[14];tempRow5[7] = tempSbox5[3];
          tempRow5[8] = tempSbox5[8];tempRow5[9] = tempSbox5[13];tempRow5[10] = tempSbox5[2];tempRow5[11] = tempSbox5[7];
          tempRow5[12] = tempSbox5[12];tempRow5[13] = tempSbox5[1];tempRow5[14] = tempSbox5[6];tempRow5[15] = tempSbox5[11];
          next_state = 31;
      end    
     31:begin
          d5[0] =  mul2[tempRow5[0]] ^ mul3[tempRow5[1]] ^ tempRow5[2] ^ tempRow5[3];//state0
          d5[1] =  tempRow5[0] ^ mul2[tempRow5[1]] ^ mul3[tempRow5[2]] ^ tempRow5[3];//state1
          d5[2] =  tempRow5[0] ^ tempRow5[1] ^ mul2[tempRow5[2]] ^ mul3[tempRow5[3]];//state2
          d5[3] =  mul3[tempRow5[0]] ^ tempRow5[1] ^ tempRow5[2] ^ mul2[tempRow5[3]];//state3
          d5[4] =  mul2[tempRow5[4]] ^ mul3[tempRow5[5]] ^ tempRow5[6] ^ tempRow5[7];//state4
          d5[5] =  tempRow5[4] ^ mul2[tempRow5[5]] ^ mul3[tempRow5[6]] ^ tempRow5[7];//state5
          d5[6] =  tempRow5[4] ^ tempRow5[5] ^ mul2[tempRow5[6]] ^ mul3[tempRow5[7]];//state6
          d5[7] =  mul3[tempRow5[4]] ^ tempRow5[5] ^ tempRow5[6] ^ mul2[tempRow5[7]];//state7
          d5[8] =  mul2[tempRow5[8]] ^ mul3[tempRow5[9]] ^ tempRow5[10] ^ tempRow5[11];//state8
          d5[9] =  tempRow5[8] ^ mul2[tempRow5[9]] ^ mul3[tempRow5[10]] ^ tempRow5[11];//state9
          d5[10] = tempRow5[8] ^ tempRow5[9] ^ mul2[tempRow5[10]] ^ mul3[tempRow5[11]];//state10
          d5[11] = mul3[tempRow5[8]] ^ tempRow5[9] ^ tempRow5[10] ^ mul2[tempRow5[11]];//state11
          d5[12] = mul2[tempRow5[12]] ^ mul3[tempRow5[13]] ^ tempRow5[14] ^ tempRow5[15];//state12
          d5[13] = tempRow5[12] ^ mul2[tempRow5[13]] ^ mul3[tempRow5[14]] ^ tempRow5[15];//state13
          d5[14] = tempRow5[12] ^ tempRow5[13] ^ mul2[tempRow5[14]] ^ mul3[tempRow5[15]];//state14
          d5[15] = mul3[tempRow5[12]] ^ tempRow5[13] ^ tempRow5[14] ^ mul2[tempRow5[15]];//state15                    
          next_state = 32;
          end
      32:begin
          /* round[6].m_col => w6[0] */
           w6[0] = {d5[0],d5[1],d5[2],d5[3]};
           w6[1] = {d5[4],d5[5],d5[6],d5[7]};
           w6[2] = {d5[8],d5[9],d5[10],d5[11]};
           w6[3] = {d5[12],d5[13],d5[14],d5[15]};
           next_state = 33;
       end
     33:begin
          /* round[6].input => w6[n] */
          /* round[6].sch => k[n] */
          /* round[7].start => tempStart6[n] */
          /* round[7].start = round[6].input XOR round[6].k_sch */
          tempStart6[0] = w6[0] ^ k[24];
          tempStart6[1] = w6[1] ^ k[25];
          tempStart6[2] = w6[2] ^ k[26];
          tempStart6[3] = w6[3] ^ k[27];
          next_state =  34;         
      end
      34:begin
          /* round[7].s_box => tempSbox6[n] */
          tempSbox6[0] = sbox[tempStart6[0][31:24]];tempSbox6[1] = sbox[tempStart6[0][23:16]];tempSbox6[2] = sbox[tempStart6[0][15:8]];tempSbox6[3] = sbox[tempStart6[0][7:0]];
          tempSbox6[4] = sbox[tempStart6[1][31:24]];tempSbox6[5] = sbox[tempStart6[1][23:16]];tempSbox6[6] = sbox[tempStart6[1][15:8]];tempSbox6[7] = sbox[tempStart6[1][7:0]];
          tempSbox6[8] = sbox[tempStart6[2][31:24]];tempSbox6[9] = sbox[tempStart6[2][23:16]];tempSbox6[10] = sbox[tempStart6[2][15:8]];tempSbox6[11] = sbox[tempStart6[2][7:0]];
          tempSbox6[12] = sbox[tempStart6[3][31:24]];tempSbox6[13] = sbox[tempStart6[3][23:16]];tempSbox6[14] = sbox[tempStart6[3][15:8]];tempSbox6[15] = sbox[tempStart6[3][7:0]];
          next_state = 35;
      end
      35:begin
         /* round[7].s_row => tempRow6[n] */
          tempRow6[0] = tempSbox6[0];tempRow6[1] = tempSbox6[5];tempRow6[2] = tempSbox6[10];tempRow6[3] = tempSbox6[15];
          tempRow6[4] = tempSbox6[4];tempRow6[5] = tempSbox6[9];tempRow6[6] = tempSbox6[14];tempRow6[7] = tempSbox6[3];
          tempRow6[8] = tempSbox6[8];tempRow6[9] = tempSbox6[13];tempRow6[10] = tempSbox6[2];tempRow6[11] = tempSbox6[7];
          tempRow6[12] = tempSbox6[12];tempRow6[13] = tempSbox6[1];tempRow6[14] = tempSbox6[6];tempRow6[15] = tempSbox6[11];
          next_state = 36;
      end
     36:begin
          d6[0] =  mul2[tempRow6[0]] ^ mul3[tempRow6[1]] ^ tempRow6[2] ^ tempRow6[3];//state0
          d6[1] =  tempRow6[0] ^ mul2[tempRow6[1]] ^ mul3[tempRow6[2]] ^ tempRow6[3];//state1
          d6[2] =  tempRow6[0] ^ tempRow6[1] ^ mul2[tempRow6[2]] ^ mul3[tempRow6[3]];//state2
          d6[3] =  mul3[tempRow6[0]] ^ tempRow6[1] ^ tempRow6[2] ^ mul2[tempRow6[3]];//state3
          d6[4] =  mul2[tempRow6[4]] ^ mul3[tempRow6[5]] ^ tempRow6[6] ^ tempRow6[7];//state4
          d6[5] =  tempRow6[4] ^ mul2[tempRow6[5]] ^ mul3[tempRow6[6]] ^ tempRow6[7];//state5
          d6[6] =  tempRow6[4] ^ tempRow6[5] ^ mul2[tempRow6[6]] ^ mul3[tempRow6[7]];//state6
          d6[7] =  mul3[tempRow6[4]] ^ tempRow6[5] ^ tempRow6[6] ^ mul2[tempRow6[7]];//state7
          d6[8] =  mul2[tempRow6[8]] ^ mul3[tempRow6[9]] ^ tempRow6[10] ^ tempRow6[11];//state8
          d6[9] =  tempRow6[8] ^ mul2[tempRow6[9]] ^ mul3[tempRow6[10]] ^ tempRow6[11];//state9
          d6[10] = tempRow6[8] ^ tempRow6[9] ^ mul2[tempRow6[10]] ^ mul3[tempRow6[11]];//state10
          d6[11] = mul3[tempRow6[8]] ^ tempRow6[9] ^ tempRow6[10] ^ mul2[tempRow6[11]];//state11
          d6[12] = mul2[tempRow6[12]] ^ mul3[tempRow6[13]] ^ tempRow6[14] ^ tempRow6[15];//state12
          d6[13] = tempRow6[12] ^ mul2[tempRow6[13]] ^ mul3[tempRow6[14]] ^ tempRow6[15];//state13
          d6[14] = tempRow6[12] ^ tempRow6[13] ^ mul2[tempRow6[14]] ^ mul3[tempRow6[15]];//state14
          d6[15] = mul3[tempRow6[12]] ^ tempRow6[13] ^ tempRow6[14] ^ mul2[tempRow6[15]];//state15                 
          next_state = 37;
          end
      37:begin
          /* round[7].m_col => w7[0] */
           w7[0] = {d6[0],d6[1],d6[2],d6[3]};
           w7[1] = {d6[4],d6[5],d6[6],d6[7]};
           w7[2] = {d6[8],d6[9],d6[10],d6[11]};
           w7[3] = {d6[12],d6[13],d6[14],d6[15]};
           next_state = 38;
       end
     38:begin
          /* round[7].input => w7[n] */
          /* round[7].sch => k[n] */
          /* round[8].start => tempStart7[n] */
          /* round[8].start = round[7].input XOR round[7].k_sch */
          tempStart7[0] = w7[0] ^ k[28];
          tempStart7[1] = w7[1] ^ k[29];
          tempStart7[2] = w7[2] ^ k[30];
          tempStart7[3] = w7[3] ^ k[31];
          next_state =  39;         
      end
      39:begin
          /* round[8].s_box => tempSbox7[n] */
          tempSbox7[0] = sbox[tempStart7[0][31:24]];tempSbox7[1] = sbox[tempStart7[0][23:16]];tempSbox7[2] = sbox[tempStart7[0][15:8]];tempSbox7[3] = sbox[tempStart7[0][7:0]];
          tempSbox7[4] = sbox[tempStart7[1][31:24]];tempSbox7[5] = sbox[tempStart7[1][23:16]];tempSbox7[6] = sbox[tempStart7[1][15:8]];tempSbox7[7] = sbox[tempStart7[1][7:0]];
          tempSbox7[8] = sbox[tempStart7[2][31:24]];tempSbox7[9] = sbox[tempStart7[2][23:16]];tempSbox7[10] = sbox[tempStart7[2][15:8]];tempSbox7[11] = sbox[tempStart7[2][7:0]];
          tempSbox7[12] = sbox[tempStart7[3][31:24]];tempSbox7[13] = sbox[tempStart7[3][23:16]];tempSbox7[14] = sbox[tempStart7[3][15:8]];tempSbox7[15] = sbox[tempStart7[3][7:0]];
          next_state = 40;
      end
      40:begin
         /* round[8].s_row => tempRow7[n] */
          tempRow7[0] = tempSbox7[0];tempRow7[1] = tempSbox7[5];tempRow7[2] = tempSbox7[10];tempRow7[3] = tempSbox7[15];
          tempRow7[4] = tempSbox7[4];tempRow7[5] = tempSbox7[9];tempRow7[6] = tempSbox7[14];tempRow7[7] = tempSbox7[3];
          tempRow7[8] = tempSbox7[8];tempRow7[9] = tempSbox7[13];tempRow7[10] = tempSbox7[2];tempRow7[11] = tempSbox7[7];
          tempRow7[12] = tempSbox7[12];tempRow7[13] = tempSbox7[1];tempRow7[14] = tempSbox7[6];tempRow7[15] = tempSbox7[11];
          next_state = 41;
      end
     41:begin
          d7[0] =  mul2[tempRow7[0]] ^ mul3[tempRow7[1]] ^ tempRow7[2] ^ tempRow7[3];//state0
          d7[1] =  tempRow7[0] ^ mul2[tempRow7[1]] ^ mul3[tempRow7[2]] ^ tempRow7[3];//state1
          d7[2] =  tempRow7[0] ^ tempRow7[1] ^ mul2[tempRow7[2]] ^ mul3[tempRow7[3]];//state2
          d7[3] =  mul3[tempRow7[0]] ^ tempRow7[1] ^ tempRow7[2] ^ mul2[tempRow7[3]];//state3
          d7[4] =  mul2[tempRow7[4]] ^ mul3[tempRow7[5]] ^ tempRow7[6] ^ tempRow7[7];//state4
          d7[5] =  tempRow7[4] ^ mul2[tempRow7[5]] ^ mul3[tempRow7[6]] ^ tempRow7[7];//state5
          d7[6] =  tempRow7[4] ^ tempRow7[5] ^ mul2[tempRow7[6]] ^ mul3[tempRow7[7]];//state6
          d7[7] =  mul3[tempRow7[4]] ^ tempRow7[5] ^ tempRow7[6] ^ mul2[tempRow7[7]];//state7
          d7[8] =  mul2[tempRow7[8]] ^ mul3[tempRow7[9]] ^ tempRow7[10] ^ tempRow7[11];//state8
          d7[9] =  tempRow7[8] ^ mul2[tempRow7[9]] ^ mul3[tempRow7[10]] ^ tempRow7[11];//state9
          d7[10] = tempRow7[8] ^ tempRow7[9] ^ mul2[tempRow7[10]] ^ mul3[tempRow7[11]];//state10
          d7[11] = mul3[tempRow7[8]] ^ tempRow7[9] ^ tempRow7[10] ^ mul2[tempRow7[11]];//state11
          d7[12] = mul2[tempRow7[12]] ^ mul3[tempRow7[13]] ^ tempRow7[14] ^ tempRow7[15];//state12
          d7[13] = tempRow7[12] ^ mul2[tempRow7[13]] ^ mul3[tempRow7[14]] ^ tempRow7[15];//state13
          d7[14] = tempRow7[12] ^ tempRow7[13] ^ mul2[tempRow7[14]] ^ mul3[tempRow7[15]];//state14
          d7[15] = mul3[tempRow7[12]] ^ tempRow7[13] ^ tempRow7[14] ^ mul2[tempRow7[15]];//state15                 
          next_state = 42;
          end
      42:begin
          /* round[8].m_col => w8[0] */
           w8[0] = {d7[0],d7[1],d7[2],d7[3]};
           w8[1] = {d7[4],d7[5],d7[6],d7[7]};
           w8[2] = {d7[8],d7[9],d7[10],d7[11]};
           w8[3] = {d7[12],d7[13],d7[14],d7[15]};
           next_state = 43;
       end
     43:begin
          /* round[8].input => w8[n] */
          /* round[8].sch => k[n] */
          /* round[9].start => tempStart8[n] */
          /* round[9].start = round[8].input XOR round[8].k_sch */
          tempStart8[0] = w8[0] ^ k[32];
          tempStart8[1] = w8[1] ^ k[33];
          tempStart8[2] = w8[2] ^ k[34];
          tempStart8[3] = w8[3] ^ k[35];
          next_state =  44;         
      end
      44:begin
          /* round[9].s_box => tempSbox8[n] */
          tempSbox8[0] = sbox[tempStart8[0][31:24]];tempSbox8[1] = sbox[tempStart8[0][23:16]];tempSbox8[2] = sbox[tempStart8[0][15:8]];tempSbox8[3] = sbox[tempStart8[0][7:0]];
          tempSbox8[4] = sbox[tempStart8[1][31:24]];tempSbox8[5] = sbox[tempStart8[1][23:16]];tempSbox8[6] = sbox[tempStart8[1][15:8]];tempSbox8[7] = sbox[tempStart8[1][7:0]];
          tempSbox8[8] = sbox[tempStart8[2][31:24]];tempSbox8[9] = sbox[tempStart8[2][23:16]];tempSbox8[10] = sbox[tempStart8[2][15:8]];tempSbox8[11] = sbox[tempStart8[2][7:0]];
          tempSbox8[12] = sbox[tempStart8[3][31:24]];tempSbox8[13] = sbox[tempStart8[3][23:16]];tempSbox8[14] = sbox[tempStart8[3][15:8]];tempSbox8[15] = sbox[tempStart8[3][7:0]];
          next_state = 45;
      end
      45:begin
         /* round[9].s_row => tempRow8[n] */
          tempRow8[0] = tempSbox8[0];tempRow8[1] = tempSbox8[5];tempRow8[2] = tempSbox8[10];tempRow8[3] = tempSbox8[15];
          tempRow8[4] = tempSbox8[4];tempRow8[5] = tempSbox8[9];tempRow8[6] = tempSbox8[14];tempRow8[7] = tempSbox8[3];
          tempRow8[8] = tempSbox8[8];tempRow8[9] = tempSbox8[13];tempRow8[10] = tempSbox8[2];tempRow8[11] = tempSbox8[7];
          tempRow8[12] = tempSbox8[12];tempRow8[13] = tempSbox8[1];tempRow8[14] = tempSbox8[6];tempRow8[15] = tempSbox8[11];
          next_state = 46;
      end
     46:begin
          d8[0] =  mul2[tempRow8[0]] ^ mul3[tempRow8[1]] ^ tempRow8[2] ^ tempRow8[3];//state0
          d8[1] =  tempRow8[0] ^ mul2[tempRow8[1]] ^ mul3[tempRow8[2]] ^ tempRow8[3];//state1
          d8[2] =  tempRow8[0] ^ tempRow8[1] ^ mul2[tempRow8[2]] ^ mul3[tempRow8[3]];//state2
          d8[3] =  mul3[tempRow8[0]] ^ tempRow8[1] ^ tempRow8[2] ^ mul2[tempRow8[3]];//state3
          d8[4] =  mul2[tempRow8[4]] ^ mul3[tempRow8[5]] ^ tempRow8[6] ^ tempRow8[7];//state4
          d8[5] =  tempRow8[4] ^ mul2[tempRow8[5]] ^ mul3[tempRow8[6]] ^ tempRow8[7];//state5
          d8[6] =  tempRow8[4] ^ tempRow8[5] ^ mul2[tempRow8[6]] ^ mul3[tempRow8[7]];//state6
          d8[7] =  mul3[tempRow8[4]] ^ tempRow8[5] ^ tempRow8[6] ^ mul2[tempRow8[7]];//state7
          d8[8] =  mul2[tempRow8[8]] ^ mul3[tempRow8[9]] ^ tempRow8[10] ^ tempRow8[11];//state8
          d8[9] =  tempRow8[8] ^ mul2[tempRow8[9]] ^ mul3[tempRow8[10]] ^ tempRow8[11];//state9
          d8[10] = tempRow8[8] ^ tempRow8[9] ^ mul2[tempRow8[10]] ^ mul3[tempRow8[11]];//state10
          d8[11] = mul3[tempRow8[8]] ^ tempRow8[9] ^ tempRow8[10] ^ mul2[tempRow8[11]];//state11
          d8[12] = mul2[tempRow8[12]] ^ mul3[tempRow8[13]] ^ tempRow8[14] ^ tempRow8[15];//state12
          d8[13] = tempRow8[12] ^ mul2[tempRow8[13]] ^ mul3[tempRow8[14]] ^ tempRow8[15];//state13
          d8[14] = tempRow8[12] ^ tempRow8[13] ^ mul2[tempRow8[14]] ^ mul3[tempRow8[15]];//state14
          d8[15] = mul3[tempRow8[12]] ^ tempRow8[13] ^ tempRow8[14] ^ mul2[tempRow8[15]];//state15                  
          next_state = 47;
          end
      47:begin
          /* round[9].m_col => w9[0] */
           w9[0] = {d8[0],d8[1],d8[2],d8[3]};
           w9[1] = {d8[4],d8[5],d8[6],d8[7]};
           w9[2] = {d8[8],d8[9],d8[10],d8[11]};
           w9[3] = {d8[12],d8[13],d8[14],d8[15]};
           next_state = 48;
       end
     48:begin
          /* round[9].input => w9[n] */
          /* round[9].sch => k[n] */
          /* round[10].start => tempStart9[n] */
          /* round[10].start = round[8].input XOR round[8].k_sch */
          tempStart9[0] = w9[0] ^ k[36];
          tempStart9[1] = w9[1] ^ k[37];
          tempStart9[2] = w9[2] ^ k[38];
          tempStart9[3] = w9[3] ^ k[39];
          next_state =  49;         
      end
      49:begin
          /* round[10].s_box => tempSbox9[n] */
          tempSbox9[0] = sbox[tempStart9[0][31:24]];tempSbox9[1] = sbox[tempStart9[0][23:16]];tempSbox9[2] = sbox[tempStart9[0][15:8]];tempSbox9[3] = sbox[tempStart9[0][7:0]];
          tempSbox9[4] = sbox[tempStart9[1][31:24]];tempSbox9[5] = sbox[tempStart9[1][23:16]];tempSbox9[6] = sbox[tempStart9[1][15:8]];tempSbox9[7] = sbox[tempStart9[1][7:0]];
          tempSbox9[8] = sbox[tempStart9[2][31:24]];tempSbox9[9] = sbox[tempStart9[2][23:16]];tempSbox9[10] = sbox[tempStart9[2][15:8]];tempSbox9[11] = sbox[tempStart9[2][7:0]];
          tempSbox9[12] = sbox[tempStart9[3][31:24]];tempSbox9[13] = sbox[tempStart9[3][23:16]];tempSbox9[14] = sbox[tempStart9[3][15:8]];tempSbox9[15] = sbox[tempStart9[3][7:0]];
          next_state = 50;
      end
      50:begin
         /* round[9].s_row => tempRow9[n] */
          tempRow9[0] = tempSbox9[0];tempRow9[1] = tempSbox9[5];tempRow9[2] = tempSbox9[10];tempRow9[3] = tempSbox9[15];
          tempRow9[4] = tempSbox9[4];tempRow9[5] = tempSbox9[9];tempRow9[6] = tempSbox9[14];tempRow9[7] = tempSbox9[3];
          tempRow9[8] = tempSbox9[8];tempRow9[9] = tempSbox9[13];tempRow9[10] = tempSbox9[2];tempRow9[11] = tempSbox9[7];
          tempRow9[12] = tempSbox9[12];tempRow9[13] = tempSbox9[1];tempRow9[14] = tempSbox9[6];tempRow9[15] = tempSbox9[11];
          next_state = 51;
      end
     51:begin
          d9[0] =  mul2[tempRow9[0]] ^ mul3[tempRow9[1]] ^ tempRow9[2] ^ tempRow9[3];//state0
          d9[1] =  tempRow9[0] ^ mul2[tempRow9[1]] ^ mul3[tempRow9[2]] ^ tempRow9[3];//state1
          d9[2] =  tempRow9[0] ^ tempRow9[1] ^ mul2[tempRow9[2]] ^ mul3[tempRow9[3]];//state2
          d9[3] =  mul3[tempRow9[0]] ^ tempRow9[1] ^ tempRow9[2] ^ mul2[tempRow9[3]];//state3
          d9[4] =  mul2[tempRow9[4]] ^ mul3[tempRow9[5]] ^ tempRow9[6] ^ tempRow9[7];//state4
          d9[5] =  tempRow9[4] ^ mul2[tempRow9[5]] ^ mul3[tempRow9[6]] ^ tempRow9[7];//state5
          d9[6] =  tempRow9[4] ^ tempRow9[5] ^ mul2[tempRow9[6]] ^ mul3[tempRow9[7]];//state6
          d9[7] =  mul3[tempRow9[4]] ^ tempRow9[5] ^ tempRow9[6] ^ mul2[tempRow9[7]];//state7
          d9[8] =  mul2[tempRow9[8]] ^ mul3[tempRow9[9]] ^ tempRow9[10] ^ tempRow9[11];//state8
          d9[9] =  tempRow9[8] ^ mul2[tempRow9[9]] ^ mul3[tempRow9[10]] ^ tempRow9[11];//state9
          d9[10] = tempRow9[8] ^ tempRow9[9] ^ mul2[tempRow9[10]] ^ mul3[tempRow9[11]];//state10
          d9[11] = mul3[tempRow9[8]] ^ tempRow9[9] ^ tempRow9[10] ^ mul2[tempRow9[11]];//state11
          d9[12] = mul2[tempRow9[12]] ^ mul3[tempRow9[13]] ^ tempRow9[14] ^ tempRow9[15];//state12
          d9[13] = tempRow9[12] ^ mul2[tempRow9[13]] ^ mul3[tempRow9[14]] ^ tempRow9[15];//state13
          d9[14] = tempRow9[12] ^ tempRow9[13] ^ mul2[tempRow9[14]] ^ mul3[tempRow9[15]];//state14
          d9[15] = mul3[tempRow9[12]] ^ tempRow9[13] ^ tempRow9[14] ^ mul2[tempRow9[15]];//state15                  
          next_state = 52;
          end
      52:begin
          /* round[10].m_col => w10[0] */
           w10[0] = {d9[0],d9[1],d9[2],d9[3]};
           w10[1] = {d9[4],d9[5],d9[6],d9[7]};
           w10[2] = {d9[8],d9[9],d9[10],d9[11]};
           w10[3] = {d9[12],d9[13],d9[14],d9[15]};
           next_state = 53;
       end
      53:begin
          /* round[10].input => w10[n] */
          /* round[10].sch => k[n] */
          /* round[11].start => tempStart10[n] */
          /* round[11].start = round[10].input XOR round[10].k_sch */
          tempStart10[0] = w10[0] ^ k[40];
          tempStart10[1] = w10[1] ^ k[41];
          tempStart10[2] = w10[2] ^ k[42];
          tempStart10[3] = w10[3] ^ k[43];
          next_state =  54;         
      end
      54:begin
          /* round[11].s_box => tempSbox10[n] */
          tempSbox10[0] = sbox[tempStart10[0][31:24]];tempSbox10[1] = sbox[tempStart10[0][23:16]];tempSbox10[2] = sbox[tempStart10[0][15:8]];tempSbox10[3] = sbox[tempStart10[0][7:0]];
          tempSbox10[4] = sbox[tempStart10[1][31:24]];tempSbox10[5] = sbox[tempStart10[1][23:16]];tempSbox10[6] = sbox[tempStart10[1][15:8]];tempSbox10[7] = sbox[tempStart10[1][7:0]];
          tempSbox10[8] = sbox[tempStart10[2][31:24]];tempSbox10[9] = sbox[tempStart10[2][23:16]];tempSbox10[10] = sbox[tempStart10[2][15:8]];tempSbox10[11] = sbox[tempStart10[2][7:0]];
          tempSbox10[12] = sbox[tempStart10[3][31:24]];tempSbox10[13] = sbox[tempStart10[3][23:16]];tempSbox10[14] = sbox[tempStart10[3][15:8]];tempSbox10[15] = sbox[tempStart10[3][7:0]];
          next_state = 55;
      end
      55:begin
         /* round[11].s_row => tempRow10[n] */
          tempRow10[0] = tempSbox10[0];tempRow10[1] = tempSbox10[5];tempRow10[2] = tempSbox10[10];tempRow10[3] = tempSbox10[15];
          tempRow10[4] = tempSbox10[4];tempRow10[5] = tempSbox10[9];tempRow10[6] = tempSbox10[14];tempRow10[7] = tempSbox10[3];
          tempRow10[8] = tempSbox10[8];tempRow10[9] = tempSbox10[13];tempRow10[10] = tempSbox10[2];tempRow10[11] = tempSbox10[7];
          tempRow10[12] = tempSbox10[12];tempRow10[13] = tempSbox10[1];tempRow10[14] = tempSbox10[6];tempRow10[15] = tempSbox10[11];
          next_state = 56;
      end
     56:begin
          d10[0] =  mul2[tempRow10[0]] ^ mul3[tempRow10[1]] ^ tempRow10[2] ^ tempRow10[3];//state0
          d10[1] =  tempRow10[0] ^ mul2[tempRow10[1]] ^ mul3[tempRow10[2]] ^ tempRow10[3];//state1
          d10[2] =  tempRow10[0] ^ tempRow10[1] ^ mul2[tempRow10[2]] ^ mul3[tempRow10[3]];//state2
          d10[3] =  mul3[tempRow10[0]] ^ tempRow10[1] ^ tempRow10[2] ^ mul2[tempRow10[3]];//state3
          d10[4] =  mul2[tempRow10[4]] ^ mul3[tempRow10[5]] ^ tempRow10[6] ^ tempRow10[7];//state4
          d10[5] =  tempRow10[4] ^ mul2[tempRow10[5]] ^ mul3[tempRow10[6]] ^ tempRow10[7];//state5
          d10[6] =  tempRow10[4] ^ tempRow10[5] ^ mul2[tempRow10[6]] ^ mul3[tempRow10[7]];//state6
          d10[7] =  mul3[tempRow10[4]] ^ tempRow10[5] ^ tempRow10[6] ^ mul2[tempRow10[7]];//state7
          d10[8] =  mul2[tempRow10[8]] ^ mul3[tempRow10[9]] ^ tempRow10[10] ^ tempRow10[11];//state8
          d10[9] =  tempRow10[8] ^ mul2[tempRow10[9]] ^ mul3[tempRow10[10]] ^ tempRow10[11];//state9
          d10[10] = tempRow10[8] ^ tempRow10[9] ^ mul2[tempRow10[10]] ^ mul3[tempRow10[11]];//state10
          d10[11] = mul3[tempRow10[8]] ^ tempRow10[9] ^ tempRow10[10] ^ mul2[tempRow10[11]];//state11
          d10[12] = mul2[tempRow10[12]] ^ mul3[tempRow10[13]] ^ tempRow10[14] ^ tempRow10[15];//state12
          d10[13] = tempRow10[12] ^ mul2[tempRow10[13]] ^ mul3[tempRow10[14]] ^ tempRow10[15];//state13
          d10[14] = tempRow10[12] ^ tempRow10[13] ^ mul2[tempRow10[14]] ^ mul3[tempRow10[15]];//state14
          d10[15] = mul3[tempRow10[12]] ^ tempRow10[13] ^ tempRow10[14] ^ mul2[tempRow10[15]];//state15                   
          next_state = 57;
          end
      57:begin
          /* round[11].m_col => w11[0] */
           w11[0] = {d10[0],d10[1],d10[2],d10[3]};
           w11[1] = {d10[4],d10[5],d10[6],d10[7]};
           w11[2] = {d10[8],d10[9],d10[10],d10[11]};
           w11[3] = {d10[12],d10[13],d10[14],d10[15]};
           next_state = 58;
       end
      58:begin
          /* round[11].input => w11[n] */
          /* round[11].sch => k[n] */
          /* round[12].start => tempStart11[n] */
          /* round[12].start = round[11].input XOR round[11].k_sch */
          tempStart11[0] = w11[0] ^ k[44];
          tempStart11[1] = w11[1] ^ k[45];
          tempStart11[2] = w11[2] ^ k[46];
          tempStart11[3] = w11[3] ^ k[47];
          next_state =  59;         
      end
      59:begin
          /* round[12].s_box => tempSbox11[n] */
          tempSbox11[0] = sbox[tempStart11[0][31:24]];tempSbox11[1] = sbox[tempStart11[0][23:16]];tempSbox11[2] = sbox[tempStart11[0][15:8]];tempSbox11[3] = sbox[tempStart11[0][7:0]];
          tempSbox11[4] = sbox[tempStart11[1][31:24]];tempSbox11[5] = sbox[tempStart11[1][23:16]];tempSbox11[6] = sbox[tempStart11[1][15:8]];tempSbox11[7] = sbox[tempStart11[1][7:0]];
          tempSbox11[8] = sbox[tempStart11[2][31:24]];tempSbox11[9] = sbox[tempStart11[2][23:16]];tempSbox11[10] = sbox[tempStart11[2][15:8]];tempSbox11[11] = sbox[tempStart11[2][7:0]];
          tempSbox11[12] = sbox[tempStart11[3][31:24]];tempSbox11[13] = sbox[tempStart11[3][23:16]];tempSbox11[14] = sbox[tempStart11[3][15:8]];tempSbox11[15] = sbox[tempStart11[3][7:0]];
          next_state = 60;
      end
      60:begin
         /* round[12].s_row => tempRow11[n] */
          tempRow11[0] = tempSbox11[0];tempRow11[1] = tempSbox11[5];tempRow11[2] = tempSbox11[10];tempRow11[3] = tempSbox11[15];
          tempRow11[4] = tempSbox11[4];tempRow11[5] = tempSbox11[9];tempRow11[6] = tempSbox11[14];tempRow11[7] = tempSbox11[3];
          tempRow11[8] = tempSbox11[8];tempRow11[9] = tempSbox11[13];tempRow11[10] = tempSbox11[2];tempRow11[11] = tempSbox11[7];
          tempRow11[12] = tempSbox11[12];tempRow11[13] = tempSbox11[1];tempRow11[14] = tempSbox11[6];tempRow11[15] = tempSbox11[11];
          next_state = 61;
      end
     61:begin
          d11[0] =  mul2[tempRow11[0]] ^ mul3[tempRow11[1]] ^ tempRow11[2] ^ tempRow11[3];//state0
          d11[1] =  tempRow11[0] ^ mul2[tempRow11[1]] ^ mul3[tempRow11[2]] ^ tempRow11[3];//state1
          d11[2] =  tempRow11[0] ^ tempRow11[1] ^ mul2[tempRow11[2]] ^ mul3[tempRow11[3]];//state2
          d11[3] =  mul3[tempRow11[0]] ^ tempRow11[1] ^ tempRow11[2] ^ mul2[tempRow11[3]];//state3
          d11[4] =  mul2[tempRow11[4]] ^ mul3[tempRow11[5]] ^ tempRow11[6] ^ tempRow11[7];//state4
          d11[5] =  tempRow11[4] ^ mul2[tempRow11[5]] ^ mul3[tempRow11[6]] ^ tempRow11[7];//state5
          d11[6] =  tempRow11[4] ^ tempRow11[5] ^ mul2[tempRow11[6]] ^ mul3[tempRow11[7]];//state6
          d11[7] =  mul3[tempRow11[4]] ^ tempRow11[5] ^ tempRow11[6] ^ mul2[tempRow11[7]];//state7
          d11[8] =  mul2[tempRow11[8]] ^ mul3[tempRow11[9]] ^ tempRow11[10] ^ tempRow11[11];//state8
          d11[9] =  tempRow11[8] ^ mul2[tempRow11[9]] ^ mul3[tempRow11[10]] ^ tempRow11[11];//state9
          d11[10] = tempRow11[8] ^ tempRow11[9] ^ mul2[tempRow11[10]] ^ mul3[tempRow11[11]];//state10
          d11[11] = mul3[tempRow11[8]] ^ tempRow11[9] ^ tempRow11[10] ^ mul2[tempRow11[11]];//state11
          d11[12] = mul2[tempRow11[12]] ^ mul3[tempRow11[13]] ^ tempRow11[14] ^ tempRow11[15];//state12
          d11[13] = tempRow11[12] ^ mul2[tempRow11[13]] ^ mul3[tempRow11[14]] ^ tempRow11[15];//state13
          d11[14] = tempRow11[12] ^ tempRow11[13] ^ mul2[tempRow11[14]] ^ mul3[tempRow11[15]];//state14
          d11[15] = mul3[tempRow11[12]] ^ tempRow11[13] ^ tempRow11[14] ^ mul2[tempRow11[15]];//state15                 
          next_state = 62;
          end
      62:begin
          /* round[12].m_col => w12[0] */
           w12[0] = {d11[0],d11[1],d11[2],d11[3]};
           w12[1] = {d11[4],d11[5],d11[6],d11[7]};
           w12[2] = {d11[8],d11[9],d11[10],d11[11]};
           w12[3] = {d11[12],d11[13],d11[14],d11[15]};
           next_state = 63;
       end
      63:begin
          /* round[12].input => w12[n] */
          /* round[12].sch => k[n] */
          /* round[12].start => tempStart12[n] */
          /* round[12].start = round[11].input XOR round[11].k_sch */
          tempStart12[0] = w12[0] ^ k[48];
          tempStart12[1] = w12[1] ^ k[49];
          tempStart12[2] = w12[2] ^ k[50];
          tempStart12[3] = w12[3] ^ k[51];
          next_state =  64;         
      end
      64:begin
          /* round[12].s_box => tempSbox12[n] */
          tempSbox12[0] = sbox[tempStart12[0][31:24]];tempSbox12[1] = sbox[tempStart12[0][23:16]];tempSbox12[2] = sbox[tempStart12[0][15:8]];tempSbox12[3] = sbox[tempStart12[0][7:0]];
          tempSbox12[4] = sbox[tempStart12[1][31:24]];tempSbox12[5] = sbox[tempStart12[1][23:16]];tempSbox12[6] = sbox[tempStart12[1][15:8]];tempSbox12[7] = sbox[tempStart12[1][7:0]];
          tempSbox12[8] = sbox[tempStart12[2][31:24]];tempSbox12[9] = sbox[tempStart12[2][23:16]];tempSbox12[10] = sbox[tempStart12[2][15:8]];tempSbox12[11] = sbox[tempStart12[2][7:0]];
          tempSbox12[12] = sbox[tempStart12[3][31:24]];tempSbox12[13] = sbox[tempStart12[3][23:16]];tempSbox12[14] = sbox[tempStart12[3][15:8]];tempSbox12[15] = sbox[tempStart12[3][7:0]];
          next_state = 65;
      end
      65:begin
         /* round[12].s_row => tempRow12[n] */
          tempRow12[0] = tempSbox12[0];tempRow12[1] = tempSbox12[5];tempRow12[2] = tempSbox12[10];tempRow12[3] = tempSbox12[15];
          tempRow12[4] = tempSbox12[4];tempRow12[5] = tempSbox12[9];tempRow12[6] = tempSbox12[14];tempRow12[7] = tempSbox12[3];
          tempRow12[8] = tempSbox12[8];tempRow12[9] = tempSbox12[13];tempRow12[10] = tempSbox12[2];tempRow12[11] = tempSbox12[7];
          tempRow12[12] = tempSbox12[12];tempRow12[13] = tempSbox12[1];tempRow12[14] = tempSbox12[6];tempRow12[15] = tempSbox12[11];
          next_state = 66;
      end
      66:begin
          d12[0] =  mul2[tempRow12[0]] ^ mul3[tempRow12[1]] ^ tempRow12[2] ^ tempRow12[3];//state0
          d12[1] =  tempRow12[0] ^ mul2[tempRow12[1]] ^ mul3[tempRow12[2]] ^ tempRow12[3];//state1
          d12[2] =  tempRow12[0] ^ tempRow12[1] ^ mul2[tempRow12[2]] ^ mul3[tempRow12[3]];//state2
          d12[3] =  mul3[tempRow12[0]] ^ tempRow12[1] ^ tempRow12[2] ^ mul2[tempRow12[3]];//state3
          d12[4] =  mul2[tempRow12[4]] ^ mul3[tempRow12[5]] ^ tempRow12[6] ^ tempRow12[7];//state4
          d12[5] =  tempRow12[4] ^ mul2[tempRow12[5]] ^ mul3[tempRow12[6]] ^ tempRow12[7];//state5
          d12[6] =  tempRow12[4] ^ tempRow12[5] ^ mul2[tempRow12[6]] ^ mul3[tempRow12[7]];//state6
          d12[7] =  mul3[tempRow12[4]] ^ tempRow12[5] ^ tempRow12[6] ^ mul2[tempRow12[7]];//state7
          d12[8] =  mul2[tempRow12[8]] ^ mul3[tempRow12[9]] ^ tempRow12[10] ^ tempRow12[11];//state8
          d12[9] =  tempRow12[8] ^ mul2[tempRow12[9]] ^ mul3[tempRow12[10]] ^ tempRow12[11];//state9
          d12[10] = tempRow12[8] ^ tempRow12[9] ^ mul2[tempRow12[10]] ^ mul3[tempRow12[11]];//state10
          d12[11] = mul3[tempRow12[8]] ^ tempRow12[9] ^ tempRow12[10] ^ mul2[tempRow12[11]];//state11
          d12[12] = mul2[tempRow12[12]] ^ mul3[tempRow12[13]] ^ tempRow12[14] ^ tempRow12[15];//state12
          d12[13] = tempRow12[12] ^ mul2[tempRow12[13]] ^ mul3[tempRow12[14]] ^ tempRow12[15];//state13
          d12[14] = tempRow12[12] ^ tempRow12[13] ^ mul2[tempRow12[14]] ^ mul3[tempRow12[15]];//state14
          d12[15] = mul3[tempRow12[12]] ^ tempRow12[13] ^ tempRow12[14] ^ mul2[tempRow12[15]];//state15                
          next_state = 67;
          end
      67:begin
          /* round[13].m_col => w13[0] */
           w13[0] = {d12[0],d12[1],d12[2],d12[3]};
           w13[1] = {d12[4],d12[5],d12[6],d12[7]};
           w13[2] = {d12[8],d12[9],d12[10],d12[11]};
           w13[3] = {d12[12],d12[13],d12[14],d12[15]};
           next_state = 68;
       end
     68:begin
          /* round[13].input => w13[n] */
          /* round[13].sch => k[n] */
          /* round[14].start => tempStart13[n] */
          /* round[14].start = round[0].input XOR round[0].k_sch */
          tempStart13[0] = w13[0] ^ k[52];
          tempStart13[1] = w13[1] ^ k[53];
          tempStart13[2] = w13[2] ^ k[54];
          tempStart13[3] = w13[3] ^ k[55];
          next_state =  69;         
      end
      69:begin
          /* round[14].s_box => tempSbox13[n] */
          tempSbox13[0] = sbox[tempStart13[0][31:24]];tempSbox13[1] = sbox[tempStart13[0][23:16]];tempSbox13[2] = sbox[tempStart13[0][15:8]];tempSbox13[3] = sbox[tempStart13[0][7:0]];
          tempSbox13[4] = sbox[tempStart13[1][31:24]];tempSbox13[5] = sbox[tempStart13[1][23:16]];tempSbox13[6] = sbox[tempStart13[1][15:8]];tempSbox13[7] = sbox[tempStart13[1][7:0]];
          tempSbox13[8] = sbox[tempStart13[2][31:24]];tempSbox13[9] = sbox[tempStart13[2][23:16]];tempSbox13[10] = sbox[tempStart13[2][15:8]];tempSbox13[11] = sbox[tempStart13[2][7:0]];
          tempSbox13[12] = sbox[tempStart13[3][31:24]];tempSbox13[13] = sbox[tempStart13[3][23:16]];tempSbox13[14] = sbox[tempStart13[3][15:8]];tempSbox13[15] = sbox[tempStart13[3][7:0]];
          next_state = 70;
      end
      70:begin
         /* round[1].s_row => tempRow13[n] */
          tempRow13[0] = tempSbox13[0];tempRow13[1] = tempSbox13[5];tempRow13[2] = tempSbox13[10];tempRow13[3] = tempSbox13[15];
          tempRow13[4] = tempSbox13[4];tempRow13[5] = tempSbox13[9];tempRow13[6] = tempSbox13[14];tempRow13[7] = tempSbox13[3];
          tempRow13[8] = tempSbox13[8];tempRow13[9] = tempSbox13[13];tempRow13[10] = tempSbox13[2];tempRow13[11] = tempSbox13[7];
          tempRow13[12] = tempSbox13[12];tempRow13[13] = tempSbox13[1];tempRow13[14] = tempSbox13[6];tempRow13[15] = tempSbox13[11];
          next_state = 71;
      end
      71:begin
          d13[0] = tempRow13[0] ^ k[56][31:24];
          d13[1] = tempRow13[1] ^ k[56][23:16];
          d13[2] = tempRow13[2] ^ k[56][15:8];
          d13[3] = tempRow13[3] ^ k[56][7:0];
          d13[4] = tempRow13[4] ^ k[57][31:24];
          d13[5] = tempRow13[5] ^ k[57][23:16];
          d13[6] = tempRow13[6] ^ k[57][15:8];
          d13[7] = tempRow13[7] ^ k[57][7:0];
          d13[8] = tempRow13[8] ^ k[58][31:24];
          d13[9] = tempRow13[9] ^ k[58][23:16];
          d13[10] = tempRow13[10] ^ k[58][15:8];
          d13[11] = tempRow13[11] ^ k[58][7:0];
          d13[12] = tempRow13[12] ^ k[59][31:24];
          d13[13] = tempRow13[13] ^ k[59][23:16];
          d13[14] = tempRow13[14] ^ k[59][15:8];
          d13[15] = tempRow13[15] ^ k[59][7:0];
          next_state = 72;
      end
      72:begin
          /* round[14].m_col => w14[0] */
           w14[0] = {d13[0],d13[1],d13[2],d13[3]};
           w14[1] = {d13[4],d13[5],d13[6],d13[7]};
           w14[2] = {d13[8],d13[9],d13[10],d13[11]};
           w14[3] = {d13[12],d13[13],d13[14],d13[15]};
           next_state = 73;
       end 
       
      73: begin
          //cipher = {w1[0],w1[1],w1[2],w1[3]};
            //cipher = {w5[0],w5[1],w5[2],w5[3]};
            //cipher = {w10[0],w10[1],w10[2],w10[3]};
          cipher = {w14[0],w14[1],w14[2],w14[3]};
         //cipher = {tempRow[0],tempRow[1],tempRow[2],tempRow[3],tempRow[4],tempRow[5],tempRow[6],tempRow[7],tempRow[8],tempRow[9],tempRow[10],tempRow[11],tempRow[12],tempRow[13],tempRow[14],tempRow[15]};
          encDone =  1;  
          next_state = 74;
      end
      74:begin
            encDone =  1;
            ledDone = 1;  
            next_state = 74;
       end
          default:begin
                      next_state = 0;
                  end
           
      endcase
  end 
      
      
  endmodule