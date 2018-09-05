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


module aes_dec_core(input clk,
                  input rst,
                  input start,
                  input dstart,
                  input [1:0]enc_dec,
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
reg [7:0]d11[15:0];
reg [7:0]d12[15:0];
reg [7:0]d13[15:0];
reg [7:0]d14[15:0];
reg [7:0]d15[15:0];
reg [7:0]d16[15:0];
reg [7:0]d17[15:0];
reg [7:0]d18[15:0];
reg [7:0]d19[15:0];
reg [7:0]d20[15:0];
reg [7:0]d21[15:0];
reg [7:0]d22[15:0];
reg [7:0]d23[15:0];
reg [7:0]d24[15:0];
reg [7:0]d25[15:0];
reg [7:0]d26[15:0];


//reg [7:0]d1[15:0];
reg [31:0]w[3:0];
reg [31:0]w1[3:0];


reg [31:0]k[59:0];
wire [7:0]inv_sbox[255:0];
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

wire [7 : 0] mul9 [0 : 255];
wire [7 : 0] mul11 [0 : 255];
wire [7 : 0] mul13 [0 : 255];
wire [7 : 0] mul14 [0 : 255];

assign inv_sbox[8'h00] = 8'h52;
  assign inv_sbox[8'h01] = 8'h09;
  assign inv_sbox[8'h02] = 8'h6a;
  assign inv_sbox[8'h03] = 8'hd5;
  assign inv_sbox[8'h04] = 8'h30;
  assign inv_sbox[8'h05] = 8'h36;
  assign inv_sbox[8'h06] = 8'ha5;
  assign inv_sbox[8'h07] = 8'h38;
  assign inv_sbox[8'h08] = 8'hbf;
  assign inv_sbox[8'h09] = 8'h40;
  assign inv_sbox[8'h0a] = 8'ha3;
  assign inv_sbox[8'h0b] = 8'h9e;
  assign inv_sbox[8'h0c] = 8'h81;
  assign inv_sbox[8'h0d] = 8'hf3;
  assign inv_sbox[8'h0e] = 8'hd7;
  assign inv_sbox[8'h0f] = 8'hfb;
  assign inv_sbox[8'h10] = 8'h7c;
  assign inv_sbox[8'h11] = 8'he3;
  assign inv_sbox[8'h12] = 8'h39;
  assign inv_sbox[8'h13] = 8'h82;
  assign inv_sbox[8'h14] = 8'h9b;
  assign inv_sbox[8'h15] = 8'h2f;
  assign inv_sbox[8'h16] = 8'hff;
  assign inv_sbox[8'h17] = 8'h87;
  assign inv_sbox[8'h18] = 8'h34;
  assign inv_sbox[8'h19] = 8'h8e;
  assign inv_sbox[8'h1a] = 8'h43;
  assign inv_sbox[8'h1b] = 8'h44;
  assign inv_sbox[8'h1c] = 8'hc4;
  assign inv_sbox[8'h1d] = 8'hde;
  assign inv_sbox[8'h1e] = 8'he9;
  assign inv_sbox[8'h1f] = 8'hcb;
  assign inv_sbox[8'h20] = 8'h54;
  assign inv_sbox[8'h21] = 8'h7b;
  assign inv_sbox[8'h22] = 8'h94;
  assign inv_sbox[8'h23] = 8'h32;
  assign inv_sbox[8'h24] = 8'ha6;
  assign inv_sbox[8'h25] = 8'hc2;
  assign inv_sbox[8'h26] = 8'h23;
  assign inv_sbox[8'h27] = 8'h3d;
  assign inv_sbox[8'h28] = 8'hee;
  assign inv_sbox[8'h29] = 8'h4c;
  assign inv_sbox[8'h2a] = 8'h95;
  assign inv_sbox[8'h2b] = 8'h0b;
  assign inv_sbox[8'h2c] = 8'h42;
  assign inv_sbox[8'h2d] = 8'hfa;
  assign inv_sbox[8'h2e] = 8'hc3;
  assign inv_sbox[8'h2f] = 8'h4e;
  assign inv_sbox[8'h30] = 8'h08;
  assign inv_sbox[8'h31] = 8'h2e;
  assign inv_sbox[8'h32] = 8'ha1;
  assign inv_sbox[8'h33] = 8'h66;
  assign inv_sbox[8'h34] = 8'h28;
  assign inv_sbox[8'h35] = 8'hd9;
  assign inv_sbox[8'h36] = 8'h24;
  assign inv_sbox[8'h37] = 8'hb2;
  assign inv_sbox[8'h38] = 8'h76;
  assign inv_sbox[8'h39] = 8'h5b;
  assign inv_sbox[8'h3a] = 8'ha2;
  assign inv_sbox[8'h3b] = 8'h49;
  assign inv_sbox[8'h3c] = 8'h6d;
  assign inv_sbox[8'h3d] = 8'h8b;
  assign inv_sbox[8'h3e] = 8'hd1;
  assign inv_sbox[8'h3f] = 8'h25;
  assign inv_sbox[8'h40] = 8'h72;
  assign inv_sbox[8'h41] = 8'hf8;
  assign inv_sbox[8'h42] = 8'hf6;
  assign inv_sbox[8'h43] = 8'h64;
  assign inv_sbox[8'h44] = 8'h86;
  assign inv_sbox[8'h45] = 8'h68;
  assign inv_sbox[8'h46] = 8'h98;
  assign inv_sbox[8'h47] = 8'h16;
  assign inv_sbox[8'h48] = 8'hd4;
  assign inv_sbox[8'h49] = 8'ha4;
  assign inv_sbox[8'h4a] = 8'h5c;
  assign inv_sbox[8'h4b] = 8'hcc;
  assign inv_sbox[8'h4c] = 8'h5d;
  assign inv_sbox[8'h4d] = 8'h65;
  assign inv_sbox[8'h4e] = 8'hb6;
  assign inv_sbox[8'h4f] = 8'h92;
  assign inv_sbox[8'h50] = 8'h6c;
  assign inv_sbox[8'h51] = 8'h70;
  assign inv_sbox[8'h52] = 8'h48;
  assign inv_sbox[8'h53] = 8'h50;
  assign inv_sbox[8'h54] = 8'hfd;
  assign inv_sbox[8'h55] = 8'hed;
  assign inv_sbox[8'h56] = 8'hb9;
  assign inv_sbox[8'h57] = 8'hda;
  assign inv_sbox[8'h58] = 8'h5e;
  assign inv_sbox[8'h59] = 8'h15;
  assign inv_sbox[8'h5a] = 8'h46;
  assign inv_sbox[8'h5b] = 8'h57;
  assign inv_sbox[8'h5c] = 8'ha7;
  assign inv_sbox[8'h5d] = 8'h8d;
  assign inv_sbox[8'h5e] = 8'h9d;
  assign inv_sbox[8'h5f] = 8'h84;
  assign inv_sbox[8'h60] = 8'h90;
  assign inv_sbox[8'h61] = 8'hd8;
  assign inv_sbox[8'h62] = 8'hab;
  assign inv_sbox[8'h63] = 8'h00;
  assign inv_sbox[8'h64] = 8'h8c;
  assign inv_sbox[8'h65] = 8'hbc;
  assign inv_sbox[8'h66] = 8'hd3;
  assign inv_sbox[8'h67] = 8'h0a;
  assign inv_sbox[8'h68] = 8'hf7;
  assign inv_sbox[8'h69] = 8'he4;
  assign inv_sbox[8'h6a] = 8'h58;
  assign inv_sbox[8'h6b] = 8'h05;
  assign inv_sbox[8'h6c] = 8'hb8;
  assign inv_sbox[8'h6d] = 8'hb3;
  assign inv_sbox[8'h6e] = 8'h45;
  assign inv_sbox[8'h6f] = 8'h06;
  assign inv_sbox[8'h70] = 8'hd0;
  assign inv_sbox[8'h71] = 8'h2c;
  assign inv_sbox[8'h72] = 8'h1e;
  assign inv_sbox[8'h73] = 8'h8f;
  assign inv_sbox[8'h74] = 8'hca;
  assign inv_sbox[8'h75] = 8'h3f;
  assign inv_sbox[8'h76] = 8'h0f;
  assign inv_sbox[8'h77] = 8'h02;
  assign inv_sbox[8'h78] = 8'hc1;
  assign inv_sbox[8'h79] = 8'haf;
  assign inv_sbox[8'h7a] = 8'hbd;
  assign inv_sbox[8'h7b] = 8'h03;
  assign inv_sbox[8'h7c] = 8'h01;
  assign inv_sbox[8'h7d] = 8'h13;
  assign inv_sbox[8'h7e] = 8'h8a;
  assign inv_sbox[8'h7f] = 8'h6b;
  assign inv_sbox[8'h80] = 8'h3a;
  assign inv_sbox[8'h81] = 8'h91;
  assign inv_sbox[8'h82] = 8'h11;
  assign inv_sbox[8'h83] = 8'h41;
  assign inv_sbox[8'h84] = 8'h4f;
  assign inv_sbox[8'h85] = 8'h67;
  assign inv_sbox[8'h86] = 8'hdc;
  assign inv_sbox[8'h87] = 8'hea;
  assign inv_sbox[8'h88] = 8'h97;
  assign inv_sbox[8'h89] = 8'hf2;
  assign inv_sbox[8'h8a] = 8'hcf;
  assign inv_sbox[8'h8b] = 8'hce;
  assign inv_sbox[8'h8c] = 8'hf0;
  assign inv_sbox[8'h8d] = 8'hb4;
  assign inv_sbox[8'h8e] = 8'he6;
  assign inv_sbox[8'h8f] = 8'h73;
  assign inv_sbox[8'h90] = 8'h96;
  assign inv_sbox[8'h91] = 8'hac;
  assign inv_sbox[8'h92] = 8'h74;
  assign inv_sbox[8'h93] = 8'h22;
  assign inv_sbox[8'h94] = 8'he7;
  assign inv_sbox[8'h95] = 8'had;
  assign inv_sbox[8'h96] = 8'h35;
  assign inv_sbox[8'h97] = 8'h85;
  assign inv_sbox[8'h98] = 8'he2;
  assign inv_sbox[8'h99] = 8'hf9;
  assign inv_sbox[8'h9a] = 8'h37;
  assign inv_sbox[8'h9b] = 8'he8;
  assign inv_sbox[8'h9c] = 8'h1c;
  assign inv_sbox[8'h9d] = 8'h75;
  assign inv_sbox[8'h9e] = 8'hdf;
  assign inv_sbox[8'h9f] = 8'h6e;
  assign inv_sbox[8'ha0] = 8'h47;
  assign inv_sbox[8'ha1] = 8'hf1;
  assign inv_sbox[8'ha2] = 8'h1a;
  assign inv_sbox[8'ha3] = 8'h71;
  assign inv_sbox[8'ha4] = 8'h1d;
  assign inv_sbox[8'ha5] = 8'h29;
  assign inv_sbox[8'ha6] = 8'hc5;
  assign inv_sbox[8'ha7] = 8'h89;
  assign inv_sbox[8'ha8] = 8'h6f;
  assign inv_sbox[8'ha9] = 8'hb7;
  assign inv_sbox[8'haa] = 8'h62;
  assign inv_sbox[8'hab] = 8'h0e;
  assign inv_sbox[8'hac] = 8'haa;
  assign inv_sbox[8'had] = 8'h18;
  assign inv_sbox[8'hae] = 8'hbe;
  assign inv_sbox[8'haf] = 8'h1b;
  assign inv_sbox[8'hb0] = 8'hfc;
  assign inv_sbox[8'hb1] = 8'h56;
  assign inv_sbox[8'hb2] = 8'h3e;
  assign inv_sbox[8'hb3] = 8'h4b;
  assign inv_sbox[8'hb4] = 8'hc6;
  assign inv_sbox[8'hb5] = 8'hd2;
  assign inv_sbox[8'hb6] = 8'h79;
  assign inv_sbox[8'hb7] = 8'h20;
  assign inv_sbox[8'hb8] = 8'h9a;
  assign inv_sbox[8'hb9] = 8'hdb;
  assign inv_sbox[8'hba] = 8'hc0;
  assign inv_sbox[8'hbb] = 8'hfe;
  assign inv_sbox[8'hbc] = 8'h78;
  assign inv_sbox[8'hbd] = 8'hcd;
  assign inv_sbox[8'hbe] = 8'h5a;
  assign inv_sbox[8'hbf] = 8'hf4;
  assign inv_sbox[8'hc0] = 8'h1f;
  assign inv_sbox[8'hc1] = 8'hdd;
  assign inv_sbox[8'hc2] = 8'ha8;
  assign inv_sbox[8'hc3] = 8'h33;
  assign inv_sbox[8'hc4] = 8'h88;
  assign inv_sbox[8'hc5] = 8'h07;
  assign inv_sbox[8'hc6] = 8'hc7;
  assign inv_sbox[8'hc7] = 8'h31;
  assign inv_sbox[8'hc8] = 8'hb1;
  assign inv_sbox[8'hc9] = 8'h12;
  assign inv_sbox[8'hca] = 8'h10;
  assign inv_sbox[8'hcb] = 8'h59;
  assign inv_sbox[8'hcc] = 8'h27;
  assign inv_sbox[8'hcd] = 8'h80;
  assign inv_sbox[8'hce] = 8'hec;
  assign inv_sbox[8'hcf] = 8'h5f;
  assign inv_sbox[8'hd0] = 8'h60;
  assign inv_sbox[8'hd1] = 8'h51;
  assign inv_sbox[8'hd2] = 8'h7f;
  assign inv_sbox[8'hd3] = 8'ha9;
  assign inv_sbox[8'hd4] = 8'h19;
  assign inv_sbox[8'hd5] = 8'hb5;
  assign inv_sbox[8'hd6] = 8'h4a;
  assign inv_sbox[8'hd7] = 8'h0d;
  assign inv_sbox[8'hd8] = 8'h2d;
  assign inv_sbox[8'hd9] = 8'he5;
  assign inv_sbox[8'hda] = 8'h7a;
  assign inv_sbox[8'hdb] = 8'h9f;
  assign inv_sbox[8'hdc] = 8'h93;
  assign inv_sbox[8'hdd] = 8'hc9;
  assign inv_sbox[8'hde] = 8'h9c;
  assign inv_sbox[8'hdf] = 8'hef;
  assign inv_sbox[8'he0] = 8'ha0;
  assign inv_sbox[8'he1] = 8'he0;
  assign inv_sbox[8'he2] = 8'h3b;
  assign inv_sbox[8'he3] = 8'h4d;
  assign inv_sbox[8'he4] = 8'hae;
  assign inv_sbox[8'he5] = 8'h2a;
  assign inv_sbox[8'he6] = 8'hf5;
  assign inv_sbox[8'he7] = 8'hb0;
  assign inv_sbox[8'he8] = 8'hc8;
  assign inv_sbox[8'he9] = 8'heb;
  assign inv_sbox[8'hea] = 8'hbb;
  assign inv_sbox[8'heb] = 8'h3c;
  assign inv_sbox[8'hec] = 8'h83;
  assign inv_sbox[8'hed] = 8'h53;
  assign inv_sbox[8'hee] = 8'h99;
  assign inv_sbox[8'hef] = 8'h61;
  assign inv_sbox[8'hf0] = 8'h17;
  assign inv_sbox[8'hf1] = 8'h2b;
  assign inv_sbox[8'hf2] = 8'h04;
  assign inv_sbox[8'hf3] = 8'h7e;
  assign inv_sbox[8'hf4] = 8'hba;
  assign inv_sbox[8'hf5] = 8'h77;
  assign inv_sbox[8'hf6] = 8'hd6;
  assign inv_sbox[8'hf7] = 8'h26;
  assign inv_sbox[8'hf8] = 8'he1;
  assign inv_sbox[8'hf9] = 8'h69;
  assign inv_sbox[8'hfa] = 8'h14;
  assign inv_sbox[8'hfb] = 8'h63;
  assign inv_sbox[8'hfc] = 8'h55;
  assign inv_sbox[8'hfd] = 8'h21;
  assign inv_sbox[8'hfe] = 8'h0c;
  assign inv_sbox[8'hff] = 8'h7d;

assign mul9[8'h00]=8'h00;
assign mul9[8'h01]=8'h09;
assign mul9[8'h02]=8'h12;
assign mul9[8'h03]=8'h1b;
assign mul9[8'h04]=8'h24;
assign mul9[8'h05]=8'h2d;
assign mul9[8'h06]=8'h36;
assign mul9[8'h07]=8'h3f;
assign mul9[8'h08]=8'h48;
assign mul9[8'h09]=8'h41;
assign mul9[8'h0a]=8'h5a;
assign mul9[8'h0b]=8'h53;
assign mul9[8'h0c]=8'h6c;
assign mul9[8'h0d]=8'h65;
assign mul9[8'h0e]=8'h7e;
assign mul9[8'h0f]=8'h77;
assign mul9[8'h10]=8'h90;
assign mul9[8'h11]=8'h99;
assign mul9[8'h12]=8'h82;
assign mul9[8'h13]=8'h8b;
assign mul9[8'h14]=8'hb4;
assign mul9[8'h15]=8'hbd;
assign mul9[8'h16]=8'ha6;
assign mul9[8'h17]=8'haf;
assign mul9[8'h18]=8'hd8;
assign mul9[8'h19]=8'hd1;
assign mul9[8'h1a]=8'hca;
assign mul9[8'h1b]=8'hc3;
assign mul9[8'h1c]=8'hfc;
assign mul9[8'h1d]=8'hf5;
assign mul9[8'h1e]=8'hee;
assign mul9[8'h1f]=8'he7;
assign mul9[8'h20]=8'h3b;
assign mul9[8'h21]=8'h32;
assign mul9[8'h22]=8'h29;
assign mul9[8'h23]=8'h20;
assign mul9[8'h24]=8'h1f;
assign mul9[8'h25]=8'h16;
assign mul9[8'h26]=8'h0d;
assign mul9[8'h27]=8'h04;
assign mul9[8'h28]=8'h73;
assign mul9[8'h29]=8'h7a;
assign mul9[8'h2a]=8'h61;
assign mul9[8'h2b]=8'h68;
assign mul9[8'h2c]=8'h57;
assign mul9[8'h2d]=8'h5e;
assign mul9[8'h2e]=8'h45;
assign mul9[8'h2f]=8'h4c;
assign mul9[8'h30]=8'hab;
assign mul9[8'h31]=8'ha2;
assign mul9[8'h32]=8'hb9;
assign mul9[8'h33]=8'hb0;
assign mul9[8'h34]=8'h8f;
assign mul9[8'h35]=8'h86;
assign mul9[8'h36]=8'h9d;
assign mul9[8'h37]=8'h94;
assign mul9[8'h38]=8'he3;
assign mul9[8'h39]=8'hea;
assign mul9[8'h3a]=8'hf1;
assign mul9[8'h3b]=8'hf8;
assign mul9[8'h3c]=8'hc7;
assign mul9[8'h3d]=8'hce;
assign mul9[8'h3e]=8'hd5;
assign mul9[8'h3f]=8'hdc;
assign mul9[8'h40]=8'h76;
assign mul9[8'h41]=8'h7f;
assign mul9[8'h42]=8'h64;
assign mul9[8'h43]=8'h6d;
assign mul9[8'h44]=8'h52;
assign mul9[8'h45]=8'h5b;
assign mul9[8'h46]=8'h40;
assign mul9[8'h47]=8'h49;
assign mul9[8'h48]=8'h3e;
assign mul9[8'h49]=8'h37;
assign mul9[8'h4a]=8'h2c;
assign mul9[8'h4b]=8'h25;
assign mul9[8'h4c]=8'h1a;
assign mul9[8'h4d]=8'h13;
assign mul9[8'h4e]=8'h08;
assign mul9[8'h4f]=8'h01;
assign mul9[8'h50]=8'he6;
assign mul9[8'h51]=8'hef;
assign mul9[8'h52]=8'hf4;
assign mul9[8'h53]=8'hfd;
assign mul9[8'h54]=8'hc2;
assign mul9[8'h55]=8'hcb;
assign mul9[8'h56]=8'hd0;
assign mul9[8'h57]=8'hd9;
assign mul9[8'h58]=8'hae;
assign mul9[8'h59]=8'ha7;
assign mul9[8'h5a]=8'hbc;
assign mul9[8'h5b]=8'hb5;
assign mul9[8'h5c]=8'h8a;
assign mul9[8'h5d]=8'h83;
assign mul9[8'h5e]=8'h98;
assign mul9[8'h5f]=8'h91;
assign mul9[8'h60]=8'h4d;
assign mul9[8'h61]=8'h44;
assign mul9[8'h62]=8'h5f;
assign mul9[8'h63]=8'h56;
assign mul9[8'h64]=8'h69;
assign mul9[8'h65]=8'h60;
assign mul9[8'h66]=8'h7b;
assign mul9[8'h67]=8'h72;
assign mul9[8'h68]=8'h05;
assign mul9[8'h69]=8'h0c;
assign mul9[8'h6a]=8'h17;
assign mul9[8'h6b]=8'h1e;
assign mul9[8'h6c]=8'h21;
assign mul9[8'h6d]=8'h28;
assign mul9[8'h6e]=8'h33;
assign mul9[8'h6f]=8'h3a;
assign mul9[8'h70]=8'hdd;
assign mul9[8'h71]=8'hd4;
assign mul9[8'h72]=8'hcf;
assign mul9[8'h73]=8'hc6;
assign mul9[8'h74]=8'hf9;
assign mul9[8'h75]=8'hf0;
assign mul9[8'h76]=8'heb;
assign mul9[8'h77]=8'he2;
assign mul9[8'h78]=8'h95;
assign mul9[8'h79]=8'h9c;
assign mul9[8'h7a]=8'h87;
assign mul9[8'h7b]=8'h8e;
assign mul9[8'h7c]=8'hb1;
assign mul9[8'h7d]=8'hb8;
assign mul9[8'h7e]=8'ha3;
assign mul9[8'h7f]=8'haa;
assign mul9[8'h80]=8'hec;
assign mul9[8'h81]=8'he5;
assign mul9[8'h82]=8'hfe;
assign mul9[8'h83]=8'hf7;
assign mul9[8'h84]=8'hc8;
assign mul9[8'h85]=8'hc1;
assign mul9[8'h86]=8'hda;
assign mul9[8'h87]=8'hd3;
assign mul9[8'h88]=8'ha4;
assign mul9[8'h89]=8'had;
assign mul9[8'h8a]=8'hb6;
assign mul9[8'h8b]=8'hbf;
assign mul9[8'h8c]=8'h80;
assign mul9[8'h8d]=8'h89;
assign mul9[8'h8e]=8'h92;
assign mul9[8'h8f]=8'h9b;
assign mul9[8'h90]=8'h7c;
assign mul9[8'h91]=8'h75;
assign mul9[8'h92]=8'h6e;
assign mul9[8'h93]=8'h67;
assign mul9[8'h94]=8'h58;
assign mul9[8'h95]=8'h51;
assign mul9[8'h96]=8'h4a;
assign mul9[8'h97]=8'h43;
assign mul9[8'h98]=8'h34;
assign mul9[8'h99]=8'h3d;
assign mul9[8'h9a]=8'h26;
assign mul9[8'h9b]=8'h2f;
assign mul9[8'h9c]=8'h10;
assign mul9[8'h9d]=8'h19;
assign mul9[8'h9e]=8'h02;
assign mul9[8'h9f]=8'h0b;
assign mul9[8'ha0]=8'hd7;
assign mul9[8'ha1]=8'hde;
assign mul9[8'ha2]=8'hc5;
assign mul9[8'ha3]=8'hcc;
assign mul9[8'ha4]=8'hf3;
assign mul9[8'ha5]=8'hfa;
assign mul9[8'ha6]=8'he1;
assign mul9[8'ha7]=8'he8;
assign mul9[8'ha8]=8'h9f;
assign mul9[8'ha9]=8'h96;
assign mul9[8'haa]=8'h8d;
assign mul9[8'hab]=8'h84;
assign mul9[8'hac]=8'hbb;
assign mul9[8'had]=8'hb2;
assign mul9[8'hae]=8'ha9;
assign mul9[8'haf]=8'ha0;
assign mul9[8'hb0]=8'h47;
assign mul9[8'hb1]=8'h4e;
assign mul9[8'hb2]=8'h55;
assign mul9[8'hb3]=8'h5c;
assign mul9[8'hb4]=8'h63;
assign mul9[8'hb5]=8'h6a;
assign mul9[8'hb6]=8'h71;
assign mul9[8'hb7]=8'h78;
assign mul9[8'hb8]=8'h0f;
assign mul9[8'hb9]=8'h06;
assign mul9[8'hba]=8'h1d;
assign mul9[8'hbb]=8'h14;
assign mul9[8'hbc]=8'h2b;
assign mul9[8'hbd]=8'h22;
assign mul9[8'hbe]=8'h39;
assign mul9[8'hbf]=8'h30;
assign mul9[8'hc0]=8'h9a;
assign mul9[8'hc1]=8'h93;
assign mul9[8'hc2]=8'h88;
assign mul9[8'hc3]=8'h81;
assign mul9[8'hc4]=8'hbe;
assign mul9[8'hc5]=8'hb7;
assign mul9[8'hc6]=8'hac;
assign mul9[8'hc7]=8'ha5;
assign mul9[8'hc8]=8'hd2;
assign mul9[8'hc9]=8'hdb;
assign mul9[8'hca]=8'hc0;
assign mul9[8'hcb]=8'hc9;
assign mul9[8'hcc]=8'hf6;
assign mul9[8'hcd]=8'hff;
assign mul9[8'hce]=8'he4;
assign mul9[8'hcf]=8'hed;
assign mul9[8'hd0]=8'h0a;
assign mul9[8'hd1]=8'h03;
assign mul9[8'hd2]=8'h18;
assign mul9[8'hd3]=8'h11;
assign mul9[8'hd4]=8'h2e;
assign mul9[8'hd5]=8'h27;
assign mul9[8'hd6]=8'h3c;
assign mul9[8'hd7]=8'h35;
assign mul9[8'hd8]=8'h42;
assign mul9[8'hd9]=8'h4b;
assign mul9[8'hda]=8'h50;
assign mul9[8'hdb]=8'h59;
assign mul9[8'hdc]=8'h66;
assign mul9[8'hdd]=8'h6f;
assign mul9[8'hde]=8'h74;
assign mul9[8'hdf]=8'h7d;
assign mul9[8'he0]=8'ha1;
assign mul9[8'he1]=8'ha8;
assign mul9[8'he2]=8'hb3;
assign mul9[8'he3]=8'hba;
assign mul9[8'he4]=8'h85;
assign mul9[8'he5]=8'h8c;
assign mul9[8'he6]=8'h97;
assign mul9[8'he7]=8'h9e;
assign mul9[8'he8]=8'he9;
assign mul9[8'he9]=8'he0;
assign mul9[8'hea]=8'hfb;
assign mul9[8'heb]=8'hf2;
assign mul9[8'hec]=8'hcd;
assign mul9[8'hed]=8'hc4;
assign mul9[8'hee]=8'hdf;
assign mul9[8'hef]=8'hd6;
assign mul9[8'hf0]=8'h31;
assign mul9[8'hf1]=8'h38;
assign mul9[8'hf2]=8'h23;
assign mul9[8'hf3]=8'h2a;
assign mul9[8'hf4]=8'h15;
assign mul9[8'hf5]=8'h1c;
assign mul9[8'hf6]=8'h07;
assign mul9[8'hf7]=8'h0e;
assign mul9[8'hf8]=8'h79;
assign mul9[8'hf9]=8'h70;
assign mul9[8'hfa]=8'h6b;
assign mul9[8'hfb]=8'h62;
assign mul9[8'hfc]=8'h5d;
assign mul9[8'hfd]=8'h54;
assign mul9[8'hfe]=8'h4f;
assign mul9[8'hff]=8'h46;

assign mul11[8'h00]=8'h00;
assign mul11[8'h01]=8'h0b;
assign mul11[8'h02]=8'h16;
assign mul11[8'h03]=8'h1d;
assign mul11[8'h04]=8'h2c;
assign mul11[8'h05]=8'h27;
assign mul11[8'h06]=8'h3a;
assign mul11[8'h07]=8'h31;
assign mul11[8'h08]=8'h58;
assign mul11[8'h09]=8'h53;
assign mul11[8'h0a]=8'h4e;
assign mul11[8'h0b]=8'h45;
assign mul11[8'h0c]=8'h74;
assign mul11[8'h0d]=8'h7f;
assign mul11[8'h0e]=8'h62;
assign mul11[8'h0f]=8'h69;
assign mul11[8'h10]=8'hb0;
assign mul11[8'h11]=8'hbb;
assign mul11[8'h12]=8'ha6;
assign mul11[8'h13]=8'had;
assign mul11[8'h14]=8'h9c;
assign mul11[8'h15]=8'h97;
assign mul11[8'h16]=8'h8a;
assign mul11[8'h17]=8'h81;
assign mul11[8'h18]=8'he8;
assign mul11[8'h19]=8'he3;
assign mul11[8'h1a]=8'hfe;
assign mul11[8'h1b]=8'hf5;
assign mul11[8'h1c]=8'hc4;
assign mul11[8'h1d]=8'hcf;
assign mul11[8'h1e]=8'hd2;
assign mul11[8'h1f]=8'hd9;
assign mul11[8'h20]=8'h7b;
assign mul11[8'h21]=8'h70;
assign mul11[8'h22]=8'h6d;
assign mul11[8'h23]=8'h66;
assign mul11[8'h24]=8'h57;
assign mul11[8'h25]=8'h5c;
assign mul11[8'h26]=8'h41;
assign mul11[8'h27]=8'h4a;
assign mul11[8'h28]=8'h23;
assign mul11[8'h29]=8'h28;
assign mul11[8'h2a]=8'h35;
assign mul11[8'h2b]=8'h3e;
assign mul11[8'h2c]=8'h0f;
assign mul11[8'h2d]=8'h04;
assign mul11[8'h2e]=8'h19;
assign mul11[8'h2f]=8'h12;
assign mul11[8'h30]=8'hcb;
assign mul11[8'h31]=8'hc0;
assign mul11[8'h32]=8'hdd;
assign mul11[8'h33]=8'hd6;
assign mul11[8'h34]=8'he7;
assign mul11[8'h35]=8'hec;
assign mul11[8'h36]=8'hf1;
assign mul11[8'h37]=8'hfa;
assign mul11[8'h38]=8'h93;
assign mul11[8'h39]=8'h98;
assign mul11[8'h3a]=8'h85;
assign mul11[8'h3b]=8'h8e;
assign mul11[8'h3c]=8'hbf;
assign mul11[8'h3d]=8'hb4;
assign mul11[8'h3e]=8'ha9;
assign mul11[8'h3f]=8'ha2;
assign mul11[8'h40]=8'hf6;
assign mul11[8'h41]=8'hfd;
assign mul11[8'h42]=8'he0;
assign mul11[8'h43]=8'heb;
assign mul11[8'h44]=8'hda;
assign mul11[8'h45]=8'hd1;
assign mul11[8'h46]=8'hcc;
assign mul11[8'h47]=8'hc7;
assign mul11[8'h48]=8'hae;
assign mul11[8'h49]=8'ha5;
assign mul11[8'h4a]=8'hb8;
assign mul11[8'h4b]=8'hb3;
assign mul11[8'h4c]=8'h82;
assign mul11[8'h4d]=8'h89;
assign mul11[8'h4e]=8'h94;
assign mul11[8'h4f]=8'h9f;
assign mul11[8'h50]=8'h46;
assign mul11[8'h51]=8'h4d;
assign mul11[8'h52]=8'h50;
assign mul11[8'h53]=8'h5b;
assign mul11[8'h54]=8'h6a;
assign mul11[8'h55]=8'h61;
assign mul11[8'h56]=8'h7c;
assign mul11[8'h57]=8'h77;
assign mul11[8'h58]=8'h1e;
assign mul11[8'h59]=8'h15;
assign mul11[8'h5a]=8'h08;
assign mul11[8'h5b]=8'h03;
assign mul11[8'h5c]=8'h32;
assign mul11[8'h5d]=8'h39;
assign mul11[8'h5e]=8'h24;
assign mul11[8'h5f]=8'h2f;
assign mul11[8'h60]=8'h8d;
assign mul11[8'h61]=8'h86;
assign mul11[8'h62]=8'h9b;
assign mul11[8'h63]=8'h90;
assign mul11[8'h64]=8'ha1;
assign mul11[8'h65]=8'haa;
assign mul11[8'h66]=8'hb7;
assign mul11[8'h67]=8'hbc;
assign mul11[8'h68]=8'hd5;
assign mul11[8'h69]=8'hde;
assign mul11[8'h6a]=8'hc3;
assign mul11[8'h6b]=8'hc8;
assign mul11[8'h6c]=8'hf9;
assign mul11[8'h6d]=8'hf2;
assign mul11[8'h6e]=8'hef;
assign mul11[8'h6f]=8'he4;
assign mul11[8'h70]=8'h3d;
assign mul11[8'h71]=8'h36;
assign mul11[8'h72]=8'h2b;
assign mul11[8'h73]=8'h20;
assign mul11[8'h74]=8'h11;
assign mul11[8'h75]=8'h1a;
assign mul11[8'h76]=8'h07;
assign mul11[8'h77]=8'h0c;
assign mul11[8'h78]=8'h65;
assign mul11[8'h79]=8'h6e;
assign mul11[8'h7a]=8'h73;
assign mul11[8'h7b]=8'h78;
assign mul11[8'h7c]=8'h49;
assign mul11[8'h7d]=8'h42;
assign mul11[8'h7e]=8'h5f;
assign mul11[8'h7f]=8'h54;
assign mul11[8'h80]=8'hf7;
assign mul11[8'h81]=8'hfc;
assign mul11[8'h82]=8'he1;
assign mul11[8'h83]=8'hea;
assign mul11[8'h84]=8'hdb;
assign mul11[8'h85]=8'hd0;
assign mul11[8'h86]=8'hcd;
assign mul11[8'h87]=8'hc6;
assign mul11[8'h88]=8'haf;
assign mul11[8'h89]=8'ha4;
assign mul11[8'h8a]=8'hb9;
assign mul11[8'h8b]=8'hb2;
assign mul11[8'h8c]=8'h83;
assign mul11[8'h8d]=8'h88;
assign mul11[8'h8e]=8'h95;
assign mul11[8'h8f]=8'h9e;
assign mul11[8'h90]=8'h47;
assign mul11[8'h91]=8'h4c;
assign mul11[8'h92]=8'h51;
assign mul11[8'h93]=8'h5a;
assign mul11[8'h94]=8'h6b;
assign mul11[8'h95]=8'h60;
assign mul11[8'h96]=8'h7d;
assign mul11[8'h97]=8'h76;
assign mul11[8'h98]=8'h1f;
assign mul11[8'h99]=8'h14;
assign mul11[8'h9a]=8'h09;
assign mul11[8'h9b]=8'h02;
assign mul11[8'h9c]=8'h33;
assign mul11[8'h9d]=8'h38;
assign mul11[8'h9e]=8'h25;
assign mul11[8'h9f]=8'h2e;
assign mul11[8'ha0]=8'h8c;
assign mul11[8'ha1]=8'h87;
assign mul11[8'ha2]=8'h9a;
assign mul11[8'ha3]=8'h91;
assign mul11[8'ha4]=8'ha0;
assign mul11[8'ha5]=8'hab;
assign mul11[8'ha6]=8'hb6;
assign mul11[8'ha7]=8'hbd;
assign mul11[8'ha8]=8'hd4;
assign mul11[8'ha9]=8'hdf;
assign mul11[8'haa]=8'hc2;
assign mul11[8'hab]=8'hc9;
assign mul11[8'hac]=8'hf8;
assign mul11[8'had]=8'hf3;
assign mul11[8'hae]=8'hee;
assign mul11[8'haf]=8'he5;
assign mul11[8'hb0]=8'h3c;
assign mul11[8'hb1]=8'h37;
assign mul11[8'hb2]=8'h2a;
assign mul11[8'hb3]=8'h21;
assign mul11[8'hb4]=8'h10;
assign mul11[8'hb5]=8'h1b;
assign mul11[8'hb6]=8'h06;
assign mul11[8'hb7]=8'h0d;
assign mul11[8'hb8]=8'h64;
assign mul11[8'hb9]=8'h6f;
assign mul11[8'hba]=8'h72;
assign mul11[8'hbb]=8'h79;
assign mul11[8'hbc]=8'h48;
assign mul11[8'hbd]=8'h43;
assign mul11[8'hbe]=8'h5e;
assign mul11[8'hbf]=8'h55;
assign mul11[8'hc0]=8'h01;
assign mul11[8'hc1]=8'h0a;
assign mul11[8'hc2]=8'h17;
assign mul11[8'hc3]=8'h1c;
assign mul11[8'hc4]=8'h2d;
assign mul11[8'hc5]=8'h26;
assign mul11[8'hc6]=8'h3b;
assign mul11[8'hc7]=8'h30;
assign mul11[8'hc8]=8'h59;
assign mul11[8'hc9]=8'h52;
assign mul11[8'hca]=8'h4f;
assign mul11[8'hcb]=8'h44;
assign mul11[8'hcc]=8'h75;
assign mul11[8'hcd]=8'h7e;
assign mul11[8'hce]=8'h63;
assign mul11[8'hcf]=8'h68;
assign mul11[8'hd0]=8'hb1;
assign mul11[8'hd1]=8'hba;
assign mul11[8'hd2]=8'ha7;
assign mul11[8'hd3]=8'hac;
assign mul11[8'hd4]=8'h9d;
assign mul11[8'hd5]=8'h96;
assign mul11[8'hd6]=8'h8b;
assign mul11[8'hd7]=8'h80;
assign mul11[8'hd8]=8'he9;
assign mul11[8'hd9]=8'he2;
assign mul11[8'hda]=8'hff;
assign mul11[8'hdb]=8'hf4;
assign mul11[8'hdc]=8'hc5;
assign mul11[8'hdd]=8'hce;
assign mul11[8'hde]=8'hd3;
assign mul11[8'hdf]=8'hd8;
assign mul11[8'he0]=8'h7a;
assign mul11[8'he1]=8'h71;
assign mul11[8'he2]=8'h6c;
assign mul11[8'he3]=8'h67;
assign mul11[8'he4]=8'h56;
assign mul11[8'he5]=8'h5d;
assign mul11[8'he6]=8'h40;
assign mul11[8'he7]=8'h4b;
assign mul11[8'he8]=8'h22;
assign mul11[8'he9]=8'h29;
assign mul11[8'hea]=8'h34;
assign mul11[8'heb]=8'h3f;
assign mul11[8'hec]=8'h0e;
assign mul11[8'hed]=8'h05;
assign mul11[8'hee]=8'h18;
assign mul11[8'hef]=8'h13;
assign mul11[8'hf0]=8'hca;
assign mul11[8'hf1]=8'hc1;
assign mul11[8'hf2]=8'hdc;
assign mul11[8'hf3]=8'hd7;
assign mul11[8'hf4]=8'he6;
assign mul11[8'hf5]=8'hed;
assign mul11[8'hf6]=8'hf0;
assign mul11[8'hf7]=8'hfb;
assign mul11[8'hf8]=8'h92;
assign mul11[8'hf9]=8'h99;
assign mul11[8'hfa]=8'h84;
assign mul11[8'hfb]=8'h8f;
assign mul11[8'hfc]=8'hbe;
assign mul11[8'hfd]=8'hb5;
assign mul11[8'hfe]=8'ha8;
assign mul11[8'hff]=8'ha3;

assign mul13[8'h00]=8'h00;
assign mul13[8'h01]=8'h0d;
assign mul13[8'h02]=8'h1a;
assign mul13[8'h03]=8'h17;
assign mul13[8'h04]=8'h34;
assign mul13[8'h05]=8'h39;
assign mul13[8'h06]=8'h2e;
assign mul13[8'h07]=8'h23;
assign mul13[8'h08]=8'h68;
assign mul13[8'h09]=8'h65;
assign mul13[8'h0a]=8'h72;
assign mul13[8'h0b]=8'h7f;
assign mul13[8'h0c]=8'h5c;
assign mul13[8'h0d]=8'h51;
assign mul13[8'h0e]=8'h46;
assign mul13[8'h0f]=8'h4b;
assign mul13[8'h10]=8'hd0;
assign mul13[8'h11]=8'hdd;
assign mul13[8'h12]=8'hca;
assign mul13[8'h13]=8'hc7;
assign mul13[8'h14]=8'he4;
assign mul13[8'h15]=8'he9;
assign mul13[8'h16]=8'hfe;
assign mul13[8'h17]=8'hf3;
assign mul13[8'h18]=8'hb8;
assign mul13[8'h19]=8'hb5;
assign mul13[8'h1a]=8'ha2;
assign mul13[8'h1b]=8'haf;
assign mul13[8'h1c]=8'h8c;
assign mul13[8'h1d]=8'h81;
assign mul13[8'h1e]=8'h96;
assign mul13[8'h1f]=8'h9b;
assign mul13[8'h20]=8'hbb;
assign mul13[8'h21]=8'hb6;
assign mul13[8'h22]=8'ha1;
assign mul13[8'h23]=8'hac;
assign mul13[8'h24]=8'h8f;
assign mul13[8'h25]=8'h82;
assign mul13[8'h26]=8'h95;
assign mul13[8'h27]=8'h98;
assign mul13[8'h28]=8'hd3;
assign mul13[8'h29]=8'hde;
assign mul13[8'h2a]=8'hc9;
assign mul13[8'h2b]=8'hc4;
assign mul13[8'h2c]=8'he7;
assign mul13[8'h2d]=8'hea;
assign mul13[8'h2e]=8'hfd;
assign mul13[8'h2f]=8'hf0;
assign mul13[8'h30]=8'h6b;
assign mul13[8'h31]=8'h66;
assign mul13[8'h32]=8'h71;
assign mul13[8'h33]=8'h7c;
assign mul13[8'h34]=8'h5f;
assign mul13[8'h35]=8'h52;
assign mul13[8'h36]=8'h45;
assign mul13[8'h37]=8'h48;
assign mul13[8'h38]=8'h03;
assign mul13[8'h39]=8'h0e;
assign mul13[8'h3a]=8'h19;
assign mul13[8'h3b]=8'h14;
assign mul13[8'h3c]=8'h37;
assign mul13[8'h3d]=8'h3a;
assign mul13[8'h3e]=8'h2d;
assign mul13[8'h3f]=8'h20;
assign mul13[8'h40]=8'h6d;
assign mul13[8'h41]=8'h60;
assign mul13[8'h42]=8'h77;
assign mul13[8'h43]=8'h7a;
assign mul13[8'h44]=8'h59;
assign mul13[8'h45]=8'h54;
assign mul13[8'h46]=8'h43;
assign mul13[8'h47]=8'h4e;
assign mul13[8'h48]=8'h05;
assign mul13[8'h49]=8'h08;
assign mul13[8'h4a]=8'h1f;
assign mul13[8'h4b]=8'h12;
assign mul13[8'h4c]=8'h31;
assign mul13[8'h4d]=8'h3c;
assign mul13[8'h4e]=8'h2b;
assign mul13[8'h4f]=8'h26;
assign mul13[8'h50]=8'hbd;
assign mul13[8'h51]=8'hb0;
assign mul13[8'h52]=8'ha7;
assign mul13[8'h53]=8'haa;
assign mul13[8'h54]=8'h89;
assign mul13[8'h55]=8'h84;
assign mul13[8'h56]=8'h93;
assign mul13[8'h57]=8'h9e;
assign mul13[8'h58]=8'hd5;
assign mul13[8'h59]=8'hd8;
assign mul13[8'h5a]=8'hcf;
assign mul13[8'h5b]=8'hc2;
assign mul13[8'h5c]=8'he1;
assign mul13[8'h5d]=8'hec;
assign mul13[8'h5e]=8'hfb;
assign mul13[8'h5f]=8'hf6;
assign mul13[8'h60]=8'hd6;
assign mul13[8'h61]=8'hdb;
assign mul13[8'h62]=8'hcc;
assign mul13[8'h63]=8'hc1;
assign mul13[8'h64]=8'he2;
assign mul13[8'h65]=8'hef;
assign mul13[8'h66]=8'hf8;
assign mul13[8'h67]=8'hf5;
assign mul13[8'h68]=8'hbe;
assign mul13[8'h69]=8'hb3;
assign mul13[8'h6a]=8'ha4;
assign mul13[8'h6b]=8'ha9;
assign mul13[8'h6c]=8'h8a;
assign mul13[8'h6d]=8'h87;
assign mul13[8'h6e]=8'h90;
assign mul13[8'h6f]=8'h9d;
assign mul13[8'h70]=8'h06;
assign mul13[8'h71]=8'h0b;
assign mul13[8'h72]=8'h1c;
assign mul13[8'h73]=8'h11;
assign mul13[8'h74]=8'h32;
assign mul13[8'h75]=8'h3f;
assign mul13[8'h76]=8'h28;
assign mul13[8'h77]=8'h25;
assign mul13[8'h78]=8'h6e;
assign mul13[8'h79]=8'h63;
assign mul13[8'h7a]=8'h74;
assign mul13[8'h7b]=8'h79;
assign mul13[8'h7c]=8'h5a;
assign mul13[8'h7d]=8'h57;
assign mul13[8'h7e]=8'h40;
assign mul13[8'h7f]=8'h4d;
assign mul13[8'h80]=8'hda;
assign mul13[8'h81]=8'hd7;
assign mul13[8'h82]=8'hc0;
assign mul13[8'h83]=8'hcd;
assign mul13[8'h84]=8'hee;
assign mul13[8'h85]=8'he3;
assign mul13[8'h86]=8'hf4;
assign mul13[8'h87]=8'hf9;
assign mul13[8'h88]=8'hb2;
assign mul13[8'h89]=8'hbf;
assign mul13[8'h8a]=8'ha8;
assign mul13[8'h8b]=8'ha5;
assign mul13[8'h8c]=8'h86;
assign mul13[8'h8d]=8'h8b;
assign mul13[8'h8e]=8'h9c;
assign mul13[8'h8f]=8'h91;
assign mul13[8'h90]=8'h0a;
assign mul13[8'h91]=8'h07;
assign mul13[8'h92]=8'h10;
assign mul13[8'h93]=8'h1d;
assign mul13[8'h94]=8'h3e;
assign mul13[8'h95]=8'h33;
assign mul13[8'h96]=8'h24;
assign mul13[8'h97]=8'h29;
assign mul13[8'h98]=8'h62;
assign mul13[8'h99]=8'h6f;
assign mul13[8'h9a]=8'h78;
assign mul13[8'h9b]=8'h75;
assign mul13[8'h9c]=8'h56;
assign mul13[8'h9d]=8'h5b;
assign mul13[8'h9e]=8'h4c;
assign mul13[8'h9f]=8'h41;
assign mul13[8'ha0]=8'h61;
assign mul13[8'ha1]=8'h6c;
assign mul13[8'ha2]=8'h7b;
assign mul13[8'ha3]=8'h76;
assign mul13[8'ha4]=8'h55;
assign mul13[8'ha5]=8'h58;
assign mul13[8'ha6]=8'h4f;
assign mul13[8'ha7]=8'h42;
assign mul13[8'ha8]=8'h09;
assign mul13[8'ha9]=8'h04;
assign mul13[8'haa]=8'h13;
assign mul13[8'hab]=8'h1e;
assign mul13[8'hac]=8'h3d;
assign mul13[8'had]=8'h30;
assign mul13[8'hae]=8'h27;
assign mul13[8'haf]=8'h2a;
assign mul13[8'hb0]=8'hb1;
assign mul13[8'hb1]=8'hbc;
assign mul13[8'hb2]=8'hab;
assign mul13[8'hb3]=8'ha6;
assign mul13[8'hb4]=8'h85;
assign mul13[8'hb5]=8'h88;
assign mul13[8'hb6]=8'h9f;
assign mul13[8'hb7]=8'h92;
assign mul13[8'hb8]=8'hd9;
assign mul13[8'hb9]=8'hd4;
assign mul13[8'hba]=8'hc3;
assign mul13[8'hbb]=8'hce;
assign mul13[8'hbc]=8'hed;
assign mul13[8'hbd]=8'he0;
assign mul13[8'hbe]=8'hf7;
assign mul13[8'hbf]=8'hfa;
assign mul13[8'hc0]=8'hb7;
assign mul13[8'hc1]=8'hba;
assign mul13[8'hc2]=8'had;
assign mul13[8'hc3]=8'ha0;
assign mul13[8'hc4]=8'h83;
assign mul13[8'hc5]=8'h8e;
assign mul13[8'hc6]=8'h99;
assign mul13[8'hc7]=8'h94;
assign mul13[8'hc8]=8'hdf;
assign mul13[8'hc9]=8'hd2;
assign mul13[8'hca]=8'hc5;
assign mul13[8'hcb]=8'hc8;
assign mul13[8'hcc]=8'heb;
assign mul13[8'hcd]=8'he6;
assign mul13[8'hce]=8'hf1;
assign mul13[8'hcf]=8'hfc;
assign mul13[8'hd0]=8'h67;
assign mul13[8'hd1]=8'h6a;
assign mul13[8'hd2]=8'h7d;
assign mul13[8'hd3]=8'h70;
assign mul13[8'hd4]=8'h53;
assign mul13[8'hd5]=8'h5e;
assign mul13[8'hd6]=8'h49;
assign mul13[8'hd7]=8'h44;
assign mul13[8'hd8]=8'h0f;
assign mul13[8'hd9]=8'h02;
assign mul13[8'hda]=8'h15;
assign mul13[8'hdb]=8'h18;
assign mul13[8'hdc]=8'h3b;
assign mul13[8'hdd]=8'h36;
assign mul13[8'hde]=8'h21;
assign mul13[8'hdf]=8'h2c;
assign mul13[8'he0]=8'h0c;
assign mul13[8'he1]=8'h01;
assign mul13[8'he2]=8'h16;
assign mul13[8'he3]=8'h1b;
assign mul13[8'he4]=8'h38;
assign mul13[8'he5]=8'h35;
assign mul13[8'he6]=8'h22;
assign mul13[8'he7]=8'h2f;
assign mul13[8'he8]=8'h64;
assign mul13[8'he9]=8'h69;
assign mul13[8'hea]=8'h7e;
assign mul13[8'heb]=8'h73;
assign mul13[8'hec]=8'h50;
assign mul13[8'hed]=8'h5d;
assign mul13[8'hee]=8'h4a;
assign mul13[8'hef]=8'h47;
assign mul13[8'hf0]=8'hdc;
assign mul13[8'hf1]=8'hd1;
assign mul13[8'hf2]=8'hc6;
assign mul13[8'hf3]=8'hcb;
assign mul13[8'hf4]=8'he8;
assign mul13[8'hf5]=8'he5;
assign mul13[8'hf6]=8'hf2;
assign mul13[8'hf7]=8'hff;
assign mul13[8'hf8]=8'hb4;
assign mul13[8'hf9]=8'hb9;
assign mul13[8'hfa]=8'hae;
assign mul13[8'hfb]=8'ha3;
assign mul13[8'hfc]=8'h80;
assign mul13[8'hfd]=8'h8d;
assign mul13[8'hfe]=8'h9a;
assign mul13[8'hff]=8'h97;

assign mul14[8'h00]=8'h00;
assign mul14[8'h01]=8'h0e;
assign mul14[8'h02]=8'h1c;
assign mul14[8'h03]=8'h12;
assign mul14[8'h04]=8'h38;
assign mul14[8'h05]=8'h36;
assign mul14[8'h06]=8'h24;
assign mul14[8'h07]=8'h2a;
assign mul14[8'h08]=8'h70;
assign mul14[8'h09]=8'h7e;
assign mul14[8'h0a]=8'h6c;
assign mul14[8'h0b]=8'h62;
assign mul14[8'h0c]=8'h48;
assign mul14[8'h0d]=8'h46;
assign mul14[8'h0e]=8'h54;
assign mul14[8'h0f]=8'h5a;
assign mul14[8'h10]=8'he0;
assign mul14[8'h11]=8'hee;
assign mul14[8'h12]=8'hfc;
assign mul14[8'h13]=8'hf2;
assign mul14[8'h14]=8'hd8;
assign mul14[8'h15]=8'hd6;
assign mul14[8'h16]=8'hc4;
assign mul14[8'h17]=8'hca;
assign mul14[8'h18]=8'h90;
assign mul14[8'h19]=8'h9e;
assign mul14[8'h1a]=8'h8c;
assign mul14[8'h1b]=8'h82;
assign mul14[8'h1c]=8'ha8;
assign mul14[8'h1d]=8'ha6;
assign mul14[8'h1e]=8'hb4;
assign mul14[8'h1f]=8'hba;
assign mul14[8'h20]=8'hdb;
assign mul14[8'h21]=8'hd5;
assign mul14[8'h22]=8'hc7;
assign mul14[8'h23]=8'hc9;
assign mul14[8'h24]=8'he3;
assign mul14[8'h25]=8'hed;
assign mul14[8'h26]=8'hff;
assign mul14[8'h27]=8'hf1;
assign mul14[8'h28]=8'hab;
assign mul14[8'h29]=8'ha5;
assign mul14[8'h2a]=8'hb7;
assign mul14[8'h2b]=8'hb9;
assign mul14[8'h2c]=8'h93;
assign mul14[8'h2d]=8'h9d;
assign mul14[8'h2e]=8'h8f;
assign mul14[8'h2f]=8'h81;
assign mul14[8'h30]=8'h3b;
assign mul14[8'h31]=8'h35;
assign mul14[8'h32]=8'h27;
assign mul14[8'h33]=8'h29;
assign mul14[8'h34]=8'h03;
assign mul14[8'h35]=8'h0d;
assign mul14[8'h36]=8'h1f;
assign mul14[8'h37]=8'h11;
assign mul14[8'h38]=8'h4b;
assign mul14[8'h39]=8'h45;
assign mul14[8'h3a]=8'h57;
assign mul14[8'h3b]=8'h59;
assign mul14[8'h3c]=8'h73;
assign mul14[8'h3d]=8'h7d;
assign mul14[8'h3e]=8'h6f;
assign mul14[8'h3f]=8'h61;
assign mul14[8'h40]=8'had;
assign mul14[8'h41]=8'ha3;
assign mul14[8'h42]=8'hb1;
assign mul14[8'h43]=8'hbf;
assign mul14[8'h44]=8'h95;
assign mul14[8'h45]=8'h9b;
assign mul14[8'h46]=8'h89;
assign mul14[8'h47]=8'h87;
assign mul14[8'h48]=8'hdd;
assign mul14[8'h49]=8'hd3;
assign mul14[8'h4a]=8'hc1;
assign mul14[8'h4b]=8'hcf;
assign mul14[8'h4c]=8'he5;
assign mul14[8'h4d]=8'heb;
assign mul14[8'h4e]=8'hf9;
assign mul14[8'h4f]=8'hf7;
assign mul14[8'h50]=8'h4d;
assign mul14[8'h51]=8'h43;
assign mul14[8'h52]=8'h51;
assign mul14[8'h53]=8'h5f;
assign mul14[8'h54]=8'h75;
assign mul14[8'h55]=8'h7b;
assign mul14[8'h56]=8'h69;
assign mul14[8'h57]=8'h67;
assign mul14[8'h58]=8'h3d;
assign mul14[8'h59]=8'h33;
assign mul14[8'h5a]=8'h21;
assign mul14[8'h5b]=8'h2f;
assign mul14[8'h5c]=8'h05;
assign mul14[8'h5d]=8'h0b;
assign mul14[8'h5e]=8'h19;
assign mul14[8'h5f]=8'h17;
assign mul14[8'h60]=8'h76;
assign mul14[8'h61]=8'h78;
assign mul14[8'h62]=8'h6a;
assign mul14[8'h63]=8'h64;
assign mul14[8'h64]=8'h4e;
assign mul14[8'h65]=8'h40;
assign mul14[8'h66]=8'h52;
assign mul14[8'h67]=8'h5c;
assign mul14[8'h68]=8'h06;
assign mul14[8'h69]=8'h08;
assign mul14[8'h6a]=8'h1a;
assign mul14[8'h6b]=8'h14;
assign mul14[8'h6c]=8'h3e;
assign mul14[8'h6d]=8'h30;
assign mul14[8'h6e]=8'h22;
assign mul14[8'h6f]=8'h2c;
assign mul14[8'h70]=8'h96;
assign mul14[8'h71]=8'h98;
assign mul14[8'h72]=8'h8a;
assign mul14[8'h73]=8'h84;
assign mul14[8'h74]=8'hae;
assign mul14[8'h75]=8'ha0;
assign mul14[8'h76]=8'hb2;
assign mul14[8'h77]=8'hbc;
assign mul14[8'h78]=8'he6;
assign mul14[8'h79]=8'he8;
assign mul14[8'h7a]=8'hfa;
assign mul14[8'h7b]=8'hf4;
assign mul14[8'h7c]=8'hde;
assign mul14[8'h7d]=8'hd0;
assign mul14[8'h7e]=8'hc2;
assign mul14[8'h7f]=8'hcc;
assign mul14[8'h80]=8'h41;
assign mul14[8'h81]=8'h4f;
assign mul14[8'h82]=8'h5d;
assign mul14[8'h83]=8'h53;
assign mul14[8'h84]=8'h79;
assign mul14[8'h85]=8'h77;
assign mul14[8'h86]=8'h65;
assign mul14[8'h87]=8'h6b;
assign mul14[8'h88]=8'h31;
assign mul14[8'h89]=8'h3f;
assign mul14[8'h8a]=8'h2d;
assign mul14[8'h8b]=8'h23;
assign mul14[8'h8c]=8'h09;
assign mul14[8'h8d]=8'h07;
assign mul14[8'h8e]=8'h15;
assign mul14[8'h8f]=8'h1b;
assign mul14[8'h90]=8'ha1;
assign mul14[8'h91]=8'haf;
assign mul14[8'h92]=8'hbd;
assign mul14[8'h93]=8'hb3;
assign mul14[8'h94]=8'h99;
assign mul14[8'h95]=8'h97;
assign mul14[8'h96]=8'h85;
assign mul14[8'h97]=8'h8b;
assign mul14[8'h98]=8'hd1;
assign mul14[8'h99]=8'hdf;
assign mul14[8'h9a]=8'hcd;
assign mul14[8'h9b]=8'hc3;
assign mul14[8'h9c]=8'he9;
assign mul14[8'h9d]=8'he7;
assign mul14[8'h9e]=8'hf5;
assign mul14[8'h9f]=8'hfb;
assign mul14[8'ha0]=8'h9a;
assign mul14[8'ha1]=8'h94;
assign mul14[8'ha2]=8'h86;
assign mul14[8'ha3]=8'h88;
assign mul14[8'ha4]=8'ha2;
assign mul14[8'ha5]=8'hac;
assign mul14[8'ha6]=8'hbe;
assign mul14[8'ha7]=8'hb0;
assign mul14[8'ha8]=8'hea;
assign mul14[8'ha9]=8'he4;
assign mul14[8'haa]=8'hf6;
assign mul14[8'hab]=8'hf8;
assign mul14[8'hac]=8'hd2;
assign mul14[8'had]=8'hdc;
assign mul14[8'hae]=8'hce;
assign mul14[8'haf]=8'hc0;
assign mul14[8'hb0]=8'h7a;
assign mul14[8'hb1]=8'h74;
assign mul14[8'hb2]=8'h66;
assign mul14[8'hb3]=8'h68;
assign mul14[8'hb4]=8'h42;
assign mul14[8'hb5]=8'h4c;
assign mul14[8'hb6]=8'h5e;
assign mul14[8'hb7]=8'h50;
assign mul14[8'hb8]=8'h0a;
assign mul14[8'hb9]=8'h04;
assign mul14[8'hba]=8'h16;
assign mul14[8'hbb]=8'h18;
assign mul14[8'hbc]=8'h32;
assign mul14[8'hbd]=8'h3c;
assign mul14[8'hbe]=8'h2e;
assign mul14[8'hbf]=8'h20;
assign mul14[8'hc0]=8'hec;
assign mul14[8'hc1]=8'he2;
assign mul14[8'hc2]=8'hf0;
assign mul14[8'hc3]=8'hfe;
assign mul14[8'hc4]=8'hd4;
assign mul14[8'hc5]=8'hda;
assign mul14[8'hc6]=8'hc8;
assign mul14[8'hc7]=8'hc6;
assign mul14[8'hc8]=8'h9c;
assign mul14[8'hc9]=8'h92;
assign mul14[8'hca]=8'h80;
assign mul14[8'hcb]=8'h8e;
assign mul14[8'hcc]=8'ha4;
assign mul14[8'hcd]=8'haa;
assign mul14[8'hce]=8'hb8;
assign mul14[8'hcf]=8'hb6;
assign mul14[8'hd0]=8'h0c;
assign mul14[8'hd1]=8'h02;
assign mul14[8'hd2]=8'h10;
assign mul14[8'hd3]=8'h1e;
assign mul14[8'hd4]=8'h34;
assign mul14[8'hd5]=8'h3a;
assign mul14[8'hd6]=8'h28;
assign mul14[8'hd7]=8'h26;
assign mul14[8'hd8]=8'h7c;
assign mul14[8'hd9]=8'h72;
assign mul14[8'hda]=8'h60;
assign mul14[8'hdb]=8'h6e;
assign mul14[8'hdc]=8'h44;
assign mul14[8'hdd]=8'h4a;
assign mul14[8'hde]=8'h58;
assign mul14[8'hdf]=8'h56;
assign mul14[8'he0]=8'h37;
assign mul14[8'he1]=8'h39;
assign mul14[8'he2]=8'h2b;
assign mul14[8'he3]=8'h25;
assign mul14[8'he4]=8'h0f;
assign mul14[8'he5]=8'h01;
assign mul14[8'he6]=8'h13;
assign mul14[8'he7]=8'h1d;
assign mul14[8'he8]=8'h47;
assign mul14[8'he9]=8'h49;
assign mul14[8'hea]=8'h5b;
assign mul14[8'heb]=8'h55;
assign mul14[8'hec]=8'h7f;
assign mul14[8'hed]=8'h71;
assign mul14[8'hee]=8'h63;
assign mul14[8'hef]=8'h6d;
assign mul14[8'hf0]=8'hd7;
assign mul14[8'hf1]=8'hd9;
assign mul14[8'hf2]=8'hcb;
assign mul14[8'hf3]=8'hc5;
assign mul14[8'hf4]=8'hef;
assign mul14[8'hf5]=8'he1;
assign mul14[8'hf6]=8'hf3;
assign mul14[8'hf7]=8'hfd;
assign mul14[8'hf8]=8'ha7;
assign mul14[8'hf9]=8'ha9;
assign mul14[8'hfa]=8'hbb;
assign mul14[8'hfb]=8'hb5;
assign mul14[8'hfc]=8'h9f;
assign mul14[8'hfd]=8'h91;
assign mul14[8'hfe]=8'h83;
assign mul14[8'hff]=8'h8d;
    
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
        if(enc_dec == 2'b10)begin        
            next_state = 1; 
        end
//         else begin
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
         d1[0] =  mul14[d[0]] ^ mul11[d[1]] ^ mul13[d[2]] ^ mul9[d[3]];//state0
         d1[1] =  mul9[d[0]] ^ mul14[d[1]] ^ mul11[d[2]] ^ mul13[d[3]];//state1
         d1[2] =  mul13[d[0]] ^ mul9[d[1]] ^ mul14[d[2]] ^ mul11[d[3]];//state2
         d1[3] =  mul11[d[0]] ^ mul13[d[1]] ^ mul9[d[2]] ^ mul14[d[3]];//state3
         d1[4] =  mul14[d[4]] ^ mul11[d[5]] ^ mul13[d[6]] ^ mul9[d[7]];//state4
         d1[5] =  mul9[d[4]] ^ mul14[d[5]] ^ mul11[d[6]] ^ mul13[d[7]];//state5
         d1[6] =  mul13[d[4]] ^ mul9[d[5]] ^ mul14[d[6]] ^ mul11[d[7]];//state6
         d1[7] =  mul11[d[4]] ^ mul13[d[5]] ^ mul9[d[6]] ^ mul14[d[7]];//state7
         d1[8] =  mul14[d[8]] ^ mul11[d[9]] ^ mul13[d[10]] ^ mul9[d[11]];//state8
         d1[9] =  mul9[d[8]] ^ mul14[d[9]] ^ mul11[d[10]] ^ mul13[d[11]];//state9
         d1[10] = mul13[d[8]] ^ mul9[d[9]] ^ mul14[d[10]] ^ mul11[d[11]];//state10
         d1[11] = mul11[d[8]] ^ mul13[d[9]] ^ mul9[d[10]] ^ mul14[d[11]];//state11
         d1[12] = mul14[d[12]] ^ mul11[d[13]] ^ mul13[d[14]] ^ mul9[d[15]];//state12
         d1[13] = mul9[d[12]] ^ mul14[d[13]] ^ mul11[d[14]] ^ mul13[d[15]];//state13
         d1[14] = mul13[d[12]] ^ mul9[d[13]] ^ mul14[d[14]] ^ mul11[d[15]];//state14
         d1[15] = mul11[d[12]] ^ mul13[d[13]] ^ mul9[d[14]] ^ mul14[d[15]];//state15
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
         d3[0] =  mul14[d2[0]] ^ mul11[d2[1]] ^ mul13[d2[2]] ^ mul9[d2[3]];//state0
         d3[1] =  mul9[d2[0]] ^ mul14[d2[1]] ^ mul11[d2[2]] ^ mul13[d2[3]];//state1
         d3[2] =  mul13[d2[0]] ^ mul9[d2[1]] ^ mul14[d2[2]] ^ mul11[d2[3]];//state2
         d3[3] =  mul11[d2[0]] ^ mul13[d2[1]] ^ mul9[d2[2]] ^ mul14[d2[3]];//state3
         d3[4] =  mul14[d2[4]] ^ mul11[d2[5]] ^ mul13[d2[6]] ^ mul9[d2[7]];//state4
         d3[5] =  mul9[d2[4]] ^ mul14[d2[5]] ^ mul11[d2[6]] ^ mul13[d2[7]];//state5
         d3[6] =  mul13[d2[4]] ^ mul9[d2[5]] ^ mul14[d2[6]] ^ mul11[d2[7]];//state6
         d3[7] =  mul11[d2[4]] ^ mul13[d2[5]] ^ mul9[d2[6]] ^ mul14[d2[7]];//state7
         d3[8] =  mul14[d2[8]] ^ mul11[d2[9]] ^ mul13[d2[10]] ^ mul9[d2[11]];//state8
         d3[9] =  mul9[d2[8]] ^ mul14[d2[9]] ^ mul11[d2[10]] ^ mul13[d2[11]];//state9
         d3[10] = mul13[d2[8]] ^ mul9[d2[9]] ^ mul14[d2[10]] ^ mul11[d2[11]];//state10
         d3[11] = mul11[d2[8]] ^ mul13[d2[9]] ^ mul9[d2[10]] ^ mul14[d2[11]];//state11
         d3[12] = mul14[d2[12]] ^ mul11[d2[13]] ^ mul13[d2[14]] ^ mul9[d2[15]];//state12
         d3[13] = mul9[d2[12]] ^ mul14[d2[13]] ^ mul11[d2[14]] ^ mul13[d2[15]];//state13
         d3[14] = mul13[d2[12]] ^ mul9[d2[13]] ^ mul14[d2[14]] ^ mul11[d2[15]];//state14
         d3[15] = mul11[d2[12]] ^ mul13[d2[13]] ^ mul9[d2[14]] ^ mul14[d2[15]];//state15 
         next_state = 15;
     end
     15:begin
         tempRow2[0] = d3[0];tempRow2[4] = d3[4];tempRow2[8] = d3[8];tempRow2[12] = d3[12];
         tempRow2[1] = d3[13];tempRow2[5] = d3[1];tempRow2[9] = d3[5];tempRow2[13] = d3[9];
         tempRow2[2] = d3[10];tempRow2[6] = d3[14];tempRow2[10] = d3[2];tempRow2[14] = d3[6];
         tempRow2[3] = d3[7];tempRow2[7] = d3[11];tempRow2[11] = d3[15];tempRow2[15] = d3[3];
         next_state = 16;
     end
     16:begin
         tempSbox2[0] = inv_sbox[tempRow2[0]];tempSbox2[1] = inv_sbox[tempRow2[1]];tempSbox2[2] = inv_sbox[tempRow2[2]];tempSbox2[3] = inv_sbox[tempRow2[3]];
         tempSbox2[4] = inv_sbox[tempRow2[4]];tempSbox2[5] = inv_sbox[tempRow2[5]];tempSbox2[6] = inv_sbox[tempRow2[6]];tempSbox2[7] = inv_sbox[tempRow2[7]];
         tempSbox2[8] = inv_sbox[tempRow2[8]];tempSbox2[9] = inv_sbox[tempRow2[9]];tempSbox2[10] = inv_sbox[tempRow2[10]];tempSbox2[11] = inv_sbox[tempRow2[11]];
         tempSbox2[12] = inv_sbox[tempRow2[12]];tempSbox2[13] = inv_sbox[tempRow2[13]];tempSbox2[14] = inv_sbox[tempRow2[14]];tempSbox2[15] = inv_sbox[tempRow2[15]];
         next_state = 17;
     end
     17:begin
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
         next_state = 18;
     end
     18:begin
         d5[0] =  mul14[d4[0]] ^ mul11[d4[1]] ^ mul13[d4[2]] ^ mul9[d4[3]];//state0
         d5[1] =  mul9[d4[0]] ^ mul14[d4[1]] ^ mul11[d4[2]] ^ mul13[d4[3]];//state1
         d5[2] =  mul13[d4[0]] ^ mul9[d4[1]] ^ mul14[d4[2]] ^ mul11[d4[3]];//state2
         d5[3] =  mul11[d4[0]] ^ mul13[d4[1]] ^ mul9[d4[2]] ^ mul14[d4[3]];//state3
         d5[4] =  mul14[d4[4]] ^ mul11[d4[5]] ^ mul13[d4[6]] ^ mul9[d4[7]];//state4
         d5[5] =  mul9[d4[4]] ^ mul14[d4[5]] ^ mul11[d4[6]] ^ mul13[d4[7]];//state5
         d5[6] =  mul13[d4[4]] ^ mul9[d4[5]] ^ mul14[d4[6]] ^ mul11[d4[7]];//state6
         d5[7] =  mul11[d4[4]] ^ mul13[d4[5]] ^ mul9[d4[6]] ^ mul14[d4[7]];//state7
         d5[8] =  mul14[d4[8]] ^ mul11[d4[9]] ^ mul13[d4[10]] ^ mul9[d4[11]];//state8
         d5[9] =  mul9[d4[8]] ^ mul14[d4[9]] ^ mul11[d4[10]] ^ mul13[d4[11]];//state9
         d5[10] = mul13[d4[8]] ^ mul9[d4[9]] ^ mul14[d4[10]] ^ mul11[d4[11]];//state10
         d5[11] = mul11[d4[8]] ^ mul13[d4[9]] ^ mul9[d4[10]] ^ mul14[d4[11]];//state11
         d5[12] = mul14[d4[12]] ^ mul11[d4[13]] ^ mul13[d4[14]] ^ mul9[d4[15]];//state12
         d5[13] = mul9[d4[12]] ^ mul14[d4[13]] ^ mul11[d4[14]] ^ mul13[d4[15]];//state13
         d5[14] = mul13[d4[12]] ^ mul9[d4[13]] ^ mul14[d4[14]] ^ mul11[d4[15]];//state14
         d5[15] = mul11[d4[12]] ^ mul13[d4[13]] ^ mul9[d4[14]] ^ mul14[d4[15]];//state15 
         next_state = 19;
     end
     19:begin
         tempRow3[0] = d5[0];tempRow3[4] = d5[4];tempRow3[8] = d5[8];tempRow3[12] = d5[12];
         tempRow3[1] = d5[13];tempRow3[5] = d5[1];tempRow3[9] = d5[5];tempRow3[13] = d5[9];
         tempRow3[2] = d5[10];tempRow3[6] = d5[14];tempRow3[10] = d5[2];tempRow3[14] = d5[6];
         tempRow3[3] = d5[7];tempRow3[7] = d5[11];tempRow3[11] = d5[15];tempRow3[15] = d5[3];
         next_state = 20;
     end
     20:begin
         tempSbox3[0] = inv_sbox[tempRow3[0]];tempSbox3[1] = inv_sbox[tempRow3[1]];tempSbox3[2] = inv_sbox[tempRow3[2]];tempSbox3[3] = inv_sbox[tempRow3[3]];
         tempSbox3[4] = inv_sbox[tempRow3[4]];tempSbox3[5] = inv_sbox[tempRow3[5]];tempSbox3[6] = inv_sbox[tempRow3[6]];tempSbox3[7] = inv_sbox[tempRow3[7]];
         tempSbox3[8] = inv_sbox[tempRow3[8]];tempSbox3[9] = inv_sbox[tempRow3[9]];tempSbox3[10] = inv_sbox[tempRow3[10]];tempSbox3[11] = inv_sbox[tempRow3[11]];
         tempSbox3[12] = inv_sbox[tempRow3[12]];tempSbox3[13] = inv_sbox[tempRow3[13]];tempSbox3[14] = inv_sbox[tempRow3[14]];tempSbox3[15] = inv_sbox[tempRow3[15]];
         next_state = 21;
     end
     21:begin
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
         next_state = 22;
     end
 
     22:begin
         d7[0] =  mul14[d6[0]] ^ mul11[d6[1]] ^ mul13[d6[2]] ^ mul9[d6[3]];//state0
         d7[1] =  mul9[d6[0]] ^ mul14[d6[1]] ^ mul11[d6[2]] ^ mul13[d6[3]];//state1
         d7[2] =  mul13[d6[0]] ^ mul9[d6[1]] ^ mul14[d6[2]] ^ mul11[d6[3]];//state2
         d7[3] =  mul11[d6[0]] ^ mul13[d6[1]] ^ mul9[d6[2]] ^ mul14[d6[3]];//state3
         d7[4] =  mul14[d6[4]] ^ mul11[d6[5]] ^ mul13[d6[6]] ^ mul9[d6[7]];//state4
         d7[5] =  mul9[d6[4]] ^ mul14[d6[5]] ^ mul11[d6[6]] ^ mul13[d6[7]];//state5
         d7[6] =  mul13[d6[4]] ^ mul9[d6[5]] ^ mul14[d6[6]] ^ mul11[d6[7]];//state6
         d7[7] =  mul11[d6[4]] ^ mul13[d6[5]] ^ mul9[d6[6]] ^ mul14[d6[7]];//state7
         d7[8] =  mul14[d6[8]] ^ mul11[d6[9]] ^ mul13[d6[10]] ^ mul9[d6[11]];//state8
         d7[9] =  mul9[d6[8]] ^ mul14[d6[9]] ^ mul11[d6[10]] ^ mul13[d6[11]];//state9
         d7[10] = mul13[d6[8]] ^ mul9[d6[9]] ^ mul14[d6[10]] ^ mul11[d6[11]];//state10
         d7[11] = mul11[d6[8]] ^ mul13[d6[9]] ^ mul9[d6[10]] ^ mul14[d6[11]];//state11
         d7[12] = mul14[d6[12]] ^ mul11[d6[13]] ^ mul13[d6[14]] ^ mul9[d6[15]];//state12
         d7[13] = mul9[d6[12]] ^ mul14[d6[13]] ^ mul11[d6[14]] ^ mul13[d6[15]];//state13
         d7[14] = mul13[d6[12]] ^ mul9[d6[13]] ^ mul14[d6[14]] ^ mul11[d6[15]];//state14
         d7[15] = mul11[d6[12]] ^ mul13[d6[13]] ^ mul9[d6[14]] ^ mul14[d6[15]];//state15 
         next_state = 23;
     end
     23:begin
         tempRow4[0] = d7[0];tempRow4[4] = d7[4];tempRow4[8] = d7[8];tempRow4[12] = d7[12];
         tempRow4[1] = d7[13];tempRow4[5] = d7[1];tempRow4[9] = d7[5];tempRow4[13] = d7[9];
         tempRow4[2] = d7[10];tempRow4[6] = d7[14];tempRow4[10] = d7[2];tempRow4[14] = d7[6];
         tempRow4[3] = d7[7];tempRow4[7] = d7[11];tempRow4[11] = d7[15];tempRow4[15] = d7[3];
         next_state = 24;
     end
     24:begin
         tempSbox4[0] = inv_sbox[tempRow4[0]];tempSbox4[1] = inv_sbox[tempRow4[1]];tempSbox4[2] = inv_sbox[tempRow4[2]];tempSbox4[3] = inv_sbox[tempRow4[3]];
         tempSbox4[4] = inv_sbox[tempRow4[4]];tempSbox4[5] = inv_sbox[tempRow4[5]];tempSbox4[6] = inv_sbox[tempRow4[6]];tempSbox4[7] = inv_sbox[tempRow4[7]];
         tempSbox4[8] = inv_sbox[tempRow4[8]];tempSbox4[9] = inv_sbox[tempRow4[9]];tempSbox4[10] = inv_sbox[tempRow4[10]];tempSbox4[11] = inv_sbox[tempRow4[11]];
         tempSbox4[12] = inv_sbox[tempRow4[12]];tempSbox4[13] = inv_sbox[tempRow4[13]];tempSbox4[14] = inv_sbox[tempRow4[14]];tempSbox4[15] = inv_sbox[tempRow4[15]];
         next_state = 25;
     end
     25:begin
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
         next_state = 26;
     end
     26:begin
         d9[0] =  mul14[d8[0]] ^ mul11[d8[1]] ^ mul13[d8[2]] ^ mul9[d8[3]];//state0
         d9[1] =  mul9[d8[0]] ^ mul14[d8[1]] ^ mul11[d8[2]] ^ mul13[d8[3]];//state1
         d9[2] =  mul13[d8[0]] ^ mul9[d8[1]] ^ mul14[d8[2]] ^ mul11[d8[3]];//state2
         d9[3] =  mul11[d8[0]] ^ mul13[d8[1]] ^ mul9[d8[2]] ^ mul14[d8[3]];//state3
         d9[4] =  mul14[d8[4]] ^ mul11[d8[5]] ^ mul13[d8[6]] ^ mul9[d8[7]];//state4
         d9[5] =  mul9[d8[4]] ^ mul14[d8[5]] ^ mul11[d8[6]] ^ mul13[d8[7]];//state5
         d9[6] =  mul13[d8[4]] ^ mul9[d8[5]] ^ mul14[d8[6]] ^ mul11[d8[7]];//state6
         d9[7] =  mul11[d8[4]] ^ mul13[d8[5]] ^ mul9[d8[6]] ^ mul14[d8[7]];//state7
         d9[8] =  mul14[d8[8]] ^ mul11[d8[9]] ^ mul13[d8[10]] ^ mul9[d8[11]];//state8
         d9[9] =  mul9[d8[8]] ^ mul14[d8[9]] ^ mul11[d8[10]] ^ mul13[d8[11]];//state9
         d9[10] = mul13[d8[8]] ^ mul9[d8[9]] ^ mul14[d8[10]] ^ mul11[d8[11]];//state10
         d9[11] = mul11[d8[8]] ^ mul13[d8[9]] ^ mul9[d8[10]] ^ mul14[d8[11]];//state11
         d9[12] = mul14[d8[12]] ^ mul11[d8[13]] ^ mul13[d8[14]] ^ mul9[d8[15]];//state12
         d9[13] = mul9[d8[12]] ^ mul14[d8[13]] ^ mul11[d8[14]] ^ mul13[d8[15]];//state13
         d9[14] = mul13[d8[12]] ^ mul9[d8[13]] ^ mul14[d8[14]] ^ mul11[d8[15]];//state14
         d9[15] = mul11[d8[12]] ^ mul13[d8[13]] ^ mul9[d8[14]] ^ mul14[d8[15]];//state15 
         next_state = 27;
     end
     27:begin
         tempRow5[0] = d9[0];tempRow5[4] = d9[4];tempRow5[8] = d9[8];tempRow5[12] = d9[12];
         tempRow5[1] = d9[13];tempRow5[5] = d9[1];tempRow5[9] = d9[5];tempRow5[13] = d9[9];
         tempRow5[2] = d9[10];tempRow5[6] = d9[14];tempRow5[10] = d9[2];tempRow5[14] = d9[6];
         tempRow5[3] = d9[7];tempRow5[7] = d9[11];tempRow5[11] = d9[15];tempRow5[15] = d9[3];
         next_state = 28;
     end
     28:begin
         tempSbox5[0] = inv_sbox[tempRow5[0]];tempSbox5[1] = inv_sbox[tempRow5[1]];tempSbox5[2] = inv_sbox[tempRow5[2]];tempSbox5[3] = inv_sbox[tempRow5[3]];
         tempSbox5[4] = inv_sbox[tempRow5[4]];tempSbox5[5] = inv_sbox[tempRow5[5]];tempSbox5[6] = inv_sbox[tempRow5[6]];tempSbox5[7] = inv_sbox[tempRow5[7]];
         tempSbox5[8] = inv_sbox[tempRow5[8]];tempSbox5[9] = inv_sbox[tempRow5[9]];tempSbox5[10] = inv_sbox[tempRow5[10]];tempSbox5[11] = inv_sbox[tempRow5[11]];
         tempSbox5[12] = inv_sbox[tempRow5[12]];tempSbox5[13] = inv_sbox[tempRow5[13]];tempSbox5[14] = inv_sbox[tempRow5[14]];tempSbox5[15] = inv_sbox[tempRow5[15]];
         next_state = 29;
     end
     29:begin
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
         next_state = 30;
     end
     30:begin
         d11[0] =  mul14[d10[0]] ^ mul11[d10[1]] ^ mul13[d10[2]] ^ mul9[d10[3]];//state0
         d11[1] =  mul9[d10[0]] ^ mul14[d10[1]] ^ mul11[d10[2]] ^ mul13[d10[3]];//state1
         d11[2] =  mul13[d10[0]] ^ mul9[d10[1]] ^ mul14[d10[2]] ^ mul11[d10[3]];//state2
         d11[3] =  mul11[d10[0]] ^ mul13[d10[1]] ^ mul9[d10[2]] ^ mul14[d10[3]];//state3
         d11[4] =  mul14[d10[4]] ^ mul11[d10[5]] ^ mul13[d10[6]] ^ mul9[d10[7]];//state4
         d11[5] =  mul9[d10[4]] ^ mul14[d10[5]] ^ mul11[d10[6]] ^ mul13[d10[7]];//state5
         d11[6] =  mul13[d10[4]] ^ mul9[d10[5]] ^ mul14[d10[6]] ^ mul11[d10[7]];//state6
         d11[7] =  mul11[d10[4]] ^ mul13[d10[5]] ^ mul9[d10[6]] ^ mul14[d10[7]];//state7
         d11[8] =  mul14[d10[8]] ^ mul11[d10[9]] ^ mul13[d10[10]] ^ mul9[d10[11]];//state8
         d11[9] =  mul9[d10[8]] ^ mul14[d10[9]] ^ mul11[d10[10]] ^ mul13[d10[11]];//state9
         d11[10] = mul13[d10[8]] ^ mul9[d10[9]] ^ mul14[d10[10]] ^ mul11[d10[11]];//state10
         d11[11] = mul11[d10[8]] ^ mul13[d10[9]] ^ mul9[d10[10]] ^ mul14[d10[11]];//state11
         d11[12] = mul14[d10[12]] ^ mul11[d10[13]] ^ mul13[d10[14]] ^ mul9[d10[15]];//state12
         d11[13] = mul9[d10[12]] ^ mul14[d10[13]] ^ mul11[d10[14]] ^ mul13[d10[15]];//state13
         d11[14] = mul13[d10[12]] ^ mul9[d10[13]] ^ mul14[d10[14]] ^ mul11[d10[15]];//state14
         d11[15] = mul11[d10[12]] ^ mul13[d10[13]] ^ mul9[d10[14]] ^ mul14[d10[15]];//state15 
         next_state = 31;
     end
     31:begin
         tempRow6[0] = d11[0];tempRow6[4] = d11[4];tempRow6[8] = d11[8];tempRow6[12] = d11[12];
         tempRow6[1] = d11[13];tempRow6[5] = d11[1];tempRow6[9] = d11[5];tempRow6[13] = d11[9];
         tempRow6[2] = d11[10];tempRow6[6] = d11[14];tempRow6[10] = d11[2];tempRow6[14] = d11[6];
         tempRow6[3] = d11[7];tempRow6[7] = d11[11];tempRow6[11] = d11[15];tempRow6[15] = d11[3];
         next_state = 32;
     end
     32:begin
         tempSbox6[0] = inv_sbox[tempRow6[0]];tempSbox6[1] = inv_sbox[tempRow6[1]];tempSbox6[2] = inv_sbox[tempRow6[2]];tempSbox6[3] = inv_sbox[tempRow6[3]];
         tempSbox6[4] = inv_sbox[tempRow6[4]];tempSbox6[5] = inv_sbox[tempRow6[5]];tempSbox6[6] = inv_sbox[tempRow6[6]];tempSbox6[7] = inv_sbox[tempRow6[7]];
         tempSbox6[8] = inv_sbox[tempRow6[8]];tempSbox6[9] = inv_sbox[tempRow6[9]];tempSbox6[10] = inv_sbox[tempRow6[10]];tempSbox6[11] = inv_sbox[tempRow6[11]];
         tempSbox6[12] = inv_sbox[tempRow6[12]];tempSbox6[13] = inv_sbox[tempRow6[13]];tempSbox6[14] = inv_sbox[tempRow6[14]];tempSbox6[15] = inv_sbox[tempRow6[15]];
         next_state = 33;
     end
     33:begin
         d12[0] = tempSbox6[0]^k[28][31:24];
         d12[1] = tempSbox6[1]^k[28][23:16];
         d12[2] = tempSbox6[2]^k[28][15:8];
         d12[3] = tempSbox6[3]^k[28][7:0];
         d12[4] = tempSbox6[4]^k[29][31:24];
         d12[5] = tempSbox6[5]^k[29][23:16];
         d12[6] = tempSbox6[6]^k[29][15:8];
         d12[7] = tempSbox6[7]^k[29][7:0];
         d12[8] = tempSbox6[8]^k[30][31:24];
         d12[9] = tempSbox6[9]^k[30][23:16];
         d12[10] = tempSbox6[10]^k[30][15:8];
         d12[11] = tempSbox6[11]^k[30][7:0];
         d12[12] = tempSbox6[12]^k[31][31:24];
         d12[13] = tempSbox6[13]^k[31][23:16];
         d12[14] = tempSbox6[14]^k[31][15:8];
         d12[15] = tempSbox6[15]^k[31][7:0];
         next_state = 34;
     end
     34:begin
         d13[0] =  mul14[d12[0]] ^ mul11[d12[1]] ^ mul13[d12[2]] ^ mul9[d12[3]];//state0
         d13[1] =  mul9[d12[0]] ^ mul14[d12[1]] ^ mul11[d12[2]] ^ mul13[d12[3]];//state1
         d13[2] =  mul13[d12[0]] ^ mul9[d12[1]] ^ mul14[d12[2]] ^ mul11[d12[3]];//state2
         d13[3] =  mul11[d12[0]] ^ mul13[d12[1]] ^ mul9[d12[2]] ^ mul14[d12[3]];//state3
         d13[4] =  mul14[d12[4]] ^ mul11[d12[5]] ^ mul13[d12[6]] ^ mul9[d12[7]];//state4
         d13[5] =  mul9[d12[4]] ^ mul14[d12[5]] ^ mul11[d12[6]] ^ mul13[d12[7]];//state5
         d13[6] =  mul13[d12[4]] ^ mul9[d12[5]] ^ mul14[d12[6]] ^ mul11[d12[7]];//state6
         d13[7] =  mul11[d12[4]] ^ mul13[d12[5]] ^ mul9[d12[6]] ^ mul14[d12[7]];//state7
         d13[8] =  mul14[d12[8]] ^ mul11[d12[9]] ^ mul13[d12[10]] ^ mul9[d12[11]];//state8
         d13[9] =  mul9[d12[8]] ^ mul14[d12[9]] ^ mul11[d12[10]] ^ mul13[d12[11]];//state9
         d13[10] = mul13[d12[8]] ^ mul9[d12[9]] ^ mul14[d12[10]] ^ mul11[d12[11]];//state10
         d13[11] = mul11[d12[8]] ^ mul13[d12[9]] ^ mul9[d12[10]] ^ mul14[d12[11]];//state11
         d13[12] = mul14[d12[12]] ^ mul11[d12[13]] ^ mul13[d12[14]] ^ mul9[d12[15]];//state12
         d13[13] = mul9[d12[12]] ^ mul14[d12[13]] ^ mul11[d12[14]] ^ mul13[d12[15]];//state13
         d13[14] = mul13[d12[12]] ^ mul9[d12[13]] ^ mul14[d12[14]] ^ mul11[d12[15]];//state14
         d13[15] = mul11[d12[12]] ^ mul13[d12[13]] ^ mul9[d12[14]] ^ mul14[d12[15]];//state15 
         next_state = 35;
     end
     35:begin
         tempRow7[0] = d13[0];tempRow7[4] = d13[4];tempRow7[8] = d13[8];tempRow7[12] = d13[12];
         tempRow7[1] = d13[13];tempRow7[5] = d13[1];tempRow7[9] = d13[5];tempRow7[13] = d13[9];
         tempRow7[2] = d13[10];tempRow7[6] = d13[14];tempRow7[10] = d13[2];tempRow7[14] = d13[6];
         tempRow7[3] = d13[7];tempRow7[7] = d13[11];tempRow7[11] = d13[15];tempRow7[15] = d13[3];
         next_state = 36;
     end
     36:begin
         tempSbox7[0] = inv_sbox[tempRow7[0]];tempSbox7[1] = inv_sbox[tempRow7[1]];tempSbox7[2] = inv_sbox[tempRow7[2]];tempSbox7[3] = inv_sbox[tempRow7[3]];
         tempSbox7[4] = inv_sbox[tempRow7[4]];tempSbox7[5] = inv_sbox[tempRow7[5]];tempSbox7[6] = inv_sbox[tempRow7[6]];tempSbox7[7] = inv_sbox[tempRow7[7]];
         tempSbox7[8] = inv_sbox[tempRow7[8]];tempSbox7[9] = inv_sbox[tempRow7[9]];tempSbox7[10] = inv_sbox[tempRow7[10]];tempSbox7[11] = inv_sbox[tempRow7[11]];
         tempSbox7[12] = inv_sbox[tempRow7[12]];tempSbox7[13] = inv_sbox[tempRow7[13]];tempSbox7[14] = inv_sbox[tempRow7[14]];tempSbox7[15] = inv_sbox[tempRow7[15]];
         next_state = 37;
     end
     37:begin
         d14[0] = tempSbox7[0]^k[24][31:24];
         d14[1] = tempSbox7[1]^k[24][23:16];
         d14[2] = tempSbox7[2]^k[24][15:8];
         d14[3] = tempSbox7[3]^k[24][7:0];
         d14[4] = tempSbox7[4]^k[25][31:24];
         d14[5] = tempSbox7[5]^k[25][23:16];
         d14[6] = tempSbox7[6]^k[25][15:8];
         d14[7] = tempSbox7[7]^k[25][7:0];
         d14[8] = tempSbox7[8]^k[26][31:24];
         d14[9] = tempSbox7[9]^k[26][23:16];
         d14[10] = tempSbox7[10]^k[26][15:8];
         d14[11] = tempSbox7[11]^k[26][7:0];
         d14[12] = tempSbox7[12]^k[27][31:24];
         d14[13] = tempSbox7[13]^k[27][23:16];
         d14[14] = tempSbox7[14]^k[27][15:8];
         d14[15] = tempSbox7[15]^k[27][7:0];
         next_state = 38;
     end
     38:begin
         d15[0] =  mul14[d14[0]] ^ mul11[d14[1]] ^ mul13[d14[2]] ^ mul9[d14[3]];//state0
         d15[1] =  mul9[d14[0]] ^ mul14[d14[1]] ^ mul11[d14[2]] ^ mul13[d14[3]];//state1
         d15[2] =  mul13[d14[0]] ^ mul9[d14[1]] ^ mul14[d14[2]] ^ mul11[d14[3]];//state2
         d15[3] =  mul11[d14[0]] ^ mul13[d14[1]] ^ mul9[d14[2]] ^ mul14[d14[3]];//state3
         d15[4] =  mul14[d14[4]] ^ mul11[d14[5]] ^ mul13[d14[6]] ^ mul9[d14[7]];//state4
         d15[5] =  mul9[d14[4]] ^ mul14[d14[5]] ^ mul11[d14[6]] ^ mul13[d14[7]];//state5
         d15[6] =  mul13[d14[4]] ^ mul9[d14[5]] ^ mul14[d14[6]] ^ mul11[d14[7]];//state6
         d15[7] =  mul11[d14[4]] ^ mul13[d14[5]] ^ mul9[d14[6]] ^ mul14[d14[7]];//state7
         d15[8] =  mul14[d14[8]] ^ mul11[d14[9]] ^ mul13[d14[10]] ^ mul9[d14[11]];//state8
         d15[9] =  mul9[d14[8]] ^ mul14[d14[9]] ^ mul11[d14[10]] ^ mul13[d14[11]];//state9
         d15[10] = mul13[d14[8]] ^ mul9[d14[9]] ^ mul14[d14[10]] ^ mul11[d14[11]];//state10
         d15[11] = mul11[d14[8]] ^ mul13[d14[9]] ^ mul9[d14[10]] ^ mul14[d14[11]];//state11
         d15[12] = mul14[d14[12]] ^ mul11[d14[13]] ^ mul13[d14[14]] ^ mul9[d14[15]];//state12
         d15[13] = mul9[d14[12]] ^ mul14[d14[13]] ^ mul11[d14[14]] ^ mul13[d14[15]];//state13
         d15[14] = mul13[d14[12]] ^ mul9[d14[13]] ^ mul14[d14[14]] ^ mul11[d14[15]];//state14
         d15[15] = mul11[d14[12]] ^ mul13[d14[13]] ^ mul9[d14[14]] ^ mul14[d14[15]];//state15 
         next_state = 39;
     end
     39:begin
         tempRow8[0] = d15[0];tempRow8[4] = d15[4];tempRow8[8] = d15[8];tempRow8[12] = d15[12];
         tempRow8[1] = d15[13];tempRow8[5] = d15[1];tempRow8[9] = d15[5];tempRow8[13] = d15[9];
         tempRow8[2] = d15[10];tempRow8[6] = d15[14];tempRow8[10] = d15[2];tempRow8[14] = d15[6];
         tempRow8[3] = d15[7];tempRow8[7] = d15[11];tempRow8[11] = d15[15];tempRow8[15] = d15[3];
         next_state = 40;
     end
     40:begin
         tempSbox8[0] = inv_sbox[tempRow8[0]];tempSbox8[1] = inv_sbox[tempRow8[1]];tempSbox8[2] = inv_sbox[tempRow8[2]];tempSbox8[3] = inv_sbox[tempRow8[3]];
         tempSbox8[4] = inv_sbox[tempRow8[4]];tempSbox8[5] = inv_sbox[tempRow8[5]];tempSbox8[6] = inv_sbox[tempRow8[6]];tempSbox8[7] = inv_sbox[tempRow8[7]];
         tempSbox8[8] = inv_sbox[tempRow8[8]];tempSbox8[9] = inv_sbox[tempRow8[9]];tempSbox8[10] = inv_sbox[tempRow8[10]];tempSbox8[11] = inv_sbox[tempRow8[11]];
         tempSbox8[12] = inv_sbox[tempRow8[12]];tempSbox8[13] = inv_sbox[tempRow8[13]];tempSbox8[14] = inv_sbox[tempRow8[14]];tempSbox8[15] = inv_sbox[tempRow8[15]];
         next_state = 41;
     end
     41:begin
         d16[0] = tempSbox8[0]^k[20][31:24];
         d16[1] = tempSbox8[1]^k[20][23:16];
         d16[2] = tempSbox8[2]^k[20][15:8];
         d16[3] = tempSbox8[3]^k[20][7:0];
         d16[4] = tempSbox8[4]^k[21][31:24];
         d16[5] = tempSbox8[5]^k[21][23:16];
         d16[6] = tempSbox8[6]^k[21][15:8];
         d16[7] = tempSbox8[7]^k[21][7:0];
         d16[8] = tempSbox8[8]^k[22][31:24];
         d16[9] = tempSbox8[9]^k[22][23:16];
         d16[10] = tempSbox8[10]^k[22][15:8];
         d16[11] = tempSbox8[11]^k[22][7:0];
         d16[12] = tempSbox8[12]^k[23][31:24];
         d16[13] = tempSbox8[13]^k[23][23:16];
         d16[14] = tempSbox8[14]^k[23][15:8];
         d16[15] = tempSbox8[15]^k[23][7:0];
         next_state = 42;
     end
     42:begin
         d17[0] =  mul14[d16[0]] ^ mul11[d16[1]] ^ mul13[d16[2]] ^ mul9[d16[3]];//state0
         d17[1] =  mul9[d16[0]] ^ mul14[d16[1]] ^ mul11[d16[2]] ^ mul13[d16[3]];//state1
         d17[2] =  mul13[d16[0]] ^ mul9[d16[1]] ^ mul14[d16[2]] ^ mul11[d16[3]];//state2
         d17[3] =  mul11[d16[0]] ^ mul13[d16[1]] ^ mul9[d16[2]] ^ mul14[d16[3]];//state3
         d17[4] =  mul14[d16[4]] ^ mul11[d16[5]] ^ mul13[d16[6]] ^ mul9[d16[7]];//state4
         d17[5] =  mul9[d16[4]] ^ mul14[d16[5]] ^ mul11[d16[6]] ^ mul13[d16[7]];//state5
         d17[6] =  mul13[d16[4]] ^ mul9[d16[5]] ^ mul14[d16[6]] ^ mul11[d16[7]];//state6
         d17[7] =  mul11[d16[4]] ^ mul13[d16[5]] ^ mul9[d16[6]] ^ mul14[d16[7]];//state7
         d17[8] =  mul14[d16[8]] ^ mul11[d16[9]] ^ mul13[d16[10]] ^ mul9[d16[11]];//state8
         d17[9] =  mul9[d16[8]] ^ mul14[d16[9]] ^ mul11[d16[10]] ^ mul13[d16[11]];//state9
         d17[10] = mul13[d16[8]] ^ mul9[d16[9]] ^ mul14[d16[10]] ^ mul11[d16[11]];//state10
         d17[11] = mul11[d16[8]] ^ mul13[d16[9]] ^ mul9[d16[10]] ^ mul14[d16[11]];//state11
         d17[12] = mul14[d16[12]] ^ mul11[d16[13]] ^ mul13[d16[14]] ^ mul9[d16[15]];//state12
         d17[13] = mul9[d16[12]] ^ mul14[d16[13]] ^ mul11[d16[14]] ^ mul13[d16[15]];//state13
         d17[14] = mul13[d16[12]] ^ mul9[d16[13]] ^ mul14[d16[14]] ^ mul11[d16[15]];//state14
         d17[15] = mul11[d16[12]] ^ mul13[d16[13]] ^ mul9[d16[14]] ^ mul14[d16[15]];//state15 
         next_state = 43;
     end
     43:begin
         tempRow9[0] = d17[0];tempRow9[4] = d17[4];tempRow9[8] = d17[8];tempRow9[12] = d17[12];
         tempRow9[1] = d17[13];tempRow9[5] = d17[1];tempRow9[9] = d17[5];tempRow9[13] = d17[9];
         tempRow9[2] = d17[10];tempRow9[6] = d17[14];tempRow9[10] = d17[2];tempRow9[14] = d17[6];
         tempRow9[3] = d17[7];tempRow9[7] = d17[11];tempRow9[11] = d17[15];tempRow9[15] = d17[3];
         next_state = 44;
     end
     44:begin
         tempSbox9[0] = inv_sbox[tempRow9[0]];tempSbox9[1] = inv_sbox[tempRow9[1]];tempSbox9[2] = inv_sbox[tempRow9[2]];tempSbox9[3] = inv_sbox[tempRow9[3]];
         tempSbox9[4] = inv_sbox[tempRow9[4]];tempSbox9[5] = inv_sbox[tempRow9[5]];tempSbox9[6] = inv_sbox[tempRow9[6]];tempSbox9[7] = inv_sbox[tempRow9[7]];
         tempSbox9[8] = inv_sbox[tempRow9[8]];tempSbox9[9] = inv_sbox[tempRow9[9]];tempSbox9[10] = inv_sbox[tempRow9[10]];tempSbox9[11] = inv_sbox[tempRow9[11]];
         tempSbox9[12] = inv_sbox[tempRow9[12]];tempSbox9[13] = inv_sbox[tempRow9[13]];tempSbox9[14] = inv_sbox[tempRow9[14]];tempSbox9[15] = inv_sbox[tempRow9[15]];
         next_state = 45;
     end
     45:begin
         d18[0] = tempSbox9[0]^k[16][31:24];
         d18[1] = tempSbox9[1]^k[16][23:16];
         d18[2] = tempSbox9[2]^k[16][15:8];
         d18[3] = tempSbox9[3]^k[16][7:0];
         d18[4] = tempSbox9[4]^k[17][31:24];
         d18[5] = tempSbox9[5]^k[17][23:16];
         d18[6] = tempSbox9[6]^k[17][15:8];
         d18[7] = tempSbox9[7]^k[17][7:0];
         d18[8] = tempSbox9[8]^k[18][31:24];
         d18[9] = tempSbox9[9]^k[18][23:16];
         d18[10] = tempSbox9[10]^k[18][15:8];
         d18[11] = tempSbox9[11]^k[18][7:0];
         d18[12] = tempSbox9[12]^k[19][31:24];
         d18[13] = tempSbox9[13]^k[19][23:16];
         d18[14] = tempSbox9[14]^k[19][15:8];
         d18[15] = tempSbox9[15]^k[19][7:0];
         next_state = 46;
     end
     46:begin
         d19[0] =  mul14[d18[0]] ^ mul11[d18[1]] ^ mul13[d18[2]] ^ mul9[d18[3]];//state0
         d19[1] =  mul9[d18[0]] ^ mul14[d18[1]] ^ mul11[d18[2]] ^ mul13[d18[3]];//state1
         d19[2] =  mul13[d18[0]] ^ mul9[d18[1]] ^ mul14[d18[2]] ^ mul11[d18[3]];//state2
         d19[3] =  mul11[d18[0]] ^ mul13[d18[1]] ^ mul9[d18[2]] ^ mul14[d18[3]];//state3
         d19[4] =  mul14[d18[4]] ^ mul11[d18[5]] ^ mul13[d18[6]] ^ mul9[d18[7]];//state4
         d19[5] =  mul9[d18[4]] ^ mul14[d18[5]] ^ mul11[d18[6]] ^ mul13[d18[7]];//state5
         d19[6] =  mul13[d18[4]] ^ mul9[d18[5]] ^ mul14[d18[6]] ^ mul11[d18[7]];//state6
         d19[7] =  mul11[d18[4]] ^ mul13[d18[5]] ^ mul9[d18[6]] ^ mul14[d18[7]];//state7
         d19[8] =  mul14[d18[8]] ^ mul11[d18[9]] ^ mul13[d18[10]] ^ mul9[d18[11]];//state8
         d19[9] =  mul9[d18[8]] ^ mul14[d18[9]] ^ mul11[d18[10]] ^ mul13[d18[11]];//state9
         d19[10] = mul13[d18[8]] ^ mul9[d18[9]] ^ mul14[d18[10]] ^ mul11[d18[11]];//state10
         d19[11] = mul11[d18[8]] ^ mul13[d18[9]] ^ mul9[d18[10]] ^ mul14[d18[11]];//state11
         d19[12] = mul14[d18[12]] ^ mul11[d18[13]] ^ mul13[d18[14]] ^ mul9[d18[15]];//state12
         d19[13] = mul9[d18[12]] ^ mul14[d18[13]] ^ mul11[d18[14]] ^ mul13[d18[15]];//state13
         d19[14] = mul13[d18[12]] ^ mul9[d18[13]] ^ mul14[d18[14]] ^ mul11[d18[15]];//state14
         d19[15] = mul11[d18[12]] ^ mul13[d18[13]] ^ mul9[d18[14]] ^ mul14[d18[15]];//state15 
         next_state = 47;
     end
     47:begin
         tempRow10[0] = d19[0];tempRow10[4] = d19[4];tempRow10[8] = d19[8];tempRow10[12] = d19[12];
         tempRow10[1] = d19[13];tempRow10[5] = d19[1];tempRow10[9] = d19[5];tempRow10[13] = d19[9];
         tempRow10[2] = d19[10];tempRow10[6] = d19[14];tempRow10[10] = d19[2];tempRow10[14] = d19[6];
         tempRow10[3] = d19[7];tempRow10[7] = d19[11];tempRow10[11] = d19[15];tempRow10[15] = d19[3];
         next_state = 48;
     end
     48:begin
         tempSbox10[0] = inv_sbox[tempRow10[0]];tempSbox10[1] = inv_sbox[tempRow10[1]];tempSbox10[2] = inv_sbox[tempRow10[2]];tempSbox10[3] = inv_sbox[tempRow10[3]];
         tempSbox10[4] = inv_sbox[tempRow10[4]];tempSbox10[5] = inv_sbox[tempRow10[5]];tempSbox10[6] = inv_sbox[tempRow10[6]];tempSbox10[7] = inv_sbox[tempRow10[7]];
         tempSbox10[8] = inv_sbox[tempRow10[8]];tempSbox10[9] = inv_sbox[tempRow10[9]];tempSbox10[10] = inv_sbox[tempRow10[10]];tempSbox10[11] = inv_sbox[tempRow10[11]];
         tempSbox10[12] = inv_sbox[tempRow10[12]];tempSbox10[13] = inv_sbox[tempRow10[13]];tempSbox10[14] = inv_sbox[tempRow10[14]];tempSbox10[15] = inv_sbox[tempRow10[15]];
         next_state = 49;
     end
     49:begin
         d20[0] = tempSbox10[0]^k[12][31:24];
         d20[1] = tempSbox10[1]^k[12][23:16];
         d20[2] = tempSbox10[2]^k[12][15:8];
         d20[3] = tempSbox10[3]^k[12][7:0];
         d20[4] = tempSbox10[4]^k[13][31:24];
         d20[5] = tempSbox10[5]^k[13][23:16];
         d20[6] = tempSbox10[6]^k[13][15:8];
         d20[7] = tempSbox10[7]^k[13][7:0];
         d20[8] = tempSbox10[8]^k[14][31:24];
         d20[9] = tempSbox10[9]^k[14][23:16];
         d20[10] = tempSbox10[10]^k[14][15:8];
         d20[11] = tempSbox10[11]^k[14][7:0];
         d20[12] = tempSbox10[12]^k[15][31:24];
         d20[13] = tempSbox10[13]^k[15][23:16];
         d20[14] = tempSbox10[14]^k[15][15:8];
         d20[15] = tempSbox10[15]^k[15][7:0];
         next_state = 50;
     end
     50:begin
         d21[0] =  mul14[d20[0]] ^ mul11[d20[1]] ^ mul13[d20[2]] ^ mul9[d20[3]];//state0
         d21[1] =  mul9[d20[0]] ^ mul14[d20[1]] ^ mul11[d20[2]] ^ mul13[d20[3]];//state1
         d21[2] =  mul13[d20[0]] ^ mul9[d20[1]] ^ mul14[d20[2]] ^ mul11[d20[3]];//state2
         d21[3] =  mul11[d20[0]] ^ mul13[d20[1]] ^ mul9[d20[2]] ^ mul14[d20[3]];//state3
         d21[4] =  mul14[d20[4]] ^ mul11[d20[5]] ^ mul13[d20[6]] ^ mul9[d20[7]];//state4
         d21[5] =  mul9[d20[4]] ^ mul14[d20[5]] ^ mul11[d20[6]] ^ mul13[d20[7]];//state5
         d21[6] =  mul13[d20[4]] ^ mul9[d20[5]] ^ mul14[d20[6]] ^ mul11[d20[7]];//state6
         d21[7] =  mul11[d20[4]] ^ mul13[d20[5]] ^ mul9[d20[6]] ^ mul14[d20[7]];//state7
         d21[8] =  mul14[d20[8]] ^ mul11[d20[9]] ^ mul13[d20[10]] ^ mul9[d20[11]];//state8
         d21[9] =  mul9[d20[8]] ^ mul14[d20[9]] ^ mul11[d20[10]] ^ mul13[d20[11]];//state9
         d21[10] = mul13[d20[8]] ^ mul9[d20[9]] ^ mul14[d20[10]] ^ mul11[d20[11]];//state10
         d21[11] = mul11[d20[8]] ^ mul13[d20[9]] ^ mul9[d20[10]] ^ mul14[d20[11]];//state11
         d21[12] = mul14[d20[12]] ^ mul11[d20[13]] ^ mul13[d20[14]] ^ mul9[d20[15]];//state12
         d21[13] = mul9[d20[12]] ^ mul14[d20[13]] ^ mul11[d20[14]] ^ mul13[d20[15]];//state13
         d21[14] = mul13[d20[12]] ^ mul9[d20[13]] ^ mul14[d20[14]] ^ mul11[d20[15]];//state14
         d21[15] = mul11[d20[12]] ^ mul13[d20[13]] ^ mul9[d20[14]] ^ mul14[d20[15]];//state15 
         next_state = 51;
     end
     51:begin
         tempRow11[0] = d21[0];tempRow11[4] = d21[4];tempRow11[8] = d21[8];tempRow11[12] = d21[12];
         tempRow11[1] = d21[13];tempRow11[5] = d21[1];tempRow11[9] = d21[5];tempRow11[13] = d21[9];
         tempRow11[2] = d21[10];tempRow11[6] = d21[14];tempRow11[10] = d21[2];tempRow11[14] = d21[6];
         tempRow11[3] = d21[7];tempRow11[7] = d21[11];tempRow11[11] = d21[15];tempRow11[15] = d21[3];
         next_state = 52;
     end
     52:begin
         tempSbox11[0] = inv_sbox[tempRow11[0]];tempSbox11[1] = inv_sbox[tempRow11[1]];tempSbox11[2] = inv_sbox[tempRow11[2]];tempSbox11[3] = inv_sbox[tempRow11[3]];
         tempSbox11[4] = inv_sbox[tempRow11[4]];tempSbox11[5] = inv_sbox[tempRow11[5]];tempSbox11[6] = inv_sbox[tempRow11[6]];tempSbox11[7] = inv_sbox[tempRow11[7]];
         tempSbox11[8] = inv_sbox[tempRow11[8]];tempSbox11[9] = inv_sbox[tempRow11[9]];tempSbox11[10] = inv_sbox[tempRow11[10]];tempSbox11[11] = inv_sbox[tempRow11[11]];
         tempSbox11[12] = inv_sbox[tempRow11[12]];tempSbox11[13] = inv_sbox[tempRow11[13]];tempSbox11[14] = inv_sbox[tempRow11[14]];tempSbox11[15] = inv_sbox[tempRow11[15]];
         next_state = 53;
     end
     53:begin
         d22[0] = tempSbox11[0]^k[8][31:24];
         d22[1] = tempSbox11[1]^k[8][23:16];
         d22[2] = tempSbox11[2]^k[8][15:8];
         d22[3] = tempSbox11[3]^k[8][7:0];
         d22[4] = tempSbox11[4]^k[9][31:24];
         d22[5] = tempSbox11[5]^k[9][23:16];
         d22[6] = tempSbox11[6]^k[9][15:8];
         d22[7] = tempSbox11[7]^k[9][7:0];
         d22[8] = tempSbox11[8]^k[10][31:24];
         d22[9] = tempSbox11[9]^k[10][23:16];
         d22[10] = tempSbox11[10]^k[10][15:8];
         d22[11] = tempSbox11[11]^k[10][7:0];
         d22[12] = tempSbox11[12]^k[11][31:24];
         d22[13] = tempSbox11[13]^k[11][23:16];
         d22[14] = tempSbox11[14]^k[11][15:8];
         d22[15] = tempSbox11[15]^k[11][7:0];
         next_state = 54;
     end
     54:begin
         d23[0] =  mul14[d22[0]] ^ mul11[d22[1]] ^ mul13[d22[2]] ^ mul9[d22[3]];//state0
         d23[1] =  mul9[d22[0]] ^ mul14[d22[1]] ^ mul11[d22[2]] ^ mul13[d22[3]];//state1
         d23[2] =  mul13[d22[0]] ^ mul9[d22[1]] ^ mul14[d22[2]] ^ mul11[d22[3]];//state2
         d23[3] =  mul11[d22[0]] ^ mul13[d22[1]] ^ mul9[d22[2]] ^ mul14[d22[3]];//state3
         d23[4] =  mul14[d22[4]] ^ mul11[d22[5]] ^ mul13[d22[6]] ^ mul9[d22[7]];//state4
         d23[5] =  mul9[d22[4]] ^ mul14[d22[5]] ^ mul11[d22[6]] ^ mul13[d22[7]];//state5
         d23[6] =  mul13[d22[4]] ^ mul9[d22[5]] ^ mul14[d22[6]] ^ mul11[d22[7]];//state6
         d23[7] =  mul11[d22[4]] ^ mul13[d22[5]] ^ mul9[d22[6]] ^ mul14[d22[7]];//state7
         d23[8] =  mul14[d22[8]] ^ mul11[d22[9]] ^ mul13[d22[10]] ^ mul9[d22[11]];//state8
         d23[9] =  mul9[d22[8]] ^ mul14[d22[9]] ^ mul11[d22[10]] ^ mul13[d22[11]];//state9
         d23[10] = mul13[d22[8]] ^ mul9[d22[9]] ^ mul14[d22[10]] ^ mul11[d22[11]];//state10
         d23[11] = mul11[d22[8]] ^ mul13[d22[9]] ^ mul9[d22[10]] ^ mul14[d22[11]];//state11
         d23[12] = mul14[d22[12]] ^ mul11[d22[13]] ^ mul13[d22[14]] ^ mul9[d22[15]];//state12
         d23[13] = mul9[d22[12]] ^ mul14[d22[13]] ^ mul11[d22[14]] ^ mul13[d22[15]];//state13
         d23[14] = mul13[d22[12]] ^ mul9[d22[13]] ^ mul14[d22[14]] ^ mul11[d22[15]];//state14
         d23[15] = mul11[d22[12]] ^ mul13[d22[13]] ^ mul9[d22[14]] ^ mul14[d22[15]];//state15 
         next_state = 55;
     end
     55:begin
         tempRow12[0] = d23[0];tempRow12[4] = d23[4];tempRow12[8] = d23[8];tempRow12[12] = d23[12];
         tempRow12[1] = d23[13];tempRow12[5] = d23[1];tempRow12[9] = d23[5];tempRow12[13] = d23[9];
         tempRow12[2] = d23[10];tempRow12[6] = d23[14];tempRow12[10] = d23[2];tempRow12[14] = d23[6];
         tempRow12[3] = d23[7];tempRow12[7] = d23[11];tempRow12[11] = d23[15];tempRow12[15] = d23[3];
         next_state = 56;
     end
     56:begin
         tempSbox12[0] = inv_sbox[tempRow12[0]];tempSbox12[1] = inv_sbox[tempRow12[1]];tempSbox12[2] = inv_sbox[tempRow12[2]];tempSbox12[3] = inv_sbox[tempRow12[3]];
         tempSbox12[4] = inv_sbox[tempRow12[4]];tempSbox12[5] = inv_sbox[tempRow12[5]];tempSbox12[6] = inv_sbox[tempRow12[6]];tempSbox12[7] = inv_sbox[tempRow12[7]];
         tempSbox12[8] = inv_sbox[tempRow12[8]];tempSbox12[9] = inv_sbox[tempRow12[9]];tempSbox12[10] = inv_sbox[tempRow12[10]];tempSbox12[11] = inv_sbox[tempRow12[11]];
         tempSbox12[12] = inv_sbox[tempRow12[12]];tempSbox12[13] = inv_sbox[tempRow12[13]];tempSbox12[14] = inv_sbox[tempRow12[14]];tempSbox12[15] = inv_sbox[tempRow12[15]];
         next_state = 57;
     end
     57:begin
         d24[0] = tempSbox12[0]^k[4][31:24];
         d24[1] = tempSbox12[1]^k[4][23:16];
         d24[2] = tempSbox12[2]^k[4][15:8];
         d24[3] = tempSbox12[3]^k[4][7:0];
         d24[4] = tempSbox12[4]^k[5][31:24];
         d24[5] = tempSbox12[5]^k[5][23:16];
         d24[6] = tempSbox12[6]^k[5][15:8];
         d24[7] = tempSbox12[7]^k[5][7:0];
         d24[8] = tempSbox12[8]^k[6][31:24];
         d24[9] = tempSbox12[9]^k[6][23:16];
         d24[10] = tempSbox12[10]^k[6][15:8];
         d24[11] = tempSbox12[11]^k[6][7:0];
         d24[12] = tempSbox12[12]^k[7][31:24];
         d24[13] = tempSbox12[13]^k[7][23:16];
         d24[14] = tempSbox12[14]^k[7][15:8];
         d24[15] = tempSbox12[15]^k[7][7:0];
         next_state = 58;
     end
     58:begin
         d25[0] =  mul14[d24[0]] ^ mul11[d24[1]] ^ mul13[d24[2]] ^ mul9[d24[3]];//state0
         d25[1] =  mul9[d24[0]] ^ mul14[d24[1]] ^ mul11[d24[2]] ^ mul13[d24[3]];//state1
         d25[2] =  mul13[d24[0]] ^ mul9[d24[1]] ^ mul14[d24[2]] ^ mul11[d24[3]];//state2
         d25[3] =  mul11[d24[0]] ^ mul13[d24[1]] ^ mul9[d24[2]] ^ mul14[d24[3]];//state3
         d25[4] =  mul14[d24[4]] ^ mul11[d24[5]] ^ mul13[d24[6]] ^ mul9[d24[7]];//state4
         d25[5] =  mul9[d24[4]] ^ mul14[d24[5]] ^ mul11[d24[6]] ^ mul13[d24[7]];//state5
         d25[6] =  mul13[d24[4]] ^ mul9[d24[5]] ^ mul14[d24[6]] ^ mul11[d24[7]];//state6
         d25[7] =  mul11[d24[4]] ^ mul13[d24[5]] ^ mul9[d24[6]] ^ mul14[d24[7]];//state7
         d25[8] =  mul14[d24[8]] ^ mul11[d24[9]] ^ mul13[d24[10]] ^ mul9[d24[11]];//state8
         d25[9] =  mul9[d24[8]] ^ mul14[d24[9]] ^ mul11[d24[10]] ^ mul13[d24[11]];//state9
         d25[10] = mul13[d24[8]] ^ mul9[d24[9]] ^ mul14[d24[10]] ^ mul11[d24[11]];//state10
         d25[11] = mul11[d24[8]] ^ mul13[d24[9]] ^ mul9[d24[10]] ^ mul14[d24[11]];//state11
         d25[12] = mul14[d24[12]] ^ mul11[d24[13]] ^ mul13[d24[14]] ^ mul9[d24[15]];//state12
         d25[13] = mul9[d24[12]] ^ mul14[d24[13]] ^ mul11[d24[14]] ^ mul13[d24[15]];//state13
         d25[14] = mul13[d24[12]] ^ mul9[d24[13]] ^ mul14[d24[14]] ^ mul11[d24[15]];//state14
         d25[15] = mul11[d24[12]] ^ mul13[d24[13]] ^ mul9[d24[14]] ^ mul14[d24[15]];//state15 
         next_state = 59;
     end
     59:begin
         tempRow13[0] = d25[0];tempRow13[4] = d25[4];tempRow13[8] = d25[8];tempRow13[12] = d25[12];
         tempRow13[1] = d25[13];tempRow13[5] = d25[1];tempRow13[9] = d25[5];tempRow13[13] = d25[9];
         tempRow13[2] = d25[10];tempRow13[6] = d25[14];tempRow13[10] = d25[2];tempRow13[14] = d25[6];
         tempRow13[3] = d25[7];tempRow13[7] = d25[11];tempRow13[11] = d25[15];tempRow13[15] = d25[3];
         next_state = 60;
     end
     60:begin
         tempSbox13[0] = inv_sbox[tempRow13[0]];tempSbox13[1] = inv_sbox[tempRow13[1]];tempSbox13[2] = inv_sbox[tempRow13[2]];tempSbox13[3] = inv_sbox[tempRow13[3]];
         tempSbox13[4] = inv_sbox[tempRow13[4]];tempSbox13[5] = inv_sbox[tempRow13[5]];tempSbox13[6] = inv_sbox[tempRow13[6]];tempSbox13[7] = inv_sbox[tempRow13[7]];
         tempSbox13[8] = inv_sbox[tempRow13[8]];tempSbox13[9] = inv_sbox[tempRow13[9]];tempSbox13[10] = inv_sbox[tempRow13[10]];tempSbox13[11] = inv_sbox[tempRow13[11]];
         tempSbox13[12] = inv_sbox[tempRow13[12]];tempSbox13[13] = inv_sbox[tempRow13[13]];tempSbox13[14] = inv_sbox[tempRow13[14]];tempSbox13[15] = inv_sbox[tempRow13[15]];
         next_state = 61;
     end
     61:begin
         d26[0] = tempSbox13[0]^k[0][31:24];
         d26[1] = tempSbox13[1]^k[0][23:16];
         d26[2] = tempSbox13[2]^k[0][15:8];
         d26[3] = tempSbox13[3]^k[0][7:0];
         d26[4] = tempSbox13[4]^k[1][31:24];
         d26[5] = tempSbox13[5]^k[1][23:16];
         d26[6] = tempSbox13[6]^k[1][15:8];
         d26[7] = tempSbox13[7]^k[1][7:0];
         d26[8] = tempSbox13[8]^k[2][31:24];
         d26[9] = tempSbox13[9]^k[2][23:16];
         d26[10] = tempSbox13[10]^k[2][15:8];
         d26[11] = tempSbox13[11]^k[2][7:0];
         d26[12] = tempSbox13[12]^k[3][31:24];
         d26[13] = tempSbox13[13]^k[3][23:16];
         d26[14] = tempSbox13[14]^k[3][15:8];
         d26[15] = tempSbox13[15]^k[3][7:0];
         next_state = 62;
     end
     62:begin
          w1[0] = {d26[0],d26[1],d26[2],d26[3]};
          w1[1] = {d26[4],d26[5],d26[6],d26[7]};
          w1[2] = {d26[8],d26[9],d26[10],d26[11]};
          w1[3] = {d26[12],d26[13],d26[14],d26[15]};
          next_state = 63;
     end
     63: begin
         plaintext = {w1[0],w1[1],w1[2],w1[3]};
        //plaintext = {tempRow1[0],tempRow1[1],tempRow1[2],tempRow1[3],tempRow1[4],tempRow1[5],tempRow1[6],tempRow1[7],tempRow1[8],tempRow1[9],tempRow1[10],tempRow1[11],tempRow1[12],tempRow1[13],tempRow1[14],tempRow1[15]};
        //  plaintext = {tempSbox[0],tempSbox[1],tempSbox[2],tempSbox[3],tempSbox[4],tempSbox[5],tempSbox[6],tempSbox[7],tempSbox[8],tempSbox[9],tempSbox[10],tempSbox[11],tempSbox[12],tempSbox[13],tempSbox[14],tempSbox[15]};
         encDone =  1;  
         next_state = 64;
     end
     64:begin
           encDone =  1;
           ledDone = 1;  
           next_state = 64;
      end
         default:begin
                     next_state = 0;
                 end
     
     endcase
     end
 endmodule
