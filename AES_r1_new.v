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
        /* round[1].is_box => tempSbox[n] */
        tempSbox[0] = inv_sbox[tempStart[0][31:24]];tempSbox[1] = inv_sbox[tempStart[0][23:16]];tempSbox[2] = inv_sbox[tempStart[0][15:8]];tempSbox[3] = inv_sbox[tempStart[0][7:0]];
        tempSbox[4] = inv_sbox[tempStart[1][31:24]];tempSbox[5] = inv_sbox[tempStart[1][23:16]];tempSbox[6] = inv_sbox[tempStart[1][15:8]];tempSbox[7] = inv_sbox[tempStart[1][7:0]];
        tempSbox[8] = inv_sbox[tempStart[2][31:24]];tempSbox[9] = inv_sbox[tempStart[2][23:16]];tempSbox[10] = inv_sbox[tempStart[2][15:8]];tempSbox[11] = inv_sbox[tempStart[2][7:0]];
        tempSbox[12] = inv_sbox[tempStart[3][31:24]];tempSbox[13] = inv_sbox[tempStart[3][23:16]];tempSbox[14] = inv_sbox[tempStart[3][15:8]];tempSbox[15] = inv_sbox[tempStart[3][7:0]];
        next_state = 5;
    end
    5:begin
       /* round[1].is_row => tempRow[n] */
        tempRow[0] = tempSbox[0];tempRow[1] = tempSbox[13];tempRow[2] = tempSbox[10];tempRow[3] = tempSbox[7];
        tempRow[4] = tempSbox[4];tempRow[5] = tempSbox[1];tempRow[6] = tempSbox[14];tempRow[7] = tempSbox[11];
        tempRow[8] = tempSbox[8];tempRow[9] = tempSbox[5];tempRow[10] = tempSbox[2];tempRow[11] = tempSbox[15];
        tempRow[12] = tempSbox[12];tempRow[13] = tempSbox[9];tempRow[14] = tempSbox[6];tempRow[15] = tempSbox[3];
        next_state = 6;
    end
	6:begin 
	    /* For b0 & b4*/
		if(tempRow[0] == 0)begin LT[0] = 0; LT[4] = 0; LT[8] = 0; LT[12] = 0 ;end
		else begin LT[0] = lTable[tempRow[0]] + lTable[8'h0e];LT[4] = lTable[tempRow[0]] + lTable[8'h09];LT[8] =  lTable[tempRow[0]] + lTable[8'h0d];LT[12] = lTable[tempRow[0]] + lTable[8'h0b];end
	    /* For b1 & b2*/
		if(tempRow[1] == 0)begin LT[1] = 0;LT[5] = 0;LT[9] =0; LT[13] = 0;end
		else begin LT[1] = lTable[tempRow[1]] + lTable[8'h0b];LT[5] = lTable[tempRow[1]] + lTable[8'h0e];LT[9] = lTable[tempRow[1]] + lTable[8'h09]; LT[13] = lTable[tempRow[1]] + lTable[8'h0d];end
	    /* For b3 & b4*/
		if(tempRow[2] == 0)begin LT[2] = 0;LT[6] = 0;LT[10] = 0;LT[14] = 0;end
		else begin LT[2] = lTable[tempRow[2]] + lTable[8'h0d];LT[6] = lTable[tempRow[2]] + lTable[8'h0b];LT[10] = lTable[tempRow[2]] + lTable[8'h0e];LT[14] = lTable[tempRow[2]] + lTable[8'h09];end
	    /* For b5 & b7*/			
		if(tempRow[3] == 0)begin LT[3] = 0;LT[7] = 0;LT[11] = 0;LT[15] = 0;end 
		else begin  LT[3] = lTable[tempRow[3]] + lTable[8'h09];LT[7] = lTable[tempRow[3]] + lTable[8'h0d];LT[11] = lTable[tempRow[3]] + lTable[8'h0b];LT[15] = lTable[tempRow[3]] + lTable[8'h0e];end
	    /* For b8 & b14 */				
		if(tempRow[4] == 0)begin LT[16] = 0; LT[20] = 0; LT[24] = 0; LT[28] = 0;end
		else begin LT[16] = lTable[tempRow[4]] + lTable[8'h0e]; LT[20] = lTable[tempRow[4]] + lTable[8'h09]; LT[24] = lTable[tempRow[4]] + lTable[8'h0d]; LT[28] = lTable[tempRow[4]] + lTable[8'h0b];end
		/* For b9 & b10 */
		if(tempRow[5] == 0)begin LT[17] = 0;LT[21] = 0; LT[25] = 0;LT[29] = 0;end
		else begin LT[17] = lTable[tempRow[5]] + lTable[8'h0b];LT[21] = lTable[tempRow[5]] + lTable[8'h0e]; LT[25] = lTable[tempRow[5]] + lTable[8'h09];LT[29] = lTable[tempRow[5]] + lTable[8'h0d];end
		/* For b11 & b12*/
		if(tempRow[6] == 0)begin LT[18] = 0;LT[22] = 0; LT[26] = 0;LT[30] = 0;end
		else begin LT[18] = lTable[tempRow[6]] + lTable[8'h0d];LT[22] = lTable[tempRow[6]] + lTable[8'h0b]; LT[26] = lTable[tempRow[6]] + lTable[8'h0e];LT[30] = lTable[tempRow[6]] + lTable[8'h09];end
		/* For b13 & b15 */
		if(tempRow[7] == 0)begin LT[19] = 0;LT[23] = 0; LT[27] = 0;LT[31] = 0;end
		else begin LT[19] = lTable[tempRow[7]] + lTable[8'h09];LT[23] = lTable[tempRow[7]] + lTable[8'h0d]; LT[27] = lTable[tempRow[7]] + lTable[8'h0b];LT[31] = lTable[tempRow[7]] + lTable[8'h0e];end
		/* For b16 & b22 */
		if(tempRow[8] == 0)begin LT[32] = 0;LT[36] = 0; LT[40] = 0;LT[44] = 0;end
		else begin LT[32] = lTable[tempRow[8]] + lTable[8'h0e];LT[36] = lTable[tempRow[8]] + lTable[8'h09];LT[40] = lTable[tempRow[8]] + lTable[8'h0d];LT[44] = lTable[tempRow[8]] + lTable[8'h0b];end
		/* For b17 & 18 */
		if(tempRow[9] == 0)begin LT[33] = 0;LT[37] = 0; LT[41] = 0;LT[45] = 0;end
		else begin LT[33] = lTable[tempRow[9]] + lTable[8'h0b];LT[37] = lTable[tempRow[9]] + lTable[8'h0e]; LT[41] = lTable[tempRow[9]] + lTable[8'h09];LT[45] = lTable[tempRow[9]] + lTable[8'h0d];end
		/* For b19 & b20 */
		if(tempRow[10] == 0)begin LT[34] = 0;LT[38] = 0;LT[42] = 0;LT[46] = 0;end
		else begin LT[34] = lTable[tempRow[10]] + lTable[8'h0d];LT[38] = lTable[tempRow[10]] + lTable[8'h0b];LT[42] = lTable[tempRow[10]] + lTable[8'h0e];LT[46] = lTable[tempRow[10]] + lTable[8'h09];end
		/* For b21 & b23 */
		if(tempRow[11] == 0)begin LT[35] = 0; LT[39] =0;LT[43] = 0; LT[47] =0;end
		else begin  LT[35] = lTable[tempRow[11]] + lTable[8'h09]; LT[39] =lTable[tempRow[11]] + lTable[8'h0d];LT[43] = lTable[tempRow[11]] + lTable[8'h0b]; LT[47] =lTable[tempRow[11]] + lTable[8'h0e];end	
		/* For b24 & b30 */
		if(tempRow[12] == 0)begin LT[48] = 0;LT[52] = 0; LT[56] = 0;LT[60] = 0;end 
		else begin LT[48] = lTable[tempRow[12]] + lTable[8'h0e];LT[52] = lTable[tempRow[12]] + lTable[8'h09]; LT[56] = lTable[tempRow[12]] + lTable[8'h0d];LT[60] = lTable[tempRow[12]] + lTable[8'h0b];end 		
		/* For b25 & b26 */		
		if(tempRow[13] == 0)begin LT[49] = 0;LT[53] = 0; LT[57] = 0;LT[61] = 0;end 
		else begin  LT[49] = lTable[tempRow[13]] + lTable[8'h0b];LT[53] = lTable[tempRow[13]] + lTable[8'h0e]; LT[57] = lTable[tempRow[13]] + lTable[8'h09];LT[61] = lTable[tempRow[13]] + lTable[8'h0d];end 
		/* For b27 & b28 */
		if(tempRow[14] == 0)begin LT[50] = 0;LT[54] = 0; LT[58] = 0;LT[62] = 0;end 
		else begin LT[50] = lTable[tempRow[14]] + lTable[8'h0d];LT[54] = lTable[tempRow[14]] + lTable[8'h0b]; LT[58] = lTable[tempRow[14]] + lTable[8'h0e];LT[62] = lTable[tempRow[14]] + lTable[8'h09];end 
		/* For b29 & b31 */
		if(tempRow[15] == 0)begin LT[51] = 0;LT[55] = 0; LT[59] = 0;LT[63] = 0;end 
		else begin LT[51] = lTable[tempRow[15]] + lTable[8'h09];LT[55] = lTable[tempRow[15]] + lTable[8'h0d]; LT[59] = lTable[tempRow[15]] + lTable[8'h0b];LT[63] = lTable[tempRow[15]] + lTable[8'h0e];end 
        next_state = 7;
    end
    7:begin
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
		next_state = 8;
	end
	8:begin
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
		next_state = 9;
	end
    9:begin
        d[0] = ET[0]^ET[1]^ET[2]^ET[3];
        d[1] = ET[4]^ET[5]^ET[6]^ET[7];
        d[2] = ET[8]^ET[9]^ET[10]^ET[11];
        d[3] = ET[12]^ET[13]^ET[14]^ET[15];
        d[4] = ET[16]^ET[17]^ET[18]^ET[19];
        d[5] = ET[20]^ET[21]^ET[22]^ET[23];
        d[6] = ET[24]^ET[25]^ET[26]^ET[27];
        d[7] = ET[28]^ET[29]^ET[30]^ET[31];
        d[8] = ET[32]^ET[33]^ET[34]^ET[35];
        d[9] = ET[36]^ET[37]^ET[38]^ET[39];
        d[10] = ET[40]^ET[41]^ET[42]^ET[43];
        d[11] = ET[44]^ET[45]^ET[46]^ET[47];
        d[12] = ET[48]^ET[49]^ET[50]^ET[51];
        d[13] = ET[52]^ET[53]^ET[54]^ET[55];
        d[14] = ET[56]^ET[57]^ET[58]^ET[59];
        d[15] =ET[60]^ET[61]^ET[62]^ET[63]; 
        next_state = 10;
    end
    10:begin
         w1[0] = {d[0],d[1],d[2],d[3]};
         w1[1] = {d[4],d[5],d[6],d[7]};
         w1[2] = {d[8],d[9],d[10],d[11]};
         w1[3] = {d[12],d[13],d[14],d[15]};
         next_state = 99;
    end
    99: begin
        plaintext = {w1[0],w1[1],w1[2],w1[3]};
       //cipher = {tempRow[0],tempRow[1],tempRow[2],tempRow[3],tempRow[4],tempRow[5],tempRow[6],tempRow[7],tempRow[8],tempRow[9],tempRow[10],tempRow[11],tempRow[12],tempRow[13],tempRow[14],tempRow[15]};
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
