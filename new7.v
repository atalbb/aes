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
                  output reg [127:0]ciphertext
    );
reg [9:0]curr_state, next_state;
reg [7:0]b[15:0];
reg [7:0]d[15:0];
reg [31:0]w[3:0];
reg [31:0]k[59:0];
wire [7:0]sbox[255:0];
wire [7:0]eTable[255:0];
wire [7:0]lTable[255:0];
reg [31:0]tempStart[3:0];
reg [7:0]tempRow[15:0];
reg [8:0]l[63:0];
//reg [2:0]
/* SBOX */
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
/* ETABLE */
assign eTable[8'h00] = 8'h01;
assign eTable[8'h01] = 8'h03;
assign eTable[8'h02] = 8'h05;
assign eTable[8'h03] = 8'h0f;
assign eTable[8'h04] = 8'h11;
assign eTable[8'h05] = 8'h33;
assign eTable[8'h06] = 8'h55;
assign eTable[8'h07] = 8'hff;
assign eTable[8'h08] = 8'h1a;
assign eTable[8'h09] = 8'h2e;
assign eTable[8'h0a] = 8'h72;
assign eTable[8'h0b] = 8'h96;
assign eTable[8'h0c] = 8'ha1;
assign eTable[8'h0d] = 8'hf8;
assign eTable[8'h0e] = 8'h13;
assign eTable[8'h0f] = 8'h35;
assign eTable[8'h10] = 8'h5f;
assign eTable[8'h11] = 8'he1;
assign eTable[8'h12] = 8'h38;
assign eTable[8'h13] = 8'h48;
assign eTable[8'h14] = 8'hd8;
assign eTable[8'h15] = 8'h73;
assign eTable[8'h16] = 8'h95;
assign eTable[8'h17] = 8'ha4;
assign eTable[8'h18] = 8'hf7;
assign eTable[8'h19] = 8'h02;
assign eTable[8'h1a] = 8'h06;
assign eTable[8'h1b] = 8'h0a;
assign eTable[8'h1c] = 8'h1e;
assign eTable[8'h1d] = 8'h22;
assign eTable[8'h1e] = 8'h66;
assign eTable[8'h1f] = 8'haa;
assign eTable[8'h20] = 8'he5;
assign eTable[8'h21] = 8'h34;
assign eTable[8'h22] = 8'h5c;
assign eTable[8'h23] = 8'he4;
assign eTable[8'h24] = 8'h37;
assign eTable[8'h25] = 8'h59;
assign eTable[8'h26] = 8'heb;
assign eTable[8'h27] = 8'h26;
assign eTable[8'h28] = 8'h6a;
assign eTable[8'h29] = 8'hbe;
assign eTable[8'h2a] = 8'hd9;
assign eTable[8'h2b] = 8'h70;
assign eTable[8'h2c] = 8'h90;
assign eTable[8'h2d] = 8'hab;
assign eTable[8'h2e] = 8'he6;
assign eTable[8'h2f] = 8'h31;
assign eTable[8'h30] = 8'h53;
assign eTable[8'h31] = 8'hf5;
assign eTable[8'h32] = 8'h04;
assign eTable[8'h33] = 8'h0c;
assign eTable[8'h34] = 8'h14;
assign eTable[8'h35] = 8'h3c;
assign eTable[8'h36] = 8'h44;
assign eTable[8'h37] = 8'hcc;
assign eTable[8'h38] = 8'h4f;
assign eTable[8'h39] = 8'hd1;
assign eTable[8'h3a] = 8'h68;
assign eTable[8'h3b] = 8'hb8;
assign eTable[8'h3c] = 8'hd3;
assign eTable[8'h3d] = 8'h6e;
assign eTable[8'h3e] = 8'hb2;
assign eTable[8'h3f] = 8'hcd;
assign eTable[8'h40] = 8'h4c;
assign eTable[8'h41] = 8'hd4;
assign eTable[8'h42] = 8'h67;
assign eTable[8'h43] = 8'ha9;
assign eTable[8'h44] = 8'he0;
assign eTable[8'h45] = 8'h3b;
assign eTable[8'h46] = 8'h4d;
assign eTable[8'h47] = 8'hd7;
assign eTable[8'h48] = 8'h62;
assign eTable[8'h49] = 8'ha6;
assign eTable[8'h4a] = 8'hf1;
assign eTable[8'h4b] = 8'h08;
assign eTable[8'h4c] = 8'h18;
assign eTable[8'h4d] = 8'h28;
assign eTable[8'h4e] = 8'h78;
assign eTable[8'h4f] = 8'h88;
assign eTable[8'h50] = 8'h83;
assign eTable[8'h51] = 8'h9e;
assign eTable[8'h52] = 8'hb9;
assign eTable[8'h53] = 8'hd0;
assign eTable[8'h54] = 8'h6b;
assign eTable[8'h55] = 8'hbd;
assign eTable[8'h56] = 8'hdc;
assign eTable[8'h57] = 8'h7f;
assign eTable[8'h58] = 8'h81;
assign eTable[8'h59] = 8'h98;
assign eTable[8'h5a] = 8'hb3;
assign eTable[8'h5b] = 8'hce;
assign eTable[8'h5c] = 8'h49;
assign eTable[8'h5d] = 8'hdb;
assign eTable[8'h5e] = 8'h76;
assign eTable[8'h5f] = 8'h9a;
assign eTable[8'h60] = 8'hb5;
assign eTable[8'h61] = 8'hc4;
assign eTable[8'h62] = 8'h57;
assign eTable[8'h63] = 8'hf9;
assign eTable[8'h64] = 8'h10;
assign eTable[8'h65] = 8'h30;
assign eTable[8'h66] = 8'h50;
assign eTable[8'h67] = 8'hf0;
assign eTable[8'h68] = 8'h0b;
assign eTable[8'h69] = 8'h1d;
assign eTable[8'h6a] = 8'h27;
assign eTable[8'h6b] = 8'h69;
assign eTable[8'h6c] = 8'hbb;
assign eTable[8'h6d] = 8'hd6;
assign eTable[8'h6e] = 8'h61;
assign eTable[8'h6f] = 8'ha3;
assign eTable[8'h70] = 8'hfe;
assign eTable[8'h71] = 8'h19;
assign eTable[8'h72] = 8'h2b;
assign eTable[8'h73] = 8'h7d;
assign eTable[8'h74] = 8'h87;
assign eTable[8'h75] = 8'h92;
assign eTable[8'h76] = 8'had;
assign eTable[8'h77] = 8'hec;
assign eTable[8'h78] = 8'h2f;
assign eTable[8'h79] = 8'h71;
assign eTable[8'h7a] = 8'h93;
assign eTable[8'h7b] = 8'hae;
assign eTable[8'h7c] = 8'he9;
assign eTable[8'h7d] = 8'h20;
assign eTable[8'h7e] = 8'h60;
assign eTable[8'h7f] = 8'ha0;
assign eTable[8'h80] = 8'hfb;
assign eTable[8'h81] = 8'h16;
assign eTable[8'h82] = 8'h3a;
assign eTable[8'h83] = 8'h4e;
assign eTable[8'h84] = 8'hd2;
assign eTable[8'h85] = 8'h6d;
assign eTable[8'h86] = 8'hb7;
assign eTable[8'h87] = 8'hc2;
assign eTable[8'h88] = 8'h5d;
assign eTable[8'h89] = 8'he7;
assign eTable[8'h8a] = 8'h32;
assign eTable[8'h8b] = 8'h56;
assign eTable[8'h8c] = 8'hfa;
assign eTable[8'h8d] = 8'h15;
assign eTable[8'h8e] = 8'h3f;
assign eTable[8'h8f] = 8'h41;
assign eTable[8'h90] = 8'hc3;
assign eTable[8'h91] = 8'h5e;
assign eTable[8'h92] = 8'he2;
assign eTable[8'h93] = 8'h3d;
assign eTable[8'h94] = 8'h47;
assign eTable[8'h95] = 8'hc9;
assign eTable[8'h96] = 8'h40;
assign eTable[8'h97] = 8'hc0;
assign eTable[8'h98] = 8'h5b;
assign eTable[8'h99] = 8'hed;
assign eTable[8'h9a] = 8'h2c;
assign eTable[8'h9b] = 8'h74;
assign eTable[8'h9c] = 8'h9c;
assign eTable[8'h9d] = 8'hbf;
assign eTable[8'h9e] = 8'hda;
assign eTable[8'h9f] = 8'h75;
assign eTable[8'ha0] = 8'h9f;
assign eTable[8'ha1] = 8'hba;
assign eTable[8'ha2] = 8'hd5;
assign eTable[8'ha3] = 8'h64;
assign eTable[8'ha4] = 8'hac;
assign eTable[8'ha5] = 8'hef;
assign eTable[8'ha6] = 8'h2a;
assign eTable[8'ha7] = 8'h7e;
assign eTable[8'ha8] = 8'h82;
assign eTable[8'ha9] = 8'h9d;
assign eTable[8'haa] = 8'hbc;
assign eTable[8'hab] = 8'hdf;
assign eTable[8'hac] = 8'h7a;
assign eTable[8'had] = 8'h8e;
assign eTable[8'hae] = 8'h89;
assign eTable[8'haf] = 8'h80;
assign eTable[8'hb0] = 8'h9b;
assign eTable[8'hb1] = 8'hbc;
assign eTable[8'hb2] = 8'hc1;
assign eTable[8'hb3] = 8'h58;
assign eTable[8'hb4] = 8'he8;
assign eTable[8'hb5] = 8'h23;
assign eTable[8'hb6] = 8'h65;
assign eTable[8'hb7] = 8'haf;
assign eTable[8'hb8] = 8'hea;
assign eTable[8'hb9] = 8'h25;
assign eTable[8'hba] = 8'h6f;
assign eTable[8'hbb] = 8'hb1;
assign eTable[8'hbc] = 8'hc8;
assign eTable[8'hbd] = 8'h43;
assign eTable[8'hbe] = 8'hc5;
assign eTable[8'hbf] = 8'h54;
assign eTable[8'hc0] = 8'hfc;
assign eTable[8'hc1] = 8'h1f;
assign eTable[8'hc2] = 8'h21;
assign eTable[8'hc3] = 8'h63;
assign eTable[8'hc4] = 8'ha5;
assign eTable[8'hc5] = 8'hf4;
assign eTable[8'hc6] = 8'h07;
assign eTable[8'hc7] = 8'h09;
assign eTable[8'hc8] = 8'h1b;
assign eTable[8'hc9] = 8'h2d;
assign eTable[8'hca] = 8'h77;
assign eTable[8'hcb] = 8'h99;
assign eTable[8'hcc] = 8'hb0;
assign eTable[8'hcd] = 8'hcb;
assign eTable[8'hce] = 8'h46;
assign eTable[8'hcf] = 8'hca;
assign eTable[8'hd0] = 8'h45;
assign eTable[8'hd1] = 8'hcf;
assign eTable[8'hd2] = 8'h4a;
assign eTable[8'hd3] = 8'hde;
assign eTable[8'hd4] = 8'h79;
assign eTable[8'hd5] = 8'h8b;
assign eTable[8'hd6] = 8'h86;
assign eTable[8'hd7] = 8'h91;
assign eTable[8'hd8] = 8'ha8;
assign eTable[8'hd9] = 8'he3;
assign eTable[8'hda] = 8'h3e;
assign eTable[8'hdb] = 8'h42;
assign eTable[8'hdc] = 8'hc6;
assign eTable[8'hdd] = 8'h51;
assign eTable[8'hde] = 8'hf3;
assign eTable[8'hdf] = 8'h0e;
assign eTable[8'he0] = 8'h12;
assign eTable[8'he1] = 8'h36;
assign eTable[8'he2] = 8'h5a;
assign eTable[8'he3] = 8'hee;
assign eTable[8'he4] = 8'h29;
assign eTable[8'he5] = 8'h7b;
assign eTable[8'he6] = 8'h8d;
assign eTable[8'he7] = 8'h8c;
assign eTable[8'he8] = 8'h8f;
assign eTable[8'he9] = 8'h8a;
assign eTable[8'hea] = 8'h85;
assign eTable[8'heb] = 8'h94;
assign eTable[8'hec] = 8'ha7;
assign eTable[8'hed] = 8'hf2;
assign eTable[8'hee] = 8'h0d;
assign eTable[8'hef] = 8'h17;
assign eTable[8'hf0] = 8'h39;
assign eTable[8'hf1] = 8'h4b;
assign eTable[8'hf2] = 8'hdd;
assign eTable[8'hf3] = 8'h7c;
assign eTable[8'hf4] = 8'h84;
assign eTable[8'hf5] = 8'h97;
assign eTable[8'hf6] = 8'ha2;
assign eTable[8'hf7] = 8'hfd;
assign eTable[8'hf8] = 8'h1c;
assign eTable[8'hf9] = 8'h24;
assign eTable[8'hfa] = 8'h6c;
assign eTable[8'hfb] = 8'hb4;
assign eTable[8'hfc] = 8'hc7;
assign eTable[8'hfd] = 8'h52;
assign eTable[8'hfe] = 8'hf6;
assign eTable[8'hff] = 8'h01;

/* LTABLE */
//assign eTable[8'h00] = 8'h01;
assign lTable[8'h01] = 8'h00;
assign lTable[8'h02] = 8'h19;
assign lTable[8'h03] = 8'h01;
assign lTable[8'h04] = 8'h32;
assign lTable[8'h05] = 8'h02;
assign lTable[8'h06] = 8'h1a;
assign lTable[8'h07] = 8'hc6;
assign lTable[8'h08] = 8'h4b;
assign lTable[8'h09] = 8'hc7;
assign lTable[8'h0a] = 8'h1b;
assign lTable[8'h0b] = 8'h68;
assign lTable[8'h0c] = 8'h33;
assign lTable[8'h0d] = 8'hee;
assign lTable[8'h0e] = 8'hdf;
assign lTable[8'h0f] = 8'h03;
assign lTable[8'h10] = 8'h64;
assign lTable[8'h11] = 8'h04;
assign lTable[8'h12] = 8'he0;
assign lTable[8'h13] = 8'h0e;
assign lTable[8'h14] = 8'h34;
assign lTable[8'h15] = 8'h8d;
assign lTable[8'h16] = 8'h81;
assign lTable[8'h17] = 8'hef;
assign lTable[8'h18] = 8'h4c;
assign lTable[8'h19] = 8'h71;
assign lTable[8'h1a] = 8'h08;
assign lTable[8'h1b] = 8'hc8;
assign lTable[8'h1c] = 8'hf8;
assign lTable[8'h1d] = 8'h69;
assign lTable[8'h1e] = 8'h1c;
assign lTable[8'h1f] = 8'hc1;
assign lTable[8'h20] = 8'h7d;
assign lTable[8'h21] = 8'hc2;
assign lTable[8'h22] = 8'h1d;
assign lTable[8'h23] = 8'hb5;
assign lTable[8'h24] = 8'hf9;
assign lTable[8'h25] = 8'hb9;
assign lTable[8'h26] = 8'h27;
assign lTable[8'h27] = 8'h6a;
assign lTable[8'h28] = 8'h4d;
assign lTable[8'h29] = 8'he4;
assign lTable[8'h2a] = 8'ha6;
assign lTable[8'h2b] = 8'h72;
assign lTable[8'h2c] = 8'h9a;
assign lTable[8'h2d] = 8'hc9;
assign lTable[8'h2e] = 8'h09;
assign lTable[8'h2f] = 8'h78;
assign lTable[8'h30] = 8'h65;
assign lTable[8'h31] = 8'h2f;
assign lTable[8'h32] = 8'h8a;
assign lTable[8'h33] = 8'h05;
assign lTable[8'h34] = 8'h21;
assign lTable[8'h35] = 8'h0f;
assign lTable[8'h36] = 8'he1;
assign lTable[8'h37] = 8'h24;
assign lTable[8'h38] = 8'h12;
assign lTable[8'h39] = 8'hf0;
assign lTable[8'h3a] = 8'h82;
assign lTable[8'h3b] = 8'h45;
assign lTable[8'h3c] = 8'h35;
assign lTable[8'h3d] = 8'h93;
assign lTable[8'h3e] = 8'hda;
assign lTable[8'h3f] = 8'h83;
assign lTable[8'h40] = 8'h96;
assign lTable[8'h41] = 8'h8f;
assign lTable[8'h42] = 8'hdb;
assign lTable[8'h43] = 8'hbd;
assign lTable[8'h44] = 8'h36;
assign lTable[8'h45] = 8'hd0;
assign lTable[8'h46] = 8'hce;
assign lTable[8'h47] = 8'h94;
assign lTable[8'h48] = 8'h13;
assign lTable[8'h49] = 8'h5c;
assign lTable[8'h4a] = 8'hd2;
assign lTable[8'h4b] = 8'hf1;
assign lTable[8'h4c] = 8'h40;
assign lTable[8'h4d] = 8'h46;
assign lTable[8'h4e] = 8'h83;
assign lTable[8'h4f] = 8'h38;
assign lTable[8'h50] = 8'h66;
assign lTable[8'h51] = 8'hdd;
assign lTable[8'h52] = 8'hfd;
assign lTable[8'h53] = 8'h30;
assign lTable[8'h54] = 8'hbf;
assign lTable[8'h55] = 8'h06;
assign lTable[8'h56] = 8'h8b;
assign lTable[8'h57] = 8'h62;
assign lTable[8'h58] = 8'hb3;
assign lTable[8'h59] = 8'h25;
assign lTable[8'h5a] = 8'he2;
assign lTable[8'h5b] = 8'h98;
assign lTable[8'h5c] = 8'h22;
assign lTable[8'h5d] = 8'h88;
assign lTable[8'h5e] = 8'h91;
assign lTable[8'h5f] = 8'h10;
assign lTable[8'h60] = 8'h7e;
assign lTable[8'h61] = 8'h6e;
assign lTable[8'h62] = 8'h48;
assign lTable[8'h63] = 8'hc3;
assign lTable[8'h64] = 8'ha3;
assign lTable[8'h65] = 8'hb6;
assign lTable[8'h66] = 8'h1e;
assign lTable[8'h67] = 8'h42;
assign lTable[8'h68] = 8'h3a;
assign lTable[8'h69] = 8'h6b;
assign lTable[8'h6a] = 8'h28;
assign lTable[8'h6b] = 8'h54;
assign lTable[8'h6c] = 8'hfa;
assign lTable[8'h6d] = 8'h85;
assign lTable[8'h6e] = 8'h3d;
assign lTable[8'h6f] = 8'hba;
assign lTable[8'h70] = 8'h2b;
assign lTable[8'h71] = 8'h79;
assign lTable[8'h72] = 8'h0a;
assign lTable[8'h73] = 8'h15;
assign lTable[8'h74] = 8'h9b;
assign lTable[8'h75] = 8'h9f;
assign lTable[8'h76] = 8'h5e;
assign lTable[8'h77] = 8'hca;
assign lTable[8'h78] = 8'h4e;
assign lTable[8'h79] = 8'hd4;
assign lTable[8'h7a] = 8'hac;
assign lTable[8'h7b] = 8'he5;
assign lTable[8'h7c] = 8'hf3;
assign lTable[8'h7d] = 8'h73;
assign lTable[8'h7e] = 8'ha7;
assign lTable[8'h7f] = 8'h57;
assign lTable[8'h80] = 8'haf;
assign lTable[8'h81] = 8'h58;
assign lTable[8'h82] = 8'ha8;
assign lTable[8'h83] = 8'h50;
assign lTable[8'h84] = 8'hf4;
assign lTable[8'h85] = 8'hea;
assign lTable[8'h86] = 8'hd6;
assign lTable[8'h87] = 8'h74;
assign lTable[8'h88] = 8'h4f;
assign lTable[8'h89] = 8'hae;
assign lTable[8'h8a] = 8'he9;
assign lTable[8'h8b] = 8'hd5;
assign lTable[8'h8c] = 8'he7;
assign lTable[8'h8d] = 8'he6;
assign lTable[8'h8e] = 8'had;
assign lTable[8'h8f] = 8'he8;
assign lTable[8'h90] = 8'h2c;
assign lTable[8'h91] = 8'hd7;
assign lTable[8'h92] = 8'h75;
assign lTable[8'h93] = 8'h7a;
assign lTable[8'h94] = 8'heb;
assign lTable[8'h95] = 8'h16;
assign lTable[8'h96] = 8'h0b;
assign lTable[8'h97] = 8'hf5;
assign lTable[8'h98] = 8'h59;
assign lTable[8'h99] = 8'hcb;
assign lTable[8'h9a] = 8'h5f;
assign lTable[8'h9b] = 8'hb0;
assign lTable[8'h9c] = 8'h9c;
assign lTable[8'h9d] = 8'ha9;
assign lTable[8'h9e] = 8'h51;
assign lTable[8'h9f] = 8'ha0;
assign lTable[8'ha0] = 8'h7f;
assign lTable[8'ha1] = 8'h0c;
assign lTable[8'ha2] = 8'hf6;
assign lTable[8'ha3] = 8'h6f;
assign lTable[8'ha4] = 8'h17;
assign lTable[8'ha5] = 8'hc4;
assign lTable[8'ha6] = 8'h49;
assign lTable[8'ha7] = 8'hec;
assign lTable[8'ha8] = 8'hd8;
assign lTable[8'ha9] = 8'h43;
assign lTable[8'haa] = 8'h1f;
assign lTable[8'hab] = 8'h2d;
assign lTable[8'hac] = 8'ha4;
assign lTable[8'had] = 8'h76;
assign lTable[8'hae] = 8'h7b;
assign lTable[8'haf] = 8'hb7;
assign lTable[8'hb0] = 8'hcc;
assign lTable[8'hb1] = 8'hbb;
assign lTable[8'hb2] = 8'h3e;
assign lTable[8'hb3] = 8'h5a;
assign lTable[8'hb4] = 8'hfb;
assign lTable[8'hb5] = 8'h60;
assign lTable[8'hb6] = 8'hb1;
assign lTable[8'hb7] = 8'h86;
assign lTable[8'hb8] = 8'h3b;
assign lTable[8'hb9] = 8'h52;
assign lTable[8'hba] = 8'ha1;
assign lTable[8'hbb] = 8'h6c;
assign lTable[8'hbc] = 8'haa;
assign lTable[8'hbd] = 8'h55;
assign lTable[8'hbe] = 8'h29;
assign lTable[8'hbf] = 8'h9d;
assign lTable[8'hc0] = 8'h97;
assign lTable[8'hc1] = 8'hb2;
assign lTable[8'hc2] = 8'h87;
assign lTable[8'hc3] = 8'h90;
assign lTable[8'hc4] = 8'h61;
assign lTable[8'hc5] = 8'hbe;
assign lTable[8'hc6] = 8'hdc;
assign lTable[8'hc7] = 8'hfc;
assign lTable[8'hc8] = 8'hbc;
assign lTable[8'hc9] = 8'h95;
assign lTable[8'hca] = 8'hcf;
assign lTable[8'hcb] = 8'hcd;
assign lTable[8'hcc] = 8'h37;
assign lTable[8'hcd] = 8'h3f;
assign lTable[8'hce] = 8'h5b;
assign lTable[8'hcf] = 8'hd1;
assign lTable[8'hd0] = 8'h53;
assign lTable[8'hd1] = 8'h39;
assign lTable[8'hd2] = 8'h84;
assign lTable[8'hd3] = 8'h3c;
assign lTable[8'hd4] = 8'h41;
assign lTable[8'hd5] = 8'ha2;
assign lTable[8'hd6] = 8'h6d;
assign lTable[8'hd7] = 8'h47;
assign lTable[8'hd8] = 8'h14;
assign lTable[8'hd9] = 8'h2a;
assign lTable[8'hda] = 8'h9e;
assign lTable[8'hdb] = 8'h5d;
assign lTable[8'hdc] = 8'h56;
assign lTable[8'hdd] = 8'hf2;
assign lTable[8'hde] = 8'hd3;
assign lTable[8'hdf] = 8'hab;
assign lTable[8'he0] = 8'h44;
assign lTable[8'he1] = 8'h11;
assign lTable[8'he2] = 8'h92;
assign lTable[8'he3] = 8'hd9;
assign lTable[8'he4] = 8'h23;
assign lTable[8'he5] = 8'h20;
assign lTable[8'he6] = 8'h2e;
assign lTable[8'he7] = 8'h89;
assign lTable[8'he8] = 8'hb4;
assign lTable[8'he9] = 8'h7c;
assign lTable[8'hea] = 8'hb8;
assign lTable[8'heb] = 8'h26;
assign lTable[8'hec] = 8'h77;
assign lTable[8'hed] = 8'h99;
assign lTable[8'hee] = 8'he3;
assign lTable[8'hef] = 8'ha5;
assign lTable[8'hf0] = 8'h67;
assign lTable[8'hf1] = 8'h4a;
assign lTable[8'hf2] = 8'hed;
assign lTable[8'hf3] = 8'hde;
assign lTable[8'hf4] = 8'hc5;
assign lTable[8'hf5] = 8'h31;
assign lTable[8'hf6] = 8'hfe;
assign lTable[8'hf7] = 8'h18;
assign lTable[8'hf8] = 8'h0d;
assign lTable[8'hf9] = 8'h63;
assign lTable[8'hfa] = 8'h8c;
assign lTable[8'hfb] = 8'h80;
assign lTable[8'hfc] = 8'hc0;
assign lTable[8'hfd] = 8'hf7;
assign lTable[8'hfe] = 8'h70;
assign lTable[8'hff] = 8'h07;


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
             if(expandedKeyEnable)begin
                 k[58] = expandedKey;
                 next_state = 63;
             end
        end
        63:begin
            if(expandedKeyEnable) begin
                 k[59] = expandedKey;
                 next_state = 64;
            end            
        end
        64:begin
            if(plaintextEnable)
                next_state = 65;
        end
        65:begin
            if(plaintextEnable)
                next_state = 66;        
        end
        66:begin
            if(plaintextEnable)
                next_state = 67;        
        end
        67:begin
            if(plaintextEnable)begin
                w[0] = plaintext;
                next_state = 68;
            end
        end
        68:begin
            if(plaintextEnable)begin
                w[1] = plaintext;
                next_state = 69;
            end
        end
        69:begin
            if(plaintextEnable)begin
                w[2] = plaintext;
                next_state = 70;
            end
        end
        70:begin
            if(plaintextEnable)begin
                w[3] = plaintext;
                next_state = 71;
            end
        end
        71:begin
           tempStart[0] = w[0] ^ k[0];
           tempStart[1] = w[1] ^ k[1];
           tempStart[2] = w[2] ^ k[2];
           tempStart[3] = w[3] ^ k[3];
           next_state = 72;              
        end
        72:begin
           b[0] = sbox[tempStart[0][31:24]];
           b[1] = sbox[tempStart[0][23:16]];
           b[2] = sbox[tempStart[0][15:8]];
           b[3] = sbox[tempStart[0][7:0]];        
           b[4] = sbox[tempStart[1][31:24]];
           b[5] = sbox[tempStart[1][23:16]];
           b[6] = sbox[tempStart[1][15:8]];
           b[7] = sbox[tempStart[1][7:0]];
           b[8] = sbox[tempStart[2][31:24]];
           b[9] = sbox[tempStart[2][23:16]];
           b[10] = sbox[tempStart[2][15:8]];
           b[11] = sbox[tempStart[2][7:0]];
           b[12] = sbox[tempStart[3][31:24]];
           b[13] = sbox[tempStart[3][23:16]];
           b[14] = sbox[tempStart[3][15:8]];
           b[15] = sbox[tempStart[3][7:0]];      
           next_state = 73; 
        end
        73:begin
            tempRow[0] = b[0];
            tempRow[1] = b[5];
            tempRow[2] = b[10];
            tempRow[3] = b[15];
            tempRow[4] = b[4];
            tempRow[5] = b[9];
            tempRow[6] = b[14];
            tempRow[7] = b[3];
            tempRow[8] = b[8];
            tempRow[9] = b[13];
            tempRow[10] = b[2];
            tempRow[11] = b[7];
            tempRow[12] = b[12];
            tempRow[13] = b[1];
            tempRow[14] = b[6];
            tempRow[15] = b[11];
            next_state = 74;
        end
        74:begin
         /* For b0*/
            l[0] = lTable[tempRow[0]] + lTable[2];
            if(l[0] > 255)
                l[0] = l[0]-255;
            l[1] = lTable[tempRow[1]] + lTable[3];
            if(l[1] > 255)
                l[1] = l[1]-255;
        /* For b1 */
            l[2] = lTable[tempRow[1]] + lTable[2];
            if(l[2] > 255)
                l[2] = l[2]-255;
            l[3] = lTable[tempRow[2]] + lTable[3];
            if(l[3] > 255)
                l[3] = l[3]-255;
        /* For b2*/
            l[4] = lTable[tempRow[2]] + lTable[2];
            if(l[4] > 255)
                l[4] = l[4]-255;
            l[5] = lTable[tempRow[3]] + lTable[3];
                if(l[5] > 255)
                    l[5] = l[5]-255;
        /* For b3*/
            l[6] = lTable[tempRow[0]] + lTable[3];
            if(l[6] > 255)
                l[6] = l[6]-255;
            l[7] = lTable[tempRow[3]] + lTable[2];
                if(l[7] > 255)
                    l[7] = l[7]-255;            
         /* For b4*/
           l[8] = lTable[tempRow[4]] + lTable[2];
           if(l[8] > 255)
               l[8] = l[8]-255;
           l[9] = lTable[tempRow[5]] + lTable[3];
           if(l[9] > 255)
               l[9] = l[9]-255;
       /* For b5 */
           l[10] = lTable[tempRow[5]] + lTable[2];
           if(l[10] > 255)
               l[10] = l[10]-255;
           l[11] = lTable[tempRow[6]] + lTable[3];
           if(l[11] > 255)
               l[11] = l[11]-255;
       /* For b6*/
           l[12] = lTable[tempRow[6]] + lTable[2];
           if(l[12] > 255)
               l[12] = l[12]-255;
           l[13] = lTable[tempRow[7]] + lTable[3];
               if(l[13] > 255)
                   l[13] = l[13]-255;
       /* For b7*/
           l[14] = lTable[tempRow[4]] + lTable[3];
           if(l[14] > 255)
               l[14] = l[14]-255;
           l[15] = lTable[tempRow[7]] + lTable[2];
               if(l[15] > 255)
                   l[15] = l[15]-255;    


            next_state = 75;
        end
        75:begin
            d[0] = eTable[l[0]]^eTable[l[1]]^tempRow[2]^tempRow[3];
            d[1] = tempRow[0]^eTable[l[2]]^eTable[l[3]]^tempRow[3];
            d[2] = tempRow[0]^tempRow[1]^eTable[l[4]]^eTable[l[5]];
            d[3] = eTable[l[6]]^tempRow[1]^tempRow[2]^eTable[l[7]];
            d[4] = eTable[l[8]]^eTable[l[9]]^tempRow[6]^tempRow[7];
            d[5] = tempRow[4]^eTable[l[10]]^eTable[l[11]]^tempRow[7];
            d[6] = tempRow[4]^tempRow[5]^eTable[l[12]]^eTable[l[13]];
            d[7] = eTable[l[14]]^tempRow[5]^tempRow[6]^eTable[l[15]];

            ciphertext = {d[0],d[1],d[2],d[3],d[4],d[5],d[6],d[7]}; 
            next_state = 76; 
        end
        76:begin
            //ciphertext = d[0];
            ciphertextDone = 1;                            
        end
        //end
    endcase
end
endmodule