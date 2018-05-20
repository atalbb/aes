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
//reg [7:0]d1[15:0];
reg [31:0]w[3:0];
reg [31:0]w1[3:0];
reg [31:0]w2[3:0];
reg [31:0]w3[3:0];
reg [31:0]w4[3:0];
reg [31:0]w5[3:0];
reg [31:0]w6[3:0];

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
reg [7:0]tempSbox[15:0];
reg [7:0]tempSbox1[15:0];
reg [7:0]tempSbox2[15:0];
reg [7:0]tempRow[15:0];
reg [7:0]tempRow1[15:0];
reg [7:0]tempRow2[15:0];
reg [7:0]tempRow3[15:0];
reg [7:0]tempRow4[15:0];
reg [7:0]tempRow5[15:0];
/* 16-bits wide because they hold sum of two 8 bits data */
reg [15:0]l[31:0];
reg [15:0]l1[31:0];
reg [15:0]l2[31:0];
reg [15:0]l3[31:0];
reg [15:0]l4[31:0];
reg [15:0]l5[31:0];
reg [15:0]l6[31:0];
reg [15:0]LT[31:0];
reg [15:0]LT1[31:0];
reg [15:0]LT2[31:0];
reg [15:0]LT3[31:0];
reg [15:0]LT4[31:0];
reg [15:0]LT5[31:0];
reg [15:0]LT6[31:0];
reg [7:0]ET[31:0];
reg [7:0]ET1[31:0];
reg [7:0]ET2[31:0];
reg [7:0]ET3[31:0];
reg [7:0]ET4[31:0];
reg [7:0]ET5[31:0];
reg [7:0]ET6[31:0];
    
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
        eTable[8'haf] = 8'h80;eTable[8'hb0] = 8'h9b;eTable[8'hb1] = 8'hbc;eTable[8'hb2] = 8'hc1;eTable[8'hb3] = 8'h58;
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
         next_state = 99;
     end
    99: begin
        cipher = {w3[0],w3[1],w3[2],w3[3]};
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