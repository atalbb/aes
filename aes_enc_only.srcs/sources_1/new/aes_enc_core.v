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
reg [7:0]d27[15:0];
reg [7:0]d28[15:0];
reg [7:0]d29[15:0];
reg [7:0]d30[15:0];
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
reg [31:0]tempStart6[3:0];
reg [31:0]tempStart7[3:0];
reg [31:0]tempStart8[3:0];
reg [31:0]tempStart9[3:0];
reg [31:0]tempStart10[3:0];
reg [31:0]tempStart11[3:0];
reg [31:0]tempStart12[3:0];
reg [31:0]tempStart13[3:0];
reg [31:0]tempStart14[3:0];
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

/* 16-bits wide because they hold sum of two 8 bits data */
reg [15:0]l[63:0];
reg [15:0]l1[63:0];
reg [15:0]l2[63:0];
reg [15:0]l3[63:0];
reg [15:0]l4[63:0];
reg [15:0]l5[63:0];
reg [15:0]l6[63:0];
reg [15:0]l7[63:0];
reg [15:0]l8[63:0];
reg [15:0]l9[63:0];
reg [15:0]l10[63:0];
reg [15:0]l11[63:0];
reg [15:0]l12[63:0];
reg [15:0]l13[63:0];
reg [15:0]l14[63:0];
reg [15:0]LT[63:0];
reg [15:0]LT1[63:0];
reg [15:0]LT2[63:0];
reg [15:0]LT3[63:0];
reg [15:0]LT4[63:0];
reg [15:0]LT5[63:0];
reg [15:0]LT6[63:0];
reg [15:0]LT7[63:0];
reg [15:0]LT8[63:0];
reg [15:0]LT9[63:0];
reg [15:0]LT10[63:0];
reg [15:0]LT11[63:0];
reg [15:0]LT12[63:0];
reg [15:0]LT13[63:0];
reg [15:0]LT14[63:0];
reg [7:0]ET[63:0];
reg [7:0]ET1[63:0];
reg [7:0]ET2[63:0];
reg [7:0]ET3[63:0];
reg [7:0]ET4[63:0];
reg [7:0]ET5[63:0];
reg [7:0]ET6[63:0];
reg [7:0]ET7[63:0];
reg [7:0]ET8[63:0];
reg [7:0]ET9[63:0];
reg [7:0]ET10[63:0];
reg [7:0]ET11[63:0];
reg [7:0]ET12[63:0];
reg [7:0]ET13[63:0];
reg [7:0]ET14[63:0];    
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
		next_state = 42;
	end
	42:begin 
	    /* For b0 & b4*/
		if(d10[0] == 0)begin LT5[0] = 0; LT5[4] = 0; LT5[8] = 0; LT5[12] = 0 ;end
		else begin LT5[0] = lTable[d10[0]] + lTable[8'h0e];LT5[4] = lTable[d10[0]] + lTable[8'h09];LT5[8] =  lTable[d10[0]] + lTable[8'h0d];LT5[12] = lTable[d10[0]] + lTable[8'h0b];end
	    /* For b1 & b2*/
		if(d10[1] == 0)begin LT5[1] = 0;LT5[5] = 0;LT5[9] =0; LT5[13] = 0;end
		else begin LT5[1] = lTable[d10[1]] + lTable[8'h0b];LT5[5] = lTable[d10[1]] + lTable[8'h0e];LT5[9] = lTable[d10[1]] + lTable[8'h09]; LT5[13] = lTable[d10[1]] + lTable[8'h0d];end
	    /* For b3 & b4*/
		if(d10[2] == 0)begin LT5[2] = 0;LT5[6] = 0;LT5[10] = 0;LT5[14] = 0;end
		else begin LT5[2] = lTable[d10[2]] + lTable[8'h0d];LT5[6] = lTable[d10[2]] + lTable[8'h0b];LT5[10] = lTable[d10[2]] + lTable[8'h0e];LT5[14] = lTable[d10[2]] + lTable[8'h09];end
	    /* For b5 & b7*/			
		if(d10[3] == 0)begin LT5[3] = 0;LT5[7] = 0;LT5[11] = 0;LT5[15] = 0;end 
		else begin  LT5[3] = lTable[d10[3]] + lTable[8'h09];LT5[7] = lTable[d10[3]] + lTable[8'h0d];LT5[11] = lTable[d10[3]] + lTable[8'h0b];LT5[15] = lTable[d10[3]] + lTable[8'h0e];end
	    /* For b8 & b14 */				
		if(d10[4] == 0)begin LT5[16] = 0; LT5[20] = 0; LT5[24] = 0; LT5[28] = 0;end
		else begin LT5[16] = lTable[d10[4]] + lTable[8'h0e]; LT5[20] = lTable[d10[4]] + lTable[8'h09]; LT5[24] = lTable[d10[4]] + lTable[8'h0d]; LT5[28] = lTable[d10[4]] + lTable[8'h0b];end
		/* For b9 & b10 */
		if(d10[5] == 0)begin LT5[17] = 0;LT5[21] = 0; LT5[25] = 0;LT5[29] = 0;end
		else begin LT5[17] = lTable[d10[5]] + lTable[8'h0b];LT5[21] = lTable[d10[5]] + lTable[8'h0e]; LT5[25] = lTable[d10[5]] + lTable[8'h09];LT5[29] = lTable[d10[5]] + lTable[8'h0d];end
		/* For b11 & b12*/
		if(d10[6] == 0)begin LT5[18] = 0;LT5[22] = 0; LT5[26] = 0;LT5[30] = 0;end
		else begin LT5[18] = lTable[d10[6]] + lTable[8'h0d];LT5[22] = lTable[d10[6]] + lTable[8'h0b]; LT5[26] = lTable[d10[6]] + lTable[8'h0e];LT5[30] = lTable[d10[6]] + lTable[8'h09];end
		/* For b13 & b15 */
		if(d10[7] == 0)begin LT5[19] = 0;LT5[23] = 0; LT5[27] = 0;LT5[31] = 0;end
		else begin LT5[19] = lTable[d10[7]] + lTable[8'h09];LT5[23] = lTable[d10[7]] + lTable[8'h0d]; LT5[27] = lTable[d10[7]] + lTable[8'h0b];LT5[31] = lTable[d10[7]] + lTable[8'h0e];end
		/* For b16 & b22 */
		if(d10[8] == 0)begin LT5[32] = 0;LT5[36] = 0; LT5[40] = 0;LT5[44] = 0;end
		else begin LT5[32] = lTable[d10[8]] + lTable[8'h0e];LT5[36] = lTable[d10[8]] + lTable[8'h09];LT5[40] = lTable[d10[8]] + lTable[8'h0d];LT5[44] = lTable[d10[8]] + lTable[8'h0b];end
		/* For b17 & 18 */
		if(d10[9] == 0)begin LT5[33] = 0;LT5[37] = 0; LT5[41] = 0;LT5[45] = 0;end
		else begin LT5[33] = lTable[d10[9]] + lTable[8'h0b];LT5[37] = lTable[d10[9]] + lTable[8'h0e]; LT5[41] = lTable[d10[9]] + lTable[8'h09];LT5[45] = lTable[d10[9]] + lTable[8'h0d];end
		/* For b19 & b20 */
		if(d10[10] == 0)begin LT5[34] = 0;LT5[38] = 0;LT5[42] = 0;LT5[46] = 0;end
		else begin LT5[34] = lTable[d10[10]] + lTable[8'h0d];LT5[38] = lTable[d10[10]] + lTable[8'h0b];LT5[42] = lTable[d10[10]] + lTable[8'h0e];LT5[46] = lTable[d10[10]] + lTable[8'h09];end
		/* For b21 & b23 */
		if(d10[11] == 0)begin LT5[35] = 0; LT5[39] =0;LT5[43] = 0; LT5[47] =0;end
		else begin  LT5[35] = lTable[d10[11]] + lTable[8'h09]; LT5[39] =lTable[d10[11]] + lTable[8'h0d];LT5[43] = lTable[d10[11]] + lTable[8'h0b]; LT5[47] =lTable[d10[11]] + lTable[8'h0e];end	
		/* For b24 & b30 */
		if(d10[12] == 0)begin LT5[48] = 0;LT5[52] = 0; LT5[56] = 0;LT5[60] = 0;end 
		else begin LT5[48] = lTable[d10[12]] + lTable[8'h0e];LT5[52] = lTable[d10[12]] + lTable[8'h09]; LT5[56] = lTable[d10[12]] + lTable[8'h0d];LT5[60] = lTable[d10[12]] + lTable[8'h0b];end 		
		/* For b25 & b26 */		
		if(d10[13] == 0)begin LT5[49] = 0;LT5[53] = 0; LT5[57] = 0;LT5[61] = 0;end 
		else begin  LT5[49] = lTable[d10[13]] + lTable[8'h0b];LT5[53] = lTable[d10[13]] + lTable[8'h0e]; LT5[57] = lTable[d10[13]] + lTable[8'h09];LT5[61] = lTable[d10[13]] + lTable[8'h0d];end 
		/* For b27 & b28 */
		if(d10[14] == 0)begin LT5[50] = 0;LT5[54] = 0; LT5[58] = 0;LT5[62] = 0;end 
		else begin LT5[50] = lTable[d10[14]] + lTable[8'h0d];LT5[54] = lTable[d10[14]] + lTable[8'h0b]; LT5[58] = lTable[d10[14]] + lTable[8'h0e];LT5[62] = lTable[d10[14]] + lTable[8'h09];end 
		/* For b29 & b31 */
		if(d10[15] == 0)begin LT5[51] = 0;LT5[55] = 0; LT5[59] = 0;LT5[63] = 0;end 
		else begin LT5[51] = lTable[d10[15]] + lTable[8'h09];LT5[55] = lTable[d10[15]] + lTable[8'h0d]; LT5[59] = lTable[d10[15]] + lTable[8'h0b];LT5[63] = lTable[d10[15]] + lTable[8'h0e];end 

        next_state = 43;
    end
    43:begin
		if(LT5[0] > 255)begin l5[0] = LT5[0] - 255;end
		else begin l5[0] = LT5[0];end
		if(LT5[1] > 255)begin l5[1] = LT5[1] - 255;end
		else  begin l5[1] = LT5[1];end
		if(LT5[2] > 255)begin l5[2] = LT5[2] - 255;end
		else  begin l5[2] = LT5[2];end
		if(LT5[3] > 255)begin l5[3] = LT5[3] - 255;end
		else  begin l5[3] = LT5[3];end
		if(LT5[4] > 255)begin l5[4] = LT5[4] - 255;end
		else  begin l5[4] = LT5[4];end
		if(LT5[5] > 255)begin l5[5] = LT5[5] - 255;end
		else  begin l5[5] = LT5[5];end
		if(LT5[6] > 255)begin l5[6] = LT5[6] - 255;end
		else  begin l5[6] = LT5[6];end
		if(LT5[7] > 255)begin l5[7] = LT5[7] - 255;end
		else  begin l5[7] = LT5[7];end
		if(LT5[8] > 255)begin l5[8] = LT5[8] - 255;end
		else  begin l5[8] = LT5[8];end
		if(LT5[9] > 255)begin l5[9] = LT5[9] - 255;end
		else  begin l5[9] = LT5[9];end
		if(LT5[10] > 255)begin l5[10] = LT5[10] - 255;end
		else  begin l5[10] = LT5[10];end
		if(LT5[11] > 255)begin l5[11] = LT5[11] - 255;end
		else  begin l5[11] = LT5[11];end
		if(LT5[12] > 255)begin l5[12] = LT5[12] - 255;end
		else  begin l5[12] = LT5[12];end
		if(LT5[13] > 255)begin l5[13] = LT5[13] - 255;end
		else  begin l5[13] = LT5[13];end
		if(LT5[14] > 255)begin l5[14] = LT5[14] - 255;end
		else  begin l5[14] = LT5[14];end
		if(LT5[15] > 255)begin l5[15] = LT5[15] - 255;end
		else  begin l5[15] = LT5[15];end
		if(LT5[16] > 255)begin l5[16] = LT5[16] - 255;end
		else  begin l5[16] = LT5[16];end
		if(LT5[17] > 255)begin l5[17] = LT5[17] - 255;end
		else  begin l5[17] = LT5[17];end
		if(LT5[18] > 255)begin l5[18] = LT5[18] - 255;end
		else  begin l5[18] = LT5[18];end
		if(LT5[19] > 255)begin l5[19] = LT5[19] - 255;end
		else  begin l5[19] = LT5[19];end
		if(LT5[20] > 255)begin l5[20] = LT5[20] - 255;end
		else  begin l5[20] = LT5[20];end
		if(LT5[21] > 255)begin l5[21] = LT5[21] - 255;end
		else  begin l5[21] = LT5[21];end
		if(LT5[22] > 255)begin l5[22] = LT5[22] - 255;end
		else  begin l5[22] = LT5[22];end
		if(LT5[23] > 255)begin l5[23] = LT5[23] - 255;end
		else  begin l5[23] = LT5[23];end
		if(LT5[24] > 255)begin l5[24] = LT5[24] - 255;end
		else  begin l5[24] = LT5[24];end
		if(LT5[25] > 255)begin l5[25] = LT5[25] - 255;end
		else  begin l5[25] = LT5[25];end
		if(LT5[26] > 255)begin l5[26] = LT5[26] - 255;end
		else  begin l5[26] = LT5[26];end
		if(LT5[27] > 255)begin l5[27] = LT5[27] - 255;end
		else  begin l5[27] = LT5[27];end
		if(LT5[28] > 255)begin l5[28] = LT5[28] - 255;end
		else  begin l5[28] = LT5[28];end
		if(LT5[29] > 255)begin l5[29] = LT5[29] - 255;end
		else  begin l5[29] = LT5[29];end
		if(LT5[30] > 255)begin l5[30] = LT5[30] - 255;end
		else  begin l5[30] = LT5[30];end
		if(LT5[31] > 255)begin l5[31] = LT5[31] - 255;end
		else  begin l5[31] = LT5[31];end
		if(LT5[32] > 255)begin l5[32] = LT5[32] - 255;end
		else  begin l5[32] = LT5[32];end
		if(LT5[33] > 255)begin l5[33] = LT5[33] - 255;end
		else  begin l5[33] = LT5[33];end
		if(LT5[34] > 255)begin l5[34] = LT5[34] - 255;end
		else  begin l5[34] = LT5[34];end
		if(LT5[35] > 255)begin l5[35] = LT5[35] - 255;end
		else  begin l5[35] = LT5[35];end
		if(LT5[36] > 255)begin l5[36] = LT5[36] - 255;end
		else  begin l5[36] = LT5[36];end
		if(LT5[37] > 255)begin l5[37] = LT5[37] - 255;end
		else  begin l5[37] = LT5[37];end
		if(LT5[38] > 255)begin l5[38] = LT5[38] - 255;end
		else  begin l5[38] = LT5[38];end
		if(LT5[39] > 255)begin l5[39] = LT5[39] - 255;end
		else  begin l5[39] = LT5[39];end
		if(LT5[40] > 255)begin l5[40] = LT5[40] - 255;end
		else  begin l5[40] = LT5[40];end
		if(LT5[41] > 255)begin l5[41] = LT5[41] - 255;end
		else  begin l5[41] = LT5[41];end
		if(LT5[42] > 255)begin l5[42] = LT5[42] - 255;end
		else  begin l5[42] = LT5[42];end
		if(LT5[43] > 255)begin l5[43] = LT5[43] - 255;end
		else  begin l5[43] = LT5[43];end
		if(LT5[44] > 255)begin l5[44] = LT5[44] - 255;end
		else  begin l5[44] = LT5[44];end
		if(LT5[45] > 255)begin l5[45] = LT5[45] - 255;end
		else  begin l5[45] = LT5[45];end
		if(LT5[46] > 255)begin l5[46] = LT5[46] - 255;end
		else  begin l5[46] = LT5[46];end
		if(LT5[47] > 255)begin l5[47] = LT5[47] - 255;end
		else  begin l5[47] = LT5[47];end
		if(LT5[48] > 255)begin l5[48] = LT5[48] - 255;end
		else  begin l5[48] = LT5[48];end
		if(LT5[49] > 255)begin l5[49] = LT5[49] - 255;end
		else  begin l5[49] = LT5[49];end
		if(LT5[50] > 255)begin l5[50] = LT5[50] - 255;end
		else  begin l5[50] = LT5[50];end
		if(LT5[51] > 255)begin l5[51] = LT5[51] - 255;end
		else  begin l5[51] = LT5[51];end
		if(LT5[52] > 255)begin l5[52] = LT5[52] - 255;end
		else  begin l5[52] = LT5[52];end
		if(LT5[53] > 255)begin l5[53] = LT5[53] - 255;end
		else  begin l5[53] = LT5[53];end
		if(LT5[54] > 255)begin l5[54] = LT5[54] - 255;end
		else  begin l5[54] = LT5[54];end
		if(LT5[55] > 255)begin l5[55] = LT5[55] - 255;end
		else  begin l5[55] = LT5[55];end
		if(LT5[56] > 255)begin l5[56] = LT5[56] - 255;end
		else  begin l5[56] = LT5[56];end
		if(LT5[57] > 255)begin l5[57] = LT5[57] - 255;end
		else  begin l5[57] = LT5[57];end
		if(LT5[58] > 255)begin l5[58] = LT5[58] - 255;end
		else  begin l5[58] = LT5[58];end
		if(LT5[59] > 255)begin l5[59] = LT5[59] - 255;end
		else  begin l5[59] = LT5[59];end
		if(LT5[60] > 255)begin l5[60] = LT5[60] - 255;end
		else  begin l5[60] = LT5[60];end
		if(LT5[61] > 255)begin l5[61] = LT5[61] - 255;end
		else  begin l5[61] = LT5[61];end
		if(LT5[62] > 255)begin l5[62] = LT5[62] - 255;end
		else  begin l5[62] = LT5[62];end
		if(LT5[63] > 255)begin l5[63] = LT5[63] - 255;end
		else  begin l5[63] = LT5[63];end		
		next_state = 44;
	end
	44:begin
		/* for d0 */
		if(l5[0] == 0)begin ET5[0] = 0;end
		else begin ET5[0] = eTable[l5[0]];end
		if(l5[1] == 0)begin ET5[1] = 0;end
		else begin ET5[1] = eTable[l5[1]];end
		/* for d10 */
		if(l5[2] == 0)begin ET5[2] = 0;end
		else begin ET5[2] = eTable[l5[2]];end
		if(l5[3] == 0)begin ET5[3] = 0;end
		else begin ET5[3] = eTable[l5[3]];end
		/* for d10 */
		if(l5[4] == 0)begin ET5[4] = 0;end
		else begin ET5[4] = eTable[l5[4]];end
		if(l5[5] == 0)begin ET5[5] = 0;end
		else begin ET5[5] = eTable[l5[5]];end
		/* for d3 */
		if(l5[6] == 0)begin ET5[6] = 0;end
		else begin ET5[6] = eTable[l5[6]];end
		if(l5[7] == 0)begin ET5[7] = 0;end
		else begin ET5[7] = eTable[l5[7]];end
		/* for d10 */
		if(l5[8] == 0)begin ET5[8] = 0;end
		else begin ET5[8] = eTable[l5[8]];end
		if(l5[9] == 0)begin ET5[9] = 0;end
		else begin ET5[9] = eTable[l5[9]];end
		/* for d10 */
		if(l5[10] == 0)begin ET5[10] = 0;end
		else begin ET5[10] = eTable[l5[10]];end
		if(l5[11] == 0)begin ET5[11] = 0;end
		else begin ET5[11] = eTable[l5[11]];end
		/* for d10 */
		if(l5[12] == 0)begin ET5[12] = 0;end
		else begin ET5[12] = eTable[l5[12]];end
		if(l5[13] == 0)begin ET5[13] = 0;end
		else begin ET5[13] = eTable[l5[13]];end
		/* for d7 */
		if(l5[14] == 0)begin ET5[14] = 0;end
		else begin ET5[14] = eTable[l5[14]];end
		if(l5[15] == 0)begin ET5[15] = 0;end
		else begin ET5[15] = eTable[l5[15]];end
		/* for d10 */
		if(l5[16] == 0)begin ET5[16] = 0;end
		else begin ET5[16] = eTable[l5[16]];end
		if(l5[17] == 0)begin ET5[17] = 0;end
		else begin ET5[17] = eTable[l5[17]];end
		/* for d11 */
		if(l5[18] == 0)begin ET5[18] = 0;end
		else begin ET5[18] = eTable[l5[18]];end
		if(l5[19] == 0)begin ET5[19] = 0;end
		else begin ET5[19] = eTable[l5[19]];end
		/* for d10 */
		if(l5[20] == 0)begin ET5[20] = 0;end
		else begin ET5[20] = eTable[l5[20]];end
		if(l5[21] == 0)begin ET5[21] = 0;end
		else begin ET5[21] = eTable[l5[21]];end
		/* for d11 */
		if(l5[22] == 0)begin ET5[22] = 0;end
		else begin ET5[22] = eTable[l5[22]];end
		if(l5[23] == 0)begin ET5[23] = 0;end
		else begin ET5[23] = eTable[l5[23]];end
		/* for d12 */
		if(l5[24] == 0)begin ET5[24] = 0;end
		else begin ET5[24] = eTable[l5[24]];end
		if(l5[25] == 0)begin ET5[25] = 0;end
		else begin ET5[25] = eTable[l5[25]];end
		/* for d13 */
		if(l5[26] == 0)begin ET5[26] = 0;end
		else begin ET5[26] = eTable[l5[26]];end
		if(l5[27] == 0)begin ET5[27] = 0;end
		else begin ET5[27] = eTable[l5[27]];end
		/* for d14 */
		if(l5[28] == 0)begin ET5[28] = 0;end
		else begin ET5[28] = eTable[l5[28]];end
		if(l5[29] == 0)begin ET5[29] = 0;end
		else begin ET5[29] = eTable[l5[29]];end
		/* for d15 */
		if(l5[30] == 0)begin ET5[30] = 0;end
		else begin ET5[30] = eTable[l5[30]];end
		if(l5[31] == 0)begin ET5[31] = 0;end
		else begin ET5[31] = eTable[l5[31]];end
		if(l5[32] == 0)begin ET5[32] = 0;end
		else begin ET5[32] = eTable[l5[32]];end
		if(l5[33] == 0)begin ET5[33] = 0;end
		else begin ET5[33] = eTable[l5[33]];end
		if(l5[34] == 0)begin ET5[34] = 0;end
		else begin ET5[34] = eTable[l5[34]];end
		if(l5[35] == 0)begin ET5[35] = 0;end
		else begin ET5[35] = eTable[l5[35]];end
		if(l5[36] == 0)begin ET5[36] = 0;end
		else begin ET5[36] = eTable[l5[36]];end
		if(l5[37] == 0)begin ET5[37] = 0;end
		else begin ET5[37] = eTable[l5[37]];end
		if(l5[38] == 0)begin ET5[38] = 0;end
		else begin ET5[38] = eTable[l5[38]];end
		if(l5[39] == 0)begin ET5[39] = 0;end
		else begin ET5[39] = eTable[l5[39]];end
		if(l5[40] == 0)begin ET5[40] = 0;end
		else begin ET5[40] = eTable[l5[40]];end
		if(l5[41] == 0)begin ET5[41] = 0;end
		else begin ET5[41] = eTable[l5[41]];end
		if(l5[42] == 0)begin ET5[42] = 0;end
		else begin ET5[42] = eTable[l5[42]];end
		if(l5[43] == 0)begin ET5[43] = 0;end
		else begin ET5[43] = eTable[l5[43]];end
		if(l5[44] == 0)begin ET5[44] = 0;end
		else begin ET5[44] = eTable[l5[44]];end
		if(l5[45] == 0)begin ET5[45] = 0;end
		else begin ET5[45] = eTable[l5[45]];end
		if(l5[46] == 0)begin ET5[46] = 0;end
		else begin ET5[46] = eTable[l5[46]];end
		if(l5[47] == 0)begin ET5[47] = 0;end
		else begin ET5[47] = eTable[l5[47]];end
		if(l5[48] == 0)begin ET5[48] = 0;end
		else begin ET5[48] = eTable[l5[48]];end
		if(l5[49] == 0)begin ET5[49] = 0;end
		else begin ET5[49] = eTable[l5[49]];end
		if(l5[50] == 0)begin ET5[50] = 0;end
		else begin ET5[50] = eTable[l5[50]];end		
		if(l5[51] == 0)begin ET5[51] = 0;end
		else begin ET5[51] = eTable[l5[51]];end
		if(l5[52] == 0)begin ET5[52] = 0;end
		else begin ET5[52] = eTable[l5[52]];end
		if(l5[53] == 0)begin ET5[53] = 0;end
		else begin ET5[53] = eTable[l5[53]];end
		if(l5[54] == 0)begin ET5[54] = 0;end
		else begin ET5[54] = eTable[l5[54]];end
		if(l5[55] == 0)begin ET5[55] = 0;end
		else begin ET5[55] = eTable[l5[55]];end
		if(l5[56] == 0)begin ET5[56] = 0;end
		else begin ET5[56] = eTable[l5[56]];end
		if(l5[57] == 0)begin ET5[57] = 0;end
		else begin ET5[57] = eTable[l5[57]];end
		if(l5[58] == 0)begin ET5[58] = 0;end
		else begin ET5[58] = eTable[l5[58]];end
		if(l5[59] == 0)begin ET5[59] = 0;end
		else begin ET5[59] = eTable[l5[59]];end
		if(l5[60] == 0)begin ET5[60] = 0;end
		else begin ET5[60] = eTable[l5[60]];end	
		if(l5[61] == 0)begin ET5[61] = 0;end
		else begin ET5[61] = eTable[l5[61]];end
		if(l5[62] == 0)begin ET5[62] = 0;end
		else begin ET5[62] = eTable[l5[62]];end
		if(l5[63] == 0)begin ET5[63] = 0;end
		else begin ET5[63] = eTable[l5[63]];end
		next_state = 45;
	end
    45:begin
        d11[0] = ET5[0]^ET5[1]^ET5[2]^ET5[3];
        d11[1] = ET5[4]^ET5[5]^ET5[6]^ET5[7];
        d11[2] = ET5[8]^ET5[9]^ET5[10]^ET5[11];
        d11[3] = ET5[12]^ET5[13]^ET5[14]^ET5[15];
        d11[4] = ET5[16]^ET5[17]^ET5[18]^ET5[19];
        d11[5] = ET5[20]^ET5[21]^ET5[22]^ET5[23];
        d11[6] = ET5[24]^ET5[25]^ET5[26]^ET5[27];
        d11[7] = ET5[28]^ET5[29]^ET5[30]^ET5[31];
        d11[8] = ET5[32]^ET5[33]^ET5[34]^ET5[35];
        d11[9] = ET5[36]^ET5[37]^ET5[38]^ET5[39];
        d11[10] = ET5[40]^ET5[41]^ET5[42]^ET5[43];
        d11[11] = ET5[44]^ET5[45]^ET5[46]^ET5[47];
        d11[12] = ET5[48]^ET5[49]^ET5[50]^ET5[51];
        d11[13] = ET5[52]^ET5[53]^ET5[54]^ET5[55];
        d11[14] = ET5[56]^ET5[57]^ET5[58]^ET5[59];
        d11[15] =ET5[60]^ET5[61]^ET5[62]^ET5[63]; 
        next_state = 46;
    end
	46:begin
        tempRow6[0] = d11[0];tempRow6[4] = d11[4];tempRow6[8] = d11[8];tempRow6[12] = d11[12];
        tempRow6[1] = d11[13];tempRow6[5] = d11[1];tempRow6[9] = d11[5];tempRow6[13] = d11[9];
        tempRow6[2] = d11[10];tempRow6[6] = d11[14];tempRow6[10] = d11[2];tempRow6[14] = d11[6];
        tempRow6[3] = d11[7];tempRow6[7] = d11[11];tempRow6[11] = d11[15];tempRow6[15] = d11[3];
        next_state = 47;
	end
	47:begin
        tempSbox6[0] = inv_sbox[tempRow6[0]];tempSbox6[1] = inv_sbox[tempRow6[1]];tempSbox6[2] = inv_sbox[tempRow6[2]];tempSbox6[3] = inv_sbox[tempRow6[3]];
        tempSbox6[4] = inv_sbox[tempRow6[4]];tempSbox6[5] = inv_sbox[tempRow6[5]];tempSbox6[6] = inv_sbox[tempRow6[6]];tempSbox6[7] = inv_sbox[tempRow6[7]];
        tempSbox6[8] = inv_sbox[tempRow6[8]];tempSbox6[9] = inv_sbox[tempRow6[9]];tempSbox6[10] = inv_sbox[tempRow6[10]];tempSbox6[11] = inv_sbox[tempRow6[11]];
        tempSbox6[12] = inv_sbox[tempRow6[12]];tempSbox6[13] = inv_sbox[tempRow6[13]];tempSbox6[14] = inv_sbox[tempRow6[14]];tempSbox6[15] = inv_sbox[tempRow6[15]];
		next_state = 48;
	end
	48:begin
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
		next_state = 49;
	end
	49:begin 
	    /* For b0 & b4*/
		if(d12[0] == 0)begin LT6[0] = 0; LT6[4] = 0; LT6[8] = 0; LT6[12] = 0 ;end
		else begin LT6[0] = lTable[d12[0]] + lTable[8'h0e];LT6[4] = lTable[d12[0]] + lTable[8'h09];LT6[8] =  lTable[d12[0]] + lTable[8'h0d];LT6[12] = lTable[d12[0]] + lTable[8'h0b];end
	    /* For b1 & b2*/
		if(d12[1] == 0)begin LT6[1] = 0;LT6[5] = 0;LT6[9] =0; LT6[13] = 0;end
		else begin LT6[1] = lTable[d12[1]] + lTable[8'h0b];LT6[5] = lTable[d12[1]] + lTable[8'h0e];LT6[9] = lTable[d12[1]] + lTable[8'h09]; LT6[13] = lTable[d12[1]] + lTable[8'h0d];end
	    /* For b3 & b4*/
		if(d12[2] == 0)begin LT6[2] = 0;LT6[6] = 0;LT6[10] = 0;LT6[14] = 0;end
		else begin LT6[2] = lTable[d12[2]] + lTable[8'h0d];LT6[6] = lTable[d12[2]] + lTable[8'h0b];LT6[10] = lTable[d12[2]] + lTable[8'h0e];LT6[14] = lTable[d12[2]] + lTable[8'h09];end
	    /* For b5 & b7*/			
		if(d12[3] == 0)begin LT6[3] = 0;LT6[7] = 0;LT6[11] = 0;LT6[15] = 0;end 
		else begin  LT6[3] = lTable[d12[3]] + lTable[8'h09];LT6[7] = lTable[d12[3]] + lTable[8'h0d];LT6[11] = lTable[d12[3]] + lTable[8'h0b];LT6[15] = lTable[d12[3]] + lTable[8'h0e];end
	    /* For b8 & b14 */				
		if(d12[4] == 0)begin LT6[16] = 0; LT6[20] = 0; LT6[24] = 0; LT6[28] = 0;end
		else begin LT6[16] = lTable[d12[4]] + lTable[8'h0e]; LT6[20] = lTable[d12[4]] + lTable[8'h09]; LT6[24] = lTable[d12[4]] + lTable[8'h0d]; LT6[28] = lTable[d12[4]] + lTable[8'h0b];end
		/* For b9 & b10 */
		if(d12[5] == 0)begin LT6[17] = 0;LT6[21] = 0; LT6[25] = 0;LT6[29] = 0;end
		else begin LT6[17] = lTable[d12[5]] + lTable[8'h0b];LT6[21] = lTable[d12[5]] + lTable[8'h0e]; LT6[25] = lTable[d12[5]] + lTable[8'h09];LT6[29] = lTable[d12[5]] + lTable[8'h0d];end
		/* For b11 & b12*/
		if(d12[6] == 0)begin LT6[18] = 0;LT6[22] = 0; LT6[26] = 0;LT6[30] = 0;end
		else begin LT6[18] = lTable[d12[6]] + lTable[8'h0d];LT6[22] = lTable[d12[6]] + lTable[8'h0b]; LT6[26] = lTable[d12[6]] + lTable[8'h0e];LT6[30] = lTable[d12[6]] + lTable[8'h09];end
		/* For b13 & b15 */
		if(d12[7] == 0)begin LT6[19] = 0;LT6[23] = 0; LT6[27] = 0;LT6[31] = 0;end
		else begin LT6[19] = lTable[d12[7]] + lTable[8'h09];LT6[23] = lTable[d12[7]] + lTable[8'h0d]; LT6[27] = lTable[d12[7]] + lTable[8'h0b];LT6[31] = lTable[d12[7]] + lTable[8'h0e];end
		/* For b16 & b22 */
		if(d12[8] == 0)begin LT6[32] = 0;LT6[36] = 0; LT6[40] = 0;LT6[44] = 0;end
		else begin LT6[32] = lTable[d12[8]] + lTable[8'h0e];LT6[36] = lTable[d12[8]] + lTable[8'h09];LT6[40] = lTable[d12[8]] + lTable[8'h0d];LT6[44] = lTable[d12[8]] + lTable[8'h0b];end
		/* For b17 & 18 */
		if(d12[9] == 0)begin LT6[33] = 0;LT6[37] = 0; LT6[41] = 0;LT6[45] = 0;end
		else begin LT6[33] = lTable[d12[9]] + lTable[8'h0b];LT6[37] = lTable[d12[9]] + lTable[8'h0e]; LT6[41] = lTable[d12[9]] + lTable[8'h09];LT6[45] = lTable[d12[9]] + lTable[8'h0d];end
		/* For b19 & b20 */
		if(d12[10] == 0)begin LT6[34] = 0;LT6[38] = 0;LT6[42] = 0;LT6[46] = 0;end
		else begin LT6[34] = lTable[d12[10]] + lTable[8'h0d];LT6[38] = lTable[d12[10]] + lTable[8'h0b];LT6[42] = lTable[d12[10]] + lTable[8'h0e];LT6[46] = lTable[d12[10]] + lTable[8'h09];end
		/* For b21 & b23 */
		if(d12[11] == 0)begin LT6[35] = 0; LT6[39] =0;LT6[43] = 0; LT6[47] =0;end
		else begin  LT6[35] = lTable[d12[11]] + lTable[8'h09]; LT6[39] =lTable[d12[11]] + lTable[8'h0d];LT6[43] = lTable[d12[11]] + lTable[8'h0b]; LT6[47] =lTable[d12[11]] + lTable[8'h0e];end	
		/* For b24 & b30 */
		if(d12[12] == 0)begin LT6[48] = 0;LT6[52] = 0; LT6[56] = 0;LT6[60] = 0;end 
		else begin LT6[48] = lTable[d12[12]] + lTable[8'h0e];LT6[52] = lTable[d12[12]] + lTable[8'h09]; LT6[56] = lTable[d12[12]] + lTable[8'h0d];LT6[60] = lTable[d12[12]] + lTable[8'h0b];end 		
		/* For b25 & b26 */		
		if(d12[13] == 0)begin LT6[49] = 0;LT6[53] = 0; LT6[57] = 0;LT6[61] = 0;end 
		else begin  LT6[49] = lTable[d12[13]] + lTable[8'h0b];LT6[53] = lTable[d12[13]] + lTable[8'h0e]; LT6[57] = lTable[d12[13]] + lTable[8'h09];LT6[61] = lTable[d12[13]] + lTable[8'h0d];end 
		/* For b27 & b28 */
		if(d12[14] == 0)begin LT6[50] = 0;LT6[54] = 0; LT6[58] = 0;LT6[62] = 0;end 
		else begin LT6[50] = lTable[d12[14]] + lTable[8'h0d];LT6[54] = lTable[d12[14]] + lTable[8'h0b]; LT6[58] = lTable[d12[14]] + lTable[8'h0e];LT6[62] = lTable[d12[14]] + lTable[8'h09];end 
		/* For b29 & b31 */
		if(d12[15] == 0)begin LT6[51] = 0;LT6[55] = 0; LT6[59] = 0;LT6[63] = 0;end 
		else begin LT6[51] = lTable[d12[15]] + lTable[8'h09];LT6[55] = lTable[d12[15]] + lTable[8'h0d]; LT6[59] = lTable[d12[15]] + lTable[8'h0b];LT6[63] = lTable[d12[15]] + lTable[8'h0e];end 

        next_state = 50;
    end
    50:begin
		if(LT6[0] > 255)begin l6[0] = LT6[0] - 255;end
		else begin l6[0] = LT6[0];end
		if(LT6[1] > 255)begin l6[1] = LT6[1] - 255;end
		else  begin l6[1] = LT6[1];end
		if(LT6[2] > 255)begin l6[2] = LT6[2] - 255;end
		else  begin l6[2] = LT6[2];end
		if(LT6[3] > 255)begin l6[3] = LT6[3] - 255;end
		else  begin l6[3] = LT6[3];end
		if(LT6[4] > 255)begin l6[4] = LT6[4] - 255;end
		else  begin l6[4] = LT6[4];end
		if(LT6[5] > 255)begin l6[5] = LT6[5] - 255;end
		else  begin l6[5] = LT6[5];end
		if(LT6[6] > 255)begin l6[6] = LT6[6] - 255;end
		else  begin l6[6] = LT6[6];end
		if(LT6[7] > 255)begin l6[7] = LT6[7] - 255;end
		else  begin l6[7] = LT6[7];end
		if(LT6[8] > 255)begin l6[8] = LT6[8] - 255;end
		else  begin l6[8] = LT6[8];end
		if(LT6[9] > 255)begin l6[9] = LT6[9] - 255;end
		else  begin l6[9] = LT6[9];end
		if(LT6[10] > 255)begin l6[10] = LT6[10] - 255;end
		else  begin l6[10] = LT6[10];end
		if(LT6[11] > 255)begin l6[11] = LT6[11] - 255;end
		else  begin l6[11] = LT6[11];end
		if(LT6[12] > 255)begin l6[12] = LT6[12] - 255;end
		else  begin l6[12] = LT6[12];end
		if(LT6[13] > 255)begin l6[13] = LT6[13] - 255;end
		else  begin l6[13] = LT6[13];end
		if(LT6[14] > 255)begin l6[14] = LT6[14] - 255;end
		else  begin l6[14] = LT6[14];end
		if(LT6[15] > 255)begin l6[15] = LT6[15] - 255;end
		else  begin l6[15] = LT6[15];end
		if(LT6[16] > 255)begin l6[16] = LT6[16] - 255;end
		else  begin l6[16] = LT6[16];end
		if(LT6[17] > 255)begin l6[17] = LT6[17] - 255;end
		else  begin l6[17] = LT6[17];end
		if(LT6[18] > 255)begin l6[18] = LT6[18] - 255;end
		else  begin l6[18] = LT6[18];end
		if(LT6[19] > 255)begin l6[19] = LT6[19] - 255;end
		else  begin l6[19] = LT6[19];end
		if(LT6[20] > 255)begin l6[20] = LT6[20] - 255;end
		else  begin l6[20] = LT6[20];end
		if(LT6[21] > 255)begin l6[21] = LT6[21] - 255;end
		else  begin l6[21] = LT6[21];end
		if(LT6[22] > 255)begin l6[22] = LT6[22] - 255;end
		else  begin l6[22] = LT6[22];end
		if(LT6[23] > 255)begin l6[23] = LT6[23] - 255;end
		else  begin l6[23] = LT6[23];end
		if(LT6[24] > 255)begin l6[24] = LT6[24] - 255;end
		else  begin l6[24] = LT6[24];end
		if(LT6[25] > 255)begin l6[25] = LT6[25] - 255;end
		else  begin l6[25] = LT6[25];end
		if(LT6[26] > 255)begin l6[26] = LT6[26] - 255;end
		else  begin l6[26] = LT6[26];end
		if(LT6[27] > 255)begin l6[27] = LT6[27] - 255;end
		else  begin l6[27] = LT6[27];end
		if(LT6[28] > 255)begin l6[28] = LT6[28] - 255;end
		else  begin l6[28] = LT6[28];end
		if(LT6[29] > 255)begin l6[29] = LT6[29] - 255;end
		else  begin l6[29] = LT6[29];end
		if(LT6[30] > 255)begin l6[30] = LT6[30] - 255;end
		else  begin l6[30] = LT6[30];end
		if(LT6[31] > 255)begin l6[31] = LT6[31] - 255;end
		else  begin l6[31] = LT6[31];end
		if(LT6[32] > 255)begin l6[32] = LT6[32] - 255;end
		else  begin l6[32] = LT6[32];end
		if(LT6[33] > 255)begin l6[33] = LT6[33] - 255;end
		else  begin l6[33] = LT6[33];end
		if(LT6[34] > 255)begin l6[34] = LT6[34] - 255;end
		else  begin l6[34] = LT6[34];end
		if(LT6[35] > 255)begin l6[35] = LT6[35] - 255;end
		else  begin l6[35] = LT6[35];end
		if(LT6[36] > 255)begin l6[36] = LT6[36] - 255;end
		else  begin l6[36] = LT6[36];end
		if(LT6[37] > 255)begin l6[37] = LT6[37] - 255;end
		else  begin l6[37] = LT6[37];end
		if(LT6[38] > 255)begin l6[38] = LT6[38] - 255;end
		else  begin l6[38] = LT6[38];end
		if(LT6[39] > 255)begin l6[39] = LT6[39] - 255;end
		else  begin l6[39] = LT6[39];end
		if(LT6[40] > 255)begin l6[40] = LT6[40] - 255;end
		else  begin l6[40] = LT6[40];end
		if(LT6[41] > 255)begin l6[41] = LT6[41] - 255;end
		else  begin l6[41] = LT6[41];end
		if(LT6[42] > 255)begin l6[42] = LT6[42] - 255;end
		else  begin l6[42] = LT6[42];end
		if(LT6[43] > 255)begin l6[43] = LT6[43] - 255;end
		else  begin l6[43] = LT6[43];end
		if(LT6[44] > 255)begin l6[44] = LT6[44] - 255;end
		else  begin l6[44] = LT6[44];end
		if(LT6[45] > 255)begin l6[45] = LT6[45] - 255;end
		else  begin l6[45] = LT6[45];end
		if(LT6[46] > 255)begin l6[46] = LT6[46] - 255;end
		else  begin l6[46] = LT6[46];end
		if(LT6[47] > 255)begin l6[47] = LT6[47] - 255;end
		else  begin l6[47] = LT6[47];end
		if(LT6[48] > 255)begin l6[48] = LT6[48] - 255;end
		else  begin l6[48] = LT6[48];end
		if(LT6[49] > 255)begin l6[49] = LT6[49] - 255;end
		else  begin l6[49] = LT6[49];end
		if(LT6[50] > 255)begin l6[50] = LT6[50] - 255;end
		else  begin l6[50] = LT6[50];end
		if(LT6[51] > 255)begin l6[51] = LT6[51] - 255;end
		else  begin l6[51] = LT6[51];end
		if(LT6[52] > 255)begin l6[52] = LT6[52] - 255;end
		else  begin l6[52] = LT6[52];end
		if(LT6[53] > 255)begin l6[53] = LT6[53] - 255;end
		else  begin l6[53] = LT6[53];end
		if(LT6[54] > 255)begin l6[54] = LT6[54] - 255;end
		else  begin l6[54] = LT6[54];end
		if(LT6[55] > 255)begin l6[55] = LT6[55] - 255;end
		else  begin l6[55] = LT6[55];end
		if(LT6[56] > 255)begin l6[56] = LT6[56] - 255;end
		else  begin l6[56] = LT6[56];end
		if(LT6[57] > 255)begin l6[57] = LT6[57] - 255;end
		else  begin l6[57] = LT6[57];end
		if(LT6[58] > 255)begin l6[58] = LT6[58] - 255;end
		else  begin l6[58] = LT6[58];end
		if(LT6[59] > 255)begin l6[59] = LT6[59] - 255;end
		else  begin l6[59] = LT6[59];end
		if(LT6[60] > 255)begin l6[60] = LT6[60] - 255;end
		else  begin l6[60] = LT6[60];end
		if(LT6[61] > 255)begin l6[61] = LT6[61] - 255;end
		else  begin l6[61] = LT6[61];end
		if(LT6[62] > 255)begin l6[62] = LT6[62] - 255;end
		else  begin l6[62] = LT6[62];end
		if(LT6[63] > 255)begin l6[63] = LT6[63] - 255;end
		else  begin l6[63] = LT6[63];end		
		next_state = 51;
	end
	51:begin
		/* for d0 */
		if(l6[0] == 0)begin ET6[0] = 0;end
		else begin ET6[0] = eTable[l6[0]];end
		if(l6[1] == 0)begin ET6[1] = 0;end
		else begin ET6[1] = eTable[l6[1]];end
		/* for d12 */
		if(l6[2] == 0)begin ET6[2] = 0;end
		else begin ET6[2] = eTable[l6[2]];end
		if(l6[3] == 0)begin ET6[3] = 0;end
		else begin ET6[3] = eTable[l6[3]];end
		/* for d12 */
		if(l6[4] == 0)begin ET6[4] = 0;end
		else begin ET6[4] = eTable[l6[4]];end
		if(l6[5] == 0)begin ET6[5] = 0;end
		else begin ET6[5] = eTable[l6[5]];end
		/* for d3 */
		if(l6[6] == 0)begin ET6[6] = 0;end
		else begin ET6[6] = eTable[l6[6]];end
		if(l6[7] == 0)begin ET6[7] = 0;end
		else begin ET6[7] = eTable[l6[7]];end
		/* for d12 */
		if(l6[8] == 0)begin ET6[8] = 0;end
		else begin ET6[8] = eTable[l6[8]];end
		if(l6[9] == 0)begin ET6[9] = 0;end
		else begin ET6[9] = eTable[l6[9]];end
		/* for d12 */
		if(l6[10] == 0)begin ET6[10] = 0;end
		else begin ET6[10] = eTable[l6[10]];end
		if(l6[11] == 0)begin ET6[11] = 0;end
		else begin ET6[11] = eTable[l6[11]];end
		/* for d12 */
		if(l6[12] == 0)begin ET6[12] = 0;end
		else begin ET6[12] = eTable[l6[12]];end
		if(l6[13] == 0)begin ET6[13] = 0;end
		else begin ET6[13] = eTable[l6[13]];end
		/* for d7 */
		if(l6[14] == 0)begin ET6[14] = 0;end
		else begin ET6[14] = eTable[l6[14]];end
		if(l6[15] == 0)begin ET6[15] = 0;end
		else begin ET6[15] = eTable[l6[15]];end
		/* for d12 */
		if(l6[16] == 0)begin ET6[16] = 0;end
		else begin ET6[16] = eTable[l6[16]];end
		if(l6[17] == 0)begin ET6[17] = 0;end
		else begin ET6[17] = eTable[l6[17]];end
		/* for d13 */
		if(l6[18] == 0)begin ET6[18] = 0;end
		else begin ET6[18] = eTable[l6[18]];end
		if(l6[19] == 0)begin ET6[19] = 0;end
		else begin ET6[19] = eTable[l6[19]];end
		/* for d12 */
		if(l6[20] == 0)begin ET6[20] = 0;end
		else begin ET6[20] = eTable[l6[20]];end
		if(l6[21] == 0)begin ET6[21] = 0;end
		else begin ET6[21] = eTable[l6[21]];end
		/* for d13 */
		if(l6[22] == 0)begin ET6[22] = 0;end
		else begin ET6[22] = eTable[l6[22]];end
		if(l6[23] == 0)begin ET6[23] = 0;end
		else begin ET6[23] = eTable[l6[23]];end
		/* for d12 */
		if(l6[24] == 0)begin ET6[24] = 0;end
		else begin ET6[24] = eTable[l6[24]];end
		if(l6[25] == 0)begin ET6[25] = 0;end
		else begin ET6[25] = eTable[l6[25]];end
		/* for d13 */
		if(l6[26] == 0)begin ET6[26] = 0;end
		else begin ET6[26] = eTable[l6[26]];end
		if(l6[27] == 0)begin ET6[27] = 0;end
		else begin ET6[27] = eTable[l6[27]];end
		/* for d14 */
		if(l6[28] == 0)begin ET6[28] = 0;end
		else begin ET6[28] = eTable[l6[28]];end
		if(l6[29] == 0)begin ET6[29] = 0;end
		else begin ET6[29] = eTable[l6[29]];end
		/* for d15 */
		if(l6[30] == 0)begin ET6[30] = 0;end
		else begin ET6[30] = eTable[l6[30]];end
		if(l6[31] == 0)begin ET6[31] = 0;end
		else begin ET6[31] = eTable[l6[31]];end
		if(l6[32] == 0)begin ET6[32] = 0;end
		else begin ET6[32] = eTable[l6[32]];end
		if(l6[33] == 0)begin ET6[33] = 0;end
		else begin ET6[33] = eTable[l6[33]];end
		if(l6[34] == 0)begin ET6[34] = 0;end
		else begin ET6[34] = eTable[l6[34]];end
		if(l6[35] == 0)begin ET6[35] = 0;end
		else begin ET6[35] = eTable[l6[35]];end
		if(l6[36] == 0)begin ET6[36] = 0;end
		else begin ET6[36] = eTable[l6[36]];end
		if(l6[37] == 0)begin ET6[37] = 0;end
		else begin ET6[37] = eTable[l6[37]];end
		if(l6[38] == 0)begin ET6[38] = 0;end
		else begin ET6[38] = eTable[l6[38]];end
		if(l6[39] == 0)begin ET6[39] = 0;end
		else begin ET6[39] = eTable[l6[39]];end
		if(l6[40] == 0)begin ET6[40] = 0;end
		else begin ET6[40] = eTable[l6[40]];end
		if(l6[41] == 0)begin ET6[41] = 0;end
		else begin ET6[41] = eTable[l6[41]];end
		if(l6[42] == 0)begin ET6[42] = 0;end
		else begin ET6[42] = eTable[l6[42]];end
		if(l6[43] == 0)begin ET6[43] = 0;end
		else begin ET6[43] = eTable[l6[43]];end
		if(l6[44] == 0)begin ET6[44] = 0;end
		else begin ET6[44] = eTable[l6[44]];end
		if(l6[45] == 0)begin ET6[45] = 0;end
		else begin ET6[45] = eTable[l6[45]];end
		if(l6[46] == 0)begin ET6[46] = 0;end
		else begin ET6[46] = eTable[l6[46]];end
		if(l6[47] == 0)begin ET6[47] = 0;end
		else begin ET6[47] = eTable[l6[47]];end
		if(l6[48] == 0)begin ET6[48] = 0;end
		else begin ET6[48] = eTable[l6[48]];end
		if(l6[49] == 0)begin ET6[49] = 0;end
		else begin ET6[49] = eTable[l6[49]];end
		if(l6[50] == 0)begin ET6[50] = 0;end
		else begin ET6[50] = eTable[l6[50]];end		
		if(l6[51] == 0)begin ET6[51] = 0;end
		else begin ET6[51] = eTable[l6[51]];end
		if(l6[52] == 0)begin ET6[52] = 0;end
		else begin ET6[52] = eTable[l6[52]];end
		if(l6[53] == 0)begin ET6[53] = 0;end
		else begin ET6[53] = eTable[l6[53]];end
		if(l6[54] == 0)begin ET6[54] = 0;end
		else begin ET6[54] = eTable[l6[54]];end
		if(l6[55] == 0)begin ET6[55] = 0;end
		else begin ET6[55] = eTable[l6[55]];end
		if(l6[56] == 0)begin ET6[56] = 0;end
		else begin ET6[56] = eTable[l6[56]];end
		if(l6[57] == 0)begin ET6[57] = 0;end
		else begin ET6[57] = eTable[l6[57]];end
		if(l6[58] == 0)begin ET6[58] = 0;end
		else begin ET6[58] = eTable[l6[58]];end
		if(l6[59] == 0)begin ET6[59] = 0;end
		else begin ET6[59] = eTable[l6[59]];end
		if(l6[60] == 0)begin ET6[60] = 0;end
		else begin ET6[60] = eTable[l6[60]];end	
		if(l6[61] == 0)begin ET6[61] = 0;end
		else begin ET6[61] = eTable[l6[61]];end
		if(l6[62] == 0)begin ET6[62] = 0;end
		else begin ET6[62] = eTable[l6[62]];end
		if(l6[63] == 0)begin ET6[63] = 0;end
		else begin ET6[63] = eTable[l6[63]];end
		next_state = 52;
	end
    52:begin
        d13[0] = ET6[0]^ET6[1]^ET6[2]^ET6[3];
        d13[1] = ET6[4]^ET6[5]^ET6[6]^ET6[7];
        d13[2] = ET6[8]^ET6[9]^ET6[10]^ET6[11];
        d13[3] = ET6[12]^ET6[13]^ET6[14]^ET6[15];
        d13[4] = ET6[16]^ET6[17]^ET6[18]^ET6[19];
        d13[5] = ET6[20]^ET6[21]^ET6[22]^ET6[23];
        d13[6] = ET6[24]^ET6[25]^ET6[26]^ET6[27];
        d13[7] = ET6[28]^ET6[29]^ET6[30]^ET6[31];
        d13[8] = ET6[32]^ET6[33]^ET6[34]^ET6[35];
        d13[9] = ET6[36]^ET6[37]^ET6[38]^ET6[39];
        d13[10] = ET6[40]^ET6[41]^ET6[42]^ET6[43];
        d13[11] = ET6[44]^ET6[45]^ET6[46]^ET6[47];
        d13[12] = ET6[48]^ET6[49]^ET6[50]^ET6[51];
        d13[13] = ET6[52]^ET6[53]^ET6[54]^ET6[55];
        d13[14] = ET6[56]^ET6[57]^ET6[58]^ET6[59];
        d13[15] =ET6[60]^ET6[61]^ET6[62]^ET6[63]; 
        next_state = 53;
    end
	53:begin
        tempRow7[0] = d13[0];tempRow7[4] = d13[4];tempRow7[8] = d13[8];tempRow7[12] = d13[12];
        tempRow7[1] = d13[13];tempRow7[5] = d13[1];tempRow7[9] = d13[5];tempRow7[13] = d13[9];
        tempRow7[2] = d13[10];tempRow7[6] = d13[14];tempRow7[10] = d13[2];tempRow7[14] = d13[6];
        tempRow7[3] = d13[7];tempRow7[7] = d13[11];tempRow7[11] = d13[15];tempRow7[15] = d13[3];
        next_state = 54;
	end
	54:begin
        tempSbox7[0] = inv_sbox[tempRow7[0]];tempSbox7[1] = inv_sbox[tempRow7[1]];tempSbox7[2] = inv_sbox[tempRow7[2]];tempSbox7[3] = inv_sbox[tempRow7[3]];
        tempSbox7[4] = inv_sbox[tempRow7[4]];tempSbox7[5] = inv_sbox[tempRow7[5]];tempSbox7[6] = inv_sbox[tempRow7[6]];tempSbox7[7] = inv_sbox[tempRow7[7]];
        tempSbox7[8] = inv_sbox[tempRow7[8]];tempSbox7[9] = inv_sbox[tempRow7[9]];tempSbox7[10] = inv_sbox[tempRow7[10]];tempSbox7[11] = inv_sbox[tempRow7[11]];
        tempSbox7[12] = inv_sbox[tempRow7[12]];tempSbox7[13] = inv_sbox[tempRow7[13]];tempSbox7[14] = inv_sbox[tempRow7[14]];tempSbox7[15] = inv_sbox[tempRow7[15]];
		next_state = 55;
	end
	55:begin
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
		next_state = 56;
	end
	56:begin 
	    /* For b0 & b4*/
		if(d14[0] == 0)begin LT7[0] = 0; LT7[4] = 0; LT7[8] = 0; LT7[12] = 0 ;end
		else begin LT7[0] = lTable[d14[0]] + lTable[8'h0e];LT7[4] = lTable[d14[0]] + lTable[8'h09];LT7[8] =  lTable[d14[0]] + lTable[8'h0d];LT7[12] = lTable[d14[0]] + lTable[8'h0b];end
	    /* For b1 & b2*/
		if(d14[1] == 0)begin LT7[1] = 0;LT7[5] = 0;LT7[9] =0; LT7[13] = 0;end
		else begin LT7[1] = lTable[d14[1]] + lTable[8'h0b];LT7[5] = lTable[d14[1]] + lTable[8'h0e];LT7[9] = lTable[d14[1]] + lTable[8'h09]; LT7[13] = lTable[d14[1]] + lTable[8'h0d];end
	    /* For b3 & b4*/
		if(d14[2] == 0)begin LT7[2] = 0;LT7[6] = 0;LT7[10] = 0;LT7[14] = 0;end
		else begin LT7[2] = lTable[d14[2]] + lTable[8'h0d];LT7[6] = lTable[d14[2]] + lTable[8'h0b];LT7[10] = lTable[d14[2]] + lTable[8'h0e];LT7[14] = lTable[d14[2]] + lTable[8'h09];end
	    /* For b5 & b7*/			
		if(d14[3] == 0)begin LT7[3] = 0;LT7[7] = 0;LT7[11] = 0;LT7[15] = 0;end 
		else begin  LT7[3] = lTable[d14[3]] + lTable[8'h09];LT7[7] = lTable[d14[3]] + lTable[8'h0d];LT7[11] = lTable[d14[3]] + lTable[8'h0b];LT7[15] = lTable[d14[3]] + lTable[8'h0e];end
	    /* For b8 & b14 */				
		if(d14[4] == 0)begin LT7[16] = 0; LT7[20] = 0; LT7[24] = 0; LT7[28] = 0;end
		else begin LT7[16] = lTable[d14[4]] + lTable[8'h0e]; LT7[20] = lTable[d14[4]] + lTable[8'h09]; LT7[24] = lTable[d14[4]] + lTable[8'h0d]; LT7[28] = lTable[d14[4]] + lTable[8'h0b];end
		/* For b9 & b10 */
		if(d14[5] == 0)begin LT7[17] = 0;LT7[21] = 0; LT7[25] = 0;LT7[29] = 0;end
		else begin LT7[17] = lTable[d14[5]] + lTable[8'h0b];LT7[21] = lTable[d14[5]] + lTable[8'h0e]; LT7[25] = lTable[d14[5]] + lTable[8'h09];LT7[29] = lTable[d14[5]] + lTable[8'h0d];end
		/* For b11 & b12*/
		if(d14[6] == 0)begin LT7[18] = 0;LT7[22] = 0; LT7[26] = 0;LT7[30] = 0;end
		else begin LT7[18] = lTable[d14[6]] + lTable[8'h0d];LT7[22] = lTable[d14[6]] + lTable[8'h0b]; LT7[26] = lTable[d14[6]] + lTable[8'h0e];LT7[30] = lTable[d14[6]] + lTable[8'h09];end
		/* For b13 & b15 */
		if(d14[7] == 0)begin LT7[19] = 0;LT7[23] = 0; LT7[27] = 0;LT7[31] = 0;end
		else begin LT7[19] = lTable[d14[7]] + lTable[8'h09];LT7[23] = lTable[d14[7]] + lTable[8'h0d]; LT7[27] = lTable[d14[7]] + lTable[8'h0b];LT7[31] = lTable[d14[7]] + lTable[8'h0e];end
		/* For b16 & b22 */
		if(d14[8] == 0)begin LT7[32] = 0;LT7[36] = 0; LT7[40] = 0;LT7[44] = 0;end
		else begin LT7[32] = lTable[d14[8]] + lTable[8'h0e];LT7[36] = lTable[d14[8]] + lTable[8'h09];LT7[40] = lTable[d14[8]] + lTable[8'h0d];LT7[44] = lTable[d14[8]] + lTable[8'h0b];end
		/* For b17 & 18 */
		if(d14[9] == 0)begin LT7[33] = 0;LT7[37] = 0; LT7[41] = 0;LT7[45] = 0;end
		else begin LT7[33] = lTable[d14[9]] + lTable[8'h0b];LT7[37] = lTable[d14[9]] + lTable[8'h0e]; LT7[41] = lTable[d14[9]] + lTable[8'h09];LT7[45] = lTable[d14[9]] + lTable[8'h0d];end
		/* For b19 & b20 */
		if(d14[10] == 0)begin LT7[34] = 0;LT7[38] = 0;LT7[42] = 0;LT7[46] = 0;end
		else begin LT7[34] = lTable[d14[10]] + lTable[8'h0d];LT7[38] = lTable[d14[10]] + lTable[8'h0b];LT7[42] = lTable[d14[10]] + lTable[8'h0e];LT7[46] = lTable[d14[10]] + lTable[8'h09];end
		/* For b21 & b23 */
		if(d14[11] == 0)begin LT7[35] = 0; LT7[39] =0;LT7[43] = 0; LT7[47] =0;end
		else begin  LT7[35] = lTable[d14[11]] + lTable[8'h09]; LT7[39] =lTable[d14[11]] + lTable[8'h0d];LT7[43] = lTable[d14[11]] + lTable[8'h0b]; LT7[47] =lTable[d14[11]] + lTable[8'h0e];end	
		/* For b24 & b30 */
		if(d14[12] == 0)begin LT7[48] = 0;LT7[52] = 0; LT7[56] = 0;LT7[60] = 0;end 
		else begin LT7[48] = lTable[d14[12]] + lTable[8'h0e];LT7[52] = lTable[d14[12]] + lTable[8'h09]; LT7[56] = lTable[d14[12]] + lTable[8'h0d];LT7[60] = lTable[d14[12]] + lTable[8'h0b];end 		
		/* For b25 & b26 */		
		if(d14[13] == 0)begin LT7[49] = 0;LT7[53] = 0; LT7[57] = 0;LT7[61] = 0;end 
		else begin  LT7[49] = lTable[d14[13]] + lTable[8'h0b];LT7[53] = lTable[d14[13]] + lTable[8'h0e]; LT7[57] = lTable[d14[13]] + lTable[8'h09];LT7[61] = lTable[d14[13]] + lTable[8'h0d];end 
		/* For b27 & b28 */
		if(d14[14] == 0)begin LT7[50] = 0;LT7[54] = 0; LT7[58] = 0;LT7[62] = 0;end 
		else begin LT7[50] = lTable[d14[14]] + lTable[8'h0d];LT7[54] = lTable[d14[14]] + lTable[8'h0b]; LT7[58] = lTable[d14[14]] + lTable[8'h0e];LT7[62] = lTable[d14[14]] + lTable[8'h09];end 
		/* For b29 & b31 */
		if(d14[15] == 0)begin LT7[51] = 0;LT7[55] = 0; LT7[59] = 0;LT7[63] = 0;end 
		else begin LT7[51] = lTable[d14[15]] + lTable[8'h09];LT7[55] = lTable[d14[15]] + lTable[8'h0d]; LT7[59] = lTable[d14[15]] + lTable[8'h0b];LT7[63] = lTable[d14[15]] + lTable[8'h0e];end 

        next_state = 57;
    end
    57:begin
		if(LT7[0] > 255)begin l7[0] = LT7[0] - 255;end
		else begin l7[0] = LT7[0];end
		if(LT7[1] > 255)begin l7[1] = LT7[1] - 255;end
		else  begin l7[1] = LT7[1];end
		if(LT7[2] > 255)begin l7[2] = LT7[2] - 255;end
		else  begin l7[2] = LT7[2];end
		if(LT7[3] > 255)begin l7[3] = LT7[3] - 255;end
		else  begin l7[3] = LT7[3];end
		if(LT7[4] > 255)begin l7[4] = LT7[4] - 255;end
		else  begin l7[4] = LT7[4];end
		if(LT7[5] > 255)begin l7[5] = LT7[5] - 255;end
		else  begin l7[5] = LT7[5];end
		if(LT7[6] > 255)begin l7[6] = LT7[6] - 255;end
		else  begin l7[6] = LT7[6];end
		if(LT7[7] > 255)begin l7[7] = LT7[7] - 255;end
		else  begin l7[7] = LT7[7];end
		if(LT7[8] > 255)begin l7[8] = LT7[8] - 255;end
		else  begin l7[8] = LT7[8];end
		if(LT7[9] > 255)begin l7[9] = LT7[9] - 255;end
		else  begin l7[9] = LT7[9];end
		if(LT7[10] > 255)begin l7[10] = LT7[10] - 255;end
		else  begin l7[10] = LT7[10];end
		if(LT7[11] > 255)begin l7[11] = LT7[11] - 255;end
		else  begin l7[11] = LT7[11];end
		if(LT7[12] > 255)begin l7[12] = LT7[12] - 255;end
		else  begin l7[12] = LT7[12];end
		if(LT7[13] > 255)begin l7[13] = LT7[13] - 255;end
		else  begin l7[13] = LT7[13];end
		if(LT7[14] > 255)begin l7[14] = LT7[14] - 255;end
		else  begin l7[14] = LT7[14];end
		if(LT7[15] > 255)begin l7[15] = LT7[15] - 255;end
		else  begin l7[15] = LT7[15];end
		if(LT7[16] > 255)begin l7[16] = LT7[16] - 255;end
		else  begin l7[16] = LT7[16];end
		if(LT7[17] > 255)begin l7[17] = LT7[17] - 255;end
		else  begin l7[17] = LT7[17];end
		if(LT7[18] > 255)begin l7[18] = LT7[18] - 255;end
		else  begin l7[18] = LT7[18];end
		if(LT7[19] > 255)begin l7[19] = LT7[19] - 255;end
		else  begin l7[19] = LT7[19];end
		if(LT7[20] > 255)begin l7[20] = LT7[20] - 255;end
		else  begin l7[20] = LT7[20];end
		if(LT7[21] > 255)begin l7[21] = LT7[21] - 255;end
		else  begin l7[21] = LT7[21];end
		if(LT7[22] > 255)begin l7[22] = LT7[22] - 255;end
		else  begin l7[22] = LT7[22];end
		if(LT7[23] > 255)begin l7[23] = LT7[23] - 255;end
		else  begin l7[23] = LT7[23];end
		if(LT7[24] > 255)begin l7[24] = LT7[24] - 255;end
		else  begin l7[24] = LT7[24];end
		if(LT7[25] > 255)begin l7[25] = LT7[25] - 255;end
		else  begin l7[25] = LT7[25];end
		if(LT7[26] > 255)begin l7[26] = LT7[26] - 255;end
		else  begin l7[26] = LT7[26];end
		if(LT7[27] > 255)begin l7[27] = LT7[27] - 255;end
		else  begin l7[27] = LT7[27];end
		if(LT7[28] > 255)begin l7[28] = LT7[28] - 255;end
		else  begin l7[28] = LT7[28];end
		if(LT7[29] > 255)begin l7[29] = LT7[29] - 255;end
		else  begin l7[29] = LT7[29];end
		if(LT7[30] > 255)begin l7[30] = LT7[30] - 255;end
		else  begin l7[30] = LT7[30];end
		if(LT7[31] > 255)begin l7[31] = LT7[31] - 255;end
		else  begin l7[31] = LT7[31];end
		if(LT7[32] > 255)begin l7[32] = LT7[32] - 255;end
		else  begin l7[32] = LT7[32];end
		if(LT7[33] > 255)begin l7[33] = LT7[33] - 255;end
		else  begin l7[33] = LT7[33];end
		if(LT7[34] > 255)begin l7[34] = LT7[34] - 255;end
		else  begin l7[34] = LT7[34];end
		if(LT7[35] > 255)begin l7[35] = LT7[35] - 255;end
		else  begin l7[35] = LT7[35];end
		if(LT7[36] > 255)begin l7[36] = LT7[36] - 255;end
		else  begin l7[36] = LT7[36];end
		if(LT7[37] > 255)begin l7[37] = LT7[37] - 255;end
		else  begin l7[37] = LT7[37];end
		if(LT7[38] > 255)begin l7[38] = LT7[38] - 255;end
		else  begin l7[38] = LT7[38];end
		if(LT7[39] > 255)begin l7[39] = LT7[39] - 255;end
		else  begin l7[39] = LT7[39];end
		if(LT7[40] > 255)begin l7[40] = LT7[40] - 255;end
		else  begin l7[40] = LT7[40];end
		if(LT7[41] > 255)begin l7[41] = LT7[41] - 255;end
		else  begin l7[41] = LT7[41];end
		if(LT7[42] > 255)begin l7[42] = LT7[42] - 255;end
		else  begin l7[42] = LT7[42];end
		if(LT7[43] > 255)begin l7[43] = LT7[43] - 255;end
		else  begin l7[43] = LT7[43];end
		if(LT7[44] > 255)begin l7[44] = LT7[44] - 255;end
		else  begin l7[44] = LT7[44];end
		if(LT7[45] > 255)begin l7[45] = LT7[45] - 255;end
		else  begin l7[45] = LT7[45];end
		if(LT7[46] > 255)begin l7[46] = LT7[46] - 255;end
		else  begin l7[46] = LT7[46];end
		if(LT7[47] > 255)begin l7[47] = LT7[47] - 255;end
		else  begin l7[47] = LT7[47];end
		if(LT7[48] > 255)begin l7[48] = LT7[48] - 255;end
		else  begin l7[48] = LT7[48];end
		if(LT7[49] > 255)begin l7[49] = LT7[49] - 255;end
		else  begin l7[49] = LT7[49];end
		if(LT7[50] > 255)begin l7[50] = LT7[50] - 255;end
		else  begin l7[50] = LT7[50];end
		if(LT7[51] > 255)begin l7[51] = LT7[51] - 255;end
		else  begin l7[51] = LT7[51];end
		if(LT7[52] > 255)begin l7[52] = LT7[52] - 255;end
		else  begin l7[52] = LT7[52];end
		if(LT7[53] > 255)begin l7[53] = LT7[53] - 255;end
		else  begin l7[53] = LT7[53];end
		if(LT7[54] > 255)begin l7[54] = LT7[54] - 255;end
		else  begin l7[54] = LT7[54];end
		if(LT7[55] > 255)begin l7[55] = LT7[55] - 255;end
		else  begin l7[55] = LT7[55];end
		if(LT7[56] > 255)begin l7[56] = LT7[56] - 255;end
		else  begin l7[56] = LT7[56];end
		if(LT7[57] > 255)begin l7[57] = LT7[57] - 255;end
		else  begin l7[57] = LT7[57];end
		if(LT7[58] > 255)begin l7[58] = LT7[58] - 255;end
		else  begin l7[58] = LT7[58];end
		if(LT7[59] > 255)begin l7[59] = LT7[59] - 255;end
		else  begin l7[59] = LT7[59];end
		if(LT7[60] > 255)begin l7[60] = LT7[60] - 255;end
		else  begin l7[60] = LT7[60];end
		if(LT7[61] > 255)begin l7[61] = LT7[61] - 255;end
		else  begin l7[61] = LT7[61];end
		if(LT7[62] > 255)begin l7[62] = LT7[62] - 255;end
		else  begin l7[62] = LT7[62];end
		if(LT7[63] > 255)begin l7[63] = LT7[63] - 255;end
		else  begin l7[63] = LT7[63];end		
		next_state = 58;
	end
	58:begin
		/* for d0 */
		if(l7[0] == 0)begin ET7[0] = 0;end
		else begin ET7[0] = eTable[l7[0]];end
		if(l7[1] == 0)begin ET7[1] = 0;end
		else begin ET7[1] = eTable[l7[1]];end
		/* for d14 */
		if(l7[2] == 0)begin ET7[2] = 0;end
		else begin ET7[2] = eTable[l7[2]];end
		if(l7[3] == 0)begin ET7[3] = 0;end
		else begin ET7[3] = eTable[l7[3]];end
		/* for d14 */
		if(l7[4] == 0)begin ET7[4] = 0;end
		else begin ET7[4] = eTable[l7[4]];end
		if(l7[5] == 0)begin ET7[5] = 0;end
		else begin ET7[5] = eTable[l7[5]];end
		/* for d3 */
		if(l7[6] == 0)begin ET7[6] = 0;end
		else begin ET7[6] = eTable[l7[6]];end
		if(l7[7] == 0)begin ET7[7] = 0;end
		else begin ET7[7] = eTable[l7[7]];end
		/* for d14 */
		if(l7[8] == 0)begin ET7[8] = 0;end
		else begin ET7[8] = eTable[l7[8]];end
		if(l7[9] == 0)begin ET7[9] = 0;end
		else begin ET7[9] = eTable[l7[9]];end
		/* for d14 */
		if(l7[10] == 0)begin ET7[10] = 0;end
		else begin ET7[10] = eTable[l7[10]];end
		if(l7[11] == 0)begin ET7[11] = 0;end
		else begin ET7[11] = eTable[l7[11]];end
		/* for d14 */
		if(l7[12] == 0)begin ET7[12] = 0;end
		else begin ET7[12] = eTable[l7[12]];end
		if(l7[13] == 0)begin ET7[13] = 0;end
		else begin ET7[13] = eTable[l7[13]];end
		/* for d7 */
		if(l7[14] == 0)begin ET7[14] = 0;end
		else begin ET7[14] = eTable[l7[14]];end
		if(l7[15] == 0)begin ET7[15] = 0;end
		else begin ET7[15] = eTable[l7[15]];end
		/* for d14 */
		if(l7[16] == 0)begin ET7[16] = 0;end
		else begin ET7[16] = eTable[l7[16]];end
		if(l7[17] == 0)begin ET7[17] = 0;end
		else begin ET7[17] = eTable[l7[17]];end
		/* for d15 */
		if(l7[18] == 0)begin ET7[18] = 0;end
		else begin ET7[18] = eTable[l7[18]];end
		if(l7[19] == 0)begin ET7[19] = 0;end
		else begin ET7[19] = eTable[l7[19]];end
		/* for d14 */
		if(l7[20] == 0)begin ET7[20] = 0;end
		else begin ET7[20] = eTable[l7[20]];end
		if(l7[21] == 0)begin ET7[21] = 0;end
		else begin ET7[21] = eTable[l7[21]];end
		/* for d15 */
		if(l7[22] == 0)begin ET7[22] = 0;end
		else begin ET7[22] = eTable[l7[22]];end
		if(l7[23] == 0)begin ET7[23] = 0;end
		else begin ET7[23] = eTable[l7[23]];end
		/* for d14 */
		if(l7[24] == 0)begin ET7[24] = 0;end
		else begin ET7[24] = eTable[l7[24]];end
		if(l7[25] == 0)begin ET7[25] = 0;end
		else begin ET7[25] = eTable[l7[25]];end
		/* for d15 */
		if(l7[26] == 0)begin ET7[26] = 0;end
		else begin ET7[26] = eTable[l7[26]];end
		if(l7[27] == 0)begin ET7[27] = 0;end
		else begin ET7[27] = eTable[l7[27]];end
		/* for d14 */
		if(l7[28] == 0)begin ET7[28] = 0;end
		else begin ET7[28] = eTable[l7[28]];end
		if(l7[29] == 0)begin ET7[29] = 0;end
		else begin ET7[29] = eTable[l7[29]];end
		/* for d15 */
		if(l7[30] == 0)begin ET7[30] = 0;end
		else begin ET7[30] = eTable[l7[30]];end
		if(l7[31] == 0)begin ET7[31] = 0;end
		else begin ET7[31] = eTable[l7[31]];end
		if(l7[32] == 0)begin ET7[32] = 0;end
		else begin ET7[32] = eTable[l7[32]];end
		if(l7[33] == 0)begin ET7[33] = 0;end
		else begin ET7[33] = eTable[l7[33]];end
		if(l7[34] == 0)begin ET7[34] = 0;end
		else begin ET7[34] = eTable[l7[34]];end
		if(l7[35] == 0)begin ET7[35] = 0;end
		else begin ET7[35] = eTable[l7[35]];end
		if(l7[36] == 0)begin ET7[36] = 0;end
		else begin ET7[36] = eTable[l7[36]];end
		if(l7[37] == 0)begin ET7[37] = 0;end
		else begin ET7[37] = eTable[l7[37]];end
		if(l7[38] == 0)begin ET7[38] = 0;end
		else begin ET7[38] = eTable[l7[38]];end
		if(l7[39] == 0)begin ET7[39] = 0;end
		else begin ET7[39] = eTable[l7[39]];end
		if(l7[40] == 0)begin ET7[40] = 0;end
		else begin ET7[40] = eTable[l7[40]];end
		if(l7[41] == 0)begin ET7[41] = 0;end
		else begin ET7[41] = eTable[l7[41]];end
		if(l7[42] == 0)begin ET7[42] = 0;end
		else begin ET7[42] = eTable[l7[42]];end
		if(l7[43] == 0)begin ET7[43] = 0;end
		else begin ET7[43] = eTable[l7[43]];end
		if(l7[44] == 0)begin ET7[44] = 0;end
		else begin ET7[44] = eTable[l7[44]];end
		if(l7[45] == 0)begin ET7[45] = 0;end
		else begin ET7[45] = eTable[l7[45]];end
		if(l7[46] == 0)begin ET7[46] = 0;end
		else begin ET7[46] = eTable[l7[46]];end
		if(l7[47] == 0)begin ET7[47] = 0;end
		else begin ET7[47] = eTable[l7[47]];end
		if(l7[48] == 0)begin ET7[48] = 0;end
		else begin ET7[48] = eTable[l7[48]];end
		if(l7[49] == 0)begin ET7[49] = 0;end
		else begin ET7[49] = eTable[l7[49]];end
		if(l7[50] == 0)begin ET7[50] = 0;end
		else begin ET7[50] = eTable[l7[50]];end		
		if(l7[51] == 0)begin ET7[51] = 0;end
		else begin ET7[51] = eTable[l7[51]];end
		if(l7[52] == 0)begin ET7[52] = 0;end
		else begin ET7[52] = eTable[l7[52]];end
		if(l7[53] == 0)begin ET7[53] = 0;end
		else begin ET7[53] = eTable[l7[53]];end
		if(l7[54] == 0)begin ET7[54] = 0;end
		else begin ET7[54] = eTable[l7[54]];end
		if(l7[55] == 0)begin ET7[55] = 0;end
		else begin ET7[55] = eTable[l7[55]];end
		if(l7[56] == 0)begin ET7[56] = 0;end
		else begin ET7[56] = eTable[l7[56]];end
		if(l7[57] == 0)begin ET7[57] = 0;end
		else begin ET7[57] = eTable[l7[57]];end
		if(l7[58] == 0)begin ET7[58] = 0;end
		else begin ET7[58] = eTable[l7[58]];end
		if(l7[59] == 0)begin ET7[59] = 0;end
		else begin ET7[59] = eTable[l7[59]];end
		if(l7[60] == 0)begin ET7[60] = 0;end
		else begin ET7[60] = eTable[l7[60]];end	
		if(l7[61] == 0)begin ET7[61] = 0;end
		else begin ET7[61] = eTable[l7[61]];end
		if(l7[62] == 0)begin ET7[62] = 0;end
		else begin ET7[62] = eTable[l7[62]];end
		if(l7[63] == 0)begin ET7[63] = 0;end
		else begin ET7[63] = eTable[l7[63]];end
		next_state = 59;
	end
    59:begin
        d15[0] = ET7[0]^ET7[1]^ET7[2]^ET7[3];
        d15[1] = ET7[4]^ET7[5]^ET7[6]^ET7[7];
        d15[2] = ET7[8]^ET7[9]^ET7[10]^ET7[11];
        d15[3] = ET7[12]^ET7[13]^ET7[14]^ET7[15];
        d15[4] = ET7[16]^ET7[17]^ET7[18]^ET7[19];
        d15[5] = ET7[20]^ET7[21]^ET7[22]^ET7[23];
        d15[6] = ET7[24]^ET7[25]^ET7[26]^ET7[27];
        d15[7] = ET7[28]^ET7[29]^ET7[30]^ET7[31];
        d15[8] = ET7[32]^ET7[33]^ET7[34]^ET7[35];
        d15[9] = ET7[36]^ET7[37]^ET7[38]^ET7[39];
        d15[10] = ET7[40]^ET7[41]^ET7[42]^ET7[43];
        d15[11] = ET7[44]^ET7[45]^ET7[46]^ET7[47];
        d15[12] = ET7[48]^ET7[49]^ET7[50]^ET7[51];
        d15[13] = ET7[52]^ET7[53]^ET7[54]^ET7[55];
        d15[14] = ET7[56]^ET7[57]^ET7[58]^ET7[59];
        d15[15] =ET7[60]^ET7[61]^ET7[62]^ET7[63]; 
        next_state = 60;
    end
	60:begin
        tempRow8[0] = d15[0];tempRow8[4] = d15[4];tempRow8[8] = d15[8];tempRow8[12] = d15[12];
        tempRow8[1] = d15[13];tempRow8[5] = d15[1];tempRow8[9] = d15[5];tempRow8[13] = d15[9];
        tempRow8[2] = d15[10];tempRow8[6] = d15[14];tempRow8[10] = d15[2];tempRow8[14] = d15[6];
        tempRow8[3] = d15[7];tempRow8[7] = d15[11];tempRow8[11] = d15[15];tempRow8[15] = d15[3];
        next_state = 61;
	end
	61:begin
        tempSbox8[0] = inv_sbox[tempRow8[0]];tempSbox8[1] = inv_sbox[tempRow8[1]];tempSbox8[2] = inv_sbox[tempRow8[2]];tempSbox8[3] = inv_sbox[tempRow8[3]];
        tempSbox8[4] = inv_sbox[tempRow8[4]];tempSbox8[5] = inv_sbox[tempRow8[5]];tempSbox8[6] = inv_sbox[tempRow8[6]];tempSbox8[7] = inv_sbox[tempRow8[7]];
        tempSbox8[8] = inv_sbox[tempRow8[8]];tempSbox8[9] = inv_sbox[tempRow8[9]];tempSbox8[10] = inv_sbox[tempRow8[10]];tempSbox8[11] = inv_sbox[tempRow8[11]];
        tempSbox8[12] = inv_sbox[tempRow8[12]];tempSbox8[13] = inv_sbox[tempRow8[13]];tempSbox8[14] = inv_sbox[tempRow8[14]];tempSbox8[15] = inv_sbox[tempRow8[15]];
		next_state = 62;
	end
	62:begin
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
		next_state = 63;
	end
	63:begin 
	    /* For b0 & b4*/
		if(d16[0] == 0)begin LT8[0] = 0; LT8[4] = 0; LT8[8] = 0; LT8[12] = 0 ;end
		else begin LT8[0] = lTable[d16[0]] + lTable[8'h0e];LT8[4] = lTable[d16[0]] + lTable[8'h09];LT8[8] =  lTable[d16[0]] + lTable[8'h0d];LT8[12] = lTable[d16[0]] + lTable[8'h0b];end
	    /* For b1 & b2*/
		if(d16[1] == 0)begin LT8[1] = 0;LT8[5] = 0;LT8[9] =0; LT8[13] = 0;end
		else begin LT8[1] = lTable[d16[1]] + lTable[8'h0b];LT8[5] = lTable[d16[1]] + lTable[8'h0e];LT8[9] = lTable[d16[1]] + lTable[8'h09]; LT8[13] = lTable[d16[1]] + lTable[8'h0d];end
	    /* For b3 & b4*/
		if(d16[2] == 0)begin LT8[2] = 0;LT8[6] = 0;LT8[10] = 0;LT8[14] = 0;end
		else begin LT8[2] = lTable[d16[2]] + lTable[8'h0d];LT8[6] = lTable[d16[2]] + lTable[8'h0b];LT8[10] = lTable[d16[2]] + lTable[8'h0e];LT8[14] = lTable[d16[2]] + lTable[8'h09];end
	    /* For b5 & b7*/			
		if(d16[3] == 0)begin LT8[3] = 0;LT8[7] = 0;LT8[11] = 0;LT8[15] = 0;end 
		else begin  LT8[3] = lTable[d16[3]] + lTable[8'h09];LT8[7] = lTable[d16[3]] + lTable[8'h0d];LT8[11] = lTable[d16[3]] + lTable[8'h0b];LT8[15] = lTable[d16[3]] + lTable[8'h0e];end
	    /* For b8 & b14 */				
		if(d16[4] == 0)begin LT8[16] = 0; LT8[20] = 0; LT8[24] = 0; LT8[28] = 0;end
		else begin LT8[16] = lTable[d16[4]] + lTable[8'h0e]; LT8[20] = lTable[d16[4]] + lTable[8'h09]; LT8[24] = lTable[d16[4]] + lTable[8'h0d]; LT8[28] = lTable[d16[4]] + lTable[8'h0b];end
		/* For b9 & b10 */
		if(d16[5] == 0)begin LT8[17] = 0;LT8[21] = 0; LT8[25] = 0;LT8[29] = 0;end
		else begin LT8[17] = lTable[d16[5]] + lTable[8'h0b];LT8[21] = lTable[d16[5]] + lTable[8'h0e]; LT8[25] = lTable[d16[5]] + lTable[8'h09];LT8[29] = lTable[d16[5]] + lTable[8'h0d];end
		/* For b11 & b12*/
		if(d16[6] == 0)begin LT8[18] = 0;LT8[22] = 0; LT8[26] = 0;LT8[30] = 0;end
		else begin LT8[18] = lTable[d16[6]] + lTable[8'h0d];LT8[22] = lTable[d16[6]] + lTable[8'h0b]; LT8[26] = lTable[d16[6]] + lTable[8'h0e];LT8[30] = lTable[d16[6]] + lTable[8'h09];end
		/* For b13 & b15 */
		if(d16[7] == 0)begin LT8[19] = 0;LT8[23] = 0; LT8[27] = 0;LT8[31] = 0;end
		else begin LT8[19] = lTable[d16[7]] + lTable[8'h09];LT8[23] = lTable[d16[7]] + lTable[8'h0d]; LT8[27] = lTable[d16[7]] + lTable[8'h0b];LT8[31] = lTable[d16[7]] + lTable[8'h0e];end
		/* For b16 & b22 */
		if(d16[8] == 0)begin LT8[32] = 0;LT8[36] = 0; LT8[40] = 0;LT8[44] = 0;end
		else begin LT8[32] = lTable[d16[8]] + lTable[8'h0e];LT8[36] = lTable[d16[8]] + lTable[8'h09];LT8[40] = lTable[d16[8]] + lTable[8'h0d];LT8[44] = lTable[d16[8]] + lTable[8'h0b];end
		/* For b17 & 18 */
		if(d16[9] == 0)begin LT8[33] = 0;LT8[37] = 0; LT8[41] = 0;LT8[45] = 0;end
		else begin LT8[33] = lTable[d16[9]] + lTable[8'h0b];LT8[37] = lTable[d16[9]] + lTable[8'h0e]; LT8[41] = lTable[d16[9]] + lTable[8'h09];LT8[45] = lTable[d16[9]] + lTable[8'h0d];end
		/* For b19 & b20 */
		if(d16[10] == 0)begin LT8[34] = 0;LT8[38] = 0;LT8[42] = 0;LT8[46] = 0;end
		else begin LT8[34] = lTable[d16[10]] + lTable[8'h0d];LT8[38] = lTable[d16[10]] + lTable[8'h0b];LT8[42] = lTable[d16[10]] + lTable[8'h0e];LT8[46] = lTable[d16[10]] + lTable[8'h09];end
		/* For b21 & b23 */
		if(d16[11] == 0)begin LT8[35] = 0; LT8[39] =0;LT8[43] = 0; LT8[47] =0;end
		else begin  LT8[35] = lTable[d16[11]] + lTable[8'h09]; LT8[39] =lTable[d16[11]] + lTable[8'h0d];LT8[43] = lTable[d16[11]] + lTable[8'h0b]; LT8[47] =lTable[d16[11]] + lTable[8'h0e];end	
		/* For b24 & b30 */
		if(d16[12] == 0)begin LT8[48] = 0;LT8[52] = 0; LT8[56] = 0;LT8[60] = 0;end 
		else begin LT8[48] = lTable[d16[12]] + lTable[8'h0e];LT8[52] = lTable[d16[12]] + lTable[8'h09]; LT8[56] = lTable[d16[12]] + lTable[8'h0d];LT8[60] = lTable[d16[12]] + lTable[8'h0b];end 		
		/* For b25 & b26 */		
		if(d16[13] == 0)begin LT8[49] = 0;LT8[53] = 0; LT8[57] = 0;LT8[61] = 0;end 
		else begin  LT8[49] = lTable[d16[13]] + lTable[8'h0b];LT8[53] = lTable[d16[13]] + lTable[8'h0e]; LT8[57] = lTable[d16[13]] + lTable[8'h09];LT8[61] = lTable[d16[13]] + lTable[8'h0d];end 
		/* For b27 & b28 */
		if(d16[14] == 0)begin LT8[50] = 0;LT8[54] = 0; LT8[58] = 0;LT8[62] = 0;end 
		else begin LT8[50] = lTable[d16[14]] + lTable[8'h0d];LT8[54] = lTable[d16[14]] + lTable[8'h0b]; LT8[58] = lTable[d16[14]] + lTable[8'h0e];LT8[62] = lTable[d16[14]] + lTable[8'h09];end 
		/* For b29 & b31 */
		if(d16[15] == 0)begin LT8[51] = 0;LT8[55] = 0; LT8[59] = 0;LT8[63] = 0;end 
		else begin LT8[51] = lTable[d16[15]] + lTable[8'h09];LT8[55] = lTable[d16[15]] + lTable[8'h0d]; LT8[59] = lTable[d16[15]] + lTable[8'h0b];LT8[63] = lTable[d16[15]] + lTable[8'h0e];end 

        next_state = 64;
    end
    64:begin
		if(LT8[0] > 255)begin l8[0] = LT8[0] - 255;end
		else begin l8[0] = LT8[0];end
		if(LT8[1] > 255)begin l8[1] = LT8[1] - 255;end
		else  begin l8[1] = LT8[1];end
		if(LT8[2] > 255)begin l8[2] = LT8[2] - 255;end
		else  begin l8[2] = LT8[2];end
		if(LT8[3] > 255)begin l8[3] = LT8[3] - 255;end
		else  begin l8[3] = LT8[3];end
		if(LT8[4] > 255)begin l8[4] = LT8[4] - 255;end
		else  begin l8[4] = LT8[4];end
		if(LT8[5] > 255)begin l8[5] = LT8[5] - 255;end
		else  begin l8[5] = LT8[5];end
		if(LT8[6] > 255)begin l8[6] = LT8[6] - 255;end
		else  begin l8[6] = LT8[6];end
		if(LT8[7] > 255)begin l8[7] = LT8[7] - 255;end
		else  begin l8[7] = LT8[7];end
		if(LT8[8] > 255)begin l8[8] = LT8[8] - 255;end
		else  begin l8[8] = LT8[8];end
		if(LT8[9] > 255)begin l8[9] = LT8[9] - 255;end
		else  begin l8[9] = LT8[9];end
		if(LT8[10] > 255)begin l8[10] = LT8[10] - 255;end
		else  begin l8[10] = LT8[10];end
		if(LT8[11] > 255)begin l8[11] = LT8[11] - 255;end
		else  begin l8[11] = LT8[11];end
		if(LT8[12] > 255)begin l8[12] = LT8[12] - 255;end
		else  begin l8[12] = LT8[12];end
		if(LT8[13] > 255)begin l8[13] = LT8[13] - 255;end
		else  begin l8[13] = LT8[13];end
		if(LT8[14] > 255)begin l8[14] = LT8[14] - 255;end
		else  begin l8[14] = LT8[14];end
		if(LT8[15] > 255)begin l8[15] = LT8[15] - 255;end
		else  begin l8[15] = LT8[15];end
		if(LT8[16] > 255)begin l8[16] = LT8[16] - 255;end
		else  begin l8[16] = LT8[16];end
		if(LT8[17] > 255)begin l8[17] = LT8[17] - 255;end
		else  begin l8[17] = LT8[17];end
		if(LT8[18] > 255)begin l8[18] = LT8[18] - 255;end
		else  begin l8[18] = LT8[18];end
		if(LT8[19] > 255)begin l8[19] = LT8[19] - 255;end
		else  begin l8[19] = LT8[19];end
		if(LT8[20] > 255)begin l8[20] = LT8[20] - 255;end
		else  begin l8[20] = LT8[20];end
		if(LT8[21] > 255)begin l8[21] = LT8[21] - 255;end
		else  begin l8[21] = LT8[21];end
		if(LT8[22] > 255)begin l8[22] = LT8[22] - 255;end
		else  begin l8[22] = LT8[22];end
		if(LT8[23] > 255)begin l8[23] = LT8[23] - 255;end
		else  begin l8[23] = LT8[23];end
		if(LT8[24] > 255)begin l8[24] = LT8[24] - 255;end
		else  begin l8[24] = LT8[24];end
		if(LT8[25] > 255)begin l8[25] = LT8[25] - 255;end
		else  begin l8[25] = LT8[25];end
		if(LT8[26] > 255)begin l8[26] = LT8[26] - 255;end
		else  begin l8[26] = LT8[26];end
		if(LT8[27] > 255)begin l8[27] = LT8[27] - 255;end
		else  begin l8[27] = LT8[27];end
		if(LT8[28] > 255)begin l8[28] = LT8[28] - 255;end
		else  begin l8[28] = LT8[28];end
		if(LT8[29] > 255)begin l8[29] = LT8[29] - 255;end
		else  begin l8[29] = LT8[29];end
		if(LT8[30] > 255)begin l8[30] = LT8[30] - 255;end
		else  begin l8[30] = LT8[30];end
		if(LT8[31] > 255)begin l8[31] = LT8[31] - 255;end
		else  begin l8[31] = LT8[31];end
		if(LT8[32] > 255)begin l8[32] = LT8[32] - 255;end
		else  begin l8[32] = LT8[32];end
		if(LT8[33] > 255)begin l8[33] = LT8[33] - 255;end
		else  begin l8[33] = LT8[33];end
		if(LT8[34] > 255)begin l8[34] = LT8[34] - 255;end
		else  begin l8[34] = LT8[34];end
		if(LT8[35] > 255)begin l8[35] = LT8[35] - 255;end
		else  begin l8[35] = LT8[35];end
		if(LT8[36] > 255)begin l8[36] = LT8[36] - 255;end
		else  begin l8[36] = LT8[36];end
		if(LT8[37] > 255)begin l8[37] = LT8[37] - 255;end
		else  begin l8[37] = LT8[37];end
		if(LT8[38] > 255)begin l8[38] = LT8[38] - 255;end
		else  begin l8[38] = LT8[38];end
		if(LT8[39] > 255)begin l8[39] = LT8[39] - 255;end
		else  begin l8[39] = LT8[39];end
		if(LT8[40] > 255)begin l8[40] = LT8[40] - 255;end
		else  begin l8[40] = LT8[40];end
		if(LT8[41] > 255)begin l8[41] = LT8[41] - 255;end
		else  begin l8[41] = LT8[41];end
		if(LT8[42] > 255)begin l8[42] = LT8[42] - 255;end
		else  begin l8[42] = LT8[42];end
		if(LT8[43] > 255)begin l8[43] = LT8[43] - 255;end
		else  begin l8[43] = LT8[43];end
		if(LT8[44] > 255)begin l8[44] = LT8[44] - 255;end
		else  begin l8[44] = LT8[44];end
		if(LT8[45] > 255)begin l8[45] = LT8[45] - 255;end
		else  begin l8[45] = LT8[45];end
		if(LT8[46] > 255)begin l8[46] = LT8[46] - 255;end
		else  begin l8[46] = LT8[46];end
		if(LT8[47] > 255)begin l8[47] = LT8[47] - 255;end
		else  begin l8[47] = LT8[47];end
		if(LT8[48] > 255)begin l8[48] = LT8[48] - 255;end
		else  begin l8[48] = LT8[48];end
		if(LT8[49] > 255)begin l8[49] = LT8[49] - 255;end
		else  begin l8[49] = LT8[49];end
		if(LT8[50] > 255)begin l8[50] = LT8[50] - 255;end
		else  begin l8[50] = LT8[50];end
		if(LT8[51] > 255)begin l8[51] = LT8[51] - 255;end
		else  begin l8[51] = LT8[51];end
		if(LT8[52] > 255)begin l8[52] = LT8[52] - 255;end
		else  begin l8[52] = LT8[52];end
		if(LT8[53] > 255)begin l8[53] = LT8[53] - 255;end
		else  begin l8[53] = LT8[53];end
		if(LT8[54] > 255)begin l8[54] = LT8[54] - 255;end
		else  begin l8[54] = LT8[54];end
		if(LT8[55] > 255)begin l8[55] = LT8[55] - 255;end
		else  begin l8[55] = LT8[55];end
		if(LT8[56] > 255)begin l8[56] = LT8[56] - 255;end
		else  begin l8[56] = LT8[56];end
		if(LT8[57] > 255)begin l8[57] = LT8[57] - 255;end
		else  begin l8[57] = LT8[57];end
		if(LT8[58] > 255)begin l8[58] = LT8[58] - 255;end
		else  begin l8[58] = LT8[58];end
		if(LT8[59] > 255)begin l8[59] = LT8[59] - 255;end
		else  begin l8[59] = LT8[59];end
		if(LT8[60] > 255)begin l8[60] = LT8[60] - 255;end
		else  begin l8[60] = LT8[60];end
		if(LT8[61] > 255)begin l8[61] = LT8[61] - 255;end
		else  begin l8[61] = LT8[61];end
		if(LT8[62] > 255)begin l8[62] = LT8[62] - 255;end
		else  begin l8[62] = LT8[62];end
		if(LT8[63] > 255)begin l8[63] = LT8[63] - 255;end
		else  begin l8[63] = LT8[63];end		
		next_state = 65;
	end
	65:begin
		/* for d0 */
		if(l8[0] == 0)begin ET8[0] = 0;end
		else begin ET8[0] = eTable[l8[0]];end
		if(l8[1] == 0)begin ET8[1] = 0;end
		else begin ET8[1] = eTable[l8[1]];end
		/* for d16 */
		if(l8[2] == 0)begin ET8[2] = 0;end
		else begin ET8[2] = eTable[l8[2]];end
		if(l8[3] == 0)begin ET8[3] = 0;end
		else begin ET8[3] = eTable[l8[3]];end
		/* for d18 */
		if(l8[4] == 0)begin ET8[4] = 0;end
		else begin ET8[4] = eTable[l8[4]];end
		if(l8[5] == 0)begin ET8[5] = 0;end
		else begin ET8[5] = eTable[l8[5]];end
		/* for d3 */
		if(l8[6] == 0)begin ET8[6] = 0;end
		else begin ET8[6] = eTable[l8[6]];end
		if(l8[7] == 0)begin ET8[7] = 0;end
		else begin ET8[7] = eTable[l8[7]];end
		/* for d18 */
		if(l8[8] == 0)begin ET8[8] = 0;end
		else begin ET8[8] = eTable[l8[8]];end
		if(l8[9] == 0)begin ET8[9] = 0;end
		else begin ET8[9] = eTable[l8[9]];end
		/* for d18 */
		if(l8[10] == 0)begin ET8[10] = 0;end
		else begin ET8[10] = eTable[l8[10]];end
		if(l8[11] == 0)begin ET8[11] = 0;end
		else begin ET8[11] = eTable[l8[11]];end
		/* for d18 */
		if(l8[12] == 0)begin ET8[12] = 0;end
		else begin ET8[12] = eTable[l8[12]];end
		if(l8[13] == 0)begin ET8[13] = 0;end
		else begin ET8[13] = eTable[l8[13]];end
		/* for d7 */
		if(l8[14] == 0)begin ET8[14] = 0;end
		else begin ET8[14] = eTable[l8[14]];end
		if(l8[15] == 0)begin ET8[15] = 0;end
		else begin ET8[15] = eTable[l8[15]];end
		/* for d18 */
		if(l8[16] == 0)begin ET8[16] = 0;end
		else begin ET8[16] = eTable[l8[16]];end
		if(l8[17] == 0)begin ET8[17] = 0;end
		else begin ET8[17] = eTable[l8[17]];end
		/* for d17 */
		if(l8[18] == 0)begin ET8[18] = 0;end
		else begin ET8[18] = eTable[l8[18]];end
		if(l8[19] == 0)begin ET8[19] = 0;end
		else begin ET8[19] = eTable[l8[19]];end
		/* for d18 */
		if(l8[20] == 0)begin ET8[20] = 0;end
		else begin ET8[20] = eTable[l8[20]];end
		if(l8[21] == 0)begin ET8[21] = 0;end
		else begin ET8[21] = eTable[l8[21]];end
		/* for d17 */
		if(l8[22] == 0)begin ET8[22] = 0;end
		else begin ET8[22] = eTable[l8[22]];end
		if(l8[23] == 0)begin ET8[23] = 0;end
		else begin ET8[23] = eTable[l8[23]];end
		/* for d18 */
		if(l8[24] == 0)begin ET8[24] = 0;end
		else begin ET8[24] = eTable[l8[24]];end
		if(l8[25] == 0)begin ET8[25] = 0;end
		else begin ET8[25] = eTable[l8[25]];end
		/* for d17 */
		if(l8[26] == 0)begin ET8[26] = 0;end
		else begin ET8[26] = eTable[l8[26]];end
		if(l8[27] == 0)begin ET8[27] = 0;end
		else begin ET8[27] = eTable[l8[27]];end
		/* for d18 */
		if(l8[28] == 0)begin ET8[28] = 0;end
		else begin ET8[28] = eTable[l8[28]];end
		if(l8[29] == 0)begin ET8[29] = 0;end
		else begin ET8[29] = eTable[l8[29]];end
		/* for d17 */
		if(l8[30] == 0)begin ET8[30] = 0;end
		else begin ET8[30] = eTable[l8[30]];end
		if(l8[31] == 0)begin ET8[31] = 0;end
		else begin ET8[31] = eTable[l8[31]];end
		if(l8[32] == 0)begin ET8[32] = 0;end
		else begin ET8[32] = eTable[l8[32]];end
		if(l8[33] == 0)begin ET8[33] = 0;end
		else begin ET8[33] = eTable[l8[33]];end
		if(l8[34] == 0)begin ET8[34] = 0;end
		else begin ET8[34] = eTable[l8[34]];end
		if(l8[35] == 0)begin ET8[35] = 0;end
		else begin ET8[35] = eTable[l8[35]];end
		if(l8[36] == 0)begin ET8[36] = 0;end
		else begin ET8[36] = eTable[l8[36]];end
		if(l8[37] == 0)begin ET8[37] = 0;end
		else begin ET8[37] = eTable[l8[37]];end
		if(l8[38] == 0)begin ET8[38] = 0;end
		else begin ET8[38] = eTable[l8[38]];end
		if(l8[39] == 0)begin ET8[39] = 0;end
		else begin ET8[39] = eTable[l8[39]];end
		if(l8[40] == 0)begin ET8[40] = 0;end
		else begin ET8[40] = eTable[l8[40]];end
		if(l8[41] == 0)begin ET8[41] = 0;end
		else begin ET8[41] = eTable[l8[41]];end
		if(l8[42] == 0)begin ET8[42] = 0;end
		else begin ET8[42] = eTable[l8[42]];end
		if(l8[43] == 0)begin ET8[43] = 0;end
		else begin ET8[43] = eTable[l8[43]];end
		if(l8[44] == 0)begin ET8[44] = 0;end
		else begin ET8[44] = eTable[l8[44]];end
		if(l8[45] == 0)begin ET8[45] = 0;end
		else begin ET8[45] = eTable[l8[45]];end
		if(l8[46] == 0)begin ET8[46] = 0;end
		else begin ET8[46] = eTable[l8[46]];end
		if(l8[47] == 0)begin ET8[47] = 0;end
		else begin ET8[47] = eTable[l8[47]];end
		if(l8[48] == 0)begin ET8[48] = 0;end
		else begin ET8[48] = eTable[l8[48]];end
		if(l8[49] == 0)begin ET8[49] = 0;end
		else begin ET8[49] = eTable[l8[49]];end
		if(l8[50] == 0)begin ET8[50] = 0;end
		else begin ET8[50] = eTable[l8[50]];end		
		if(l8[51] == 0)begin ET8[51] = 0;end
		else begin ET8[51] = eTable[l8[51]];end
		if(l8[52] == 0)begin ET8[52] = 0;end
		else begin ET8[52] = eTable[l8[52]];end
		if(l8[53] == 0)begin ET8[53] = 0;end
		else begin ET8[53] = eTable[l8[53]];end
		if(l8[54] == 0)begin ET8[54] = 0;end
		else begin ET8[54] = eTable[l8[54]];end
		if(l8[55] == 0)begin ET8[55] = 0;end
		else begin ET8[55] = eTable[l8[55]];end
		if(l8[56] == 0)begin ET8[56] = 0;end
		else begin ET8[56] = eTable[l8[56]];end
		if(l8[57] == 0)begin ET8[57] = 0;end
		else begin ET8[57] = eTable[l8[57]];end
		if(l8[58] == 0)begin ET8[58] = 0;end
		else begin ET8[58] = eTable[l8[58]];end
		if(l8[59] == 0)begin ET8[59] = 0;end
		else begin ET8[59] = eTable[l8[59]];end
		if(l8[60] == 0)begin ET8[60] = 0;end
		else begin ET8[60] = eTable[l8[60]];end	
		if(l8[61] == 0)begin ET8[61] = 0;end
		else begin ET8[61] = eTable[l8[61]];end
		if(l8[62] == 0)begin ET8[62] = 0;end
		else begin ET8[62] = eTable[l8[62]];end
		if(l8[63] == 0)begin ET8[63] = 0;end
		else begin ET8[63] = eTable[l8[63]];end
		next_state = 66;
	end
    66:begin
        d17[0] = ET8[0]^ET8[1]^ET8[2]^ET8[3];
        d17[1] = ET8[4]^ET8[5]^ET8[6]^ET8[7];
        d17[2] = ET8[8]^ET8[9]^ET8[10]^ET8[11];
        d17[3] = ET8[12]^ET8[13]^ET8[14]^ET8[15];
        d17[4] = ET8[16]^ET8[17]^ET8[18]^ET8[19];
        d17[5] = ET8[20]^ET8[21]^ET8[22]^ET8[23];
        d17[6] = ET8[24]^ET8[25]^ET8[26]^ET8[27];
        d17[7] = ET8[28]^ET8[29]^ET8[30]^ET8[31];
        d17[8] = ET8[32]^ET8[33]^ET8[34]^ET8[35];
        d17[9] = ET8[36]^ET8[37]^ET8[38]^ET8[39];
        d17[10] = ET8[40]^ET8[41]^ET8[42]^ET8[43];
        d17[11] = ET8[44]^ET8[45]^ET8[46]^ET8[47];
        d17[12] = ET8[48]^ET8[49]^ET8[50]^ET8[51];
        d17[13] = ET8[52]^ET8[53]^ET8[54]^ET8[55];
        d17[14] = ET8[56]^ET8[57]^ET8[58]^ET8[59];
        d17[15] =ET8[60]^ET8[61]^ET8[62]^ET8[63]; 
        next_state = 67;
    end
	67:begin
        tempRow9[0] = d17[0];tempRow9[4] = d17[4];tempRow9[8] = d17[8];tempRow9[12] = d17[12];
        tempRow9[1] = d17[13];tempRow9[5] = d17[1];tempRow9[9] = d17[5];tempRow9[13] = d17[9];
        tempRow9[2] = d17[10];tempRow9[6] = d17[14];tempRow9[10] = d17[2];tempRow9[14] = d17[6];
        tempRow9[3] = d17[7];tempRow9[7] = d17[11];tempRow9[11] = d17[15];tempRow9[15] = d17[3];
        next_state = 68;
	end
	68:begin
        tempSbox9[0] = inv_sbox[tempRow9[0]];tempSbox9[1] = inv_sbox[tempRow9[1]];tempSbox9[2] = inv_sbox[tempRow9[2]];tempSbox9[3] = inv_sbox[tempRow9[3]];
        tempSbox9[4] = inv_sbox[tempRow9[4]];tempSbox9[5] = inv_sbox[tempRow9[5]];tempSbox9[6] = inv_sbox[tempRow9[6]];tempSbox9[7] = inv_sbox[tempRow9[7]];
        tempSbox9[8] = inv_sbox[tempRow9[8]];tempSbox9[9] = inv_sbox[tempRow9[9]];tempSbox9[10] = inv_sbox[tempRow9[10]];tempSbox9[11] = inv_sbox[tempRow9[11]];
        tempSbox9[12] = inv_sbox[tempRow9[12]];tempSbox9[13] = inv_sbox[tempRow9[13]];tempSbox9[14] = inv_sbox[tempRow9[14]];tempSbox9[15] = inv_sbox[tempRow9[15]];
		next_state = 69;
	end
	69:begin
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
		next_state = 70;
	end
	70:begin 
	    /* For b0 & b4*/
		if(d18[0] == 0)begin LT9[0] = 0; LT9[4] = 0; LT9[8] = 0; LT9[12] = 0 ;end
		else begin LT9[0] = lTable[d18[0]] + lTable[8'h0e];LT9[4] = lTable[d18[0]] + lTable[8'h09];LT9[8] =  lTable[d18[0]] + lTable[8'h0d];LT9[12] = lTable[d18[0]] + lTable[8'h0b];end
	    /* For b1 & b2*/
		if(d18[1] == 0)begin LT9[1] = 0;LT9[5] = 0;LT9[9] =0; LT9[13] = 0;end
		else begin LT9[1] = lTable[d18[1]] + lTable[8'h0b];LT9[5] = lTable[d18[1]] + lTable[8'h0e];LT9[9] = lTable[d18[1]] + lTable[8'h09]; LT9[13] = lTable[d18[1]] + lTable[8'h0d];end
	    /* For b3 & b4*/
		if(d18[2] == 0)begin LT9[2] = 0;LT9[6] = 0;LT9[10] = 0;LT9[14] = 0;end
		else begin LT9[2] = lTable[d18[2]] + lTable[8'h0d];LT9[6] = lTable[d18[2]] + lTable[8'h0b];LT9[10] = lTable[d18[2]] + lTable[8'h0e];LT9[14] = lTable[d18[2]] + lTable[8'h09];end
	    /* For b5 & b7*/			
		if(d18[3] == 0)begin LT9[3] = 0;LT9[7] = 0;LT9[11] = 0;LT9[15] = 0;end 
		else begin  LT9[3] = lTable[d18[3]] + lTable[8'h09];LT9[7] = lTable[d18[3]] + lTable[8'h0d];LT9[11] = lTable[d18[3]] + lTable[8'h0b];LT9[15] = lTable[d18[3]] + lTable[8'h0e];end
	    /* For b8 & b14 */				
		if(d18[4] == 0)begin LT9[16] = 0; LT9[20] = 0; LT9[24] = 0; LT9[28] = 0;end
		else begin LT9[16] = lTable[d18[4]] + lTable[8'h0e]; LT9[20] = lTable[d18[4]] + lTable[8'h09]; LT9[24] = lTable[d18[4]] + lTable[8'h0d]; LT9[28] = lTable[d18[4]] + lTable[8'h0b];end
		/* For b9 & b10 */
		if(d18[5] == 0)begin LT9[17] = 0;LT9[21] = 0; LT9[25] = 0;LT9[29] = 0;end
		else begin LT9[17] = lTable[d18[5]] + lTable[8'h0b];LT9[21] = lTable[d18[5]] + lTable[8'h0e]; LT9[25] = lTable[d18[5]] + lTable[8'h09];LT9[29] = lTable[d18[5]] + lTable[8'h0d];end
		/* For b11 & b12*/
		if(d18[6] == 0)begin LT9[18] = 0;LT9[22] = 0; LT9[26] = 0;LT9[30] = 0;end
		else begin LT9[18] = lTable[d18[6]] + lTable[8'h0d];LT9[22] = lTable[d18[6]] + lTable[8'h0b]; LT9[26] = lTable[d18[6]] + lTable[8'h0e];LT9[30] = lTable[d18[6]] + lTable[8'h09];end
		/* For b13 & b15 */
		if(d18[7] == 0)begin LT9[19] = 0;LT9[23] = 0; LT9[27] = 0;LT9[31] = 0;end
		else begin LT9[19] = lTable[d18[7]] + lTable[8'h09];LT9[23] = lTable[d18[7]] + lTable[8'h0d]; LT9[27] = lTable[d18[7]] + lTable[8'h0b];LT9[31] = lTable[d18[7]] + lTable[8'h0e];end
		/* For b16 & b22 */
		if(d18[8] == 0)begin LT9[32] = 0;LT9[36] = 0; LT9[40] = 0;LT9[44] = 0;end
		else begin LT9[32] = lTable[d18[8]] + lTable[8'h0e];LT9[36] = lTable[d18[8]] + lTable[8'h09];LT9[40] = lTable[d18[8]] + lTable[8'h0d];LT9[44] = lTable[d18[8]] + lTable[8'h0b];end
		/* For b17 & 18 */
		if(d18[9] == 0)begin LT9[33] = 0;LT9[37] = 0; LT9[41] = 0;LT9[45] = 0;end
		else begin LT9[33] = lTable[d18[9]] + lTable[8'h0b];LT9[37] = lTable[d18[9]] + lTable[8'h0e]; LT9[41] = lTable[d18[9]] + lTable[8'h09];LT9[45] = lTable[d18[9]] + lTable[8'h0d];end
		/* For b19 & b20 */
		if(d18[10] == 0)begin LT9[34] = 0;LT9[38] = 0;LT9[42] = 0;LT9[46] = 0;end
		else begin LT9[34] = lTable[d18[10]] + lTable[8'h0d];LT9[38] = lTable[d18[10]] + lTable[8'h0b];LT9[42] = lTable[d18[10]] + lTable[8'h0e];LT9[46] = lTable[d18[10]] + lTable[8'h09];end
		/* For b21 & b23 */
		if(d18[11] == 0)begin LT9[35] = 0; LT9[39] =0;LT9[43] = 0; LT9[47] =0;end
		else begin  LT9[35] = lTable[d18[11]] + lTable[8'h09]; LT9[39] =lTable[d18[11]] + lTable[8'h0d];LT9[43] = lTable[d18[11]] + lTable[8'h0b]; LT9[47] =lTable[d18[11]] + lTable[8'h0e];end	
		/* For b24 & b30 */
		if(d18[12] == 0)begin LT9[48] = 0;LT9[52] = 0; LT9[56] = 0;LT9[60] = 0;end 
		else begin LT9[48] = lTable[d18[12]] + lTable[8'h0e];LT9[52] = lTable[d18[12]] + lTable[8'h09]; LT9[56] = lTable[d18[12]] + lTable[8'h0d];LT9[60] = lTable[d18[12]] + lTable[8'h0b];end 		
		/* For b25 & b26 */		
		if(d18[13] == 0)begin LT9[49] = 0;LT9[53] = 0; LT9[57] = 0;LT9[61] = 0;end 
		else begin  LT9[49] = lTable[d18[13]] + lTable[8'h0b];LT9[53] = lTable[d18[13]] + lTable[8'h0e]; LT9[57] = lTable[d18[13]] + lTable[8'h09];LT9[61] = lTable[d18[13]] + lTable[8'h0d];end 
		/* For b27 & b28 */
		if(d18[14] == 0)begin LT9[50] = 0;LT9[54] = 0; LT9[58] = 0;LT9[62] = 0;end 
		else begin LT9[50] = lTable[d18[14]] + lTable[8'h0d];LT9[54] = lTable[d18[14]] + lTable[8'h0b]; LT9[58] = lTable[d18[14]] + lTable[8'h0e];LT9[62] = lTable[d18[14]] + lTable[8'h09];end 
		/* For b29 & b31 */
		if(d18[15] == 0)begin LT9[51] = 0;LT9[55] = 0; LT9[59] = 0;LT9[63] = 0;end 
		else begin LT9[51] = lTable[d18[15]] + lTable[8'h09];LT9[55] = lTable[d18[15]] + lTable[8'h0d]; LT9[59] = lTable[d18[15]] + lTable[8'h0b];LT9[63] = lTable[d18[15]] + lTable[8'h0e];end 

        next_state = 71;
    end
    71:begin
		if(LT9[0] > 255)begin l9[0] = LT9[0] - 255;end
		else begin l9[0] = LT9[0];end
		if(LT9[1] > 255)begin l9[1] = LT9[1] - 255;end
		else  begin l9[1] = LT9[1];end
		if(LT9[2] > 255)begin l9[2] = LT9[2] - 255;end
		else  begin l9[2] = LT9[2];end
		if(LT9[3] > 255)begin l9[3] = LT9[3] - 255;end
		else  begin l9[3] = LT9[3];end
		if(LT9[4] > 255)begin l9[4] = LT9[4] - 255;end
		else  begin l9[4] = LT9[4];end
		if(LT9[5] > 255)begin l9[5] = LT9[5] - 255;end
		else  begin l9[5] = LT9[5];end
		if(LT9[6] > 255)begin l9[6] = LT9[6] - 255;end
		else  begin l9[6] = LT9[6];end
		if(LT9[7] > 255)begin l9[7] = LT9[7] - 255;end
		else  begin l9[7] = LT9[7];end
		if(LT9[8] > 255)begin l9[8] = LT9[8] - 255;end
		else  begin l9[8] = LT9[8];end
		if(LT9[9] > 255)begin l9[9] = LT9[9] - 255;end
		else  begin l9[9] = LT9[9];end
		if(LT9[10] > 255)begin l9[10] = LT9[10] - 255;end
		else  begin l9[10] = LT9[10];end
		if(LT9[11] > 255)begin l9[11] = LT9[11] - 255;end
		else  begin l9[11] = LT9[11];end
		if(LT9[12] > 255)begin l9[12] = LT9[12] - 255;end
		else  begin l9[12] = LT9[12];end
		if(LT9[13] > 255)begin l9[13] = LT9[13] - 255;end
		else  begin l9[13] = LT9[13];end
		if(LT9[14] > 255)begin l9[14] = LT9[14] - 255;end
		else  begin l9[14] = LT9[14];end
		if(LT9[15] > 255)begin l9[15] = LT9[15] - 255;end
		else  begin l9[15] = LT9[15];end
		if(LT9[16] > 255)begin l9[16] = LT9[16] - 255;end
		else  begin l9[16] = LT9[16];end
		if(LT9[17] > 255)begin l9[17] = LT9[17] - 255;end
		else  begin l9[17] = LT9[17];end
		if(LT9[18] > 255)begin l9[18] = LT9[18] - 255;end
		else  begin l9[18] = LT9[18];end
		if(LT9[19] > 255)begin l9[19] = LT9[19] - 255;end
		else  begin l9[19] = LT9[19];end
		if(LT9[20] > 255)begin l9[20] = LT9[20] - 255;end
		else  begin l9[20] = LT9[20];end
		if(LT9[21] > 255)begin l9[21] = LT9[21] - 255;end
		else  begin l9[21] = LT9[21];end
		if(LT9[22] > 255)begin l9[22] = LT9[22] - 255;end
		else  begin l9[22] = LT9[22];end
		if(LT9[23] > 255)begin l9[23] = LT9[23] - 255;end
		else  begin l9[23] = LT9[23];end
		if(LT9[24] > 255)begin l9[24] = LT9[24] - 255;end
		else  begin l9[24] = LT9[24];end
		if(LT9[25] > 255)begin l9[25] = LT9[25] - 255;end
		else  begin l9[25] = LT9[25];end
		if(LT9[26] > 255)begin l9[26] = LT9[26] - 255;end
		else  begin l9[26] = LT9[26];end
		if(LT9[27] > 255)begin l9[27] = LT9[27] - 255;end
		else  begin l9[27] = LT9[27];end
		if(LT9[28] > 255)begin l9[28] = LT9[28] - 255;end
		else  begin l9[28] = LT9[28];end
		if(LT9[29] > 255)begin l9[29] = LT9[29] - 255;end
		else  begin l9[29] = LT9[29];end
		if(LT9[30] > 255)begin l9[30] = LT9[30] - 255;end
		else  begin l9[30] = LT9[30];end
		if(LT9[31] > 255)begin l9[31] = LT9[31] - 255;end
		else  begin l9[31] = LT9[31];end
		if(LT9[32] > 255)begin l9[32] = LT9[32] - 255;end
		else  begin l9[32] = LT9[32];end
		if(LT9[33] > 255)begin l9[33] = LT9[33] - 255;end
		else  begin l9[33] = LT9[33];end
		if(LT9[34] > 255)begin l9[34] = LT9[34] - 255;end
		else  begin l9[34] = LT9[34];end
		if(LT9[35] > 255)begin l9[35] = LT9[35] - 255;end
		else  begin l9[35] = LT9[35];end
		if(LT9[36] > 255)begin l9[36] = LT9[36] - 255;end
		else  begin l9[36] = LT9[36];end
		if(LT9[37] > 255)begin l9[37] = LT9[37] - 255;end
		else  begin l9[37] = LT9[37];end
		if(LT9[38] > 255)begin l9[38] = LT9[38] - 255;end
		else  begin l9[38] = LT9[38];end
		if(LT9[39] > 255)begin l9[39] = LT9[39] - 255;end
		else  begin l9[39] = LT9[39];end
		if(LT9[40] > 255)begin l9[40] = LT9[40] - 255;end
		else  begin l9[40] = LT9[40];end
		if(LT9[41] > 255)begin l9[41] = LT9[41] - 255;end
		else  begin l9[41] = LT9[41];end
		if(LT9[42] > 255)begin l9[42] = LT9[42] - 255;end
		else  begin l9[42] = LT9[42];end
		if(LT9[43] > 255)begin l9[43] = LT9[43] - 255;end
		else  begin l9[43] = LT9[43];end
		if(LT9[44] > 255)begin l9[44] = LT9[44] - 255;end
		else  begin l9[44] = LT9[44];end
		if(LT9[45] > 255)begin l9[45] = LT9[45] - 255;end
		else  begin l9[45] = LT9[45];end
		if(LT9[46] > 255)begin l9[46] = LT9[46] - 255;end
		else  begin l9[46] = LT9[46];end
		if(LT9[47] > 255)begin l9[47] = LT9[47] - 255;end
		else  begin l9[47] = LT9[47];end
		if(LT9[48] > 255)begin l9[48] = LT9[48] - 255;end
		else  begin l9[48] = LT9[48];end
		if(LT9[49] > 255)begin l9[49] = LT9[49] - 255;end
		else  begin l9[49] = LT9[49];end
		if(LT9[50] > 255)begin l9[50] = LT9[50] - 255;end
		else  begin l9[50] = LT9[50];end
		if(LT9[51] > 255)begin l9[51] = LT9[51] - 255;end
		else  begin l9[51] = LT9[51];end
		if(LT9[52] > 255)begin l9[52] = LT9[52] - 255;end
		else  begin l9[52] = LT9[52];end
		if(LT9[53] > 255)begin l9[53] = LT9[53] - 255;end
		else  begin l9[53] = LT9[53];end
		if(LT9[54] > 255)begin l9[54] = LT9[54] - 255;end
		else  begin l9[54] = LT9[54];end
		if(LT9[55] > 255)begin l9[55] = LT9[55] - 255;end
		else  begin l9[55] = LT9[55];end
		if(LT9[56] > 255)begin l9[56] = LT9[56] - 255;end
		else  begin l9[56] = LT9[56];end
		if(LT9[57] > 255)begin l9[57] = LT9[57] - 255;end
		else  begin l9[57] = LT9[57];end
		if(LT9[58] > 255)begin l9[58] = LT9[58] - 255;end
		else  begin l9[58] = LT9[58];end
		if(LT9[59] > 255)begin l9[59] = LT9[59] - 255;end
		else  begin l9[59] = LT9[59];end
		if(LT9[60] > 255)begin l9[60] = LT9[60] - 255;end
		else  begin l9[60] = LT9[60];end
		if(LT9[61] > 255)begin l9[61] = LT9[61] - 255;end
		else  begin l9[61] = LT9[61];end
		if(LT9[62] > 255)begin l9[62] = LT9[62] - 255;end
		else  begin l9[62] = LT9[62];end
		if(LT9[63] > 255)begin l9[63] = LT9[63] - 255;end
		else  begin l9[63] = LT9[63];end		
		next_state = 72;
	end
	72:begin
		/* for d0 */
		if(l9[0] == 0)begin ET9[0] = 0;end
		else begin ET9[0] = eTable[l9[0]];end
		if(l9[1] == 0)begin ET9[1] = 0;end
		else begin ET9[1] = eTable[l9[1]];end
		/* for d18 */
		if(l9[2] == 0)begin ET9[2] = 0;end
		else begin ET9[2] = eTable[l9[2]];end
		if(l9[3] == 0)begin ET9[3] = 0;end
		else begin ET9[3] = eTable[l9[3]];end
		/* for d18 */
		if(l9[4] == 0)begin ET9[4] = 0;end
		else begin ET9[4] = eTable[l9[4]];end
		if(l9[5] == 0)begin ET9[5] = 0;end
		else begin ET9[5] = eTable[l9[5]];end
		/* for d3 */
		if(l9[6] == 0)begin ET9[6] = 0;end
		else begin ET9[6] = eTable[l9[6]];end
		if(l9[7] == 0)begin ET9[7] = 0;end
		else begin ET9[7] = eTable[l9[7]];end
		/* for d18 */
		if(l9[8] == 0)begin ET9[8] = 0;end
		else begin ET9[8] = eTable[l9[8]];end
		if(l9[9] == 0)begin ET9[9] = 0;end
		else begin ET9[9] = eTable[l9[9]];end
		/* for d18 */
		if(l9[10] == 0)begin ET9[10] = 0;end
		else begin ET9[10] = eTable[l9[10]];end
		if(l9[11] == 0)begin ET9[11] = 0;end
		else begin ET9[11] = eTable[l9[11]];end
		/* for d18 */
		if(l9[12] == 0)begin ET9[12] = 0;end
		else begin ET9[12] = eTable[l9[12]];end
		if(l9[13] == 0)begin ET9[13] = 0;end
		else begin ET9[13] = eTable[l9[13]];end
		/* for d7 */
		if(l9[14] == 0)begin ET9[14] = 0;end
		else begin ET9[14] = eTable[l9[14]];end
		if(l9[15] == 0)begin ET9[15] = 0;end
		else begin ET9[15] = eTable[l9[15]];end
		/* for d18 */
		if(l9[16] == 0)begin ET9[16] = 0;end
		else begin ET9[16] = eTable[l9[16]];end
		if(l9[17] == 0)begin ET9[17] = 0;end
		else begin ET9[17] = eTable[l9[17]];end
		/* for d19 */
		if(l9[18] == 0)begin ET9[18] = 0;end
		else begin ET9[18] = eTable[l9[18]];end
		if(l9[19] == 0)begin ET9[19] = 0;end
		else begin ET9[19] = eTable[l9[19]];end
		/* for d18 */
		if(l9[20] == 0)begin ET9[20] = 0;end
		else begin ET9[20] = eTable[l9[20]];end
		if(l9[21] == 0)begin ET9[21] = 0;end
		else begin ET9[21] = eTable[l9[21]];end
		/* for d19 */
		if(l9[22] == 0)begin ET9[22] = 0;end
		else begin ET9[22] = eTable[l9[22]];end
		if(l9[23] == 0)begin ET9[23] = 0;end
		else begin ET9[23] = eTable[l9[23]];end
		/* for d18 */
		if(l9[24] == 0)begin ET9[24] = 0;end
		else begin ET9[24] = eTable[l9[24]];end
		if(l9[25] == 0)begin ET9[25] = 0;end
		else begin ET9[25] = eTable[l9[25]];end
		/* for d19 */
		if(l9[26] == 0)begin ET9[26] = 0;end
		else begin ET9[26] = eTable[l9[26]];end
		if(l9[27] == 0)begin ET9[27] = 0;end
		else begin ET9[27] = eTable[l9[27]];end
		/* for d18 */
		if(l9[28] == 0)begin ET9[28] = 0;end
		else begin ET9[28] = eTable[l9[28]];end
		if(l9[29] == 0)begin ET9[29] = 0;end
		else begin ET9[29] = eTable[l9[29]];end
		/* for d19 */
		if(l9[30] == 0)begin ET9[30] = 0;end
		else begin ET9[30] = eTable[l9[30]];end
		if(l9[31] == 0)begin ET9[31] = 0;end
		else begin ET9[31] = eTable[l9[31]];end
		if(l9[32] == 0)begin ET9[32] = 0;end
		else begin ET9[32] = eTable[l9[32]];end
		if(l9[33] == 0)begin ET9[33] = 0;end
		else begin ET9[33] = eTable[l9[33]];end
		if(l9[34] == 0)begin ET9[34] = 0;end
		else begin ET9[34] = eTable[l9[34]];end
		if(l9[35] == 0)begin ET9[35] = 0;end
		else begin ET9[35] = eTable[l9[35]];end
		if(l9[36] == 0)begin ET9[36] = 0;end
		else begin ET9[36] = eTable[l9[36]];end
		if(l9[37] == 0)begin ET9[37] = 0;end
		else begin ET9[37] = eTable[l9[37]];end
		if(l9[38] == 0)begin ET9[38] = 0;end
		else begin ET9[38] = eTable[l9[38]];end
		if(l9[39] == 0)begin ET9[39] = 0;end
		else begin ET9[39] = eTable[l9[39]];end
		if(l9[40] == 0)begin ET9[40] = 0;end
		else begin ET9[40] = eTable[l9[40]];end
		if(l9[41] == 0)begin ET9[41] = 0;end
		else begin ET9[41] = eTable[l9[41]];end
		if(l9[42] == 0)begin ET9[42] = 0;end
		else begin ET9[42] = eTable[l9[42]];end
		if(l9[43] == 0)begin ET9[43] = 0;end
		else begin ET9[43] = eTable[l9[43]];end
		if(l9[44] == 0)begin ET9[44] = 0;end
		else begin ET9[44] = eTable[l9[44]];end
		if(l9[45] == 0)begin ET9[45] = 0;end
		else begin ET9[45] = eTable[l9[45]];end
		if(l9[46] == 0)begin ET9[46] = 0;end
		else begin ET9[46] = eTable[l9[46]];end
		if(l9[47] == 0)begin ET9[47] = 0;end
		else begin ET9[47] = eTable[l9[47]];end
		if(l9[48] == 0)begin ET9[48] = 0;end
		else begin ET9[48] = eTable[l9[48]];end
		if(l9[49] == 0)begin ET9[49] = 0;end
		else begin ET9[49] = eTable[l9[49]];end
		if(l9[50] == 0)begin ET9[50] = 0;end
		else begin ET9[50] = eTable[l9[50]];end		
		if(l9[51] == 0)begin ET9[51] = 0;end
		else begin ET9[51] = eTable[l9[51]];end
		if(l9[52] == 0)begin ET9[52] = 0;end
		else begin ET9[52] = eTable[l9[52]];end
		if(l9[53] == 0)begin ET9[53] = 0;end
		else begin ET9[53] = eTable[l9[53]];end
		if(l9[54] == 0)begin ET9[54] = 0;end
		else begin ET9[54] = eTable[l9[54]];end
		if(l9[55] == 0)begin ET9[55] = 0;end
		else begin ET9[55] = eTable[l9[55]];end
		if(l9[56] == 0)begin ET9[56] = 0;end
		else begin ET9[56] = eTable[l9[56]];end
		if(l9[57] == 0)begin ET9[57] = 0;end
		else begin ET9[57] = eTable[l9[57]];end
		if(l9[58] == 0)begin ET9[58] = 0;end
		else begin ET9[58] = eTable[l9[58]];end
		if(l9[59] == 0)begin ET9[59] = 0;end
		else begin ET9[59] = eTable[l9[59]];end
		if(l9[60] == 0)begin ET9[60] = 0;end
		else begin ET9[60] = eTable[l9[60]];end	
		if(l9[61] == 0)begin ET9[61] = 0;end
		else begin ET9[61] = eTable[l9[61]];end
		if(l9[62] == 0)begin ET9[62] = 0;end
		else begin ET9[62] = eTable[l9[62]];end
		if(l9[63] == 0)begin ET9[63] = 0;end
		else begin ET9[63] = eTable[l9[63]];end
		next_state = 73;
	end
    73:begin
        d19[0] = ET9[0]^ET9[1]^ET9[2]^ET9[3];
        d19[1] = ET9[4]^ET9[5]^ET9[6]^ET9[7];
        d19[2] = ET9[8]^ET9[9]^ET9[10]^ET9[11];
        d19[3] = ET9[12]^ET9[13]^ET9[14]^ET9[15];
        d19[4] = ET9[16]^ET9[17]^ET9[18]^ET9[19];
        d19[5] = ET9[20]^ET9[21]^ET9[22]^ET9[23];
        d19[6] = ET9[24]^ET9[25]^ET9[26]^ET9[27];
        d19[7] = ET9[28]^ET9[29]^ET9[30]^ET9[31];
        d19[8] = ET9[32]^ET9[33]^ET9[34]^ET9[35];
        d19[9] = ET9[36]^ET9[37]^ET9[38]^ET9[39];
        d19[10] = ET9[40]^ET9[41]^ET9[42]^ET9[43];
        d19[11] = ET9[44]^ET9[45]^ET9[46]^ET9[47];
        d19[12] = ET9[48]^ET9[49]^ET9[50]^ET9[51];
        d19[13] = ET9[52]^ET9[53]^ET9[54]^ET9[55];
        d19[14] = ET9[56]^ET9[57]^ET9[58]^ET9[59];
        d19[15] =ET9[60]^ET9[61]^ET9[62]^ET9[63]; 
        next_state = 74;
    end
	74:begin
        tempRow10[0] = d19[0];tempRow10[4] = d19[4];tempRow10[8] = d19[8];tempRow10[12] = d19[12];
        tempRow10[1] = d19[13];tempRow10[5] = d19[1];tempRow10[9] = d19[5];tempRow10[13] = d19[9];
        tempRow10[2] = d19[10];tempRow10[6] = d19[14];tempRow10[10] = d19[2];tempRow10[14] = d19[6];
        tempRow10[3] = d19[7];tempRow10[7] = d19[11];tempRow10[11] = d19[15];tempRow10[15] = d19[3];
        next_state = 75;
	end
	75:begin
        tempSbox10[0] = inv_sbox[tempRow10[0]];tempSbox10[1] = inv_sbox[tempRow10[1]];tempSbox10[2] = inv_sbox[tempRow10[2]];tempSbox10[3] = inv_sbox[tempRow10[3]];
        tempSbox10[4] = inv_sbox[tempRow10[4]];tempSbox10[5] = inv_sbox[tempRow10[5]];tempSbox10[6] = inv_sbox[tempRow10[6]];tempSbox10[7] = inv_sbox[tempRow10[7]];
        tempSbox10[8] = inv_sbox[tempRow10[8]];tempSbox10[9] = inv_sbox[tempRow10[9]];tempSbox10[10] = inv_sbox[tempRow10[10]];tempSbox10[11] = inv_sbox[tempRow10[11]];
        tempSbox10[12] = inv_sbox[tempRow10[12]];tempSbox10[13] = inv_sbox[tempRow10[13]];tempSbox10[14] = inv_sbox[tempRow10[14]];tempSbox10[15] = inv_sbox[tempRow10[15]];
		next_state = 76;
	end
	76:begin
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
		next_state = 77;
	end
	77:begin 
	    /* For b0 & b4*/
		if(d20[0] == 0)begin LT10[0] = 0; LT10[4] = 0; LT10[8] = 0; LT10[12] = 0 ;end
		else begin LT10[0] = lTable[d20[0]] + lTable[8'h0e];LT10[4] = lTable[d20[0]] + lTable[8'h09];LT10[8] =  lTable[d20[0]] + lTable[8'h0d];LT10[12] = lTable[d20[0]] + lTable[8'h0b];end
	    /* For b1 & b2*/
		if(d20[1] == 0)begin LT10[1] = 0;LT10[5] = 0;LT10[9] =0; LT10[13] = 0;end
		else begin LT10[1] = lTable[d20[1]] + lTable[8'h0b];LT10[5] = lTable[d20[1]] + lTable[8'h0e];LT10[9] = lTable[d20[1]] + lTable[8'h09]; LT10[13] = lTable[d20[1]] + lTable[8'h0d];end
	    /* For b3 & b4*/
		if(d20[2] == 0)begin LT10[2] = 0;LT10[6] = 0;LT10[10] = 0;LT10[14] = 0;end
		else begin LT10[2] = lTable[d20[2]] + lTable[8'h0d];LT10[6] = lTable[d20[2]] + lTable[8'h0b];LT10[10] = lTable[d20[2]] + lTable[8'h0e];LT10[14] = lTable[d20[2]] + lTable[8'h09];end
	    /* For b5 & b7*/			
		if(d20[3] == 0)begin LT10[3] = 0;LT10[7] = 0;LT10[11] = 0;LT10[15] = 0;end 
		else begin  LT10[3] = lTable[d20[3]] + lTable[8'h09];LT10[7] = lTable[d20[3]] + lTable[8'h0d];LT10[11] = lTable[d20[3]] + lTable[8'h0b];LT10[15] = lTable[d20[3]] + lTable[8'h0e];end
	    /* For b8 & b14 */				
		if(d20[4] == 0)begin LT10[16] = 0; LT10[20] = 0; LT10[24] = 0; LT10[28] = 0;end
		else begin LT10[16] = lTable[d20[4]] + lTable[8'h0e]; LT10[20] = lTable[d20[4]] + lTable[8'h09]; LT10[24] = lTable[d20[4]] + lTable[8'h0d]; LT10[28] = lTable[d20[4]] + lTable[8'h0b];end
		/* For b9 & b10 */
		if(d20[5] == 0)begin LT10[17] = 0;LT10[21] = 0; LT10[25] = 0;LT10[29] = 0;end
		else begin LT10[17] = lTable[d20[5]] + lTable[8'h0b];LT10[21] = lTable[d20[5]] + lTable[8'h0e]; LT10[25] = lTable[d20[5]] + lTable[8'h09];LT10[29] = lTable[d20[5]] + lTable[8'h0d];end
		/* For b11 & b12*/
		if(d20[6] == 0)begin LT10[18] = 0;LT10[22] = 0; LT10[26] = 0;LT10[30] = 0;end
		else begin LT10[18] = lTable[d20[6]] + lTable[8'h0d];LT10[22] = lTable[d20[6]] + lTable[8'h0b]; LT10[26] = lTable[d20[6]] + lTable[8'h0e];LT10[30] = lTable[d20[6]] + lTable[8'h09];end
		/* For b13 & b15 */
		if(d20[7] == 0)begin LT10[19] = 0;LT10[23] = 0; LT10[27] = 0;LT10[31] = 0;end
		else begin LT10[19] = lTable[d20[7]] + lTable[8'h09];LT10[23] = lTable[d20[7]] + lTable[8'h0d]; LT10[27] = lTable[d20[7]] + lTable[8'h0b];LT10[31] = lTable[d20[7]] + lTable[8'h0e];end
		/* For b16 & b22 */
		if(d20[8] == 0)begin LT10[32] = 0;LT10[36] = 0; LT10[40] = 0;LT10[44] = 0;end
		else begin LT10[32] = lTable[d20[8]] + lTable[8'h0e];LT10[36] = lTable[d20[8]] + lTable[8'h09];LT10[40] = lTable[d20[8]] + lTable[8'h0d];LT10[44] = lTable[d20[8]] + lTable[8'h0b];end
		/* For b17 & 18 */
		if(d20[9] == 0)begin LT10[33] = 0;LT10[37] = 0; LT10[41] = 0;LT10[45] = 0;end
		else begin LT10[33] = lTable[d20[9]] + lTable[8'h0b];LT10[37] = lTable[d20[9]] + lTable[8'h0e]; LT10[41] = lTable[d20[9]] + lTable[8'h09];LT10[45] = lTable[d20[9]] + lTable[8'h0d];end
		/* For b19 & b20 */
		if(d20[10] == 0)begin LT10[34] = 0;LT10[38] = 0;LT10[42] = 0;LT10[46] = 0;end
		else begin LT10[34] = lTable[d20[10]] + lTable[8'h0d];LT10[38] = lTable[d20[10]] + lTable[8'h0b];LT10[42] = lTable[d20[10]] + lTable[8'h0e];LT10[46] = lTable[d20[10]] + lTable[8'h09];end
		/* For b21 & b23 */
		if(d20[11] == 0)begin LT10[35] = 0; LT10[39] =0;LT10[43] = 0; LT10[47] =0;end
		else begin  LT10[35] = lTable[d20[11]] + lTable[8'h09]; LT10[39] =lTable[d20[11]] + lTable[8'h0d];LT10[43] = lTable[d20[11]] + lTable[8'h0b]; LT10[47] =lTable[d20[11]] + lTable[8'h0e];end	
		/* For b24 & b30 */
		if(d20[12] == 0)begin LT10[48] = 0;LT10[52] = 0; LT10[56] = 0;LT10[60] = 0;end 
		else begin LT10[48] = lTable[d20[12]] + lTable[8'h0e];LT10[52] = lTable[d20[12]] + lTable[8'h09]; LT10[56] = lTable[d20[12]] + lTable[8'h0d];LT10[60] = lTable[d20[12]] + lTable[8'h0b];end 		
		/* For b25 & b26 */		
		if(d20[13] == 0)begin LT10[49] = 0;LT10[53] = 0; LT10[57] = 0;LT10[61] = 0;end 
		else begin  LT10[49] = lTable[d20[13]] + lTable[8'h0b];LT10[53] = lTable[d20[13]] + lTable[8'h0e]; LT10[57] = lTable[d20[13]] + lTable[8'h09];LT10[61] = lTable[d20[13]] + lTable[8'h0d];end 
		/* For b27 & b28 */
		if(d20[14] == 0)begin LT10[50] = 0;LT10[54] = 0; LT10[58] = 0;LT10[62] = 0;end 
		else begin LT10[50] = lTable[d20[14]] + lTable[8'h0d];LT10[54] = lTable[d20[14]] + lTable[8'h0b]; LT10[58] = lTable[d20[14]] + lTable[8'h0e];LT10[62] = lTable[d20[14]] + lTable[8'h09];end 
		/* For b29 & b31 */
		if(d20[15] == 0)begin LT10[51] = 0;LT10[55] = 0; LT10[59] = 0;LT10[63] = 0;end 
		else begin LT10[51] = lTable[d20[15]] + lTable[8'h09];LT10[55] = lTable[d20[15]] + lTable[8'h0d]; LT10[59] = lTable[d20[15]] + lTable[8'h0b];LT10[63] = lTable[d20[15]] + lTable[8'h0e];end 

        next_state = 78;
    end
    78:begin
		if(LT10[0] > 255)begin l10[0] = LT10[0] - 255;end
		else begin l10[0] = LT10[0];end
		if(LT10[1] > 255)begin l10[1] = LT10[1] - 255;end
		else  begin l10[1] = LT10[1];end
		if(LT10[2] > 255)begin l10[2] = LT10[2] - 255;end
		else  begin l10[2] = LT10[2];end
		if(LT10[3] > 255)begin l10[3] = LT10[3] - 255;end
		else  begin l10[3] = LT10[3];end
		if(LT10[4] > 255)begin l10[4] = LT10[4] - 255;end
		else  begin l10[4] = LT10[4];end
		if(LT10[5] > 255)begin l10[5] = LT10[5] - 255;end
		else  begin l10[5] = LT10[5];end
		if(LT10[6] > 255)begin l10[6] = LT10[6] - 255;end
		else  begin l10[6] = LT10[6];end
		if(LT10[7] > 255)begin l10[7] = LT10[7] - 255;end
		else  begin l10[7] = LT10[7];end
		if(LT10[8] > 255)begin l10[8] = LT10[8] - 255;end
		else  begin l10[8] = LT10[8];end
		if(LT10[9] > 255)begin l10[9] = LT10[9] - 255;end
		else  begin l10[9] = LT10[9];end
		if(LT10[10] > 255)begin l10[10] = LT10[10] - 255;end
		else  begin l10[10] = LT10[10];end
		if(LT10[11] > 255)begin l10[11] = LT10[11] - 255;end
		else  begin l10[11] = LT10[11];end
		if(LT10[12] > 255)begin l10[12] = LT10[12] - 255;end
		else  begin l10[12] = LT10[12];end
		if(LT10[13] > 255)begin l10[13] = LT10[13] - 255;end
		else  begin l10[13] = LT10[13];end
		if(LT10[14] > 255)begin l10[14] = LT10[14] - 255;end
		else  begin l10[14] = LT10[14];end
		if(LT10[15] > 255)begin l10[15] = LT10[15] - 255;end
		else  begin l10[15] = LT10[15];end
		if(LT10[16] > 255)begin l10[16] = LT10[16] - 255;end
		else  begin l10[16] = LT10[16];end
		if(LT10[17] > 255)begin l10[17] = LT10[17] - 255;end
		else  begin l10[17] = LT10[17];end
		if(LT10[18] > 255)begin l10[18] = LT10[18] - 255;end
		else  begin l10[18] = LT10[18];end
		if(LT10[19] > 255)begin l10[19] = LT10[19] - 255;end
		else  begin l10[19] = LT10[19];end
		if(LT10[20] > 255)begin l10[20] = LT10[20] - 255;end
		else  begin l10[20] = LT10[20];end
		if(LT10[21] > 255)begin l10[21] = LT10[21] - 255;end
		else  begin l10[21] = LT10[21];end
		if(LT10[22] > 255)begin l10[22] = LT10[22] - 255;end
		else  begin l10[22] = LT10[22];end
		if(LT10[23] > 255)begin l10[23] = LT10[23] - 255;end
		else  begin l10[23] = LT10[23];end
		if(LT10[24] > 255)begin l10[24] = LT10[24] - 255;end
		else  begin l10[24] = LT10[24];end
		if(LT10[25] > 255)begin l10[25] = LT10[25] - 255;end
		else  begin l10[25] = LT10[25];end
		if(LT10[26] > 255)begin l10[26] = LT10[26] - 255;end
		else  begin l10[26] = LT10[26];end
		if(LT10[27] > 255)begin l10[27] = LT10[27] - 255;end
		else  begin l10[27] = LT10[27];end
		if(LT10[28] > 255)begin l10[28] = LT10[28] - 255;end
		else  begin l10[28] = LT10[28];end
		if(LT10[29] > 255)begin l10[29] = LT10[29] - 255;end
		else  begin l10[29] = LT10[29];end
		if(LT10[30] > 255)begin l10[30] = LT10[30] - 255;end
		else  begin l10[30] = LT10[30];end
		if(LT10[31] > 255)begin l10[31] = LT10[31] - 255;end
		else  begin l10[31] = LT10[31];end
		if(LT10[32] > 255)begin l10[32] = LT10[32] - 255;end
		else  begin l10[32] = LT10[32];end
		if(LT10[33] > 255)begin l10[33] = LT10[33] - 255;end
		else  begin l10[33] = LT10[33];end
		if(LT10[34] > 255)begin l10[34] = LT10[34] - 255;end
		else  begin l10[34] = LT10[34];end
		if(LT10[35] > 255)begin l10[35] = LT10[35] - 255;end
		else  begin l10[35] = LT10[35];end
		if(LT10[36] > 255)begin l10[36] = LT10[36] - 255;end
		else  begin l10[36] = LT10[36];end
		if(LT10[37] > 255)begin l10[37] = LT10[37] - 255;end
		else  begin l10[37] = LT10[37];end
		if(LT10[38] > 255)begin l10[38] = LT10[38] - 255;end
		else  begin l10[38] = LT10[38];end
		if(LT10[39] > 255)begin l10[39] = LT10[39] - 255;end
		else  begin l10[39] = LT10[39];end
		if(LT10[40] > 255)begin l10[40] = LT10[40] - 255;end
		else  begin l10[40] = LT10[40];end
		if(LT10[41] > 255)begin l10[41] = LT10[41] - 255;end
		else  begin l10[41] = LT10[41];end
		if(LT10[42] > 255)begin l10[42] = LT10[42] - 255;end
		else  begin l10[42] = LT10[42];end
		if(LT10[43] > 255)begin l10[43] = LT10[43] - 255;end
		else  begin l10[43] = LT10[43];end
		if(LT10[44] > 255)begin l10[44] = LT10[44] - 255;end
		else  begin l10[44] = LT10[44];end
		if(LT10[45] > 255)begin l10[45] = LT10[45] - 255;end
		else  begin l10[45] = LT10[45];end
		if(LT10[46] > 255)begin l10[46] = LT10[46] - 255;end
		else  begin l10[46] = LT10[46];end
		if(LT10[47] > 255)begin l10[47] = LT10[47] - 255;end
		else  begin l10[47] = LT10[47];end
		if(LT10[48] > 255)begin l10[48] = LT10[48] - 255;end
		else  begin l10[48] = LT10[48];end
		if(LT10[49] > 255)begin l10[49] = LT10[49] - 255;end
		else  begin l10[49] = LT10[49];end
		if(LT10[50] > 255)begin l10[50] = LT10[50] - 255;end
		else  begin l10[50] = LT10[50];end
		if(LT10[51] > 255)begin l10[51] = LT10[51] - 255;end
		else  begin l10[51] = LT10[51];end
		if(LT10[52] > 255)begin l10[52] = LT10[52] - 255;end
		else  begin l10[52] = LT10[52];end
		if(LT10[53] > 255)begin l10[53] = LT10[53] - 255;end
		else  begin l10[53] = LT10[53];end
		if(LT10[54] > 255)begin l10[54] = LT10[54] - 255;end
		else  begin l10[54] = LT10[54];end
		if(LT10[55] > 255)begin l10[55] = LT10[55] - 255;end
		else  begin l10[55] = LT10[55];end
		if(LT10[56] > 255)begin l10[56] = LT10[56] - 255;end
		else  begin l10[56] = LT10[56];end
		if(LT10[57] > 255)begin l10[57] = LT10[57] - 255;end
		else  begin l10[57] = LT10[57];end
		if(LT10[58] > 255)begin l10[58] = LT10[58] - 255;end
		else  begin l10[58] = LT10[58];end
		if(LT10[59] > 255)begin l10[59] = LT10[59] - 255;end
		else  begin l10[59] = LT10[59];end
		if(LT10[60] > 255)begin l10[60] = LT10[60] - 255;end
		else  begin l10[60] = LT10[60];end
		if(LT10[61] > 255)begin l10[61] = LT10[61] - 255;end
		else  begin l10[61] = LT10[61];end
		if(LT10[62] > 255)begin l10[62] = LT10[62] - 255;end
		else  begin l10[62] = LT10[62];end
		if(LT10[63] > 255)begin l10[63] = LT10[63] - 255;end
		else  begin l10[63] = LT10[63];end		
		next_state = 79;
	end
	79:begin
		/* for d0 */
		if(l10[0] == 0)begin ET10[0] = 0;end
		else begin ET10[0] = eTable[l10[0]];end
		if(l10[1] == 0)begin ET10[1] = 0;end
		else begin ET10[1] = eTable[l10[1]];end
		/* for d20 */
		if(l10[2] == 0)begin ET10[2] = 0;end
		else begin ET10[2] = eTable[l10[2]];end
		if(l10[3] == 0)begin ET10[3] = 0;end
		else begin ET10[3] = eTable[l10[3]];end
		/* for d20 */
		if(l10[4] == 0)begin ET10[4] = 0;end
		else begin ET10[4] = eTable[l10[4]];end
		if(l10[5] == 0)begin ET10[5] = 0;end
		else begin ET10[5] = eTable[l10[5]];end
		/* for d3 */
		if(l10[6] == 0)begin ET10[6] = 0;end
		else begin ET10[6] = eTable[l10[6]];end
		if(l10[7] == 0)begin ET10[7] = 0;end
		else begin ET10[7] = eTable[l10[7]];end
		/* for d20 */
		if(l10[8] == 0)begin ET10[8] = 0;end
		else begin ET10[8] = eTable[l10[8]];end
		if(l10[9] == 0)begin ET10[9] = 0;end
		else begin ET10[9] = eTable[l10[9]];end
		/* for d20 */
		if(l10[10] == 0)begin ET10[10] = 0;end
		else begin ET10[10] = eTable[l10[10]];end
		if(l10[11] == 0)begin ET10[11] = 0;end
		else begin ET10[11] = eTable[l10[11]];end
		/* for d20 */
		if(l10[12] == 0)begin ET10[12] = 0;end
		else begin ET10[12] = eTable[l10[12]];end
		if(l10[13] == 0)begin ET10[13] = 0;end
		else begin ET10[13] = eTable[l10[13]];end
		/* for d7 */
		if(l10[14] == 0)begin ET10[14] = 0;end
		else begin ET10[14] = eTable[l10[14]];end
		if(l10[15] == 0)begin ET10[15] = 0;end
		else begin ET10[15] = eTable[l10[15]];end
		/* for d20 */
		if(l10[16] == 0)begin ET10[16] = 0;end
		else begin ET10[16] = eTable[l10[16]];end
		if(l10[17] == 0)begin ET10[17] = 0;end
		else begin ET10[17] = eTable[l10[17]];end
		/* for d21 */
		if(l10[18] == 0)begin ET10[18] = 0;end
		else begin ET10[18] = eTable[l10[18]];end
		if(l10[19] == 0)begin ET10[19] = 0;end
		else begin ET10[19] = eTable[l10[19]];end
		/* for d20 */
		if(l10[20] == 0)begin ET10[20] = 0;end
		else begin ET10[20] = eTable[l10[20]];end
		if(l10[21] == 0)begin ET10[21] = 0;end
		else begin ET10[21] = eTable[l10[21]];end
		/* for d21 */
		if(l10[22] == 0)begin ET10[22] = 0;end
		else begin ET10[22] = eTable[l10[22]];end
		if(l10[23] == 0)begin ET10[23] = 0;end
		else begin ET10[23] = eTable[l10[23]];end
		/* for d20 */
		if(l10[24] == 0)begin ET10[24] = 0;end
		else begin ET10[24] = eTable[l10[24]];end
		if(l10[25] == 0)begin ET10[25] = 0;end
		else begin ET10[25] = eTable[l10[25]];end
		/* for d21 */
		if(l10[26] == 0)begin ET10[26] = 0;end
		else begin ET10[26] = eTable[l10[26]];end
		if(l10[27] == 0)begin ET10[27] = 0;end
		else begin ET10[27] = eTable[l10[27]];end
		/* for d20 */
		if(l10[28] == 0)begin ET10[28] = 0;end
		else begin ET10[28] = eTable[l10[28]];end
		if(l10[29] == 0)begin ET10[29] = 0;end
		else begin ET10[29] = eTable[l10[29]];end
		/* for d21 */
		if(l10[30] == 0)begin ET10[30] = 0;end
		else begin ET10[30] = eTable[l10[30]];end
		if(l10[31] == 0)begin ET10[31] = 0;end
		else begin ET10[31] = eTable[l10[31]];end
		if(l10[32] == 0)begin ET10[32] = 0;end
		else begin ET10[32] = eTable[l10[32]];end
		if(l10[33] == 0)begin ET10[33] = 0;end
		else begin ET10[33] = eTable[l10[33]];end
		if(l10[34] == 0)begin ET10[34] = 0;end
		else begin ET10[34] = eTable[l10[34]];end
		if(l10[35] == 0)begin ET10[35] = 0;end
		else begin ET10[35] = eTable[l10[35]];end
		if(l10[36] == 0)begin ET10[36] = 0;end
		else begin ET10[36] = eTable[l10[36]];end
		if(l10[37] == 0)begin ET10[37] = 0;end
		else begin ET10[37] = eTable[l10[37]];end
		if(l10[38] == 0)begin ET10[38] = 0;end
		else begin ET10[38] = eTable[l10[38]];end
		if(l10[39] == 0)begin ET10[39] = 0;end
		else begin ET10[39] = eTable[l10[39]];end
		if(l10[40] == 0)begin ET10[40] = 0;end
		else begin ET10[40] = eTable[l10[40]];end
		if(l10[41] == 0)begin ET10[41] = 0;end
		else begin ET10[41] = eTable[l10[41]];end
		if(l10[42] == 0)begin ET10[42] = 0;end
		else begin ET10[42] = eTable[l10[42]];end
		if(l10[43] == 0)begin ET10[43] = 0;end
		else begin ET10[43] = eTable[l10[43]];end
		if(l10[44] == 0)begin ET10[44] = 0;end
		else begin ET10[44] = eTable[l10[44]];end
		if(l10[45] == 0)begin ET10[45] = 0;end
		else begin ET10[45] = eTable[l10[45]];end
		if(l10[46] == 0)begin ET10[46] = 0;end
		else begin ET10[46] = eTable[l10[46]];end
		if(l10[47] == 0)begin ET10[47] = 0;end
		else begin ET10[47] = eTable[l10[47]];end
		if(l10[48] == 0)begin ET10[48] = 0;end
		else begin ET10[48] = eTable[l10[48]];end
		if(l10[49] == 0)begin ET10[49] = 0;end
		else begin ET10[49] = eTable[l10[49]];end
		if(l10[50] == 0)begin ET10[50] = 0;end
		else begin ET10[50] = eTable[l10[50]];end		
		if(l10[51] == 0)begin ET10[51] = 0;end
		else begin ET10[51] = eTable[l10[51]];end
		if(l10[52] == 0)begin ET10[52] = 0;end
		else begin ET10[52] = eTable[l10[52]];end
		if(l10[53] == 0)begin ET10[53] = 0;end
		else begin ET10[53] = eTable[l10[53]];end
		if(l10[54] == 0)begin ET10[54] = 0;end
		else begin ET10[54] = eTable[l10[54]];end
		if(l10[55] == 0)begin ET10[55] = 0;end
		else begin ET10[55] = eTable[l10[55]];end
		if(l10[56] == 0)begin ET10[56] = 0;end
		else begin ET10[56] = eTable[l10[56]];end
		if(l10[57] == 0)begin ET10[57] = 0;end
		else begin ET10[57] = eTable[l10[57]];end
		if(l10[58] == 0)begin ET10[58] = 0;end
		else begin ET10[58] = eTable[l10[58]];end
		if(l10[59] == 0)begin ET10[59] = 0;end
		else begin ET10[59] = eTable[l10[59]];end
		if(l10[60] == 0)begin ET10[60] = 0;end
		else begin ET10[60] = eTable[l10[60]];end	
		if(l10[61] == 0)begin ET10[61] = 0;end
		else begin ET10[61] = eTable[l10[61]];end
		if(l10[62] == 0)begin ET10[62] = 0;end
		else begin ET10[62] = eTable[l10[62]];end
		if(l10[63] == 0)begin ET10[63] = 0;end
		else begin ET10[63] = eTable[l10[63]];end
		next_state = 80;
	end
    80:begin
        d21[0] = ET10[0]^ET10[1]^ET10[2]^ET10[3];
        d21[1] = ET10[4]^ET10[5]^ET10[6]^ET10[7];
        d21[2] = ET10[8]^ET10[9]^ET10[10]^ET10[11];
        d21[3] = ET10[12]^ET10[13]^ET10[14]^ET10[15];
        d21[4] = ET10[16]^ET10[17]^ET10[18]^ET10[19];
        d21[5] = ET10[20]^ET10[21]^ET10[22]^ET10[23];
        d21[6] = ET10[24]^ET10[25]^ET10[26]^ET10[27];
        d21[7] = ET10[28]^ET10[29]^ET10[30]^ET10[31];
        d21[8] = ET10[32]^ET10[33]^ET10[34]^ET10[35];
        d21[9] = ET10[36]^ET10[37]^ET10[38]^ET10[39];
        d21[10] = ET10[40]^ET10[41]^ET10[42]^ET10[43];
        d21[11] = ET10[44]^ET10[45]^ET10[46]^ET10[47];
        d21[12] = ET10[48]^ET10[49]^ET10[50]^ET10[51];
        d21[13] = ET10[52]^ET10[53]^ET10[54]^ET10[55];
        d21[14] = ET10[56]^ET10[57]^ET10[58]^ET10[59];
        d21[15] =ET10[60]^ET10[61]^ET10[62]^ET10[63]; 
        next_state = 81;
    end
	81:begin
        tempRow11[0] = d21[0];tempRow11[4] = d21[4];tempRow11[8] = d21[8];tempRow11[12] = d21[12];
        tempRow11[1] = d21[13];tempRow11[5] = d21[1];tempRow11[9] = d21[5];tempRow11[13] = d21[9];
        tempRow11[2] = d21[10];tempRow11[6] = d21[14];tempRow11[10] = d21[2];tempRow11[14] = d21[6];
        tempRow11[3] = d21[7];tempRow11[7] = d21[11];tempRow11[11] = d21[15];tempRow11[15] = d21[3];
        next_state = 82;
	end
	82:begin
        tempSbox11[0] = inv_sbox[tempRow11[0]];tempSbox11[1] = inv_sbox[tempRow11[1]];tempSbox11[2] = inv_sbox[tempRow11[2]];tempSbox11[3] = inv_sbox[tempRow11[3]];
        tempSbox11[4] = inv_sbox[tempRow11[4]];tempSbox11[5] = inv_sbox[tempRow11[5]];tempSbox11[6] = inv_sbox[tempRow11[6]];tempSbox11[7] = inv_sbox[tempRow11[7]];
        tempSbox11[8] = inv_sbox[tempRow11[8]];tempSbox11[9] = inv_sbox[tempRow11[9]];tempSbox11[10] = inv_sbox[tempRow11[10]];tempSbox11[11] = inv_sbox[tempRow11[11]];
        tempSbox11[12] = inv_sbox[tempRow11[12]];tempSbox11[13] = inv_sbox[tempRow11[13]];tempSbox11[14] = inv_sbox[tempRow11[14]];tempSbox11[15] = inv_sbox[tempRow11[15]];
		next_state = 83;
	end
	83:begin
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
		next_state = 84;
	end
	84:begin 
	    /* For b0 & b4*/
		if(d22[0] == 0)begin LT11[0] = 0; LT11[4] = 0; LT11[8] = 0; LT11[12] = 0 ;end
		else begin LT11[0] = lTable[d22[0]] + lTable[8'h0e];LT11[4] = lTable[d22[0]] + lTable[8'h09];LT11[8] =  lTable[d22[0]] + lTable[8'h0d];LT11[12] = lTable[d22[0]] + lTable[8'h0b];end
	    /* For b1 & b2*/
		if(d22[1] == 0)begin LT11[1] = 0;LT11[5] = 0;LT11[9] =0; LT11[13] = 0;end
		else begin LT11[1] = lTable[d22[1]] + lTable[8'h0b];LT11[5] = lTable[d22[1]] + lTable[8'h0e];LT11[9] = lTable[d22[1]] + lTable[8'h09]; LT11[13] = lTable[d22[1]] + lTable[8'h0d];end
	    /* For b3 & b4*/
		if(d22[2] == 0)begin LT11[2] = 0;LT11[6] = 0;LT11[10] = 0;LT11[14] = 0;end
		else begin LT11[2] = lTable[d22[2]] + lTable[8'h0d];LT11[6] = lTable[d22[2]] + lTable[8'h0b];LT11[10] = lTable[d22[2]] + lTable[8'h0e];LT11[14] = lTable[d22[2]] + lTable[8'h09];end
	    /* For b5 & b7*/			
		if(d22[3] == 0)begin LT11[3] = 0;LT11[7] = 0;LT11[11] = 0;LT11[15] = 0;end 
		else begin  LT11[3] = lTable[d22[3]] + lTable[8'h09];LT11[7] = lTable[d22[3]] + lTable[8'h0d];LT11[11] = lTable[d22[3]] + lTable[8'h0b];LT11[15] = lTable[d22[3]] + lTable[8'h0e];end
	    /* For b8 & b14 */				
		if(d22[4] == 0)begin LT11[16] = 0; LT11[20] = 0; LT11[24] = 0; LT11[28] = 0;end
		else begin LT11[16] = lTable[d22[4]] + lTable[8'h0e]; LT11[20] = lTable[d22[4]] + lTable[8'h09]; LT11[24] = lTable[d22[4]] + lTable[8'h0d]; LT11[28] = lTable[d22[4]] + lTable[8'h0b];end
		/* For b9 & b10 */
		if(d22[5] == 0)begin LT11[17] = 0;LT11[21] = 0; LT11[25] = 0;LT11[29] = 0;end
		else begin LT11[17] = lTable[d22[5]] + lTable[8'h0b];LT11[21] = lTable[d22[5]] + lTable[8'h0e]; LT11[25] = lTable[d22[5]] + lTable[8'h09];LT11[29] = lTable[d22[5]] + lTable[8'h0d];end
		/* For b11 & b12*/
		if(d22[6] == 0)begin LT11[18] = 0;LT11[22] = 0; LT11[26] = 0;LT11[30] = 0;end
		else begin LT11[18] = lTable[d22[6]] + lTable[8'h0d];LT11[22] = lTable[d22[6]] + lTable[8'h0b]; LT11[26] = lTable[d22[6]] + lTable[8'h0e];LT11[30] = lTable[d22[6]] + lTable[8'h09];end
		/* For b13 & b15 */
		if(d22[7] == 0)begin LT11[19] = 0;LT11[23] = 0; LT11[27] = 0;LT11[31] = 0;end
		else begin LT11[19] = lTable[d22[7]] + lTable[8'h09];LT11[23] = lTable[d22[7]] + lTable[8'h0d]; LT11[27] = lTable[d22[7]] + lTable[8'h0b];LT11[31] = lTable[d22[7]] + lTable[8'h0e];end
		/* For b16 & b22 */
		if(d22[8] == 0)begin LT11[32] = 0;LT11[36] = 0; LT11[40] = 0;LT11[44] = 0;end
		else begin LT11[32] = lTable[d22[8]] + lTable[8'h0e];LT11[36] = lTable[d22[8]] + lTable[8'h09];LT11[40] = lTable[d22[8]] + lTable[8'h0d];LT11[44] = lTable[d22[8]] + lTable[8'h0b];end
		/* For b17 & 18 */
		if(d22[9] == 0)begin LT11[33] = 0;LT11[37] = 0; LT11[41] = 0;LT11[45] = 0;end
		else begin LT11[33] = lTable[d22[9]] + lTable[8'h0b];LT11[37] = lTable[d22[9]] + lTable[8'h0e]; LT11[41] = lTable[d22[9]] + lTable[8'h09];LT11[45] = lTable[d22[9]] + lTable[8'h0d];end
		/* For b19 & b20 */
		if(d22[10] == 0)begin LT11[34] = 0;LT11[38] = 0;LT11[42] = 0;LT11[46] = 0;end
		else begin LT11[34] = lTable[d22[10]] + lTable[8'h0d];LT11[38] = lTable[d22[10]] + lTable[8'h0b];LT11[42] = lTable[d22[10]] + lTable[8'h0e];LT11[46] = lTable[d22[10]] + lTable[8'h09];end
		/* For b21 & b23 */
		if(d22[11] == 0)begin LT11[35] = 0; LT11[39] =0;LT11[43] = 0; LT11[47] =0;end
		else begin  LT11[35] = lTable[d22[11]] + lTable[8'h09]; LT11[39] =lTable[d22[11]] + lTable[8'h0d];LT11[43] = lTable[d22[11]] + lTable[8'h0b]; LT11[47] =lTable[d22[11]] + lTable[8'h0e];end	
		/* For b24 & b30 */
		if(d22[12] == 0)begin LT11[48] = 0;LT11[52] = 0; LT11[56] = 0;LT11[60] = 0;end 
		else begin LT11[48] = lTable[d22[12]] + lTable[8'h0e];LT11[52] = lTable[d22[12]] + lTable[8'h09]; LT11[56] = lTable[d22[12]] + lTable[8'h0d];LT11[60] = lTable[d22[12]] + lTable[8'h0b];end 		
		/* For b25 & b26 */		
		if(d22[13] == 0)begin LT11[49] = 0;LT11[53] = 0; LT11[57] = 0;LT11[61] = 0;end 
		else begin  LT11[49] = lTable[d22[13]] + lTable[8'h0b];LT11[53] = lTable[d22[13]] + lTable[8'h0e]; LT11[57] = lTable[d22[13]] + lTable[8'h09];LT11[61] = lTable[d22[13]] + lTable[8'h0d];end 
		/* For b27 & b28 */
		if(d22[14] == 0)begin LT11[50] = 0;LT11[54] = 0; LT11[58] = 0;LT11[62] = 0;end 
		else begin LT11[50] = lTable[d22[14]] + lTable[8'h0d];LT11[54] = lTable[d22[14]] + lTable[8'h0b]; LT11[58] = lTable[d22[14]] + lTable[8'h0e];LT11[62] = lTable[d22[14]] + lTable[8'h09];end 
		/* For b29 & b31 */
		if(d22[15] == 0)begin LT11[51] = 0;LT11[55] = 0; LT11[59] = 0;LT11[63] = 0;end 
		else begin LT11[51] = lTable[d22[15]] + lTable[8'h09];LT11[55] = lTable[d22[15]] + lTable[8'h0d]; LT11[59] = lTable[d22[15]] + lTable[8'h0b];LT11[63] = lTable[d22[15]] + lTable[8'h0e];end 

        next_state = 85;
    end
    85:begin
		if(LT11[0] > 255)begin l11[0] = LT11[0] - 255;end
		else begin l11[0] = LT11[0];end
		if(LT11[1] > 255)begin l11[1] = LT11[1] - 255;end
		else  begin l11[1] = LT11[1];end
		if(LT11[2] > 255)begin l11[2] = LT11[2] - 255;end
		else  begin l11[2] = LT11[2];end
		if(LT11[3] > 255)begin l11[3] = LT11[3] - 255;end
		else  begin l11[3] = LT11[3];end
		if(LT11[4] > 255)begin l11[4] = LT11[4] - 255;end
		else  begin l11[4] = LT11[4];end
		if(LT11[5] > 255)begin l11[5] = LT11[5] - 255;end
		else  begin l11[5] = LT11[5];end
		if(LT11[6] > 255)begin l11[6] = LT11[6] - 255;end
		else  begin l11[6] = LT11[6];end
		if(LT11[7] > 255)begin l11[7] = LT11[7] - 255;end
		else  begin l11[7] = LT11[7];end
		if(LT11[8] > 255)begin l11[8] = LT11[8] - 255;end
		else  begin l11[8] = LT11[8];end
		if(LT11[9] > 255)begin l11[9] = LT11[9] - 255;end
		else  begin l11[9] = LT11[9];end
		if(LT11[10] > 255)begin l11[10] = LT11[10] - 255;end
		else  begin l11[10] = LT11[10];end
		if(LT11[11] > 255)begin l11[11] = LT11[11] - 255;end
		else  begin l11[11] = LT11[11];end
		if(LT11[12] > 255)begin l11[12] = LT11[12] - 255;end
		else  begin l11[12] = LT11[12];end
		if(LT11[13] > 255)begin l11[13] = LT11[13] - 255;end
		else  begin l11[13] = LT11[13];end
		if(LT11[14] > 255)begin l11[14] = LT11[14] - 255;end
		else  begin l11[14] = LT11[14];end
		if(LT11[15] > 255)begin l11[15] = LT11[15] - 255;end
		else  begin l11[15] = LT11[15];end
		if(LT11[16] > 255)begin l11[16] = LT11[16] - 255;end
		else  begin l11[16] = LT11[16];end
		if(LT11[17] > 255)begin l11[17] = LT11[17] - 255;end
		else  begin l11[17] = LT11[17];end
		if(LT11[18] > 255)begin l11[18] = LT11[18] - 255;end
		else  begin l11[18] = LT11[18];end
		if(LT11[19] > 255)begin l11[19] = LT11[19] - 255;end
		else  begin l11[19] = LT11[19];end
		if(LT11[20] > 255)begin l11[20] = LT11[20] - 255;end
		else  begin l11[20] = LT11[20];end
		if(LT11[21] > 255)begin l11[21] = LT11[21] - 255;end
		else  begin l11[21] = LT11[21];end
		if(LT11[22] > 255)begin l11[22] = LT11[22] - 255;end
		else  begin l11[22] = LT11[22];end
		if(LT11[23] > 255)begin l11[23] = LT11[23] - 255;end
		else  begin l11[23] = LT11[23];end
		if(LT11[24] > 255)begin l11[24] = LT11[24] - 255;end
		else  begin l11[24] = LT11[24];end
		if(LT11[25] > 255)begin l11[25] = LT11[25] - 255;end
		else  begin l11[25] = LT11[25];end
		if(LT11[26] > 255)begin l11[26] = LT11[26] - 255;end
		else  begin l11[26] = LT11[26];end
		if(LT11[27] > 255)begin l11[27] = LT11[27] - 255;end
		else  begin l11[27] = LT11[27];end
		if(LT11[28] > 255)begin l11[28] = LT11[28] - 255;end
		else  begin l11[28] = LT11[28];end
		if(LT11[29] > 255)begin l11[29] = LT11[29] - 255;end
		else  begin l11[29] = LT11[29];end
		if(LT11[30] > 255)begin l11[30] = LT11[30] - 255;end
		else  begin l11[30] = LT11[30];end
		if(LT11[31] > 255)begin l11[31] = LT11[31] - 255;end
		else  begin l11[31] = LT11[31];end
		if(LT11[32] > 255)begin l11[32] = LT11[32] - 255;end
		else  begin l11[32] = LT11[32];end
		if(LT11[33] > 255)begin l11[33] = LT11[33] - 255;end
		else  begin l11[33] = LT11[33];end
		if(LT11[34] > 255)begin l11[34] = LT11[34] - 255;end
		else  begin l11[34] = LT11[34];end
		if(LT11[35] > 255)begin l11[35] = LT11[35] - 255;end
		else  begin l11[35] = LT11[35];end
		if(LT11[36] > 255)begin l11[36] = LT11[36] - 255;end
		else  begin l11[36] = LT11[36];end
		if(LT11[37] > 255)begin l11[37] = LT11[37] - 255;end
		else  begin l11[37] = LT11[37];end
		if(LT11[38] > 255)begin l11[38] = LT11[38] - 255;end
		else  begin l11[38] = LT11[38];end
		if(LT11[39] > 255)begin l11[39] = LT11[39] - 255;end
		else  begin l11[39] = LT11[39];end
		if(LT11[40] > 255)begin l11[40] = LT11[40] - 255;end
		else  begin l11[40] = LT11[40];end
		if(LT11[41] > 255)begin l11[41] = LT11[41] - 255;end
		else  begin l11[41] = LT11[41];end
		if(LT11[42] > 255)begin l11[42] = LT11[42] - 255;end
		else  begin l11[42] = LT11[42];end
		if(LT11[43] > 255)begin l11[43] = LT11[43] - 255;end
		else  begin l11[43] = LT11[43];end
		if(LT11[44] > 255)begin l11[44] = LT11[44] - 255;end
		else  begin l11[44] = LT11[44];end
		if(LT11[45] > 255)begin l11[45] = LT11[45] - 255;end
		else  begin l11[45] = LT11[45];end
		if(LT11[46] > 255)begin l11[46] = LT11[46] - 255;end
		else  begin l11[46] = LT11[46];end
		if(LT11[47] > 255)begin l11[47] = LT11[47] - 255;end
		else  begin l11[47] = LT11[47];end
		if(LT11[48] > 255)begin l11[48] = LT11[48] - 255;end
		else  begin l11[48] = LT11[48];end
		if(LT11[49] > 255)begin l11[49] = LT11[49] - 255;end
		else  begin l11[49] = LT11[49];end
		if(LT11[50] > 255)begin l11[50] = LT11[50] - 255;end
		else  begin l11[50] = LT11[50];end
		if(LT11[51] > 255)begin l11[51] = LT11[51] - 255;end
		else  begin l11[51] = LT11[51];end
		if(LT11[52] > 255)begin l11[52] = LT11[52] - 255;end
		else  begin l11[52] = LT11[52];end
		if(LT11[53] > 255)begin l11[53] = LT11[53] - 255;end
		else  begin l11[53] = LT11[53];end
		if(LT11[54] > 255)begin l11[54] = LT11[54] - 255;end
		else  begin l11[54] = LT11[54];end
		if(LT11[55] > 255)begin l11[55] = LT11[55] - 255;end
		else  begin l11[55] = LT11[55];end
		if(LT11[56] > 255)begin l11[56] = LT11[56] - 255;end
		else  begin l11[56] = LT11[56];end
		if(LT11[57] > 255)begin l11[57] = LT11[57] - 255;end
		else  begin l11[57] = LT11[57];end
		if(LT11[58] > 255)begin l11[58] = LT11[58] - 255;end
		else  begin l11[58] = LT11[58];end
		if(LT11[59] > 255)begin l11[59] = LT11[59] - 255;end
		else  begin l11[59] = LT11[59];end
		if(LT11[60] > 255)begin l11[60] = LT11[60] - 255;end
		else  begin l11[60] = LT11[60];end
		if(LT11[61] > 255)begin l11[61] = LT11[61] - 255;end
		else  begin l11[61] = LT11[61];end
		if(LT11[62] > 255)begin l11[62] = LT11[62] - 255;end
		else  begin l11[62] = LT11[62];end
		if(LT11[63] > 255)begin l11[63] = LT11[63] - 255;end
		else  begin l11[63] = LT11[63];end		
		next_state = 86;
	end
	86:begin
		/* for d0 */
		if(l11[0] == 0)begin ET11[0] = 0;end
		else begin ET11[0] = eTable[l11[0]];end
		if(l11[1] == 0)begin ET11[1] = 0;end
		else begin ET11[1] = eTable[l11[1]];end
		/* for d22 */
		if(l11[2] == 0)begin ET11[2] = 0;end
		else begin ET11[2] = eTable[l11[2]];end
		if(l11[3] == 0)begin ET11[3] = 0;end
		else begin ET11[3] = eTable[l11[3]];end
		/* for d22 */
		if(l11[4] == 0)begin ET11[4] = 0;end
		else begin ET11[4] = eTable[l11[4]];end
		if(l11[5] == 0)begin ET11[5] = 0;end
		else begin ET11[5] = eTable[l11[5]];end
		/* for d3 */
		if(l11[6] == 0)begin ET11[6] = 0;end
		else begin ET11[6] = eTable[l11[6]];end
		if(l11[7] == 0)begin ET11[7] = 0;end
		else begin ET11[7] = eTable[l11[7]];end
		/* for d22 */
		if(l11[8] == 0)begin ET11[8] = 0;end
		else begin ET11[8] = eTable[l11[8]];end
		if(l11[9] == 0)begin ET11[9] = 0;end
		else begin ET11[9] = eTable[l11[9]];end
		/* for d22 */
		if(l11[10] == 0)begin ET11[10] = 0;end
		else begin ET11[10] = eTable[l11[10]];end
		if(l11[11] == 0)begin ET11[11] = 0;end
		else begin ET11[11] = eTable[l11[11]];end
		/* for d22 */
		if(l11[12] == 0)begin ET11[12] = 0;end
		else begin ET11[12] = eTable[l11[12]];end
		if(l11[13] == 0)begin ET11[13] = 0;end
		else begin ET11[13] = eTable[l11[13]];end
		/* for d7 */
		if(l11[14] == 0)begin ET11[14] = 0;end
		else begin ET11[14] = eTable[l11[14]];end
		if(l11[15] == 0)begin ET11[15] = 0;end
		else begin ET11[15] = eTable[l11[15]];end
		/* for d22 */
		if(l11[16] == 0)begin ET11[16] = 0;end
		else begin ET11[16] = eTable[l11[16]];end
		if(l11[17] == 0)begin ET11[17] = 0;end
		else begin ET11[17] = eTable[l11[17]];end
		/* for d23 */
		if(l11[18] == 0)begin ET11[18] = 0;end
		else begin ET11[18] = eTable[l11[18]];end
		if(l11[19] == 0)begin ET11[19] = 0;end
		else begin ET11[19] = eTable[l11[19]];end
		/* for d22 */
		if(l11[20] == 0)begin ET11[20] = 0;end
		else begin ET11[20] = eTable[l11[20]];end
		if(l11[21] == 0)begin ET11[21] = 0;end
		else begin ET11[21] = eTable[l11[21]];end
		/* for d23 */
		if(l11[22] == 0)begin ET11[22] = 0;end
		else begin ET11[22] = eTable[l11[22]];end
		if(l11[23] == 0)begin ET11[23] = 0;end
		else begin ET11[23] = eTable[l11[23]];end
		/* for d22 */
		if(l11[24] == 0)begin ET11[24] = 0;end
		else begin ET11[24] = eTable[l11[24]];end
		if(l11[25] == 0)begin ET11[25] = 0;end
		else begin ET11[25] = eTable[l11[25]];end
		/* for d23 */
		if(l11[26] == 0)begin ET11[26] = 0;end
		else begin ET11[26] = eTable[l11[26]];end
		if(l11[27] == 0)begin ET11[27] = 0;end
		else begin ET11[27] = eTable[l11[27]];end
		/* for d22 */
		if(l11[28] == 0)begin ET11[28] = 0;end
		else begin ET11[28] = eTable[l11[28]];end
		if(l11[29] == 0)begin ET11[29] = 0;end
		else begin ET11[29] = eTable[l11[29]];end
		/* for d23 */
		if(l11[30] == 0)begin ET11[30] = 0;end
		else begin ET11[30] = eTable[l11[30]];end
		if(l11[31] == 0)begin ET11[31] = 0;end
		else begin ET11[31] = eTable[l11[31]];end
		if(l11[32] == 0)begin ET11[32] = 0;end
		else begin ET11[32] = eTable[l11[32]];end
		if(l11[33] == 0)begin ET11[33] = 0;end
		else begin ET11[33] = eTable[l11[33]];end
		if(l11[34] == 0)begin ET11[34] = 0;end
		else begin ET11[34] = eTable[l11[34]];end
		if(l11[35] == 0)begin ET11[35] = 0;end
		else begin ET11[35] = eTable[l11[35]];end
		if(l11[36] == 0)begin ET11[36] = 0;end
		else begin ET11[36] = eTable[l11[36]];end
		if(l11[37] == 0)begin ET11[37] = 0;end
		else begin ET11[37] = eTable[l11[37]];end
		if(l11[38] == 0)begin ET11[38] = 0;end
		else begin ET11[38] = eTable[l11[38]];end
		if(l11[39] == 0)begin ET11[39] = 0;end
		else begin ET11[39] = eTable[l11[39]];end
		if(l11[40] == 0)begin ET11[40] = 0;end
		else begin ET11[40] = eTable[l11[40]];end
		if(l11[41] == 0)begin ET11[41] = 0;end
		else begin ET11[41] = eTable[l11[41]];end
		if(l11[42] == 0)begin ET11[42] = 0;end
		else begin ET11[42] = eTable[l11[42]];end
		if(l11[43] == 0)begin ET11[43] = 0;end
		else begin ET11[43] = eTable[l11[43]];end
		if(l11[44] == 0)begin ET11[44] = 0;end
		else begin ET11[44] = eTable[l11[44]];end
		if(l11[45] == 0)begin ET11[45] = 0;end
		else begin ET11[45] = eTable[l11[45]];end
		if(l11[46] == 0)begin ET11[46] = 0;end
		else begin ET11[46] = eTable[l11[46]];end
		if(l11[47] == 0)begin ET11[47] = 0;end
		else begin ET11[47] = eTable[l11[47]];end
		if(l11[48] == 0)begin ET11[48] = 0;end
		else begin ET11[48] = eTable[l11[48]];end
		if(l11[49] == 0)begin ET11[49] = 0;end
		else begin ET11[49] = eTable[l11[49]];end
		if(l11[50] == 0)begin ET11[50] = 0;end
		else begin ET11[50] = eTable[l11[50]];end		
		if(l11[51] == 0)begin ET11[51] = 0;end
		else begin ET11[51] = eTable[l11[51]];end
		if(l11[52] == 0)begin ET11[52] = 0;end
		else begin ET11[52] = eTable[l11[52]];end
		if(l11[53] == 0)begin ET11[53] = 0;end
		else begin ET11[53] = eTable[l11[53]];end
		if(l11[54] == 0)begin ET11[54] = 0;end
		else begin ET11[54] = eTable[l11[54]];end
		if(l11[55] == 0)begin ET11[55] = 0;end
		else begin ET11[55] = eTable[l11[55]];end
		if(l11[56] == 0)begin ET11[56] = 0;end
		else begin ET11[56] = eTable[l11[56]];end
		if(l11[57] == 0)begin ET11[57] = 0;end
		else begin ET11[57] = eTable[l11[57]];end
		if(l11[58] == 0)begin ET11[58] = 0;end
		else begin ET11[58] = eTable[l11[58]];end
		if(l11[59] == 0)begin ET11[59] = 0;end
		else begin ET11[59] = eTable[l11[59]];end
		if(l11[60] == 0)begin ET11[60] = 0;end
		else begin ET11[60] = eTable[l11[60]];end	
		if(l11[61] == 0)begin ET11[61] = 0;end
		else begin ET11[61] = eTable[l11[61]];end
		if(l11[62] == 0)begin ET11[62] = 0;end
		else begin ET11[62] = eTable[l11[62]];end
		if(l11[63] == 0)begin ET11[63] = 0;end
		else begin ET11[63] = eTable[l11[63]];end
		next_state = 87;
	end
    87:begin
        d23[0] = ET11[0]^ET11[1]^ET11[2]^ET11[3];
        d23[1] = ET11[4]^ET11[5]^ET11[6]^ET11[7];
        d23[2] = ET11[8]^ET11[9]^ET11[10]^ET11[11];
        d23[3] = ET11[12]^ET11[13]^ET11[14]^ET11[15];
        d23[4] = ET11[16]^ET11[17]^ET11[18]^ET11[19];
        d23[5] = ET11[20]^ET11[21]^ET11[22]^ET11[23];
        d23[6] = ET11[24]^ET11[25]^ET11[26]^ET11[27];
        d23[7] = ET11[28]^ET11[29]^ET11[30]^ET11[31];
        d23[8] = ET11[32]^ET11[33]^ET11[34]^ET11[35];
        d23[9] = ET11[36]^ET11[37]^ET11[38]^ET11[39];
        d23[10] = ET11[40]^ET11[41]^ET11[42]^ET11[43];
        d23[11] = ET11[44]^ET11[45]^ET11[46]^ET11[47];
        d23[12] = ET11[48]^ET11[49]^ET11[50]^ET11[51];
        d23[13] = ET11[52]^ET11[53]^ET11[54]^ET11[55];
        d23[14] = ET11[56]^ET11[57]^ET11[58]^ET11[59];
        d23[15] =ET11[60]^ET11[61]^ET11[62]^ET11[63]; 
        next_state = 88;
    end
	88:begin
        tempRow12[0] = d23[0];tempRow12[4] = d23[4];tempRow12[8] = d23[8];tempRow12[12] = d23[12];
        tempRow12[1] = d23[13];tempRow12[5] = d23[1];tempRow12[9] = d23[5];tempRow12[13] = d23[9];
        tempRow12[2] = d23[10];tempRow12[6] = d23[14];tempRow12[10] = d23[2];tempRow12[14] = d23[6];
        tempRow12[3] = d23[7];tempRow12[7] = d23[11];tempRow12[11] = d23[15];tempRow12[15] = d23[3];
        next_state = 89;
	end
	89:begin
        tempSbox12[0] = inv_sbox[tempRow12[0]];tempSbox12[1] = inv_sbox[tempRow12[1]];tempSbox12[2] = inv_sbox[tempRow12[2]];tempSbox12[3] = inv_sbox[tempRow12[3]];
        tempSbox12[4] = inv_sbox[tempRow12[4]];tempSbox12[5] = inv_sbox[tempRow12[5]];tempSbox12[6] = inv_sbox[tempRow12[6]];tempSbox12[7] = inv_sbox[tempRow12[7]];
        tempSbox12[8] = inv_sbox[tempRow12[8]];tempSbox12[9] = inv_sbox[tempRow12[9]];tempSbox12[10] = inv_sbox[tempRow12[10]];tempSbox12[11] = inv_sbox[tempRow12[11]];
        tempSbox12[12] = inv_sbox[tempRow12[12]];tempSbox12[13] = inv_sbox[tempRow12[13]];tempSbox12[14] = inv_sbox[tempRow12[14]];tempSbox12[15] = inv_sbox[tempRow12[15]];
		next_state = 90;
	end
	90:begin
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
		next_state = 91;
	end
	91:begin 
	    /* For b0 & b4*/
		if(d24[0] == 0)begin LT12[0] = 0; LT12[4] = 0; LT12[8] = 0; LT12[12] = 0 ;end
		else begin LT12[0] = lTable[d24[0]] + lTable[8'h0e];LT12[4] = lTable[d24[0]] + lTable[8'h09];LT12[8] =  lTable[d24[0]] + lTable[8'h0d];LT12[12] = lTable[d24[0]] + lTable[8'h0b];end
	    /* For b1 & b2*/
		if(d24[1] == 0)begin LT12[1] = 0;LT12[5] = 0;LT12[9] =0; LT12[13] = 0;end
		else begin LT12[1] = lTable[d24[1]] + lTable[8'h0b];LT12[5] = lTable[d24[1]] + lTable[8'h0e];LT12[9] = lTable[d24[1]] + lTable[8'h09]; LT12[13] = lTable[d24[1]] + lTable[8'h0d];end
	    /* For b3 & b4*/
		if(d24[2] == 0)begin LT12[2] = 0;LT12[6] = 0;LT12[10] = 0;LT12[14] = 0;end
		else begin LT12[2] = lTable[d24[2]] + lTable[8'h0d];LT12[6] = lTable[d24[2]] + lTable[8'h0b];LT12[10] = lTable[d24[2]] + lTable[8'h0e];LT12[14] = lTable[d24[2]] + lTable[8'h09];end
	    /* For b5 & b7*/			
		if(d24[3] == 0)begin LT12[3] = 0;LT12[7] = 0;LT12[11] = 0;LT12[15] = 0;end 
		else begin  LT12[3] = lTable[d24[3]] + lTable[8'h09];LT12[7] = lTable[d24[3]] + lTable[8'h0d];LT12[11] = lTable[d24[3]] + lTable[8'h0b];LT12[15] = lTable[d24[3]] + lTable[8'h0e];end
	    /* For b8 & b14 */				
		if(d24[4] == 0)begin LT12[16] = 0; LT12[20] = 0; LT12[24] = 0; LT12[28] = 0;end
		else begin LT12[16] = lTable[d24[4]] + lTable[8'h0e]; LT12[20] = lTable[d24[4]] + lTable[8'h09]; LT12[24] = lTable[d24[4]] + lTable[8'h0d]; LT12[28] = lTable[d24[4]] + lTable[8'h0b];end
		/* For b9 & b10 */
		if(d24[5] == 0)begin LT12[17] = 0;LT12[21] = 0; LT12[25] = 0;LT12[29] = 0;end
		else begin LT12[17] = lTable[d24[5]] + lTable[8'h0b];LT12[21] = lTable[d24[5]] + lTable[8'h0e]; LT12[25] = lTable[d24[5]] + lTable[8'h09];LT12[29] = lTable[d24[5]] + lTable[8'h0d];end
		/* For b11 & b12*/
		if(d24[6] == 0)begin LT12[18] = 0;LT12[22] = 0; LT12[26] = 0;LT12[30] = 0;end
		else begin LT12[18] = lTable[d24[6]] + lTable[8'h0d];LT12[22] = lTable[d24[6]] + lTable[8'h0b]; LT12[26] = lTable[d24[6]] + lTable[8'h0e];LT12[30] = lTable[d24[6]] + lTable[8'h09];end
		/* For b13 & b15 */
		if(d24[7] == 0)begin LT12[19] = 0;LT12[23] = 0; LT12[27] = 0;LT12[31] = 0;end
		else begin LT12[19] = lTable[d24[7]] + lTable[8'h09];LT12[23] = lTable[d24[7]] + lTable[8'h0d]; LT12[27] = lTable[d24[7]] + lTable[8'h0b];LT12[31] = lTable[d24[7]] + lTable[8'h0e];end
		/* For b16 & b22 */
		if(d24[8] == 0)begin LT12[32] = 0;LT12[36] = 0; LT12[40] = 0;LT12[44] = 0;end
		else begin LT12[32] = lTable[d24[8]] + lTable[8'h0e];LT12[36] = lTable[d24[8]] + lTable[8'h09];LT12[40] = lTable[d24[8]] + lTable[8'h0d];LT12[44] = lTable[d24[8]] + lTable[8'h0b];end
		/* For b17 & 18 */
		if(d24[9] == 0)begin LT12[33] = 0;LT12[37] = 0; LT12[41] = 0;LT12[45] = 0;end
		else begin LT12[33] = lTable[d24[9]] + lTable[8'h0b];LT12[37] = lTable[d24[9]] + lTable[8'h0e]; LT12[41] = lTable[d24[9]] + lTable[8'h09];LT12[45] = lTable[d24[9]] + lTable[8'h0d];end
		/* For b19 & b20 */
		if(d24[10] == 0)begin LT12[34] = 0;LT12[38] = 0;LT12[42] = 0;LT12[46] = 0;end
		else begin LT12[34] = lTable[d24[10]] + lTable[8'h0d];LT12[38] = lTable[d24[10]] + lTable[8'h0b];LT12[42] = lTable[d24[10]] + lTable[8'h0e];LT12[46] = lTable[d24[10]] + lTable[8'h09];end
		/* For b21 & b23 */
		if(d24[11] == 0)begin LT12[35] = 0; LT12[39] =0;LT12[43] = 0; LT12[47] =0;end
		else begin  LT12[35] = lTable[d24[11]] + lTable[8'h09]; LT12[39] =lTable[d24[11]] + lTable[8'h0d];LT12[43] = lTable[d24[11]] + lTable[8'h0b]; LT12[47] =lTable[d24[11]] + lTable[8'h0e];end	
		/* For b24 & b30 */
		if(d24[12] == 0)begin LT12[48] = 0;LT12[52] = 0; LT12[56] = 0;LT12[60] = 0;end 
		else begin LT12[48] = lTable[d24[12]] + lTable[8'h0e];LT12[52] = lTable[d24[12]] + lTable[8'h09]; LT12[56] = lTable[d24[12]] + lTable[8'h0d];LT12[60] = lTable[d24[12]] + lTable[8'h0b];end 		
		/* For b25 & b26 */		
		if(d24[13] == 0)begin LT12[49] = 0;LT12[53] = 0; LT12[57] = 0;LT12[61] = 0;end 
		else begin  LT12[49] = lTable[d24[13]] + lTable[8'h0b];LT12[53] = lTable[d24[13]] + lTable[8'h0e]; LT12[57] = lTable[d24[13]] + lTable[8'h09];LT12[61] = lTable[d24[13]] + lTable[8'h0d];end 
		/* For b27 & b28 */
		if(d24[14] == 0)begin LT12[50] = 0;LT12[54] = 0; LT12[58] = 0;LT12[62] = 0;end 
		else begin LT12[50] = lTable[d24[14]] + lTable[8'h0d];LT12[54] = lTable[d24[14]] + lTable[8'h0b]; LT12[58] = lTable[d24[14]] + lTable[8'h0e];LT12[62] = lTable[d24[14]] + lTable[8'h09];end 
		/* For b29 & b31 */
		if(d24[15] == 0)begin LT12[51] = 0;LT12[55] = 0; LT12[59] = 0;LT12[63] = 0;end 
		else begin LT12[51] = lTable[d24[15]] + lTable[8'h09];LT12[55] = lTable[d24[15]] + lTable[8'h0d]; LT12[59] = lTable[d24[15]] + lTable[8'h0b];LT12[63] = lTable[d24[15]] + lTable[8'h0e];end 

        next_state = 92;
    end
    92:begin
		if(LT12[0] > 255)begin l12[0] = LT12[0] - 255;end
		else begin l12[0] = LT12[0];end
		if(LT12[1] > 255)begin l12[1] = LT12[1] - 255;end
		else  begin l12[1] = LT12[1];end
		if(LT12[2] > 255)begin l12[2] = LT12[2] - 255;end
		else  begin l12[2] = LT12[2];end
		if(LT12[3] > 255)begin l12[3] = LT12[3] - 255;end
		else  begin l12[3] = LT12[3];end
		if(LT12[4] > 255)begin l12[4] = LT12[4] - 255;end
		else  begin l12[4] = LT12[4];end
		if(LT12[5] > 255)begin l12[5] = LT12[5] - 255;end
		else  begin l12[5] = LT12[5];end
		if(LT12[6] > 255)begin l12[6] = LT12[6] - 255;end
		else  begin l12[6] = LT12[6];end
		if(LT12[7] > 255)begin l12[7] = LT12[7] - 255;end
		else  begin l12[7] = LT12[7];end
		if(LT12[8] > 255)begin l12[8] = LT12[8] - 255;end
		else  begin l12[8] = LT12[8];end
		if(LT12[9] > 255)begin l12[9] = LT12[9] - 255;end
		else  begin l12[9] = LT12[9];end
		if(LT12[10] > 255)begin l12[10] = LT12[10] - 255;end
		else  begin l12[10] = LT12[10];end
		if(LT12[11] > 255)begin l12[11] = LT12[11] - 255;end
		else  begin l12[11] = LT12[11];end
		if(LT12[12] > 255)begin l12[12] = LT12[12] - 255;end
		else  begin l12[12] = LT12[12];end
		if(LT12[13] > 255)begin l12[13] = LT12[13] - 255;end
		else  begin l12[13] = LT12[13];end
		if(LT12[14] > 255)begin l12[14] = LT12[14] - 255;end
		else  begin l12[14] = LT12[14];end
		if(LT12[15] > 255)begin l12[15] = LT12[15] - 255;end
		else  begin l12[15] = LT12[15];end
		if(LT12[16] > 255)begin l12[16] = LT12[16] - 255;end
		else  begin l12[16] = LT12[16];end
		if(LT12[17] > 255)begin l12[17] = LT12[17] - 255;end
		else  begin l12[17] = LT12[17];end
		if(LT12[18] > 255)begin l12[18] = LT12[18] - 255;end
		else  begin l12[18] = LT12[18];end
		if(LT12[19] > 255)begin l12[19] = LT12[19] - 255;end
		else  begin l12[19] = LT12[19];end
		if(LT12[20] > 255)begin l12[20] = LT12[20] - 255;end
		else  begin l12[20] = LT12[20];end
		if(LT12[21] > 255)begin l12[21] = LT12[21] - 255;end
		else  begin l12[21] = LT12[21];end
		if(LT12[22] > 255)begin l12[22] = LT12[22] - 255;end
		else  begin l12[22] = LT12[22];end
		if(LT12[23] > 255)begin l12[23] = LT12[23] - 255;end
		else  begin l12[23] = LT12[23];end
		if(LT12[24] > 255)begin l12[24] = LT12[24] - 255;end
		else  begin l12[24] = LT12[24];end
		if(LT12[25] > 255)begin l12[25] = LT12[25] - 255;end
		else  begin l12[25] = LT12[25];end
		if(LT12[26] > 255)begin l12[26] = LT12[26] - 255;end
		else  begin l12[26] = LT12[26];end
		if(LT12[27] > 255)begin l12[27] = LT12[27] - 255;end
		else  begin l12[27] = LT12[27];end
		if(LT12[28] > 255)begin l12[28] = LT12[28] - 255;end
		else  begin l12[28] = LT12[28];end
		if(LT12[29] > 255)begin l12[29] = LT12[29] - 255;end
		else  begin l12[29] = LT12[29];end
		if(LT12[30] > 255)begin l12[30] = LT12[30] - 255;end
		else  begin l12[30] = LT12[30];end
		if(LT12[31] > 255)begin l12[31] = LT12[31] - 255;end
		else  begin l12[31] = LT12[31];end
		if(LT12[32] > 255)begin l12[32] = LT12[32] - 255;end
		else  begin l12[32] = LT12[32];end
		if(LT12[33] > 255)begin l12[33] = LT12[33] - 255;end
		else  begin l12[33] = LT12[33];end
		if(LT12[34] > 255)begin l12[34] = LT12[34] - 255;end
		else  begin l12[34] = LT12[34];end
		if(LT12[35] > 255)begin l12[35] = LT12[35] - 255;end
		else  begin l12[35] = LT12[35];end
		if(LT12[36] > 255)begin l12[36] = LT12[36] - 255;end
		else  begin l12[36] = LT12[36];end
		if(LT12[37] > 255)begin l12[37] = LT12[37] - 255;end
		else  begin l12[37] = LT12[37];end
		if(LT12[38] > 255)begin l12[38] = LT12[38] - 255;end
		else  begin l12[38] = LT12[38];end
		if(LT12[39] > 255)begin l12[39] = LT12[39] - 255;end
		else  begin l12[39] = LT12[39];end
		if(LT12[40] > 255)begin l12[40] = LT12[40] - 255;end
		else  begin l12[40] = LT12[40];end
		if(LT12[41] > 255)begin l12[41] = LT12[41] - 255;end
		else  begin l12[41] = LT12[41];end
		if(LT12[42] > 255)begin l12[42] = LT12[42] - 255;end
		else  begin l12[42] = LT12[42];end
		if(LT12[43] > 255)begin l12[43] = LT12[43] - 255;end
		else  begin l12[43] = LT12[43];end
		if(LT12[44] > 255)begin l12[44] = LT12[44] - 255;end
		else  begin l12[44] = LT12[44];end
		if(LT12[45] > 255)begin l12[45] = LT12[45] - 255;end
		else  begin l12[45] = LT12[45];end
		if(LT12[46] > 255)begin l12[46] = LT12[46] - 255;end
		else  begin l12[46] = LT12[46];end
		if(LT12[47] > 255)begin l12[47] = LT12[47] - 255;end
		else  begin l12[47] = LT12[47];end
		if(LT12[48] > 255)begin l12[48] = LT12[48] - 255;end
		else  begin l12[48] = LT12[48];end
		if(LT12[49] > 255)begin l12[49] = LT12[49] - 255;end
		else  begin l12[49] = LT12[49];end
		if(LT12[50] > 255)begin l12[50] = LT12[50] - 255;end
		else  begin l12[50] = LT12[50];end
		if(LT12[51] > 255)begin l12[51] = LT12[51] - 255;end
		else  begin l12[51] = LT12[51];end
		if(LT12[52] > 255)begin l12[52] = LT12[52] - 255;end
		else  begin l12[52] = LT12[52];end
		if(LT12[53] > 255)begin l12[53] = LT12[53] - 255;end
		else  begin l12[53] = LT12[53];end
		if(LT12[54] > 255)begin l12[54] = LT12[54] - 255;end
		else  begin l12[54] = LT12[54];end
		if(LT12[55] > 255)begin l12[55] = LT12[55] - 255;end
		else  begin l12[55] = LT12[55];end
		if(LT12[56] > 255)begin l12[56] = LT12[56] - 255;end
		else  begin l12[56] = LT12[56];end
		if(LT12[57] > 255)begin l12[57] = LT12[57] - 255;end
		else  begin l12[57] = LT12[57];end
		if(LT12[58] > 255)begin l12[58] = LT12[58] - 255;end
		else  begin l12[58] = LT12[58];end
		if(LT12[59] > 255)begin l12[59] = LT12[59] - 255;end
		else  begin l12[59] = LT12[59];end
		if(LT12[60] > 255)begin l12[60] = LT12[60] - 255;end
		else  begin l12[60] = LT12[60];end
		if(LT12[61] > 255)begin l12[61] = LT12[61] - 255;end
		else  begin l12[61] = LT12[61];end
		if(LT12[62] > 255)begin l12[62] = LT12[62] - 255;end
		else  begin l12[62] = LT12[62];end
		if(LT12[63] > 255)begin l12[63] = LT12[63] - 255;end
		else  begin l12[63] = LT12[63];end		
		next_state = 93;
	end
	93:begin
		/* for d0 */
		if(l12[0] == 0)begin ET12[0] = 0;end
		else begin ET12[0] = eTable[l12[0]];end
		if(l12[1] == 0)begin ET12[1] = 0;end
		else begin ET12[1] = eTable[l12[1]];end
		/* for d24 */
		if(l12[2] == 0)begin ET12[2] = 0;end
		else begin ET12[2] = eTable[l12[2]];end
		if(l12[3] == 0)begin ET12[3] = 0;end
		else begin ET12[3] = eTable[l12[3]];end
		/* for d24 */
		if(l12[4] == 0)begin ET12[4] = 0;end
		else begin ET12[4] = eTable[l12[4]];end
		if(l12[5] == 0)begin ET12[5] = 0;end
		else begin ET12[5] = eTable[l12[5]];end
		/* for d3 */
		if(l12[6] == 0)begin ET12[6] = 0;end
		else begin ET12[6] = eTable[l12[6]];end
		if(l12[7] == 0)begin ET12[7] = 0;end
		else begin ET12[7] = eTable[l12[7]];end
		/* for d24 */
		if(l12[8] == 0)begin ET12[8] = 0;end
		else begin ET12[8] = eTable[l12[8]];end
		if(l12[9] == 0)begin ET12[9] = 0;end
		else begin ET12[9] = eTable[l12[9]];end
		/* for d24 */
		if(l12[10] == 0)begin ET12[10] = 0;end
		else begin ET12[10] = eTable[l12[10]];end
		if(l12[11] == 0)begin ET12[11] = 0;end
		else begin ET12[11] = eTable[l12[11]];end
		/* for d24 */
		if(l12[12] == 0)begin ET12[12] = 0;end
		else begin ET12[12] = eTable[l12[12]];end
		if(l12[13] == 0)begin ET12[13] = 0;end
		else begin ET12[13] = eTable[l12[13]];end
		/* for d7 */
		if(l12[14] == 0)begin ET12[14] = 0;end
		else begin ET12[14] = eTable[l12[14]];end
		if(l12[15] == 0)begin ET12[15] = 0;end
		else begin ET12[15] = eTable[l12[15]];end
		/* for d24 */
		if(l12[16] == 0)begin ET12[16] = 0;end
		else begin ET12[16] = eTable[l12[16]];end
		if(l12[17] == 0)begin ET12[17] = 0;end
		else begin ET12[17] = eTable[l12[17]];end
		/* for d25 */
		if(l12[18] == 0)begin ET12[18] = 0;end
		else begin ET12[18] = eTable[l12[18]];end
		if(l12[19] == 0)begin ET12[19] = 0;end
		else begin ET12[19] = eTable[l12[19]];end
		/* for d24 */
		if(l12[20] == 0)begin ET12[20] = 0;end
		else begin ET12[20] = eTable[l12[20]];end
		if(l12[21] == 0)begin ET12[21] = 0;end
		else begin ET12[21] = eTable[l12[21]];end
		/* for d25 */
		if(l12[22] == 0)begin ET12[22] = 0;end
		else begin ET12[22] = eTable[l12[22]];end
		if(l12[23] == 0)begin ET12[23] = 0;end
		else begin ET12[23] = eTable[l12[23]];end
		/* for d24 */
		if(l12[24] == 0)begin ET12[24] = 0;end
		else begin ET12[24] = eTable[l12[24]];end
		if(l12[25] == 0)begin ET12[25] = 0;end
		else begin ET12[25] = eTable[l12[25]];end
		/* for d25 */
		if(l12[26] == 0)begin ET12[26] = 0;end
		else begin ET12[26] = eTable[l12[26]];end
		if(l12[27] == 0)begin ET12[27] = 0;end
		else begin ET12[27] = eTable[l12[27]];end
		/* for d24 */
		if(l12[28] == 0)begin ET12[28] = 0;end
		else begin ET12[28] = eTable[l12[28]];end
		if(l12[29] == 0)begin ET12[29] = 0;end
		else begin ET12[29] = eTable[l12[29]];end
		/* for d25 */
		if(l12[30] == 0)begin ET12[30] = 0;end
		else begin ET12[30] = eTable[l12[30]];end
		if(l12[31] == 0)begin ET12[31] = 0;end
		else begin ET12[31] = eTable[l12[31]];end
		if(l12[32] == 0)begin ET12[32] = 0;end
		else begin ET12[32] = eTable[l12[32]];end
		if(l12[33] == 0)begin ET12[33] = 0;end
		else begin ET12[33] = eTable[l12[33]];end
		if(l12[34] == 0)begin ET12[34] = 0;end
		else begin ET12[34] = eTable[l12[34]];end
		if(l12[35] == 0)begin ET12[35] = 0;end
		else begin ET12[35] = eTable[l12[35]];end
		if(l12[36] == 0)begin ET12[36] = 0;end
		else begin ET12[36] = eTable[l12[36]];end
		if(l12[37] == 0)begin ET12[37] = 0;end
		else begin ET12[37] = eTable[l12[37]];end
		if(l12[38] == 0)begin ET12[38] = 0;end
		else begin ET12[38] = eTable[l12[38]];end
		if(l12[39] == 0)begin ET12[39] = 0;end
		else begin ET12[39] = eTable[l12[39]];end
		if(l12[40] == 0)begin ET12[40] = 0;end
		else begin ET12[40] = eTable[l12[40]];end
		if(l12[41] == 0)begin ET12[41] = 0;end
		else begin ET12[41] = eTable[l12[41]];end
		if(l12[42] == 0)begin ET12[42] = 0;end
		else begin ET12[42] = eTable[l12[42]];end
		if(l12[43] == 0)begin ET12[43] = 0;end
		else begin ET12[43] = eTable[l12[43]];end
		if(l12[44] == 0)begin ET12[44] = 0;end
		else begin ET12[44] = eTable[l12[44]];end
		if(l12[45] == 0)begin ET12[45] = 0;end
		else begin ET12[45] = eTable[l12[45]];end
		if(l12[46] == 0)begin ET12[46] = 0;end
		else begin ET12[46] = eTable[l12[46]];end
		if(l12[47] == 0)begin ET12[47] = 0;end
		else begin ET12[47] = eTable[l12[47]];end
		if(l12[48] == 0)begin ET12[48] = 0;end
		else begin ET12[48] = eTable[l12[48]];end
		if(l12[49] == 0)begin ET12[49] = 0;end
		else begin ET12[49] = eTable[l12[49]];end
		if(l12[50] == 0)begin ET12[50] = 0;end
		else begin ET12[50] = eTable[l12[50]];end		
		if(l12[51] == 0)begin ET12[51] = 0;end
		else begin ET12[51] = eTable[l12[51]];end
		if(l12[52] == 0)begin ET12[52] = 0;end
		else begin ET12[52] = eTable[l12[52]];end
		if(l12[53] == 0)begin ET12[53] = 0;end
		else begin ET12[53] = eTable[l12[53]];end
		if(l12[54] == 0)begin ET12[54] = 0;end
		else begin ET12[54] = eTable[l12[54]];end
		if(l12[55] == 0)begin ET12[55] = 0;end
		else begin ET12[55] = eTable[l12[55]];end
		if(l12[56] == 0)begin ET12[56] = 0;end
		else begin ET12[56] = eTable[l12[56]];end
		if(l12[57] == 0)begin ET12[57] = 0;end
		else begin ET12[57] = eTable[l12[57]];end
		if(l12[58] == 0)begin ET12[58] = 0;end
		else begin ET12[58] = eTable[l12[58]];end
		if(l12[59] == 0)begin ET12[59] = 0;end
		else begin ET12[59] = eTable[l12[59]];end
		if(l12[60] == 0)begin ET12[60] = 0;end
		else begin ET12[60] = eTable[l12[60]];end	
		if(l12[61] == 0)begin ET12[61] = 0;end
		else begin ET12[61] = eTable[l12[61]];end
		if(l12[62] == 0)begin ET12[62] = 0;end
		else begin ET12[62] = eTable[l12[62]];end
		if(l12[63] == 0)begin ET12[63] = 0;end
		else begin ET12[63] = eTable[l12[63]];end
		next_state = 94;
	end
    94:begin
        d25[0] = ET12[0]^ET12[1]^ET12[2]^ET12[3];
        d25[1] = ET12[4]^ET12[5]^ET12[6]^ET12[7];
        d25[2] = ET12[8]^ET12[9]^ET12[10]^ET12[11];
        d25[3] = ET12[12]^ET12[13]^ET12[14]^ET12[15];
        d25[4] = ET12[16]^ET12[17]^ET12[18]^ET12[19];
        d25[5] = ET12[20]^ET12[21]^ET12[22]^ET12[23];
        d25[6] = ET12[24]^ET12[25]^ET12[26]^ET12[27];
        d25[7] = ET12[28]^ET12[29]^ET12[30]^ET12[31];
        d25[8] = ET12[32]^ET12[33]^ET12[34]^ET12[35];
        d25[9] = ET12[36]^ET12[37]^ET12[38]^ET12[39];
        d25[10] = ET12[40]^ET12[41]^ET12[42]^ET12[43];
        d25[11] = ET12[44]^ET12[45]^ET12[46]^ET12[47];
        d25[12] = ET12[48]^ET12[49]^ET12[50]^ET12[51];
        d25[13] = ET12[52]^ET12[53]^ET12[54]^ET12[55];
        d25[14] = ET12[56]^ET12[57]^ET12[58]^ET12[59];
        d25[15] =ET12[60]^ET12[61]^ET12[62]^ET12[63]; 
        next_state = 95;
    end
	95:begin
        tempRow13[0] = d25[0];tempRow13[4] = d25[4];tempRow13[8] = d25[8];tempRow13[12] = d25[12];
        tempRow13[1] = d25[13];tempRow13[5] = d25[1];tempRow13[9] = d25[5];tempRow13[13] = d25[9];
        tempRow13[2] = d25[10];tempRow13[6] = d25[14];tempRow13[10] = d25[2];tempRow13[14] = d25[6];
        tempRow13[3] = d25[7];tempRow13[7] = d25[11];tempRow13[11] = d25[15];tempRow13[15] = d25[3];
        next_state = 96;
	end
	96:begin
        tempSbox13[0] = inv_sbox[tempRow13[0]];tempSbox13[1] = inv_sbox[tempRow13[1]];tempSbox13[2] = inv_sbox[tempRow13[2]];tempSbox13[3] = inv_sbox[tempRow13[3]];
        tempSbox13[4] = inv_sbox[tempRow13[4]];tempSbox13[5] = inv_sbox[tempRow13[5]];tempSbox13[6] = inv_sbox[tempRow13[6]];tempSbox13[7] = inv_sbox[tempRow13[7]];
        tempSbox13[8] = inv_sbox[tempRow13[8]];tempSbox13[9] = inv_sbox[tempRow13[9]];tempSbox13[10] = inv_sbox[tempRow13[10]];tempSbox13[11] = inv_sbox[tempRow13[11]];
        tempSbox13[12] = inv_sbox[tempRow13[12]];tempSbox13[13] = inv_sbox[tempRow13[13]];tempSbox13[14] = inv_sbox[tempRow13[14]];tempSbox13[15] = inv_sbox[tempRow13[15]];
		next_state = 97;
	end
	97:begin
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
		next_state = 98;
	end
    98:begin
         w1[0] = {d26[0],d26[1],d26[2],d26[3]};
         w1[1] = {d26[4],d26[5],d26[6],d26[7]};
         w1[2] = {d26[8],d26[9],d26[10],d26[11]};
         w1[3] = {d26[12],d26[13],d26[14],d26[15]};
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
