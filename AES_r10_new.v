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
                  input [1919:0]keyIn, // 60 words(32-bit) expanded key
                  input [127:0]dataIn, // 4 word(32-bit) data block
                  output reg encDone,
                  output reg [127:0]cipher,
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

reg [31:0]k[59:0];
reg [7:0]sbox[255:0];
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
reg [7:0]tempRow6[15:0];
reg [7:0]tempRow7[15:0];
reg [7:0]tempRow8[15:0];
reg [7:0]tempRow9[15:0];
/* 16-bits wide because they hold sum of two 8 bits data */
reg [15:0]l[31:0];
reg [15:0]l1[31:0];
reg [15:0]l2[31:0];
reg [15:0]l3[31:0];
reg [15:0]l4[31:0];
reg [15:0]l5[31:0];
reg [15:0]l6[31:0];
reg [15:0]l7[31:0];
reg [15:0]l8[31:0];
reg [15:0]l9[31:0];
reg [15:0]LT[31:0];
reg [15:0]LT1[31:0];
reg [15:0]LT2[31:0];
reg [15:0]LT3[31:0];
reg [15:0]LT4[31:0];
reg [15:0]LT5[31:0];
reg [15:0]LT6[31:0];
reg [15:0]LT7[31:0];
reg [15:0]LT8[31:0];
reg [15:0]LT9[31:0];
reg [7:0]ET[31:0];
reg [7:0]ET1[31:0];
reg [7:0]ET2[31:0];
reg [7:0]ET3[31:0];
reg [7:0]ET4[31:0];
reg [7:0]ET5[31:0];
reg [7:0]ET6[31:0];
reg [7:0]ET7[31:0];
reg [7:0]ET8[31:0];
reg [7:0]ET9[31:0];

    
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
        /* SBOX */
        sbox[8'h00] = 8'h63;sbox[8'h01] = 8'h7c;sbox[8'h02] = 8'h77;sbox[8'h03] = 8'h7b;sbox[8'h04] = 8'hf2;
        sbox[8'h05] = 8'h6b;sbox[8'h06] = 8'h6f;sbox[8'h07] = 8'hc5;sbox[8'h08] = 8'h30;sbox[8'h09] = 8'h01;               
        sbox[8'h0a] = 8'h67;sbox[8'h0b] = 8'h2b;sbox[8'h0c] = 8'hfe;sbox[8'h0d] = 8'hd7;sbox[8'h0e] = 8'hab;                           
        sbox[8'h0f] = 8'h76;sbox[8'h10] = 8'hca;sbox[8'h11] = 8'h82;sbox[8'h12] = 8'hc9;sbox[8'h13] = 8'h7d; 
        sbox[8'h14] = 8'hfa;sbox[8'h15] = 8'h59;sbox[8'h16] = 8'h47;sbox[8'h17] = 8'hf0;sbox[8'h18] = 8'had;                          
        sbox[8'h19] = 8'hd4;sbox[8'h1a] = 8'ha2;sbox[8'h1b] = 8'haf;sbox[8'h1c] = 8'h9c;sbox[8'h1d] = 8'ha4;   
        sbox[8'h1e] = 8'h72;sbox[8'h1f] = 8'hc0;sbox[8'h20] = 8'hb7;sbox[8'h21] = 8'hfd;sbox[8'h22] = 8'h93;   
        sbox[8'h23] = 8'h26;sbox[8'h24] = 8'h36;sbox[8'h25] = 8'h3f;sbox[8'h26] = 8'hf7;sbox[8'h27] = 8'hcc;                         
        sbox[8'h28] = 8'h34;sbox[8'h29] = 8'ha5;sbox[8'h2a] = 8'he5;sbox[8'h2b] = 8'hf1;sbox[8'h2c] = 8'h71;
        sbox[8'h2d] = 8'hd8;sbox[8'h2e] = 8'h31;sbox[8'h2f] = 8'h15;sbox[8'h30] = 8'h04;sbox[8'h31] = 8'hc7;
        sbox[8'h32] = 8'h23;sbox[8'h33] = 8'hc3;sbox[8'h34] = 8'h18;sbox[8'h35] = 8'h96;sbox[8'h36] = 8'h05;
        sbox[8'h37] = 8'h9a;sbox[8'h38] = 8'h07;sbox[8'h39] = 8'h12;sbox[8'h3a] = 8'h80;sbox[8'h3b] = 8'he2;                        
        sbox[8'h3c] = 8'heb;sbox[8'h3d] = 8'h27;sbox[8'h3e] = 8'hb2;sbox[8'h3f] = 8'h75;sbox[8'h40] = 8'h09;
        sbox[8'h41] = 8'h83;sbox[8'h42] = 8'h2c;sbox[8'h43] = 8'h1a;sbox[8'h44] = 8'h1b;sbox[8'h45] = 8'h6e;
        sbox[8'h46] = 8'h5a;sbox[8'h47] = 8'ha0;sbox[8'h48] = 8'h52;sbox[8'h49] = 8'h3b;sbox[8'h4a] = 8'hd6;
        sbox[8'h4b] = 8'hb3;sbox[8'h4c] = 8'h29;sbox[8'h4d] = 8'he3;sbox[8'h4e] = 8'h2f;sbox[8'h4f] = 8'h84;
        sbox[8'h50] = 8'h53;sbox[8'h51] = 8'hd1;sbox[8'h52] = 8'h00;sbox[8'h53] = 8'hed;sbox[8'h54] = 8'h20;                         
        sbox[8'h55] = 8'hfc;sbox[8'h56] = 8'hb1;sbox[8'h57] = 8'h5b;sbox[8'h58] = 8'h6a;sbox[8'h59] = 8'hcb;                            
        sbox[8'h5a] = 8'hbe;sbox[8'h5b] = 8'h39;sbox[8'h5c] = 8'h4a;sbox[8'h5d] = 8'h4c;sbox[8'h5e] = 8'h58;
        sbox[8'h5f] = 8'hcf;sbox[8'h60] = 8'hd0;sbox[8'h61] = 8'hef;sbox[8'h62] = 8'haa;sbox[8'h63] = 8'hfb;
        sbox[8'h64] = 8'h43;sbox[8'h65] = 8'h4d;sbox[8'h66] = 8'h33;sbox[8'h67] = 8'h85;sbox[8'h68] = 8'h45;
        sbox[8'h69] = 8'hf9;sbox[8'h6a] = 8'h02;sbox[8'h6b] = 8'h7f;sbox[8'h6c] = 8'h50;sbox[8'h6d] = 8'h3c;                         
        sbox[8'h6e] = 8'h9f;sbox[8'h6f] = 8'ha8;sbox[8'h70] = 8'h51;sbox[8'h71] = 8'ha3;sbox[8'h72] = 8'h40;
        sbox[8'h73] = 8'h8f;sbox[8'h74] = 8'h92;sbox[8'h75] = 8'h9d;sbox[8'h76] = 8'h38;sbox[8'h77] = 8'hf5;                        
        sbox[8'h78] = 8'hbc;sbox[8'h79] = 8'hb6;sbox[8'h7a] = 8'hda;sbox[8'h7b] = 8'h21;sbox[8'h7c] = 8'h10;
        sbox[8'h7d] = 8'hff;sbox[8'h7e] = 8'hf3;sbox[8'h7f] = 8'hd2;sbox[8'h80] = 8'hcd;sbox[8'h81] = 8'h0c;
        sbox[8'h82] = 8'h13;sbox[8'h83] = 8'hec;sbox[8'h84] = 8'h5f;sbox[8'h85] = 8'h97;sbox[8'h86] = 8'h44;                         
        sbox[8'h87] = 8'h17;sbox[8'h88] = 8'hc4;sbox[8'h89] = 8'ha7;sbox[8'h8a] = 8'h7e;sbox[8'h8b] = 8'h3d;
        sbox[8'h8c] = 8'h64;sbox[8'h8d] = 8'h5d;sbox[8'h8e] = 8'h19;sbox[8'h8f] = 8'h73;sbox[8'h90] = 8'h60;
        sbox[8'h91] = 8'h81;sbox[8'h92] = 8'h4f;sbox[8'h93] = 8'hdc;sbox[8'h94] = 8'h22;sbox[8'h95] = 8'h2a;
        sbox[8'h96] = 8'h90;sbox[8'h97] = 8'h88;sbox[8'h98] = 8'h46;sbox[8'h99] = 8'hee;sbox[8'h9a] = 8'hb8;
        sbox[8'h9b] = 8'h14;sbox[8'h9c] = 8'hde;sbox[8'h9d] = 8'h5e;sbox[8'h9e] = 8'h0b;sbox[8'h9f] = 8'hdb;                         
        sbox[8'ha0] = 8'he0;sbox[8'ha1] = 8'h32;sbox[8'ha2] = 8'h3a;sbox[8'ha3] = 8'h0a;sbox[8'ha4] = 8'h49;                                                
        sbox[8'ha5] = 8'h06;sbox[8'ha6] = 8'h24;sbox[8'ha7] = 8'h5c;sbox[8'ha8] = 8'hc2;sbox[8'ha9] = 8'hd3;
        sbox[8'haa] = 8'hac;sbox[8'hab] = 8'h62;sbox[8'hac] = 8'h91;sbox[8'had] = 8'h95;sbox[8'hae] = 8'he4;                                 
        sbox[8'haf] = 8'h79;sbox[8'hb0] = 8'he7;sbox[8'hb1] = 8'hc8;sbox[8'hb2] = 8'h37;sbox[8'hb3] = 8'h6d;
        sbox[8'hb4] = 8'h8d;sbox[8'hb5] = 8'hd5;sbox[8'hb6] = 8'h4e;sbox[8'hb7] = 8'ha9;sbox[8'hb8] = 8'h6c;
        sbox[8'hb9] = 8'h56;sbox[8'hba] = 8'hf4;sbox[8'hbb] = 8'hea;sbox[8'hbc] = 8'h65;sbox[8'hbd] = 8'h7a;                                
        sbox[8'hbe] = 8'hae;sbox[8'hbf] = 8'h08;sbox[8'hc0] = 8'hba;sbox[8'hc1] = 8'h78;sbox[8'hc2] = 8'h25;
        sbox[8'hc3] = 8'h2e;sbox[8'hc4] = 8'h1c;sbox[8'hc5] = 8'ha6;sbox[8'hc6] = 8'hb4;sbox[8'hc7] = 8'hc6;
        sbox[8'hc8] = 8'he8;sbox[8'hc9] = 8'hdd;sbox[8'hca] = 8'h74;sbox[8'hcb] = 8'h1f;sbox[8'hcc] = 8'h4b;
        sbox[8'hcd] = 8'hbd;sbox[8'hce] = 8'h8b;sbox[8'hcf] = 8'h8a;sbox[8'hd0] = 8'h70;sbox[8'hd1] = 8'h3e;
        sbox[8'hd2] = 8'hb5;sbox[8'hd3] = 8'h66;sbox[8'hd4] = 8'h48;sbox[8'hd5] = 8'h03;sbox[8'hd6] = 8'hf6;
        sbox[8'hd7] = 8'h0e;sbox[8'hd8] = 8'h61;sbox[8'hd9] = 8'h35;sbox[8'hda] = 8'h57;sbox[8'hdb] = 8'hb9; 
        sbox[8'hdc] = 8'h86;sbox[8'hdd] = 8'hc1;sbox[8'hde] = 8'h1d;sbox[8'hdf] = 8'h9e;sbox[8'he0] = 8'he1;  
        sbox[8'he1] = 8'hf8;sbox[8'he2] = 8'h98;sbox[8'he3] = 8'h11;sbox[8'he4] = 8'h69;sbox[8'he5] = 8'hd9;                                 
        sbox[8'he6] = 8'h8e;sbox[8'he7] = 8'h94;sbox[8'he8] = 8'h9b;sbox[8'he9] = 8'h1e;sbox[8'hea] = 8'h87;
        sbox[8'heb] = 8'he9;sbox[8'hec] = 8'hce;sbox[8'hed] = 8'h55;sbox[8'hee] = 8'h28;sbox[8'hef] = 8'hdf;                         
        sbox[8'hf0] = 8'h8c;sbox[8'hf1] = 8'ha1;sbox[8'hf2] = 8'h89;sbox[8'hf3] = 8'h0d;sbox[8'hf4] = 8'hbf;
        sbox[8'hf5] = 8'he6;sbox[8'hf6] = 8'h42;sbox[8'hf7] = 8'h68;sbox[8'hf8] = 8'h41;sbox[8'hf9] = 8'h99;                                
        sbox[8'hfa] = 8'h2d;sbox[8'hfb] = 8'h0f;sbox[8'hfc] = 8'hb0;sbox[8'hfd] = 8'h54;sbox[8'hfe] = 8'hbb;
        sbox[8'hff] = 8'h16;
        
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
        lTable[8'h3d] = 8'h93;lTable[8'h3e] = 8'hda;lTable[8'h3f] = 8'h83;lTable[8'h40] = 8'h96;lTable[8'h41] = 8'h8f;
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
            
            w[0] = 32'h00112233;w[1] = 32'h44556677;w[2] = 32'h8899aabb;w[3] = 32'hccddeeff;
            next_state = 3;
          end    
    end
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
    4:begin
        /* round[1].s_box => tempSbox[n] */
        tempSbox[0] = sbox[tempStart[0][31:24]];tempSbox[1] = sbox[tempStart[0][23:16]];tempSbox[2] = sbox[tempStart[0][15:8]];tempSbox[3] = sbox[tempStart[0][7:0]];
        tempSbox[4] = sbox[tempStart[1][31:24]];tempSbox[5] = sbox[tempStart[1][23:16]];tempSbox[6] = sbox[tempStart[1][15:8]];tempSbox[7] = sbox[tempStart[1][7:0]];
        tempSbox[8] = sbox[tempStart[2][31:24]];tempSbox[9] = sbox[tempStart[2][23:16]];tempSbox[10] = sbox[tempStart[2][15:8]];tempSbox[11] = sbox[tempStart[2][7:0]];
        tempSbox[12] = sbox[tempStart[3][31:24]];tempSbox[13] = sbox[tempStart[3][23:16]];tempSbox[14] = sbox[tempStart[3][15:8]];tempSbox[15] = sbox[tempStart[3][7:0]];
        next_state = 5;
    end
    5:begin
       /* round[1].s_row => tempRow[n] */
        tempRow[0] = tempSbox[0];tempRow[1] = tempSbox[5];tempRow[2] = tempSbox[10];tempRow[3] = tempSbox[15];
        tempRow[4] = tempSbox[4];tempRow[5] = tempSbox[9];tempRow[6] = tempSbox[14];tempRow[7] = tempSbox[3];
        tempRow[8] = tempSbox[8];tempRow[9] = tempSbox[13];tempRow[10] = tempSbox[2];tempRow[11] = tempSbox[7];
        tempRow[12] = tempSbox[12];tempRow[13] = tempSbox[1];tempRow[14] = tempSbox[6];tempRow[15] = tempSbox[11];
        next_state = 6;
    end
	6:begin
	    /* For b0 & b6*/
		if(tempRow[0] == 0)begin LT[0] = 0; LT[6] = 0;end
		else begin LT[0] = lTable[tempRow[0]] + lTable[2];LT[6] = lTable[tempRow[0]] + lTable[3];end
	    /* For b1 & b2*/
		if(tempRow[1] == 0)begin LT[1] = 0;LT[2] = 0;end
		else begin LT[1] = lTable[tempRow[1]] + lTable[3];LT[2] = lTable[tempRow[1]] + lTable[2];end
	    /* For b3 & b4*/
		if(tempRow[2] == 0)begin LT[3] = 0;LT[4] = 0;end
		else begin LT[3] = lTable[tempRow[2]] + lTable[3];LT[4] = lTable[tempRow[2]] + lTable[2];end
	    /* For b5 & b7*/			
		if(tempRow[3] == 0)begin LT[5] = 0;LT[7] = 0;end 
		else begin LT[5] = lTable[tempRow[3]] + lTable[3]; LT[7] = lTable[tempRow[3]] + lTable[2];end
	    /* For b8 & b14 */				
		if(tempRow[4] == 0)begin LT[8] = 0; LT[14] = 0;end
		else begin LT[8] = lTable[tempRow[4]] + lTable[2]; LT[14] = lTable[tempRow[4]] + lTable[3];end
		/* For b9 & b10 */
		if(tempRow[5] == 0)begin LT[9] = 0;LT[10] = 0;end
		else begin LT[9] = lTable[tempRow[5]] + lTable[3];LT[10] =  lTable[tempRow[5]] + lTable[2];end
		/* For b11 & b12*/
		if(tempRow[6] == 0)begin LT[11] = 0;LT[12] = 0;end
		else begin LT[11] = lTable[tempRow[6]] + lTable[3];LT[12] = lTable[tempRow[6]] + lTable[2]; end
		/* For b13 & b15 */
		if(tempRow[7] == 0)begin LT[13] = 0;LT[15] = 0;end
		else begin LT[13] = lTable[tempRow[7]] + lTable[3];LT[15] = lTable[tempRow[7]] + lTable[2];end
		/* For b16 & b22 */
		if(tempRow[8] == 0)begin LT[16] = 0;LT[22] = 0;end
		else begin LT[16] = lTable[tempRow[8]] + lTable[2];LT[22] = lTable[tempRow[8]] + lTable[3];end
		/* For b17 & 18 */
		if(tempRow[9] == 0)begin LT[17] = 0;LT[18] = 0;end
		else begin LT[17] = lTable[tempRow[9]] + lTable[3];LT[18] = lTable[tempRow[9]] + lTable[2];end
		/* For b19 & b20 */
		if(tempRow[10] == 0)begin LT[19] = 0;LT[20] = 0;end
		else begin LT[19] = lTable[tempRow[10]] + lTable[3];LT[20] = lTable[tempRow[10]] + lTable[2];end
		/* For b21 & b23 */
		if(tempRow[11] == 0)begin LT[21] = 0; LT[23] =0;end
		else begin LT[21] = lTable[tempRow[11]] + lTable[3];LT[23] = lTable[tempRow[11]] + lTable[2];end
		/* For b24 & b30 */
		if(tempRow[12] == 0)begin LT[24] = 0;LT[30] = 0;end 
		else begin LT[24] = lTable[tempRow[12]] + lTable[2];LT[30] = lTable[tempRow[12]] + lTable[3];end 
		/* For b25 & b26 */		
		if(tempRow[13] == 0)begin LT[25] = 0;LT[26] = 0;end 
		else begin LT[25] = lTable[tempRow[13]] + lTable[3];LT[26] = lTable[tempRow[13]] + lTable[2];end 
		/* For b27 & b28 */
		if(tempRow[14] == 0)begin LT[27] = 0;LT[28] = 0;end 
		else begin LT[27] = lTable[tempRow[14]] + lTable[3];LT[28] = lTable[tempRow[14]] + lTable[2];end 
		/* For b29 & b31 */
		if(tempRow[15] == 0)begin LT[29] = 0;LT[31] = 0;end 
		else begin LT[29] = lTable[tempRow[15]] + lTable[3];LT[31] =  lTable[tempRow[15]] + lTable[2];end 
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
		next_state = 9;
	end
	
   9:begin
        d[0] = ET[0]^ET[1] ^tempRow[2]^tempRow[3];
        d[1] = tempRow[0]^ET[2]^ET[3]^tempRow[3];
        d[2] = tempRow[0]^tempRow[1]^ET[4]^ET[5];
        d[3] = ET[6]^tempRow[1]^tempRow[2]^ET[7];
        d[4] = ET[8]^ET[9]^tempRow[6]^tempRow[7];
        d[5] = tempRow[4]^ET[10]^ET[11]^tempRow[7];
        d[6] = tempRow[4]^tempRow[5]^ET[12]^ET[13];
        d[7] = ET[14]^tempRow[5]^tempRow[6]^ET[15];
        d[8] = ET[16]^ET[17]^tempRow[10]^tempRow[11];
        d[9] = tempRow[8]^ET[18]^ET[19]^tempRow[11];
        d[10] = tempRow[8]^tempRow[9]^ET[20]^ET[21];
        d[11] = ET[22]^tempRow[9]^tempRow[10]^ET[23];
        d[12] = ET[24]^ET[25]^tempRow[14]^tempRow[15];
        d[13] = tempRow[12]^ET[26]^ET[27]^tempRow[15];
        d[14] = tempRow[12]^tempRow[13]^ET[28]^ET[29];
        d[15] = ET[30]^tempRow[13]^tempRow[14]^ET[31];                  
        next_state = 10;
    end
    10:begin
        /* round[1].m_col => w1[0] */
         w1[0] = {d[0],d[1],d[2],d[3]};
         w1[1] = {d[4],d[5],d[6],d[7]};
         w1[2] = {d[8],d[9],d[10],d[11]};
         w1[3] = {d[12],d[13],d[14],d[15]};
         next_state = 11;
     end
   11:begin
        /* round[1].input => w1[n] */
        /* round[1].sch => k[n] */
        /* round[2].start => tempStart1[n] */
        /* round[2].start = round[0].input XOR round[0].k_sch */
        tempStart1[0] = w1[0] ^ k[4];
        tempStart1[1] = w1[1] ^ k[5];
        tempStart1[2] = w1[2] ^ k[6];
        tempStart1[3] = w1[3] ^ k[7];
        next_state =  12;         
    end
    12:begin
        /* round[2].s_box => tempSbox1[n] */
        tempSbox1[0] = sbox[tempStart1[0][31:24]];tempSbox1[1] = sbox[tempStart1[0][23:16]];tempSbox1[2] = sbox[tempStart1[0][15:8]];tempSbox1[3] = sbox[tempStart1[0][7:0]];
        tempSbox1[4] = sbox[tempStart1[1][31:24]];tempSbox1[5] = sbox[tempStart1[1][23:16]];tempSbox1[6] = sbox[tempStart1[1][15:8]];tempSbox1[7] = sbox[tempStart1[1][7:0]];
        tempSbox1[8] = sbox[tempStart1[2][31:24]];tempSbox1[9] = sbox[tempStart1[2][23:16]];tempSbox1[10] = sbox[tempStart1[2][15:8]];tempSbox1[11] = sbox[tempStart1[2][7:0]];
        tempSbox1[12] = sbox[tempStart1[3][31:24]];tempSbox1[13] = sbox[tempStart1[3][23:16]];tempSbox1[14] = sbox[tempStart1[3][15:8]];tempSbox1[15] = sbox[tempStart1[3][7:0]];
        next_state = 13;
    end
    13:begin
       /* round[2].s_row => tempRow1[n] */
        tempRow1[0] = tempSbox1[0];tempRow1[1] = tempSbox1[5];tempRow1[2] = tempSbox1[10];tempRow1[3] = tempSbox1[15];
        tempRow1[4] = tempSbox1[4];tempRow1[5] = tempSbox1[9];tempRow1[6] = tempSbox1[14];tempRow1[7] = tempSbox1[3];
        tempRow1[8] = tempSbox1[8];tempRow1[9] = tempSbox1[13];tempRow1[10] = tempSbox1[2];tempRow1[11] = tempSbox1[7];
        tempRow1[12] = tempSbox1[12];tempRow1[13] = tempSbox1[1];tempRow1[14] = tempSbox1[6];tempRow1[15] = tempSbox1[11];
        next_state = 14;
    end
	14:begin
	    /* For b0 & b6*/
		if(tempRow1[0] == 0)begin LT1[0] = 0; LT1[6] = 0;end
		else begin LT1[0] = lTable[tempRow1[0]] + lTable[2];LT1[6] = lTable[tempRow1[0]] + lTable[3];end
	    /* For b1 & b2*/
		if(tempRow1[1] == 0)begin LT1[1] = 0;LT1[2] = 0;end
		else begin LT1[1] = lTable[tempRow1[1]] + lTable[3];LT1[2] = lTable[tempRow1[1]] + lTable[2];end
	    /* For b3 & b4*/
		if(tempRow1[2] == 0)begin LT1[3] = 0;LT1[4] = 0;end
		else begin LT1[3] = lTable[tempRow1[2]] + lTable[3];LT1[4] = lTable[tempRow1[2]] + lTable[2];end
	    /* For b5 & b7*/			
		if(tempRow1[3] == 0)begin LT1[5] = 0;LT1[7] = 0;end 
		else begin LT1[5] = lTable[tempRow1[3]] + lTable[3]; LT1[7] = lTable[tempRow1[3]] + lTable[2];end
	    /* For b8 & b14 */				
		if(tempRow1[4] == 0)begin LT1[8] = 0; LT1[14] = 0;end
		else begin LT1[8] = lTable[tempRow1[4]] + lTable[2]; LT1[14] = lTable[tempRow1[4]] + lTable[3];end
		/* For b9 & b10 */
		if(tempRow1[5] == 0)begin LT1[9] = 0;LT1[10] = 0;end
		else begin LT1[9] = lTable[tempRow1[5]] + lTable[3];LT1[10] =  lTable[tempRow1[5]] + lTable[2];end
		/* For b11 & b12*/
		if(tempRow1[6] == 0)begin LT1[11] = 0;LT1[12] = 0;end
		else begin LT1[11] = lTable[tempRow1[6]] + lTable[3];LT1[12] = lTable[tempRow1[6]] + lTable[2]; end
		/* For b13 & b15 */
		if(tempRow1[7] == 0)begin LT1[13] = 0;LT1[15] = 0;end
		else begin LT1[13] = lTable[tempRow1[7]] + lTable[3];LT1[15] = lTable[tempRow1[7]] + lTable[2];end
		/* For b16 & b22 */
		if(tempRow1[8] == 0)begin LT1[16] = 0;LT1[22] = 0;end
		else begin LT1[16] = lTable[tempRow1[8]] + lTable[2];LT1[22] = lTable[tempRow1[8]] + lTable[3];end
		/* For b17 & 18 */
		if(tempRow1[9] == 0)begin LT1[17] = 0;LT1[18] = 0;end
		else begin LT1[17] = lTable[tempRow1[9]] + lTable[3];LT1[18] = lTable[tempRow1[9]] + lTable[2];end
		/* For b19 & b20 */
		if(tempRow1[10] == 0)begin LT1[19] = 0;LT1[20] = 0;end
		else begin LT1[19] = lTable[tempRow1[10]] + lTable[3];LT1[20] = lTable[tempRow1[10]] + lTable[2];end
		/* For b21 & b23 */
		if(tempRow1[11] == 0)begin LT1[21] = 0; LT1[23] =0;end
		else begin LT1[21] = lTable[tempRow1[11]] + lTable[3];LT1[23] = lTable[tempRow1[11]] + lTable[2];end
		/* For b24 & b30 */
		if(tempRow1[12] == 0)begin LT1[24] = 0;LT1[30] = 0;end 
		else begin LT1[24] = lTable[tempRow1[12]] + lTable[2];LT1[30] = lTable[tempRow1[12]] + lTable[3];end 
		/* For b25 & b26 */		
		if(tempRow1[13] == 0)begin LT1[25] = 0;LT1[26] = 0;end 
		else begin LT1[25] = lTable[tempRow1[13]] + lTable[3];LT1[26] = lTable[tempRow1[13]] + lTable[2];end 
		/* For b27 & b28 */
		if(tempRow1[14] == 0)begin LT1[27] = 0;LT1[28] = 0;end 
		else begin LT1[27] = lTable[tempRow1[14]] + lTable[3];LT1[28] = lTable[tempRow1[14]] + lTable[2];end 
		/* For b29 & b31 */
		if(tempRow1[15] == 0)begin LT1[29] = 0;LT1[31] = 0;end 
		else begin LT1[29] = lTable[tempRow1[15]] + lTable[3];LT1[31] =  lTable[tempRow1[15]] + lTable[2];end 
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
		next_state = 16;
	end
	16:begin
		/* for d0 */
		if(l1[0] == 0)begin ET1[0] = 0;end
		else begin ET1[0] = eTable[l1[0]];end
		if(l1[1] == 0)begin ET1[1] = 0;end
		else begin ET1[1] = eTable[l1[1]];end
		/* for d1 */
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
		next_state = 17;
	end
	
   17:begin
        d1[0] = ET1[0]^ET1[1] ^tempRow1[2]^tempRow1[3];
        d1[1] = tempRow1[0]^ET1[2]^ET1[3]^tempRow1[3];
        d1[2] = tempRow1[0]^tempRow1[1]^ET1[4]^ET1[5];
        d1[3] = ET1[6]^tempRow1[1]^tempRow1[2]^ET1[7];
        d1[4] = ET1[8]^ET1[9]^tempRow1[6]^tempRow1[7];
        d1[5] = tempRow1[4]^ET1[10]^ET1[11]^tempRow1[7];
        d1[6] = tempRow1[4]^tempRow1[5]^ET1[12]^ET1[13];
        d1[7] = ET1[14]^tempRow1[5]^tempRow1[6]^ET1[15];
        d1[8] = ET1[16]^ET1[17]^tempRow1[10]^tempRow1[11];
        d1[9] = tempRow1[8]^ET1[18]^ET1[19]^tempRow1[11];
        d1[10] = tempRow1[8]^tempRow1[9]^ET1[20]^ET1[21];
        d1[11] = ET1[22]^tempRow1[9]^tempRow1[10]^ET1[23];
        d1[12] = ET1[24]^ET1[25]^tempRow1[14]^tempRow1[15];
        d1[13] = tempRow1[12]^ET1[26]^ET1[27]^tempRow1[15];
        d1[14] = tempRow1[12]^tempRow1[13]^ET1[28]^ET1[29];
        d1[15] = ET1[30]^tempRow1[13]^tempRow1[14]^ET1[31];                  
        next_state = 18;
    end
    18:begin
        /* round[2].m_col => w2[0] */
         w2[0] = {d1[0],d1[1],d1[2],d1[3]};
         w2[1] = {d1[4],d1[5],d1[6],d1[7]};
         w2[2] = {d1[8],d1[9],d1[10],d1[11]};
         w2[3] = {d1[12],d1[13],d1[14],d1[15]};
         next_state = 19;
     end
   19:begin
        /* round[2].input => w2[n] */
        /* round[2].sch => k[n] */
        /* round[3].start => tempStart2[n] */
        /* round[3].start = round[2].input XOR round[2].k_sch */
        tempStart2[0] = w2[0] ^ k[8];
        tempStart2[1] = w2[1] ^ k[9];
        tempStart2[2] = w2[2] ^ k[10];
        tempStart2[3] = w2[3] ^ k[11];
        next_state =  20;         
    end
    20:begin
        /* round[3].s_box => tempSbox2[n] */
        tempSbox2[0] = sbox[tempStart2[0][31:24]];tempSbox2[1] = sbox[tempStart2[0][23:16]];tempSbox2[2] = sbox[tempStart2[0][15:8]];tempSbox2[3] = sbox[tempStart2[0][7:0]];
        tempSbox2[4] = sbox[tempStart2[1][31:24]];tempSbox2[5] = sbox[tempStart2[1][23:16]];tempSbox2[6] = sbox[tempStart2[1][15:8]];tempSbox2[7] = sbox[tempStart2[1][7:0]];
        tempSbox2[8] = sbox[tempStart2[2][31:24]];tempSbox2[9] = sbox[tempStart2[2][23:16]];tempSbox2[10] = sbox[tempStart2[2][15:8]];tempSbox2[11] = sbox[tempStart2[2][7:0]];
        tempSbox2[12] = sbox[tempStart2[3][31:24]];tempSbox2[13] = sbox[tempStart2[3][23:16]];tempSbox2[14] = sbox[tempStart2[3][15:8]];tempSbox2[15] = sbox[tempStart2[3][7:0]];
        next_state = 21;
    end
    21:begin
       /* round[3].s_row => tempRow2[n] */
        tempRow2[0] = tempSbox2[0];tempRow2[1] = tempSbox2[5];tempRow2[2] = tempSbox2[10];tempRow2[3] = tempSbox2[15];
        tempRow2[4] = tempSbox2[4];tempRow2[5] = tempSbox2[9];tempRow2[6] = tempSbox2[14];tempRow2[7] = tempSbox2[3];
        tempRow2[8] = tempSbox2[8];tempRow2[9] = tempSbox2[13];tempRow2[10] = tempSbox2[2];tempRow2[11] = tempSbox2[7];
        tempRow2[12] = tempSbox2[12];tempRow2[13] = tempSbox2[1];tempRow2[14] = tempSbox2[6];tempRow2[15] = tempSbox2[11];
        next_state = 22;
    end
	22:begin
	    /* For b0 & b6*/
		if(tempRow2[0] == 0)begin LT2[0] = 0; LT2[6] = 0;end
		else begin LT2[0] = lTable[tempRow2[0]] + lTable[2];LT2[6] = lTable[tempRow2[0]] + lTable[3];end
	    /* For b1 & b2*/
		if(tempRow2[1] == 0)begin LT2[1] = 0;LT2[2] = 0;end
		else begin LT2[1] = lTable[tempRow2[1]] + lTable[3];LT2[2] = lTable[tempRow2[1]] + lTable[2];end
	    /* For b3 & b4*/
		if(tempRow2[2] == 0)begin LT2[3] = 0;LT2[4] = 0;end
		else begin LT2[3] = lTable[tempRow2[2]] + lTable[3];LT2[4] = lTable[tempRow2[2]] + lTable[2];end
	    /* For b5 & b7*/			
		if(tempRow2[3] == 0)begin LT2[5] = 0;LT2[7] = 0;end 
		else begin LT2[5] = lTable[tempRow2[3]] + lTable[3]; LT2[7] = lTable[tempRow2[3]] + lTable[2];end
	    /* For b8 & b14 */				
		if(tempRow2[4] == 0)begin LT2[8] = 0; LT2[14] = 0;end
		else begin LT2[8] = lTable[tempRow2[4]] + lTable[2]; LT2[14] = lTable[tempRow2[4]] + lTable[3];end
		/* For b9 & b10 */
		if(tempRow2[5] == 0)begin LT2[9] = 0;LT2[10] = 0;end
		else begin LT2[9] = lTable[tempRow2[5]] + lTable[3];LT2[10] =  lTable[tempRow2[5]] + lTable[2];end
		/* For b11 & b12*/
		if(tempRow2[6] == 0)begin LT2[11] = 0;LT2[12] = 0;end
		else begin LT2[11] = lTable[tempRow2[6]] + lTable[3];LT2[12] = lTable[tempRow2[6]] + lTable[2]; end
		/* For b13 & b15 */
		if(tempRow2[7] == 0)begin LT2[13] = 0;LT2[15] = 0;end
		else begin LT2[13] = lTable[tempRow2[7]] + lTable[3];LT2[15] = lTable[tempRow2[7]] + lTable[2];end
		/* For b16 & b22 */
		if(tempRow2[8] == 0)begin LT2[16] = 0;LT2[22] = 0;end
		else begin LT2[16] = lTable[tempRow2[8]] + lTable[2];LT2[22] = lTable[tempRow2[8]] + lTable[3];end
		/* For b17 & 18 */
		if(tempRow2[9] == 0)begin LT2[17] = 0;LT2[18] = 0;end
		else begin LT2[17] = lTable[tempRow2[9]] + lTable[3];LT2[18] = lTable[tempRow2[9]] + lTable[2];end
		/* For b19 & b20 */
		if(tempRow2[10] == 0)begin LT2[19] = 0;LT2[20] = 0;end
		else begin LT2[19] = lTable[tempRow2[10]] + lTable[3];LT2[20] = lTable[tempRow2[10]] + lTable[2];end
		/* For b21 & b23 */
		if(tempRow2[11] == 0)begin LT2[21] = 0; LT2[23] =0;end
		else begin LT2[21] = lTable[tempRow2[11]] + lTable[3];LT2[23] = lTable[tempRow2[11]] + lTable[2];end
		/* For b24 & b30 */
		if(tempRow2[12] == 0)begin LT2[24] = 0;LT2[30] = 0;end 
		else begin LT2[24] = lTable[tempRow2[12]] + lTable[2];LT2[30] = lTable[tempRow2[12]] + lTable[3];end 
		/* For b25 & b26 */		
		if(tempRow2[13] == 0)begin LT2[25] = 0;LT2[26] = 0;end 
		else begin LT2[25] = lTable[tempRow2[13]] + lTable[3];LT2[26] = lTable[tempRow2[13]] + lTable[2];end 
		/* For b27 & b28 */
		if(tempRow2[14] == 0)begin LT2[27] = 0;LT2[28] = 0;end 
		else begin LT2[27] = lTable[tempRow2[14]] + lTable[3];LT2[28] = lTable[tempRow2[14]] + lTable[2];end 
		/* For b29 & b31 */
		if(tempRow2[15] == 0)begin LT2[29] = 0;LT2[31] = 0;end 
		else begin LT2[29] = lTable[tempRow2[15]] + lTable[3];LT2[31] =  lTable[tempRow2[15]] + lTable[2];end 
		next_state = 23;
	end
	
    23:begin
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
		next_state = 24;
	end
	24:begin
		/* for d0 */
		if(l2[0] == 0)begin ET2[0] = 0;end
		else begin ET2[0] = eTable[l2[0]];end
		if(l2[1] == 0)begin ET2[1] = 0;end
		else begin ET2[1] = eTable[l2[1]];end
		/* for d2 */
		if(l2[2] == 0)begin ET2[2] = 0;end
		else begin ET2[2] = eTable[l2[2]];end
		if(l2[3] == 0)begin ET2[3] = 0;end
		else begin ET2[3] = eTable[l2[3]];end
		/* for d2 */
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
		next_state = 25;
	end
	
   25:begin
        d2[0] = ET2[0]^ET2[1] ^tempRow2[2]^tempRow2[3];
        d2[1] = tempRow2[0]^ET2[2]^ET2[3]^tempRow2[3];
        d2[2] = tempRow2[0]^tempRow2[1]^ET2[4]^ET2[5];
        d2[3] = ET2[6]^tempRow2[1]^tempRow2[2]^ET2[7];
        d2[4] = ET2[8]^ET2[9]^tempRow2[6]^tempRow2[7];
        d2[5] = tempRow2[4]^ET2[10]^ET2[11]^tempRow2[7];
        d2[6] = tempRow2[4]^tempRow2[5]^ET2[12]^ET2[13];
        d2[7] = ET2[14]^tempRow2[5]^tempRow2[6]^ET2[15];
        d2[8] = ET2[16]^ET2[17]^tempRow2[10]^tempRow2[11];
        d2[9] = tempRow2[8]^ET2[18]^ET2[19]^tempRow2[11];
        d2[10] = tempRow2[8]^tempRow2[9]^ET2[20]^ET2[21];
        d2[11] = ET2[22]^tempRow2[9]^tempRow2[10]^ET2[23];
        d2[12] = ET2[24]^ET2[25]^tempRow2[14]^tempRow2[15];
        d2[13] = tempRow2[12]^ET2[26]^ET2[27]^tempRow2[15];
        d2[14] = tempRow2[12]^tempRow2[13]^ET2[28]^ET2[29];
        d2[15] = ET2[30]^tempRow2[13]^tempRow2[14]^ET2[31];                  
        next_state = 26;
    end
    26:begin
        /* round[3].m_col => w3[0] */
         w3[0] = {d2[0],d2[1],d2[2],d2[3]};
         w3[1] = {d2[4],d2[5],d2[6],d2[7]};
         w3[2] = {d2[8],d2[9],d2[10],d2[11]};
         w3[3] = {d2[12],d2[13],d2[14],d2[15]};
         next_state = 27;
     end
   27:begin
        /* round[3].input => w3[n] */
        /* round[3].sch => k[n] */
        /* round[4].start => tempStart3[n] */
        /* round[4].start = round[2].input XOR round[2].k_sch */
        tempStart3[0] = w3[0] ^ k[12];
        tempStart3[1] = w3[1] ^ k[13];
        tempStart3[2] = w3[2] ^ k[14];
        tempStart3[3] = w3[3] ^ k[15];
        next_state =  28;         
    end
    28:begin
        /* round[4].s_box => tempSbox3[n] */
        tempSbox3[0] = sbox[tempStart3[0][31:24]];tempSbox3[1] = sbox[tempStart3[0][23:16]];tempSbox3[2] = sbox[tempStart3[0][15:8]];tempSbox3[3] = sbox[tempStart3[0][7:0]];
        tempSbox3[4] = sbox[tempStart3[1][31:24]];tempSbox3[5] = sbox[tempStart3[1][23:16]];tempSbox3[6] = sbox[tempStart3[1][15:8]];tempSbox3[7] = sbox[tempStart3[1][7:0]];
        tempSbox3[8] = sbox[tempStart3[2][31:24]];tempSbox3[9] = sbox[tempStart3[2][23:16]];tempSbox3[10] = sbox[tempStart3[2][15:8]];tempSbox3[11] = sbox[tempStart3[2][7:0]];
        tempSbox3[12] = sbox[tempStart3[3][31:24]];tempSbox3[13] = sbox[tempStart3[3][23:16]];tempSbox3[14] = sbox[tempStart3[3][15:8]];tempSbox3[15] = sbox[tempStart3[3][7:0]];
        next_state = 29;
    end
    29:begin
       /* round[4].s_row => tempRow3[n] */
        tempRow3[0] = tempSbox3[0];tempRow3[1] = tempSbox3[5];tempRow3[2] = tempSbox3[10];tempRow3[3] = tempSbox3[15];
        tempRow3[4] = tempSbox3[4];tempRow3[5] = tempSbox3[9];tempRow3[6] = tempSbox3[14];tempRow3[7] = tempSbox3[3];
        tempRow3[8] = tempSbox3[8];tempRow3[9] = tempSbox3[13];tempRow3[10] = tempSbox3[2];tempRow3[11] = tempSbox3[7];
        tempRow3[12] = tempSbox3[12];tempRow3[13] = tempSbox3[1];tempRow3[14] = tempSbox3[6];tempRow3[15] = tempSbox3[11];
        next_state = 30;
    end
	30:begin
	    /* For b0 & b6*/
		if(tempRow3[0] == 0)begin LT3[0] = 0; LT3[6] = 0;end
		else begin LT3[0] = lTable[tempRow3[0]] + lTable[2];LT3[6] = lTable[tempRow3[0]] + lTable[3];end
	    /* For b1 & b2*/
		if(tempRow3[1] == 0)begin LT3[1] = 0;LT3[2] = 0;end
		else begin LT3[1] = lTable[tempRow3[1]] + lTable[3];LT3[2] = lTable[tempRow3[1]] + lTable[2];end
	    /* For b3 & b4*/
		if(tempRow3[2] == 0)begin LT3[3] = 0;LT3[4] = 0;end
		else begin LT3[3] = lTable[tempRow3[2]] + lTable[3];LT3[4] = lTable[tempRow3[2]] + lTable[2];end
	    /* For b5 & b7*/			
		if(tempRow3[3] == 0)begin LT3[5] = 0;LT3[7] = 0;end 
		else begin LT3[5] = lTable[tempRow3[3]] + lTable[3]; LT3[7] = lTable[tempRow3[3]] + lTable[2];end
	    /* For b8 & b14 */				
		if(tempRow3[4] == 0)begin LT3[8] = 0; LT3[14] = 0;end
		else begin LT3[8] = lTable[tempRow3[4]] + lTable[2]; LT3[14] = lTable[tempRow3[4]] + lTable[3];end
		/* For b9 & b10 */
		if(tempRow3[5] == 0)begin LT3[9] = 0;LT3[10] = 0;end
		else begin LT3[9] = lTable[tempRow3[5]] + lTable[3];LT3[10] =  lTable[tempRow3[5]] + lTable[2];end
		/* For b11 & b12*/
		if(tempRow3[6] == 0)begin LT3[11] = 0;LT3[12] = 0;end
		else begin LT3[11] = lTable[tempRow3[6]] + lTable[3];LT3[12] = lTable[tempRow3[6]] + lTable[2]; end
		/* For b13 & b15 */
		if(tempRow3[7] == 0)begin LT3[13] = 0;LT3[15] = 0;end
		else begin LT3[13] = lTable[tempRow3[7]] + lTable[3];LT3[15] = lTable[tempRow3[7]] + lTable[2];end
		/* For b16 & b22 */
		if(tempRow3[8] == 0)begin LT3[16] = 0;LT3[22] = 0;end
		else begin LT3[16] = lTable[tempRow3[8]] + lTable[2];LT3[22] = lTable[tempRow3[8]] + lTable[3];end
		/* For b17 & 18 */
		if(tempRow3[9] == 0)begin LT3[17] = 0;LT3[18] = 0;end
		else begin LT3[17] = lTable[tempRow3[9]] + lTable[3];LT3[18] = lTable[tempRow3[9]] + lTable[2];end
		/* For b19 & b20 */
		if(tempRow3[10] == 0)begin LT3[19] = 0;LT3[20] = 0;end
		else begin LT3[19] = lTable[tempRow3[10]] + lTable[3];LT3[20] = lTable[tempRow3[10]] + lTable[2];end
		/* For b21 & b23 */
		if(tempRow3[11] == 0)begin LT3[21] = 0; LT3[23] =0;end
		else begin LT3[21] = lTable[tempRow3[11]] + lTable[3];LT3[23] = lTable[tempRow3[11]] + lTable[2];end
		/* For b24 & b30 */
		if(tempRow3[12] == 0)begin LT3[24] = 0;LT3[30] = 0;end 
		else begin LT3[24] = lTable[tempRow3[12]] + lTable[2];LT3[30] = lTable[tempRow3[12]] + lTable[3];end 
		/* For b25 & b26 */		
		if(tempRow3[13] == 0)begin LT3[25] = 0;LT3[26] = 0;end 
		else begin LT3[25] = lTable[tempRow3[13]] + lTable[3];LT3[26] = lTable[tempRow3[13]] + lTable[2];end 
		/* For b27 & b28 */
		if(tempRow3[14] == 0)begin LT3[27] = 0;LT3[28] = 0;end 
		else begin LT3[27] = lTable[tempRow3[14]] + lTable[3];LT3[28] = lTable[tempRow3[14]] + lTable[2];end 
		/* For b29 & b31 */
		if(tempRow3[15] == 0)begin LT3[29] = 0;LT3[31] = 0;end 
		else begin LT3[29] = lTable[tempRow3[15]] + lTable[3];LT3[31] =  lTable[tempRow3[15]] + lTable[2];end 
		next_state = 31;
	end
	
    31:begin
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
		next_state = 32;
	end
	32:begin
		/* for d0 */
		if(l3[0] == 0)begin ET3[0] = 0;end
		else begin ET3[0] = eTable[l3[0]];end
		if(l3[1] == 0)begin ET3[1] = 0;end
		else begin ET3[1] = eTable[l3[1]];end
		/* for d3 */
		if(l3[2] == 0)begin ET3[2] = 0;end
		else begin ET3[2] = eTable[l3[2]];end
		if(l3[3] == 0)begin ET3[3] = 0;end
		else begin ET3[3] = eTable[l3[3]];end
		/* for d3 */
		if(l3[4] == 0)begin ET3[4] = 0;end
		else begin ET3[4] = eTable[l3[4]];end
		if(l3[5] == 0)begin ET3[5] = 0;end
		else begin ET3[5] = eTable[l3[5]];end
		/* for d3 */
		if(l3[6] == 0)begin ET3[6] = 0;end
		else begin ET3[6] = eTable[l3[6]];end
		if(l3[7] == 0)begin ET3[7] = 0;end
		else begin ET3[7] = eTable[l3[7]];end
		/* for d3 */
		if(l3[8] == 0)begin ET3[8] = 0;end
		else begin ET3[8] = eTable[l3[8]];end
		if(l3[9] == 0)begin ET3[9] = 0;end
		else begin ET3[9] = eTable[l3[9]];end
		/* for d5 */
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
		next_state = 33;
	end
	
   33:begin
        d3[0] = ET3[0]^ET3[1] ^tempRow3[2]^tempRow3[3];
        d3[1] = tempRow3[0]^ET3[2]^ET3[3]^tempRow3[3];
        d3[2] = tempRow3[0]^tempRow3[1]^ET3[4]^ET3[5];
        d3[3] = ET3[6]^tempRow3[1]^tempRow3[2]^ET3[7];
        d3[4] = ET3[8]^ET3[9]^tempRow3[6]^tempRow3[7];
        d3[5] = tempRow3[4]^ET3[10]^ET3[11]^tempRow3[7];
        d3[6] = tempRow3[4]^tempRow3[5]^ET3[12]^ET3[13];
        d3[7] = ET3[14]^tempRow3[5]^tempRow3[6]^ET3[15];
        d3[8] = ET3[16]^ET3[17]^tempRow3[10]^tempRow3[11];
        d3[9] = tempRow3[8]^ET3[18]^ET3[19]^tempRow3[11];
        d3[10] = tempRow3[8]^tempRow3[9]^ET3[20]^ET3[21];
        d3[11] = ET3[22]^tempRow3[9]^tempRow3[10]^ET3[23];
        d3[12] = ET3[24]^ET3[25]^tempRow3[14]^tempRow3[15];
        d3[13] = tempRow3[12]^ET3[26]^ET3[27]^tempRow3[15];
        d3[14] = tempRow3[12]^tempRow3[13]^ET3[28]^ET3[29];
        d3[15] = ET3[30]^tempRow3[13]^tempRow3[14]^ET3[31];                  
        next_state = 34;
    end
    34:begin
        /* round[4].m_col => w4[0] */
         w4[0] = {d3[0],d3[1],d3[2],d3[3]};
         w4[1] = {d3[4],d3[5],d3[6],d3[7]};
         w4[2] = {d3[8],d3[9],d3[10],d3[11]};
         w4[3] = {d3[12],d3[13],d3[14],d3[15]};
         next_state = 35;
     end
   35:begin
        /* round[4].input => w4[n] */
        /* round[4].sch => k[n] */
        /* round[5].start => tempStart4[n] */
        /* round[5].start = round[2].input XOR round[2].k_sch */
        tempStart4[0] = w4[0] ^ k[16];
        tempStart4[1] = w4[1] ^ k[17];
        tempStart4[2] = w4[2] ^ k[18];
        tempStart4[3] = w4[3] ^ k[19];
        next_state =  36;         
    end
    36:begin
        /* round[5].s_box => tempSbox4[n] */
        tempSbox4[0] = sbox[tempStart4[0][31:24]];tempSbox4[1] = sbox[tempStart4[0][23:16]];tempSbox4[2] = sbox[tempStart4[0][15:8]];tempSbox4[3] = sbox[tempStart4[0][7:0]];
        tempSbox4[4] = sbox[tempStart4[1][31:24]];tempSbox4[5] = sbox[tempStart4[1][23:16]];tempSbox4[6] = sbox[tempStart4[1][15:8]];tempSbox4[7] = sbox[tempStart4[1][7:0]];
        tempSbox4[8] = sbox[tempStart4[2][31:24]];tempSbox4[9] = sbox[tempStart4[2][23:16]];tempSbox4[10] = sbox[tempStart4[2][15:8]];tempSbox4[11] = sbox[tempStart4[2][7:0]];
        tempSbox4[12] = sbox[tempStart4[3][31:24]];tempSbox4[13] = sbox[tempStart4[3][23:16]];tempSbox4[14] = sbox[tempStart4[3][15:8]];tempSbox4[15] = sbox[tempStart4[3][7:0]];
        next_state = 37;
    end
    37:begin
       /* round[5].s_row => tempRow4[n] */
        tempRow4[0] = tempSbox4[0];tempRow4[1] = tempSbox4[5];tempRow4[2] = tempSbox4[10];tempRow4[3] = tempSbox4[15];
        tempRow4[4] = tempSbox4[4];tempRow4[5] = tempSbox4[9];tempRow4[6] = tempSbox4[14];tempRow4[7] = tempSbox4[3];
        tempRow4[8] = tempSbox4[8];tempRow4[9] = tempSbox4[13];tempRow4[10] = tempSbox4[2];tempRow4[11] = tempSbox4[7];
        tempRow4[12] = tempSbox4[12];tempRow4[13] = tempSbox4[1];tempRow4[14] = tempSbox4[6];tempRow4[15] = tempSbox4[11];
        next_state = 38;
    end
	38:begin
	    /* For b0 & b6*/
		if(tempRow4[0] == 0)begin LT4[0] = 0; LT4[6] = 0;end
		else begin LT4[0] = lTable[tempRow4[0]] + lTable[2];LT4[6] = lTable[tempRow4[0]] + lTable[3];end
	    /* For b1 & b2*/
		if(tempRow4[1] == 0)begin LT4[1] = 0;LT4[2] = 0;end
		else begin LT4[1] = lTable[tempRow4[1]] + lTable[3];LT4[2] = lTable[tempRow4[1]] + lTable[2];end
	    /* For b3 & b4*/
		if(tempRow4[2] == 0)begin LT4[3] = 0;LT4[4] = 0;end
		else begin LT4[3] = lTable[tempRow4[2]] + lTable[3];LT4[4] = lTable[tempRow4[2]] + lTable[2];end
	    /* For b5 & b7*/			
		if(tempRow4[3] == 0)begin LT4[5] = 0;LT4[7] = 0;end 
		else begin LT4[5] = lTable[tempRow4[3]] + lTable[3]; LT4[7] = lTable[tempRow4[3]] + lTable[2];end
	    /* For b8 & b14 */				
		if(tempRow4[4] == 0)begin LT4[8] = 0; LT4[14] = 0;end
		else begin LT4[8] = lTable[tempRow4[4]] + lTable[2]; LT4[14] = lTable[tempRow4[4]] + lTable[3];end
		/* For b9 & b10 */
		if(tempRow4[5] == 0)begin LT4[9] = 0;LT4[10] = 0;end
		else begin LT4[9] = lTable[tempRow4[5]] + lTable[3];LT4[10] =  lTable[tempRow4[5]] + lTable[2];end
		/* For b11 & b12*/
		if(tempRow4[6] == 0)begin LT4[11] = 0;LT4[12] = 0;end
		else begin LT4[11] = lTable[tempRow4[6]] + lTable[3];LT4[12] = lTable[tempRow4[6]] + lTable[2]; end
		/* For b13 & b15 */
		if(tempRow4[7] == 0)begin LT4[13] = 0;LT4[15] = 0;end
		else begin LT4[13] = lTable[tempRow4[7]] + lTable[3];LT4[15] = lTable[tempRow4[7]] + lTable[2];end
		/* For b16 & b22 */
		if(tempRow4[8] == 0)begin LT4[16] = 0;LT4[22] = 0;end
		else begin LT4[16] = lTable[tempRow4[8]] + lTable[2];LT4[22] = lTable[tempRow4[8]] + lTable[3];end
		/* For b17 & 18 */
		if(tempRow4[9] == 0)begin LT4[17] = 0;LT4[18] = 0;end
		else begin LT4[17] = lTable[tempRow4[9]] + lTable[3];LT4[18] = lTable[tempRow4[9]] + lTable[2];end
		/* For b19 & b20 */
		if(tempRow4[10] == 0)begin LT4[19] = 0;LT4[20] = 0;end
		else begin LT4[19] = lTable[tempRow4[10]] + lTable[3];LT4[20] = lTable[tempRow4[10]] + lTable[2];end
		/* For b21 & b23 */
		if(tempRow4[11] == 0)begin LT4[21] = 0; LT4[23] =0;end
		else begin LT4[21] = lTable[tempRow4[11]] + lTable[3];LT4[23] = lTable[tempRow4[11]] + lTable[2];end
		/* For b24 & b30 */
		if(tempRow4[12] == 0)begin LT4[24] = 0;LT4[30] = 0;end 
		else begin LT4[24] = lTable[tempRow4[12]] + lTable[2];LT4[30] = lTable[tempRow4[12]] + lTable[3];end 
		/* For b25 & b26 */		
		if(tempRow4[13] == 0)begin LT4[25] = 0;LT4[26] = 0;end 
		else begin LT4[25] = lTable[tempRow4[13]] + lTable[3];LT4[26] = lTable[tempRow4[13]] + lTable[2];end 
		/* For b27 & b28 */
		if(tempRow4[14] == 0)begin LT4[27] = 0;LT4[28] = 0;end 
		else begin LT4[27] = lTable[tempRow4[14]] + lTable[3];LT4[28] = lTable[tempRow4[14]] + lTable[2];end 
		/* For b29 & b31 */
		if(tempRow4[15] == 0)begin LT4[29] = 0;LT4[31] = 0;end 
		else begin LT4[29] = lTable[tempRow4[15]] + lTable[3];LT4[31] =  lTable[tempRow4[15]] + lTable[2];end 
		next_state = 39;
	end
	
    39:begin
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
		next_state = 40;
	end
	40:begin
		/* for d0 */
		if(l4[0] == 0)begin ET4[0] = 0;end
		else begin ET4[0] = eTable[l4[0]];end
		if(l4[1] == 0)begin ET4[1] = 0;end
		else begin ET4[1] = eTable[l4[1]];end
		/* for d4 */
		if(l4[2] == 0)begin ET4[2] = 0;end
		else begin ET4[2] = eTable[l4[2]];end
		if(l4[3] == 0)begin ET4[3] = 0;end
		else begin ET4[3] = eTable[l4[3]];end
		/* for d4 */
		if(l4[4] == 0)begin ET4[4] = 0;end
		else begin ET4[4] = eTable[l4[4]];end
		if(l4[5] == 0)begin ET4[5] = 0;end
		else begin ET4[5] = eTable[l4[5]];end
		/* for d4 */
		if(l4[6] == 0)begin ET4[6] = 0;end
		else begin ET4[6] = eTable[l4[6]];end
		if(l4[7] == 0)begin ET4[7] = 0;end
		else begin ET4[7] = eTable[l4[7]];end
		/* for d4 */
		if(l4[8] == 0)begin ET4[8] = 0;end
		else begin ET4[8] = eTable[l4[8]];end
		if(l4[9] == 0)begin ET4[9] = 0;end
		else begin ET4[9] = eTable[l4[9]];end
		/* for d5 */
		if(l4[10] == 0)begin ET4[10] = 0;end
		else begin ET4[10] = eTable[l4[10]];end
		if(l4[11] == 0)begin ET4[11] = 0;end
		else begin ET4[11] = eTable[l4[11]];end
		/* for d6 */
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
		next_state = 41;
	end
	
   41:begin
        d4[0] = ET4[0]^ET4[1] ^tempRow4[2]^tempRow4[3];
        d4[1] = tempRow4[0]^ET4[2]^ET4[3]^tempRow4[3];
        d4[2] = tempRow4[0]^tempRow4[1]^ET4[4]^ET4[5];
        d4[3] = ET4[6]^tempRow4[1]^tempRow4[2]^ET4[7];
        d4[4] = ET4[8]^ET4[9]^tempRow4[6]^tempRow4[7];
        d4[5] = tempRow4[4]^ET4[10]^ET4[11]^tempRow4[7];
        d4[6] = tempRow4[4]^tempRow4[5]^ET4[12]^ET4[13];
        d4[7] = ET4[14]^tempRow4[5]^tempRow4[6]^ET4[15];
        d4[8] = ET4[16]^ET4[17]^tempRow4[10]^tempRow4[11];
        d4[9] = tempRow4[8]^ET4[18]^ET4[19]^tempRow4[11];
        d4[10] = tempRow4[8]^tempRow4[9]^ET4[20]^ET4[21];
        d4[11] = ET4[22]^tempRow4[9]^tempRow4[10]^ET4[23];
        d4[12] = ET4[24]^ET4[25]^tempRow4[14]^tempRow4[15];
        d4[13] = tempRow4[12]^ET4[26]^ET4[27]^tempRow4[15];
        d4[14] = tempRow4[12]^tempRow4[13]^ET4[28]^ET4[29];
        d4[15] = ET4[30]^tempRow4[13]^tempRow4[14]^ET4[31];                  
        next_state = 42;
        end
    42:begin
        /* round[5].m_col => w5[0] */
         w5[0] = {d4[0],d4[1],d4[2],d4[3]};
         w5[1] = {d4[4],d4[5],d4[6],d4[7]};
         w5[2] = {d4[8],d4[9],d4[10],d4[11]};
         w5[3] = {d4[12],d4[13],d4[14],d4[15]};
         next_state = 43;
     end
   43:begin
        /* round[5].input => w5[n] */
        /* round[5].sch => k[n] */
        /* round[6].start => tempStart5[n] */
        /* round[6].start = round[5].input XOR round[5].k_sch */
        tempStart5[0] = w5[0] ^ k[20];
        tempStart5[1] = w5[1] ^ k[21];
        tempStart5[2] = w5[2] ^ k[22];
        tempStart5[3] = w5[3] ^ k[23];
        next_state =  44;         
    end
    44:begin
        /* round[6].s_box => tempSbox5[n] */
        tempSbox5[0] = sbox[tempStart5[0][31:24]];tempSbox5[1] = sbox[tempStart5[0][23:16]];tempSbox5[2] = sbox[tempStart5[0][15:8]];tempSbox5[3] = sbox[tempStart5[0][7:0]];
        tempSbox5[4] = sbox[tempStart5[1][31:24]];tempSbox5[5] = sbox[tempStart5[1][23:16]];tempSbox5[6] = sbox[tempStart5[1][15:8]];tempSbox5[7] = sbox[tempStart5[1][7:0]];
        tempSbox5[8] = sbox[tempStart5[2][31:24]];tempSbox5[9] = sbox[tempStart5[2][23:16]];tempSbox5[10] = sbox[tempStart5[2][15:8]];tempSbox5[11] = sbox[tempStart5[2][7:0]];
        tempSbox5[12] = sbox[tempStart5[3][31:24]];tempSbox5[13] = sbox[tempStart5[3][23:16]];tempSbox5[14] = sbox[tempStart5[3][15:8]];tempSbox5[15] = sbox[tempStart5[3][7:0]];
        next_state = 45;
    end
    45:begin
       /* round[6].s_row => tempRow5[n] */
        tempRow5[0] = tempSbox5[0];tempRow5[1] = tempSbox5[5];tempRow5[2] = tempSbox5[10];tempRow5[3] = tempSbox5[15];
        tempRow5[4] = tempSbox5[4];tempRow5[5] = tempSbox5[9];tempRow5[6] = tempSbox5[14];tempRow5[7] = tempSbox5[3];
        tempRow5[8] = tempSbox5[8];tempRow5[9] = tempSbox5[13];tempRow5[10] = tempSbox5[2];tempRow5[11] = tempSbox5[7];
        tempRow5[12] = tempSbox5[12];tempRow5[13] = tempSbox5[1];tempRow5[14] = tempSbox5[6];tempRow5[15] = tempSbox5[11];
        next_state = 46;
    end
	46:begin
	    /* For b0 & b6*/
		if(tempRow5[0] == 0)begin LT5[0] = 0; LT5[6] = 0;end
		else begin LT5[0] = lTable[tempRow5[0]] + lTable[2];LT5[6] = lTable[tempRow5[0]] + lTable[3];end
	    /* For b1 & b2*/
		if(tempRow5[1] == 0)begin LT5[1] = 0;LT5[2] = 0;end
		else begin LT5[1] = lTable[tempRow5[1]] + lTable[3];LT5[2] = lTable[tempRow5[1]] + lTable[2];end
	    /* For b3 & b4*/
		if(tempRow5[2] == 0)begin LT5[3] = 0;LT5[4] = 0;end
		else begin LT5[3] = lTable[tempRow5[2]] + lTable[3];LT5[4] = lTable[tempRow5[2]] + lTable[2];end
	    /* For b5 & b7*/			
		if(tempRow5[3] == 0)begin LT5[5] = 0;LT5[7] = 0;end 
		else begin LT5[5] = lTable[tempRow5[3]] + lTable[3]; LT5[7] = lTable[tempRow5[3]] + lTable[2];end
	    /* For b8 & b14 */				
		if(tempRow5[4] == 0)begin LT5[8] = 0; LT5[14] = 0;end
		else begin LT5[8] = lTable[tempRow5[4]] + lTable[2]; LT5[14] = lTable[tempRow5[4]] + lTable[3];end
		/* For b9 & b10 */
		if(tempRow5[5] == 0)begin LT5[9] = 0;LT5[10] = 0;end
		else begin LT5[9] = lTable[tempRow5[5]] + lTable[3];LT5[10] =  lTable[tempRow5[5]] + lTable[2];end
		/* For b11 & b12*/
		if(tempRow5[6] == 0)begin LT5[11] = 0;LT5[12] = 0;end
		else begin LT5[11] = lTable[tempRow5[6]] + lTable[3];LT5[12] = lTable[tempRow5[6]] + lTable[2]; end
		/* For b13 & b15 */
		if(tempRow5[7] == 0)begin LT5[13] = 0;LT5[15] = 0;end
		else begin LT5[13] = lTable[tempRow5[7]] + lTable[3];LT5[15] = lTable[tempRow5[7]] + lTable[2];end
		/* For b16 & b22 */
		if(tempRow5[8] == 0)begin LT5[16] = 0;LT5[22] = 0;end
		else begin LT5[16] = lTable[tempRow5[8]] + lTable[2];LT5[22] = lTable[tempRow5[8]] + lTable[3];end
		/* For b17 & 18 */
		if(tempRow5[9] == 0)begin LT5[17] = 0;LT5[18] = 0;end
		else begin LT5[17] = lTable[tempRow5[9]] + lTable[3];LT5[18] = lTable[tempRow5[9]] + lTable[2];end
		/* For b19 & b20 */
		if(tempRow5[10] == 0)begin LT5[19] = 0;LT5[20] = 0;end
		else begin LT5[19] = lTable[tempRow5[10]] + lTable[3];LT5[20] = lTable[tempRow5[10]] + lTable[2];end
		/* For b21 & b23 */
		if(tempRow5[11] == 0)begin LT5[21] = 0; LT5[23] =0;end
		else begin LT5[21] = lTable[tempRow5[11]] + lTable[3];LT5[23] = lTable[tempRow5[11]] + lTable[2];end
		/* For b24 & b30 */
		if(tempRow5[12] == 0)begin LT5[24] = 0;LT5[30] = 0;end 
		else begin LT5[24] = lTable[tempRow5[12]] + lTable[2];LT5[30] = lTable[tempRow5[12]] + lTable[3];end 
		/* For b25 & b26 */		
		if(tempRow5[13] == 0)begin LT5[25] = 0;LT5[26] = 0;end 
		else begin LT5[25] = lTable[tempRow5[13]] + lTable[3];LT5[26] = lTable[tempRow5[13]] + lTable[2];end 
		/* For b27 & b28 */
		if(tempRow5[14] == 0)begin LT5[27] = 0;LT5[28] = 0;end 
		else begin LT5[27] = lTable[tempRow5[14]] + lTable[3];LT5[28] = lTable[tempRow5[14]] + lTable[2];end 
		/* For b29 & b31 */
		if(tempRow5[15] == 0)begin LT5[29] = 0;LT5[31] = 0;end 
		else begin LT5[29] = lTable[tempRow5[15]] + lTable[3];LT5[31] =  lTable[tempRow5[15]] + lTable[2];end 
		next_state = 47;
	end
	
    47:begin
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
		next_state = 48;
	end
	48:begin
		/* for d0 */
		if(l5[0] == 0)begin ET5[0] = 0;end
		else begin ET5[0] = eTable[l5[0]];end
		if(l5[1] == 0)begin ET5[1] = 0;end
		else begin ET5[1] = eTable[l5[1]];end
		/* for d5 */
		if(l5[2] == 0)begin ET5[2] = 0;end
		else begin ET5[2] = eTable[l5[2]];end
		if(l5[3] == 0)begin ET5[3] = 0;end
		else begin ET5[3] = eTable[l5[3]];end
		/* for d5 */
		if(l5[4] == 0)begin ET5[4] = 0;end
		else begin ET5[4] = eTable[l5[4]];end
		if(l5[5] == 0)begin ET5[5] = 0;end
		else begin ET5[5] = eTable[l5[5]];end
		/* for d5 */
		if(l5[6] == 0)begin ET5[6] = 0;end
		else begin ET5[6] = eTable[l5[6]];end
		if(l5[7] == 0)begin ET5[7] = 0;end
		else begin ET5[7] = eTable[l5[7]];end
		/* for d5 */
		if(l5[8] == 0)begin ET5[8] = 0;end
		else begin ET5[8] = eTable[l5[8]];end
		if(l5[9] == 0)begin ET5[9] = 0;end
		else begin ET5[9] = eTable[l5[9]];end
		/* for d5 */
		if(l5[10] == 0)begin ET5[10] = 0;end
		else begin ET5[10] = eTable[l5[10]];end
		if(l5[11] == 0)begin ET5[11] = 0;end
		else begin ET5[11] = eTable[l5[11]];end
		/* for d6 */
		if(l5[12] == 0)begin ET5[12] = 0;end
		else begin ET5[12] = eTable[l5[12]];end
		if(l5[13] == 0)begin ET5[13] = 0;end
		else begin ET5[13] = eTable[l5[13]];end
		/* for d7 */
		if(l5[14] == 0)begin ET5[14] = 0;end
		else begin ET5[14] = eTable[l5[14]];end
		if(l5[15] == 0)begin ET5[15] = 0;end
		else begin ET5[15] = eTable[l5[15]];end
		/* for d8 */
		if(l5[16] == 0)begin ET5[16] = 0;end
		else begin ET5[16] = eTable[l5[16]];end
		if(l5[17] == 0)begin ET5[17] = 0;end
		else begin ET5[17] = eTable[l5[17]];end
		/* for d9 */
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
		next_state = 49;
	end
	
   49:begin
        d5[0] = ET5[0]^ET5[1] ^tempRow5[2]^tempRow5[3];
        d5[1] = tempRow5[0]^ET5[2]^ET5[3]^tempRow5[3];
        d5[2] = tempRow5[0]^tempRow5[1]^ET5[4]^ET5[5];
        d5[3] = ET5[6]^tempRow5[1]^tempRow5[2]^ET5[7];
        d5[4] = ET5[8]^ET5[9]^tempRow5[6]^tempRow5[7];
        d5[5] = tempRow5[4]^ET5[10]^ET5[11]^tempRow5[7];
        d5[6] = tempRow5[4]^tempRow5[5]^ET5[12]^ET5[13];
        d5[7] = ET5[14]^tempRow5[5]^tempRow5[6]^ET5[15];
        d5[8] = ET5[16]^ET5[17]^tempRow5[10]^tempRow5[11];
        d5[9] = tempRow5[8]^ET5[18]^ET5[19]^tempRow5[11];
        d5[10] = tempRow5[8]^tempRow5[9]^ET5[20]^ET5[21];
        d5[11] = ET5[22]^tempRow5[9]^tempRow5[10]^ET5[23];
        d5[12] = ET5[24]^ET5[25]^tempRow5[14]^tempRow5[15];
        d5[13] = tempRow5[12]^ET5[26]^ET5[27]^tempRow5[15];
        d5[14] = tempRow5[12]^tempRow5[13]^ET5[28]^ET5[29];
        d5[15] = ET5[30]^tempRow5[13]^tempRow5[14]^ET5[31];                  
        next_state = 50;
        end
    50:begin
        /* round[6].m_col => w6[0] */
         w6[0] = {d5[0],d5[1],d5[2],d5[3]};
         w6[1] = {d5[4],d5[5],d5[6],d5[7]};
         w6[2] = {d5[8],d5[9],d5[10],d5[11]};
         w6[3] = {d5[12],d5[13],d5[14],d5[15]};
         next_state = 51;
     end
   51:begin
        /* round[6].input => w6[n] */
        /* round[6].sch => k[n] */
        /* round[7].start => tempStart6[n] */
        /* round[7].start = round[6].input XOR round[6].k_sch */
        tempStart6[0] = w6[0] ^ k[24];
        tempStart6[1] = w6[1] ^ k[25];
        tempStart6[2] = w6[2] ^ k[26];
        tempStart6[3] = w6[3] ^ k[27];
        next_state =  52;         
    end
    52:begin
        /* round[7].s_box => tempSbox6[n] */
        tempSbox6[0] = sbox[tempStart6[0][31:24]];tempSbox6[1] = sbox[tempStart6[0][23:16]];tempSbox6[2] = sbox[tempStart6[0][15:8]];tempSbox6[3] = sbox[tempStart6[0][7:0]];
        tempSbox6[4] = sbox[tempStart6[1][31:24]];tempSbox6[5] = sbox[tempStart6[1][23:16]];tempSbox6[6] = sbox[tempStart6[1][15:8]];tempSbox6[7] = sbox[tempStart6[1][7:0]];
        tempSbox6[8] = sbox[tempStart6[2][31:24]];tempSbox6[9] = sbox[tempStart6[2][23:16]];tempSbox6[10] = sbox[tempStart6[2][15:8]];tempSbox6[11] = sbox[tempStart6[2][7:0]];
        tempSbox6[12] = sbox[tempStart6[3][31:24]];tempSbox6[13] = sbox[tempStart6[3][23:16]];tempSbox6[14] = sbox[tempStart6[3][15:8]];tempSbox6[15] = sbox[tempStart6[3][7:0]];
        next_state = 53;
    end
    53:begin
       /* round[7].s_row => tempRow6[n] */
        tempRow6[0] = tempSbox6[0];tempRow6[1] = tempSbox6[5];tempRow6[2] = tempSbox6[10];tempRow6[3] = tempSbox6[15];
        tempRow6[4] = tempSbox6[4];tempRow6[5] = tempSbox6[9];tempRow6[6] = tempSbox6[14];tempRow6[7] = tempSbox6[3];
        tempRow6[8] = tempSbox6[8];tempRow6[9] = tempSbox6[13];tempRow6[10] = tempSbox6[2];tempRow6[11] = tempSbox6[7];
        tempRow6[12] = tempSbox6[12];tempRow6[13] = tempSbox6[1];tempRow6[14] = tempSbox6[6];tempRow6[15] = tempSbox6[11];
        next_state = 54;
    end
	54:begin
	    /* For b0 & b6*/
		if(tempRow6[0] == 0)begin LT6[0] = 0; LT6[6] = 0;end
		else begin LT6[0] = lTable[tempRow6[0]] + lTable[2];LT6[6] = lTable[tempRow6[0]] + lTable[3];end
	    /* For b1 & b2*/
		if(tempRow6[1] == 0)begin LT6[1] = 0;LT6[2] = 0;end
		else begin LT6[1] = lTable[tempRow6[1]] + lTable[3];LT6[2] = lTable[tempRow6[1]] + lTable[2];end
	    /* For b3 & b4*/
		if(tempRow6[2] == 0)begin LT6[3] = 0;LT6[4] = 0;end
		else begin LT6[3] = lTable[tempRow6[2]] + lTable[3];LT6[4] = lTable[tempRow6[2]] + lTable[2];end
	    /* For b5 & b7*/			
		if(tempRow6[3] == 0)begin LT6[5] = 0;LT6[7] = 0;end 
		else begin LT6[5] = lTable[tempRow6[3]] + lTable[3]; LT6[7] = lTable[tempRow6[3]] + lTable[2];end
	    /* For b8 & b14 */				
		if(tempRow6[4] == 0)begin LT6[8] = 0; LT6[14] = 0;end
		else begin LT6[8] = lTable[tempRow6[4]] + lTable[2]; LT6[14] = lTable[tempRow6[4]] + lTable[3];end
		/* For b9 & b10 */
		if(tempRow6[5] == 0)begin LT6[9] = 0;LT6[10] = 0;end
		else begin LT6[9] = lTable[tempRow6[5]] + lTable[3];LT6[10] =  lTable[tempRow6[5]] + lTable[2];end
		/* For b11 & b12*/
		if(tempRow6[6] == 0)begin LT6[11] = 0;LT6[12] = 0;end
		else begin LT6[11] = lTable[tempRow6[6]] + lTable[3];LT6[12] = lTable[tempRow6[6]] + lTable[2]; end
		/* For b13 & b15 */
		if(tempRow6[7] == 0)begin LT6[13] = 0;LT6[15] = 0;end
		else begin LT6[13] = lTable[tempRow6[7]] + lTable[3];LT6[15] = lTable[tempRow6[7]] + lTable[2];end
		/* For b16 & b22 */
		if(tempRow6[8] == 0)begin LT6[16] = 0;LT6[22] = 0;end
		else begin LT6[16] = lTable[tempRow6[8]] + lTable[2];LT6[22] = lTable[tempRow6[8]] + lTable[3];end
		/* For b17 & 18 */
		if(tempRow6[9] == 0)begin LT6[17] = 0;LT6[18] = 0;end
		else begin LT6[17] = lTable[tempRow6[9]] + lTable[3];LT6[18] = lTable[tempRow6[9]] + lTable[2];end
		/* For b19 & b20 */
		if(tempRow6[10] == 0)begin LT6[19] = 0;LT6[20] = 0;end
		else begin LT6[19] = lTable[tempRow6[10]] + lTable[3];LT6[20] = lTable[tempRow6[10]] + lTable[2];end
		/* For b21 & b23 */
		if(tempRow6[11] == 0)begin LT6[21] = 0; LT6[23] =0;end
		else begin LT6[21] = lTable[tempRow6[11]] + lTable[3];LT6[23] = lTable[tempRow6[11]] + lTable[2];end
		/* For b24 & b30 */
		if(tempRow6[12] == 0)begin LT6[24] = 0;LT6[30] = 0;end 
		else begin LT6[24] = lTable[tempRow6[12]] + lTable[2];LT6[30] = lTable[tempRow6[12]] + lTable[3];end 
		/* For b25 & b26 */		
		if(tempRow6[13] == 0)begin LT6[25] = 0;LT6[26] = 0;end 
		else begin LT6[25] = lTable[tempRow6[13]] + lTable[3];LT6[26] = lTable[tempRow6[13]] + lTable[2];end 
		/* For b27 & b28 */
		if(tempRow6[14] == 0)begin LT6[27] = 0;LT6[28] = 0;end 
		else begin LT6[27] = lTable[tempRow6[14]] + lTable[3];LT6[28] = lTable[tempRow6[14]] + lTable[2];end 
		/* For b29 & b31 */
		if(tempRow6[15] == 0)begin LT6[29] = 0;LT6[31] = 0;end 
		else begin LT6[29] = lTable[tempRow6[15]] + lTable[3];LT6[31] =  lTable[tempRow6[15]] + lTable[2];end 
		next_state = 55;
	end
	
    55:begin
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
		next_state = 56;
	end
	56:begin
		/* for d0 */
		if(l6[0] == 0)begin ET6[0] = 0;end
		else begin ET6[0] = eTable[l6[0]];end
		if(l6[1] == 0)begin ET6[1] = 0;end
		else begin ET6[1] = eTable[l6[1]];end
		/* for d6 */
		if(l6[2] == 0)begin ET6[2] = 0;end
		else begin ET6[2] = eTable[l6[2]];end
		if(l6[3] == 0)begin ET6[3] = 0;end
		else begin ET6[3] = eTable[l6[3]];end
		/* for d6 */
		if(l6[4] == 0)begin ET6[4] = 0;end
		else begin ET6[4] = eTable[l6[4]];end
		if(l6[5] == 0)begin ET6[5] = 0;end
		else begin ET6[5] = eTable[l6[5]];end
		/* for d6 */
		if(l6[6] == 0)begin ET6[6] = 0;end
		else begin ET6[6] = eTable[l6[6]];end
		if(l6[7] == 0)begin ET6[7] = 0;end
		else begin ET6[7] = eTable[l6[7]];end
		/* for d6 */
		if(l6[8] == 0)begin ET6[8] = 0;end
		else begin ET6[8] = eTable[l6[8]];end
		if(l6[9] == 0)begin ET6[9] = 0;end
		else begin ET6[9] = eTable[l6[9]];end
		/* for d6 */
		if(l6[10] == 0)begin ET6[10] = 0;end
		else begin ET6[10] = eTable[l6[10]];end
		if(l6[11] == 0)begin ET6[11] = 0;end
		else begin ET6[11] = eTable[l6[11]];end
		/* for d6 */
		if(l6[12] == 0)begin ET6[12] = 0;end
		else begin ET6[12] = eTable[l6[12]];end
		if(l6[13] == 0)begin ET6[13] = 0;end
		else begin ET6[13] = eTable[l6[13]];end
		/* for d7 */
		if(l6[14] == 0)begin ET6[14] = 0;end
		else begin ET6[14] = eTable[l6[14]];end
		if(l6[15] == 0)begin ET6[15] = 0;end
		else begin ET6[15] = eTable[l6[15]];end
		/* for d8 */
		if(l6[16] == 0)begin ET6[16] = 0;end
		else begin ET6[16] = eTable[l6[16]];end
		if(l6[17] == 0)begin ET6[17] = 0;end
		else begin ET6[17] = eTable[l6[17]];end
		/* for d9 */
		if(l6[18] == 0)begin ET6[18] = 0;end
		else begin ET6[18] = eTable[l6[18]];end
		if(l6[19] == 0)begin ET6[19] = 0;end
		else begin ET6[19] = eTable[l6[19]];end
		/* for d10 */
		if(l6[20] == 0)begin ET6[20] = 0;end
		else begin ET6[20] = eTable[l6[20]];end
		if(l6[21] == 0)begin ET6[21] = 0;end
		else begin ET6[21] = eTable[l6[21]];end
		/* for d11 */
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
		next_state = 57;
	end
	
   57:begin
        d6[0] = ET6[0]^ET6[1] ^tempRow6[2]^tempRow6[3];
        d6[1] = tempRow6[0]^ET6[2]^ET6[3]^tempRow6[3];
        d6[2] = tempRow6[0]^tempRow6[1]^ET6[4]^ET6[5];
        d6[3] = ET6[6]^tempRow6[1]^tempRow6[2]^ET6[7];
        d6[4] = ET6[8]^ET6[9]^tempRow6[6]^tempRow6[7];
        d6[5] = tempRow6[4]^ET6[10]^ET6[11]^tempRow6[7];
        d6[6] = tempRow6[4]^tempRow6[5]^ET6[12]^ET6[13];
        d6[7] = ET6[14]^tempRow6[5]^tempRow6[6]^ET6[15];
        d6[8] = ET6[16]^ET6[17]^tempRow6[10]^tempRow6[11];
        d6[9] = tempRow6[8]^ET6[18]^ET6[19]^tempRow6[11];
        d6[10] = tempRow6[8]^tempRow6[9]^ET6[20]^ET6[21];
        d6[11] = ET6[22]^tempRow6[9]^tempRow6[10]^ET6[23];
        d6[12] = ET6[24]^ET6[25]^tempRow6[14]^tempRow6[15];
        d6[13] = tempRow6[12]^ET6[26]^ET6[27]^tempRow6[15];
        d6[14] = tempRow6[12]^tempRow6[13]^ET6[28]^ET6[29];
        d6[15] = ET6[30]^tempRow6[13]^tempRow6[14]^ET6[31];                  
        next_state = 58;
        end
    58:begin
        /* round[7].m_col => w7[0] */
         w7[0] = {d6[0],d6[1],d6[2],d6[3]};
         w7[1] = {d6[4],d6[5],d6[6],d6[7]};
         w7[2] = {d6[8],d6[9],d6[10],d6[11]};
         w7[3] = {d6[12],d6[13],d6[14],d6[15]};
         next_state = 59;
     end
   59:begin
        /* round[7].input => w7[n] */
        /* round[7].sch => k[n] */
        /* round[8].start => tempStart7[n] */
        /* round[8].start = round[7].input XOR round[7].k_sch */
        tempStart7[0] = w7[0] ^ k[28];
        tempStart7[1] = w7[1] ^ k[29];
        tempStart7[2] = w7[2] ^ k[30];
        tempStart7[3] = w7[3] ^ k[31];
        next_state =  60;         
    end
    60:begin
        /* round[8].s_box => tempSbox7[n] */
        tempSbox7[0] = sbox[tempStart7[0][31:24]];tempSbox7[1] = sbox[tempStart7[0][23:16]];tempSbox7[2] = sbox[tempStart7[0][15:8]];tempSbox7[3] = sbox[tempStart7[0][7:0]];
        tempSbox7[4] = sbox[tempStart7[1][31:24]];tempSbox7[5] = sbox[tempStart7[1][23:16]];tempSbox7[6] = sbox[tempStart7[1][15:8]];tempSbox7[7] = sbox[tempStart7[1][7:0]];
        tempSbox7[8] = sbox[tempStart7[2][31:24]];tempSbox7[9] = sbox[tempStart7[2][23:16]];tempSbox7[10] = sbox[tempStart7[2][15:8]];tempSbox7[11] = sbox[tempStart7[2][7:0]];
        tempSbox7[12] = sbox[tempStart7[3][31:24]];tempSbox7[13] = sbox[tempStart7[3][23:16]];tempSbox7[14] = sbox[tempStart7[3][15:8]];tempSbox7[15] = sbox[tempStart7[3][7:0]];
        next_state = 61;
    end
    61:begin
       /* round[8].s_row => tempRow7[n] */
        tempRow7[0] = tempSbox7[0];tempRow7[1] = tempSbox7[5];tempRow7[2] = tempSbox7[10];tempRow7[3] = tempSbox7[15];
        tempRow7[4] = tempSbox7[4];tempRow7[5] = tempSbox7[9];tempRow7[6] = tempSbox7[14];tempRow7[7] = tempSbox7[3];
        tempRow7[8] = tempSbox7[8];tempRow7[9] = tempSbox7[13];tempRow7[10] = tempSbox7[2];tempRow7[11] = tempSbox7[7];
        tempRow7[12] = tempSbox7[12];tempRow7[13] = tempSbox7[1];tempRow7[14] = tempSbox7[6];tempRow7[15] = tempSbox7[11];
        next_state = 62;
    end
	62:begin
	    /* For b0 & b6*/
		if(tempRow7[0] == 0)begin LT7[0] = 0; LT7[6] = 0;end
		else begin LT7[0] = lTable[tempRow7[0]] + lTable[2];LT7[6] = lTable[tempRow7[0]] + lTable[3];end
	    /* For b1 & b2*/
		if(tempRow7[1] == 0)begin LT7[1] = 0;LT7[2] = 0;end
		else begin LT7[1] = lTable[tempRow7[1]] + lTable[3];LT7[2] = lTable[tempRow7[1]] + lTable[2];end
	    /* For b3 & b4*/
		if(tempRow7[2] == 0)begin LT7[3] = 0;LT7[4] = 0;end
		else begin LT7[3] = lTable[tempRow7[2]] + lTable[3];LT7[4] = lTable[tempRow7[2]] + lTable[2];end
	    /* For b5 & b7*/			
		if(tempRow7[3] == 0)begin LT7[5] = 0;LT7[7] = 0;end 
		else begin LT7[5] = lTable[tempRow7[3]] + lTable[3]; LT7[7] = lTable[tempRow7[3]] + lTable[2];end
	    /* For b8 & b14 */				
		if(tempRow7[4] == 0)begin LT7[8] = 0; LT7[14] = 0;end
		else begin LT7[8] = lTable[tempRow7[4]] + lTable[2]; LT7[14] = lTable[tempRow7[4]] + lTable[3];end
		/* For b9 & b10 */
		if(tempRow7[5] == 0)begin LT7[9] = 0;LT7[10] = 0;end
		else begin LT7[9] = lTable[tempRow7[5]] + lTable[3];LT7[10] =  lTable[tempRow7[5]] + lTable[2];end
		/* For b11 & b12*/
		if(tempRow7[6] == 0)begin LT7[11] = 0;LT7[12] = 0;end
		else begin LT7[11] = lTable[tempRow7[6]] + lTable[3];LT7[12] = lTable[tempRow7[6]] + lTable[2]; end
		/* For b13 & b15 */
		if(tempRow7[7] == 0)begin LT7[13] = 0;LT7[15] = 0;end
		else begin LT7[13] = lTable[tempRow7[7]] + lTable[3];LT7[15] = lTable[tempRow7[7]] + lTable[2];end
		/* For b16 & b22 */
		if(tempRow7[8] == 0)begin LT7[16] = 0;LT7[22] = 0;end
		else begin LT7[16] = lTable[tempRow7[8]] + lTable[2];LT7[22] = lTable[tempRow7[8]] + lTable[3];end
		/* For b17 & 18 */
		if(tempRow7[9] == 0)begin LT7[17] = 0;LT7[18] = 0;end
		else begin LT7[17] = lTable[tempRow7[9]] + lTable[3];LT7[18] = lTable[tempRow7[9]] + lTable[2];end
		/* For b19 & b20 */
		if(tempRow7[10] == 0)begin LT7[19] = 0;LT7[20] = 0;end
		else begin LT7[19] = lTable[tempRow7[10]] + lTable[3];LT7[20] = lTable[tempRow7[10]] + lTable[2];end
		/* For b21 & b23 */
		if(tempRow7[11] == 0)begin LT7[21] = 0; LT7[23] =0;end
		else begin LT7[21] = lTable[tempRow7[11]] + lTable[3];LT7[23] = lTable[tempRow7[11]] + lTable[2];end
		/* For b24 & b30 */
		if(tempRow7[12] == 0)begin LT7[24] = 0;LT7[30] = 0;end 
		else begin LT7[24] = lTable[tempRow7[12]] + lTable[2];LT7[30] = lTable[tempRow7[12]] + lTable[3];end 
		/* For b25 & b26 */		
		if(tempRow7[13] == 0)begin LT7[25] = 0;LT7[26] = 0;end 
		else begin LT7[25] = lTable[tempRow7[13]] + lTable[3];LT7[26] = lTable[tempRow7[13]] + lTable[2];end 
		/* For b27 & b28 */
		if(tempRow7[14] == 0)begin LT7[27] = 0;LT7[28] = 0;end 
		else begin LT7[27] = lTable[tempRow7[14]] + lTable[3];LT7[28] = lTable[tempRow7[14]] + lTable[2];end 
		/* For b29 & b31 */
		if(tempRow7[15] == 0)begin LT7[29] = 0;LT7[31] = 0;end 
		else begin LT7[29] = lTable[tempRow7[15]] + lTable[3];LT7[31] =  lTable[tempRow7[15]] + lTable[2];end 
		next_state = 63;
	end
	
    63:begin
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
		next_state = 64;
	end
	64:begin
		/* for d0 */
		if(l7[0] == 0)begin ET7[0] = 0;end
		else begin ET7[0] = eTable[l7[0]];end
		if(l7[1] == 0)begin ET7[1] = 0;end
		else begin ET7[1] = eTable[l7[1]];end
		/* for d7 */
		if(l7[2] == 0)begin ET7[2] = 0;end
		else begin ET7[2] = eTable[l7[2]];end
		if(l7[3] == 0)begin ET7[3] = 0;end
		else begin ET7[3] = eTable[l7[3]];end
		/* for d7 */
		if(l7[4] == 0)begin ET7[4] = 0;end
		else begin ET7[4] = eTable[l7[4]];end
		if(l7[5] == 0)begin ET7[5] = 0;end
		else begin ET7[5] = eTable[l7[5]];end
		/* for d7 */
		if(l7[6] == 0)begin ET7[6] = 0;end
		else begin ET7[6] = eTable[l7[6]];end
		if(l7[7] == 0)begin ET7[7] = 0;end
		else begin ET7[7] = eTable[l7[7]];end
		/* for d7 */
		if(l7[8] == 0)begin ET7[8] = 0;end
		else begin ET7[8] = eTable[l7[8]];end
		if(l7[9] == 0)begin ET7[9] = 0;end
		else begin ET7[9] = eTable[l7[9]];end
		/* for d7 */
		if(l7[10] == 0)begin ET7[10] = 0;end
		else begin ET7[10] = eTable[l7[10]];end
		if(l7[11] == 0)begin ET7[11] = 0;end
		else begin ET7[11] = eTable[l7[11]];end
		/* for d7 */
		if(l7[12] == 0)begin ET7[12] = 0;end
		else begin ET7[12] = eTable[l7[12]];end
		if(l7[13] == 0)begin ET7[13] = 0;end
		else begin ET7[13] = eTable[l7[13]];end
		/* for d7 */
		if(l7[14] == 0)begin ET7[14] = 0;end
		else begin ET7[14] = eTable[l7[14]];end
		if(l7[15] == 0)begin ET7[15] = 0;end
		else begin ET7[15] = eTable[l7[15]];end
		/* for d8 */
		if(l7[16] == 0)begin ET7[16] = 0;end
		else begin ET7[16] = eTable[l7[16]];end
		if(l7[17] == 0)begin ET7[17] = 0;end
		else begin ET7[17] = eTable[l7[17]];end
		/* for d9 */
		if(l7[18] == 0)begin ET7[18] = 0;end
		else begin ET7[18] = eTable[l7[18]];end
		if(l7[19] == 0)begin ET7[19] = 0;end
		else begin ET7[19] = eTable[l7[19]];end
		/* for d10 */
		if(l7[20] == 0)begin ET7[20] = 0;end
		else begin ET7[20] = eTable[l7[20]];end
		if(l7[21] == 0)begin ET7[21] = 0;end
		else begin ET7[21] = eTable[l7[21]];end
		/* for d11 */
		if(l7[22] == 0)begin ET7[22] = 0;end
		else begin ET7[22] = eTable[l7[22]];end
		if(l7[23] == 0)begin ET7[23] = 0;end
		else begin ET7[23] = eTable[l7[23]];end
		/* for d12 */
		if(l7[24] == 0)begin ET7[24] = 0;end
		else begin ET7[24] = eTable[l7[24]];end
		if(l7[25] == 0)begin ET7[25] = 0;end
		else begin ET7[25] = eTable[l7[25]];end
		/* for d13 */
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
		next_state = 65;
	end	
   65:begin
        d7[0] = ET7[0]^ET7[1] ^tempRow7[2]^tempRow7[3];
        d7[1] = tempRow7[0]^ET7[2]^ET7[3]^tempRow7[3];
        d7[2] = tempRow7[0]^tempRow7[1]^ET7[4]^ET7[5];
        d7[3] = ET7[6]^tempRow7[1]^tempRow7[2]^ET7[7];
        d7[4] = ET7[8]^ET7[9]^tempRow7[6]^tempRow7[7];
        d7[5] = tempRow7[4]^ET7[10]^ET7[11]^tempRow7[7];
        d7[6] = tempRow7[4]^tempRow7[5]^ET7[12]^ET7[13];
        d7[7] = ET7[14]^tempRow7[5]^tempRow7[6]^ET7[15];
        d7[8] = ET7[16]^ET7[17]^tempRow7[10]^tempRow7[11];
        d7[9] = tempRow7[8]^ET7[18]^ET7[19]^tempRow7[11];
        d7[10] = tempRow7[8]^tempRow7[9]^ET7[20]^ET7[21];
        d7[11] = ET7[22]^tempRow7[9]^tempRow7[10]^ET7[23];
        d7[12] = ET7[24]^ET7[25]^tempRow7[14]^tempRow7[15];
        d7[13] = tempRow7[12]^ET7[26]^ET7[27]^tempRow7[15];
        d7[14] = tempRow7[12]^tempRow7[13]^ET7[28]^ET7[29];
        d7[15] = ET7[30]^tempRow7[13]^tempRow7[14]^ET7[31];                  
        next_state = 66;
        end
    66:begin
        /* round[8].m_col => w8[0] */
         w8[0] = {d7[0],d7[1],d7[2],d7[3]};
         w8[1] = {d7[4],d7[5],d7[6],d7[7]};
         w8[2] = {d7[8],d7[9],d7[10],d7[11]};
         w8[3] = {d7[12],d7[13],d7[14],d7[15]};
         next_state = 67;
     end
   67:begin
        /* round[8].input => w8[n] */
        /* round[8].sch => k[n] */
        /* round[9].start => tempStart8[n] */
        /* round[9].start = round[8].input XOR round[8].k_sch */
        tempStart8[0] = w8[0] ^ k[32];
        tempStart8[1] = w8[1] ^ k[33];
        tempStart8[2] = w8[2] ^ k[34];
        tempStart8[3] = w8[3] ^ k[35];
        next_state =  68;         
    end
    68:begin
        /* round[9].s_box => tempSbox8[n] */
        tempSbox8[0] = sbox[tempStart8[0][31:24]];tempSbox8[1] = sbox[tempStart8[0][23:16]];tempSbox8[2] = sbox[tempStart8[0][15:8]];tempSbox8[3] = sbox[tempStart8[0][7:0]];
        tempSbox8[4] = sbox[tempStart8[1][31:24]];tempSbox8[5] = sbox[tempStart8[1][23:16]];tempSbox8[6] = sbox[tempStart8[1][15:8]];tempSbox8[7] = sbox[tempStart8[1][7:0]];
        tempSbox8[8] = sbox[tempStart8[2][31:24]];tempSbox8[9] = sbox[tempStart8[2][23:16]];tempSbox8[10] = sbox[tempStart8[2][15:8]];tempSbox8[11] = sbox[tempStart8[2][7:0]];
        tempSbox8[12] = sbox[tempStart8[3][31:24]];tempSbox8[13] = sbox[tempStart8[3][23:16]];tempSbox8[14] = sbox[tempStart8[3][15:8]];tempSbox8[15] = sbox[tempStart8[3][7:0]];
        next_state = 69;
    end
    69:begin
       /* round[9].s_row => tempRow8[n] */
        tempRow8[0] = tempSbox8[0];tempRow8[1] = tempSbox8[5];tempRow8[2] = tempSbox8[10];tempRow8[3] = tempSbox8[15];
        tempRow8[4] = tempSbox8[4];tempRow8[5] = tempSbox8[9];tempRow8[6] = tempSbox8[14];tempRow8[7] = tempSbox8[3];
        tempRow8[8] = tempSbox8[8];tempRow8[9] = tempSbox8[13];tempRow8[10] = tempSbox8[2];tempRow8[11] = tempSbox8[7];
        tempRow8[12] = tempSbox8[12];tempRow8[13] = tempSbox8[1];tempRow8[14] = tempSbox8[6];tempRow8[15] = tempSbox8[11];
        next_state = 70;
    end
	70:begin
	    /* For b0 & b6*/
		if(tempRow8[0] == 0)begin LT8[0] = 0; LT8[6] = 0;end
		else begin LT8[0] = lTable[tempRow8[0]] + lTable[2];LT8[6] = lTable[tempRow8[0]] + lTable[3];end
	    /* For b1 & b2*/
		if(tempRow8[1] == 0)begin LT8[1] = 0;LT8[2] = 0;end
		else begin LT8[1] = lTable[tempRow8[1]] + lTable[3];LT8[2] = lTable[tempRow8[1]] + lTable[2];end
	    /* For b3 & b4*/
		if(tempRow8[2] == 0)begin LT8[3] = 0;LT8[4] = 0;end
		else begin LT8[3] = lTable[tempRow8[2]] + lTable[3];LT8[4] = lTable[tempRow8[2]] + lTable[2];end
	    /* For b5 & b7*/			
		if(tempRow8[3] == 0)begin LT8[5] = 0;LT8[7] = 0;end 
		else begin LT8[5] = lTable[tempRow8[3]] + lTable[3]; LT8[7] = lTable[tempRow8[3]] + lTable[2];end
	    /* For b8 & b14 */				
		if(tempRow8[4] == 0)begin LT8[8] = 0; LT8[14] = 0;end
		else begin LT8[8] = lTable[tempRow8[4]] + lTable[2]; LT8[14] = lTable[tempRow8[4]] + lTable[3];end
		/* For b9 & b10 */
		if(tempRow8[5] == 0)begin LT8[9] = 0;LT8[10] = 0;end
		else begin LT8[9] = lTable[tempRow8[5]] + lTable[3];LT8[10] =  lTable[tempRow8[5]] + lTable[2];end
		/* For b11 & b12*/
		if(tempRow8[6] == 0)begin LT8[11] = 0;LT8[12] = 0;end
		else begin LT8[11] = lTable[tempRow8[6]] + lTable[3];LT8[12] = lTable[tempRow8[6]] + lTable[2]; end
		/* For b13 & b15 */
		if(tempRow8[7] == 0)begin LT8[13] = 0;LT8[15] = 0;end
		else begin LT8[13] = lTable[tempRow8[7]] + lTable[3];LT8[15] = lTable[tempRow8[7]] + lTable[2];end
		/* For b16 & b22 */
		if(tempRow8[8] == 0)begin LT8[16] = 0;LT8[22] = 0;end
		else begin LT8[16] = lTable[tempRow8[8]] + lTable[2];LT8[22] = lTable[tempRow8[8]] + lTable[3];end
		/* For b17 & 18 */
		if(tempRow8[9] == 0)begin LT8[17] = 0;LT8[18] = 0;end
		else begin LT8[17] = lTable[tempRow8[9]] + lTable[3];LT8[18] = lTable[tempRow8[9]] + lTable[2];end
		/* For b19 & b20 */
		if(tempRow8[10] == 0)begin LT8[19] = 0;LT8[20] = 0;end
		else begin LT8[19] = lTable[tempRow8[10]] + lTable[3];LT8[20] = lTable[tempRow8[10]] + lTable[2];end
		/* For b21 & b23 */
		if(tempRow8[11] == 0)begin LT8[21] = 0; LT8[23] =0;end
		else begin LT8[21] = lTable[tempRow8[11]] + lTable[3];LT8[23] = lTable[tempRow8[11]] + lTable[2];end
		/* For b24 & b30 */
		if(tempRow8[12] == 0)begin LT8[24] = 0;LT8[30] = 0;end 
		else begin LT8[24] = lTable[tempRow8[12]] + lTable[2];LT8[30] = lTable[tempRow8[12]] + lTable[3];end 
		/* For b25 & b26 */		
		if(tempRow8[13] == 0)begin LT8[25] = 0;LT8[26] = 0;end 
		else begin LT8[25] = lTable[tempRow8[13]] + lTable[3];LT8[26] = lTable[tempRow8[13]] + lTable[2];end 
		/* For b27 & b28 */
		if(tempRow8[14] == 0)begin LT8[27] = 0;LT8[28] = 0;end 
		else begin LT8[27] = lTable[tempRow8[14]] + lTable[3];LT8[28] = lTable[tempRow8[14]] + lTable[2];end 
		/* For b29 & b31 */
		if(tempRow8[15] == 0)begin LT8[29] = 0;LT8[31] = 0;end 
		else begin LT8[29] = lTable[tempRow8[15]] + lTable[3];LT8[31] =  lTable[tempRow8[15]] + lTable[2];end 
		next_state = 71;
	end
	
    71:begin
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
		next_state = 72;
	end
	72:begin
		/* for d0 */
		if(l8[0] == 0)begin ET8[0] = 0;end
		else begin ET8[0] = eTable[l8[0]];end
		if(l8[1] == 0)begin ET8[1] = 0;end
		else begin ET8[1] = eTable[l8[1]];end
		/* for d8 */
		if(l8[2] == 0)begin ET8[2] = 0;end
		else begin ET8[2] = eTable[l8[2]];end
		if(l8[3] == 0)begin ET8[3] = 0;end
		else begin ET8[3] = eTable[l8[3]];end
		/* for d8 */
		if(l8[4] == 0)begin ET8[4] = 0;end
		else begin ET8[4] = eTable[l8[4]];end
		if(l8[5] == 0)begin ET8[5] = 0;end
		else begin ET8[5] = eTable[l8[5]];end
		/* for d8 */
		if(l8[6] == 0)begin ET8[6] = 0;end
		else begin ET8[6] = eTable[l8[6]];end
		if(l8[7] == 0)begin ET8[7] = 0;end
		else begin ET8[7] = eTable[l8[7]];end
		/* for d8 */
		if(l8[8] == 0)begin ET8[8] = 0;end
		else begin ET8[8] = eTable[l8[8]];end
		if(l8[9] == 0)begin ET8[9] = 0;end
		else begin ET8[9] = eTable[l8[9]];end
		/* for d8 */
		if(l8[10] == 0)begin ET8[10] = 0;end
		else begin ET8[10] = eTable[l8[10]];end
		if(l8[11] == 0)begin ET8[11] = 0;end
		else begin ET8[11] = eTable[l8[11]];end
		/* for d8 */
		if(l8[12] == 0)begin ET8[12] = 0;end
		else begin ET8[12] = eTable[l8[12]];end
		if(l8[13] == 0)begin ET8[13] = 0;end
		else begin ET8[13] = eTable[l8[13]];end
		/* for d8 */
		if(l8[14] == 0)begin ET8[14] = 0;end
		else begin ET8[14] = eTable[l8[14]];end
		if(l8[15] == 0)begin ET8[15] = 0;end
		else begin ET8[15] = eTable[l8[15]];end
		/* for d8 */
		if(l8[16] == 0)begin ET8[16] = 0;end
		else begin ET8[16] = eTable[l8[16]];end
		if(l8[17] == 0)begin ET8[17] = 0;end
		else begin ET8[17] = eTable[l8[17]];end
		/* for d9 */
		if(l8[18] == 0)begin ET8[18] = 0;end
		else begin ET8[18] = eTable[l8[18]];end
		if(l8[19] == 0)begin ET8[19] = 0;end
		else begin ET8[19] = eTable[l8[19]];end
		/* for d10 */
		if(l8[20] == 0)begin ET8[20] = 0;end
		else begin ET8[20] = eTable[l8[20]];end
		if(l8[21] == 0)begin ET8[21] = 0;end
		else begin ET8[21] = eTable[l8[21]];end
		/* for d11 */
		if(l8[22] == 0)begin ET8[22] = 0;end
		else begin ET8[22] = eTable[l8[22]];end
		if(l8[23] == 0)begin ET8[23] = 0;end
		else begin ET8[23] = eTable[l8[23]];end
		/* for d12 */
		if(l8[24] == 0)begin ET8[24] = 0;end
		else begin ET8[24] = eTable[l8[24]];end
		if(l8[25] == 0)begin ET8[25] = 0;end
		else begin ET8[25] = eTable[l8[25]];end
		/* for d13 */
		if(l8[26] == 0)begin ET8[26] = 0;end
		else begin ET8[26] = eTable[l8[26]];end
		if(l8[27] == 0)begin ET8[27] = 0;end
		else begin ET8[27] = eTable[l8[27]];end
		/* for d14 */
		if(l8[28] == 0)begin ET8[28] = 0;end
		else begin ET8[28] = eTable[l8[28]];end
		if(l8[29] == 0)begin ET8[29] = 0;end
		else begin ET8[29] = eTable[l8[29]];end
		/* for d15 */
		if(l8[30] == 0)begin ET8[30] = 0;end
		else begin ET8[30] = eTable[l8[30]];end
		if(l8[31] == 0)begin ET8[31] = 0;end
		else begin ET8[31] = eTable[l8[31]];end
		next_state = 73;
	end	
   73:begin
        d8[0] = ET8[0]^ET8[1] ^tempRow8[2]^tempRow8[3];
        d8[1] = tempRow8[0]^ET8[2]^ET8[3]^tempRow8[3];
        d8[2] = tempRow8[0]^tempRow8[1]^ET8[4]^ET8[5];
        d8[3] = ET8[6]^tempRow8[1]^tempRow8[2]^ET8[7];
        d8[4] = ET8[8]^ET8[9]^tempRow8[6]^tempRow8[7];
        d8[5] = tempRow8[4]^ET8[10]^ET8[11]^tempRow8[7];
        d8[6] = tempRow8[4]^tempRow8[5]^ET8[12]^ET8[13];
        d8[7] = ET8[14]^tempRow8[5]^tempRow8[6]^ET8[15];
        d8[8] = ET8[16]^ET8[17]^tempRow8[10]^tempRow8[11];
        d8[9] = tempRow8[8]^ET8[18]^ET8[19]^tempRow8[11];
        d8[10] = tempRow8[8]^tempRow8[9]^ET8[20]^ET8[21];
        d8[11] = ET8[22]^tempRow8[9]^tempRow8[10]^ET8[23];
        d8[12] = ET8[24]^ET8[25]^tempRow8[14]^tempRow8[15];
        d8[13] = tempRow8[12]^ET8[26]^ET8[27]^tempRow8[15];
        d8[14] = tempRow8[12]^tempRow8[13]^ET8[28]^ET8[29];
        d8[15] = ET8[30]^tempRow8[13]^tempRow8[14]^ET8[31];                  
        next_state = 74;
        end
    74:begin
        /* round[9].m_col => w9[0] */
         w9[0] = {d8[0],d8[1],d8[2],d8[3]};
         w9[1] = {d8[4],d8[5],d8[6],d8[7]};
         w9[2] = {d8[8],d8[9],d8[10],d8[11]};
         w9[3] = {d8[12],d8[13],d8[14],d8[15]};
         next_state = 75;
     end
   75:begin
        /* round[9].input => w9[n] */
        /* round[9].sch => k[n] */
        /* round[10].start => tempStart9[n] */
        /* round[10].start = round[8].input XOR round[8].k_sch */
        tempStart9[0] = w9[0] ^ k[36];
        tempStart9[1] = w9[1] ^ k[37];
        tempStart9[2] = w9[2] ^ k[38];
        tempStart9[3] = w9[3] ^ k[39];
        next_state =  76;         
    end
    76:begin
        /* round[10].s_box => tempSbox9[n] */
        tempSbox9[0] = sbox[tempStart9[0][31:24]];tempSbox9[1] = sbox[tempStart9[0][23:16]];tempSbox9[2] = sbox[tempStart9[0][15:8]];tempSbox9[3] = sbox[tempStart9[0][7:0]];
        tempSbox9[4] = sbox[tempStart9[1][31:24]];tempSbox9[5] = sbox[tempStart9[1][23:16]];tempSbox9[6] = sbox[tempStart9[1][15:8]];tempSbox9[7] = sbox[tempStart9[1][7:0]];
        tempSbox9[8] = sbox[tempStart9[2][31:24]];tempSbox9[9] = sbox[tempStart9[2][23:16]];tempSbox9[10] = sbox[tempStart9[2][15:8]];tempSbox9[11] = sbox[tempStart9[2][7:0]];
        tempSbox9[12] = sbox[tempStart9[3][31:24]];tempSbox9[13] = sbox[tempStart9[3][23:16]];tempSbox9[14] = sbox[tempStart9[3][15:8]];tempSbox9[15] = sbox[tempStart9[3][7:0]];
        next_state = 77;
    end
    77:begin
       /* round[9].s_row => tempRow9[n] */
        tempRow9[0] = tempSbox9[0];tempRow9[1] = tempSbox9[5];tempRow9[2] = tempSbox9[10];tempRow9[3] = tempSbox9[15];
        tempRow9[4] = tempSbox9[4];tempRow9[5] = tempSbox9[9];tempRow9[6] = tempSbox9[14];tempRow9[7] = tempSbox9[3];
        tempRow9[8] = tempSbox9[8];tempRow9[9] = tempSbox9[13];tempRow9[10] = tempSbox9[2];tempRow9[11] = tempSbox9[7];
        tempRow9[12] = tempSbox9[12];tempRow9[13] = tempSbox9[1];tempRow9[14] = tempSbox9[6];tempRow9[15] = tempSbox9[11];
        next_state = 78;
    end
	78:begin
	    /* For b0 & b6*/
		if(tempRow9[0] == 0)begin LT9[0] = 0; LT9[6] = 0;end
		else begin LT9[0] = lTable[tempRow9[0]] + lTable[2];LT9[6] = lTable[tempRow9[0]] + lTable[3];end
	    /* For b1 & b2*/
		if(tempRow9[1] == 0)begin LT9[1] = 0;LT9[2] = 0;end
		else begin LT9[1] = lTable[tempRow9[1]] + lTable[3];LT9[2] = lTable[tempRow9[1]] + lTable[2];end
	    /* For b3 & b4*/
		if(tempRow9[2] == 0)begin LT9[3] = 0;LT9[4] = 0;end
		else begin LT9[3] = lTable[tempRow9[2]] + lTable[3];LT9[4] = lTable[tempRow9[2]] + lTable[2];end
	    /* For b5 & b7*/			
		if(tempRow9[3] == 0)begin LT9[5] = 0;LT9[7] = 0;end 
		else begin LT9[5] = lTable[tempRow9[3]] + lTable[3]; LT9[7] = lTable[tempRow9[3]] + lTable[2];end
	    /* For b8 & b14 */				
		if(tempRow9[4] == 0)begin LT9[8] = 0; LT9[14] = 0;end
		else begin LT9[8] = lTable[tempRow9[4]] + lTable[2]; LT9[14] = lTable[tempRow9[4]] + lTable[3];end
		/* For b9 & b10 */
		if(tempRow9[5] == 0)begin LT9[9] = 0;LT9[10] = 0;end
		else begin LT9[9] = lTable[tempRow9[5]] + lTable[3];LT9[10] =  lTable[tempRow9[5]] + lTable[2];end
		/* For b11 & b12*/
		if(tempRow9[6] == 0)begin LT9[11] = 0;LT9[12] = 0;end
		else begin LT9[11] = lTable[tempRow9[6]] + lTable[3];LT9[12] = lTable[tempRow9[6]] + lTable[2]; end
		/* For b13 & b15 */
		if(tempRow9[7] == 0)begin LT9[13] = 0;LT9[15] = 0;end
		else begin LT9[13] = lTable[tempRow9[7]] + lTable[3];LT9[15] = lTable[tempRow9[7]] + lTable[2];end
		/* For b16 & b22 */
		if(tempRow9[8] == 0)begin LT9[16] = 0;LT9[22] = 0;end
		else begin LT9[16] = lTable[tempRow9[8]] + lTable[2];LT9[22] = lTable[tempRow9[8]] + lTable[3];end
		/* For b17 & 18 */
		if(tempRow9[9] == 0)begin LT9[17] = 0;LT9[18] = 0;end
		else begin LT9[17] = lTable[tempRow9[9]] + lTable[3];LT9[18] = lTable[tempRow9[9]] + lTable[2];end
		/* For b19 & b20 */
		if(tempRow9[10] == 0)begin LT9[19] = 0;LT9[20] = 0;end
		else begin LT9[19] = lTable[tempRow9[10]] + lTable[3];LT9[20] = lTable[tempRow9[10]] + lTable[2];end
		/* For b21 & b23 */
		if(tempRow9[11] == 0)begin LT9[21] = 0; LT9[23] =0;end
		else begin LT9[21] = lTable[tempRow9[11]] + lTable[3];LT9[23] = lTable[tempRow9[11]] + lTable[2];end
		/* For b24 & b30 */
		if(tempRow9[12] == 0)begin LT9[24] = 0;LT9[30] = 0;end 
		else begin LT9[24] = lTable[tempRow9[12]] + lTable[2];LT9[30] = lTable[tempRow9[12]] + lTable[3];end 
		/* For b25 & b26 */		
		if(tempRow9[13] == 0)begin LT9[25] = 0;LT9[26] = 0;end 
		else begin LT9[25] = lTable[tempRow9[13]] + lTable[3];LT9[26] = lTable[tempRow9[13]] + lTable[2];end 
		/* For b27 & b28 */
		if(tempRow9[14] == 0)begin LT9[27] = 0;LT9[28] = 0;end 
		else begin LT9[27] = lTable[tempRow9[14]] + lTable[3];LT9[28] = lTable[tempRow9[14]] + lTable[2];end 
		/* For b29 & b31 */
		if(tempRow9[15] == 0)begin LT9[29] = 0;LT9[31] = 0;end 
		else begin LT9[29] = lTable[tempRow9[15]] + lTable[3];LT9[31] =  lTable[tempRow9[15]] + lTable[2];end 
		next_state = 79;
	end
	
    79:begin
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
		next_state = 80;
	end
	80:begin
		/* for d0 */
		if(l9[0] == 0)begin ET9[0] = 0;end
		else begin ET9[0] = eTable[l9[0]];end
		if(l9[1] == 0)begin ET9[1] = 0;end
		else begin ET9[1] = eTable[l9[1]];end
		/* for d9 */
		if(l9[2] == 0)begin ET9[2] = 0;end
		else begin ET9[2] = eTable[l9[2]];end
		if(l9[3] == 0)begin ET9[3] = 0;end
		else begin ET9[3] = eTable[l9[3]];end
		/* for d9 */
		if(l9[4] == 0)begin ET9[4] = 0;end
		else begin ET9[4] = eTable[l9[4]];end
		if(l9[5] == 0)begin ET9[5] = 0;end
		else begin ET9[5] = eTable[l9[5]];end
		/* for d9 */
		if(l9[6] == 0)begin ET9[6] = 0;end
		else begin ET9[6] = eTable[l9[6]];end
		if(l9[7] == 0)begin ET9[7] = 0;end
		else begin ET9[7] = eTable[l9[7]];end
		/* for d9 */
		if(l9[8] == 0)begin ET9[8] = 0;end
		else begin ET9[8] = eTable[l9[8]];end
		if(l9[9] == 0)begin ET9[9] = 0;end
		else begin ET9[9] = eTable[l9[9]];end
		/* for d9 */
		if(l9[10] == 0)begin ET9[10] = 0;end
		else begin ET9[10] = eTable[l9[10]];end
		if(l9[11] == 0)begin ET9[11] = 0;end
		else begin ET9[11] = eTable[l9[11]];end
		/* for d9 */
		if(l9[12] == 0)begin ET9[12] = 0;end
		else begin ET9[12] = eTable[l9[12]];end
		if(l9[13] == 0)begin ET9[13] = 0;end
		else begin ET9[13] = eTable[l9[13]];end
		/* for d9 */
		if(l9[14] == 0)begin ET9[14] = 0;end
		else begin ET9[14] = eTable[l9[14]];end
		if(l9[15] == 0)begin ET9[15] = 0;end
		else begin ET9[15] = eTable[l9[15]];end
		/* for d9 */
		if(l9[16] == 0)begin ET9[16] = 0;end
		else begin ET9[16] = eTable[l9[16]];end
		if(l9[17] == 0)begin ET9[17] = 0;end
		else begin ET9[17] = eTable[l9[17]];end
		/* for d9 */
		if(l9[18] == 0)begin ET9[18] = 0;end
		else begin ET9[18] = eTable[l9[18]];end
		if(l9[19] == 0)begin ET9[19] = 0;end
		else begin ET9[19] = eTable[l9[19]];end
		/* for d10 */
		if(l9[20] == 0)begin ET9[20] = 0;end
		else begin ET9[20] = eTable[l9[20]];end
		if(l9[21] == 0)begin ET9[21] = 0;end
		else begin ET9[21] = eTable[l9[21]];end
		/* for d11 */
		if(l9[22] == 0)begin ET9[22] = 0;end
		else begin ET9[22] = eTable[l9[22]];end
		if(l9[23] == 0)begin ET9[23] = 0;end
		else begin ET9[23] = eTable[l9[23]];end
		/* for d12 */
		if(l9[24] == 0)begin ET9[24] = 0;end
		else begin ET9[24] = eTable[l9[24]];end
		if(l9[25] == 0)begin ET9[25] = 0;end
		else begin ET9[25] = eTable[l9[25]];end
		/* for d13 */
		if(l9[26] == 0)begin ET9[26] = 0;end
		else begin ET9[26] = eTable[l9[26]];end
		if(l9[27] == 0)begin ET9[27] = 0;end
		else begin ET9[27] = eTable[l9[27]];end
		/* for d14 */
		if(l9[28] == 0)begin ET9[28] = 0;end
		else begin ET9[28] = eTable[l9[28]];end
		if(l9[29] == 0)begin ET9[29] = 0;end
		else begin ET9[29] = eTable[l9[29]];end
		/* for d15 */
		if(l9[30] == 0)begin ET9[30] = 0;end
		else begin ET9[30] = eTable[l9[30]];end
		if(l9[31] == 0)begin ET9[31] = 0;end
		else begin ET9[31] = eTable[l9[31]];end
		next_state = 81;
	end	
   81:begin
        d9[0] = ET9[0]^ET9[1] ^tempRow9[2]^tempRow9[3];
        d9[1] = tempRow9[0]^ET9[2]^ET9[3]^tempRow9[3];
        d9[2] = tempRow9[0]^tempRow9[1]^ET9[4]^ET9[5];
        d9[3] = ET9[6]^tempRow9[1]^tempRow9[2]^ET9[7];
        d9[4] = ET9[8]^ET9[9]^tempRow9[6]^tempRow9[7];
        d9[5] = tempRow9[4]^ET9[10]^ET9[11]^tempRow9[7];
        d9[6] = tempRow9[4]^tempRow9[5]^ET9[12]^ET9[13];
        d9[7] = ET9[14]^tempRow9[5]^tempRow9[6]^ET9[15];
        d9[8] = ET9[16]^ET9[17]^tempRow9[10]^tempRow9[11];
        d9[9] = tempRow9[8]^ET9[18]^ET9[19]^tempRow9[11];
        d9[10] = tempRow9[8]^tempRow9[9]^ET9[20]^ET9[21];
        d9[11] = ET9[22]^tempRow9[9]^tempRow9[10]^ET9[23];
        d9[12] = ET9[24]^ET9[25]^tempRow9[14]^tempRow9[15];
        d9[13] = tempRow9[12]^ET9[26]^ET9[27]^tempRow9[15];
        d9[14] = tempRow9[12]^tempRow9[13]^ET9[28]^ET9[29];
        d9[15] = ET9[30]^tempRow9[13]^tempRow9[14]^ET9[31];                  
        next_state = 82;
        end
    82:begin
        /* round[10].m_col => w10[0] */
         w10[0] = {d9[0],d9[1],d9[2],d9[3]};
         w10[1] = {d9[4],d9[5],d9[6],d9[7]};
         w10[2] = {d9[8],d9[9],d9[10],d9[11]};
         w10[3] = {d9[12],d9[13],d9[14],d9[15]};
         next_state = 99;
     end
    99: begin
        cipher = {w10[0],w10[1],w10[2],w10[3]};
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