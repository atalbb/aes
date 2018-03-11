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
//reg [7:0]d1[15:0];
reg [31:0]w[3:0];
reg [31:0]w1[3:0];
reg [31:0]w2[3:0];
reg [31:0]w3[3:0];
reg [31:0]w4[3:0];

reg [31:0]k[59:0];
reg [7:0]sbox[255:0];
reg [7:0]eTable[255:0];
reg [7:0]lTable[255:0];
reg [31:0]tempStart[3:0];
reg [31:0]tempStart1[3:0];
reg [31:0]tempStart2[3:0];
reg [31:0]tempStart3[3:0];
reg [31:0]tempStart4[3:0];
reg [7:0]tempRow[15:0];
reg [7:0]tempRow1[15:0];
reg [7:0]tempRow2[15:0];
reg [7:0]tempRow3[15:0];
reg [7:0]tempRow4[15:0];
reg [8:0]l[63:0];
reg [8:0]l1[63:0];
reg [8:0]l2[63:0];
reg [8:0]l3[63:0];
reg [8:0]l4[63:0];
    
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
        tempStart[0] = w[0] ^ k[0];
        tempStart[1] = w[1] ^ k[1];
        tempStart[2] = w[2] ^ k[2];
        tempStart[3] = w[3] ^ k[3];
        next_state =  4;         
    end
   4:begin
    tempRow[0] = sbox[tempStart[0][31:24]];tempRow[13] = sbox[tempStart[0][23:16]];tempRow[10] = sbox[tempStart[0][15:8]];tempRow[7] = sbox[tempStart[0][7:0]];        
    tempRow[4] = sbox[tempStart[1][31:24]];tempRow[1] = sbox[tempStart[1][23:16]];tempRow[14] = sbox[tempStart[1][15:8]];tempRow[11] = sbox[tempStart[1][7:0]];
    tempRow[8] = sbox[tempStart[2][31:24]];tempRow[5] = sbox[tempStart[2][23:16]];tempRow[2] = sbox[tempStart[2][15:8]];tempRow[15] = sbox[tempStart[2][7:0]];
    tempRow[12] = sbox[tempStart[3][31:24]];tempRow[9] = sbox[tempStart[3][23:16]];tempRow[6] = sbox[tempStart[3][15:8]];tempRow[3] = sbox[tempStart[3][7:0]];  
    next_state =  5;       
   end
   5:begin
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
    /* For b8*/
       l[16] = lTable[tempRow[8]] + lTable[2];
       if(l[16] > 255)
           l[16] = l[16]-255;
       l[17] = lTable[tempRow[9]] + lTable[3];
       if(l[17] > 255)
           l[17] = l[17]-255;
    /* For b9 */
       l[18] = lTable[tempRow[9]] + lTable[2];
       if(l[18] > 255)
           l[18] = l[18]-255;
       l[19] = lTable[tempRow[10]] + lTable[3];
       if(l[19] > 255)
           l[19] = l[19]-255;
    /* For b10*/
       l[20] = lTable[tempRow[10]] + lTable[2];
       if(l[20] > 255)
           l[20] = l[20]-255;
       l[21] = lTable[tempRow[11]] + lTable[3];
           if(l[21] > 255)
               l[21] = l[21]-255;
    /* For b11*/
       l[22] = lTable[tempRow[8]] + lTable[3];
       if(l[22] > 255)
           l[22] = l[22]-255;
       l[23] = lTable[tempRow[11]] + lTable[2];
           if(l[23] > 255)
               l[23] = l[23]-255;    
    /* For b12*/
       l[24] = lTable[tempRow[12]] + lTable[2];
       if(l[24] > 255)
           l[24] = l[24]-255;
       l[25] = lTable[tempRow[13]] + lTable[3];
       if(l[25] > 255)
           l[25] = l[25]-255;
    /* For b13 */
       l[26] = lTable[tempRow[13]] + lTable[2];
       if(l[26] > 255)
           l[26] = l[26]-255;
       l[27] = lTable[tempRow[14]] + lTable[3];
       if(l[27] > 255)
           l[27] = l[27]-255;
    /* For b14*/
       l[28] = lTable[tempRow[14]] + lTable[2];
       if(l[28] > 255)
           l[28] = l[28]-255;
       l[29] = lTable[tempRow[15]] + lTable[3];
           if(l[29] > 255)
               l[29] = l[29]-255;
    /* For b15*/
       l[30] = lTable[tempRow[12]] + lTable[3];
       if(l[30] > 255)
           l[30] = l[30]-255;
       l[31] = lTable[tempRow[15]] + lTable[2];
           if(l[31] > 255)
               l[31] = l[31]-255;
       next_state = 6;
    end
   6:begin
        d[0] = eTable[l[0]]^eTable[l[1]]^tempRow[2]^tempRow[3];
        d[1] = tempRow[0]^eTable[l[2]]^eTable[l[3]]^tempRow[3];
        d[2] = tempRow[0]^tempRow[1]^eTable[l[4]]^eTable[l[5]];
        d[3] = eTable[l[6]]^tempRow[1]^tempRow[2]^eTable[l[7]];
        d[4] = eTable[l[8]]^eTable[l[9]]^tempRow[6]^tempRow[7];
        d[5] = tempRow[4]^eTable[l[10]]^eTable[l[11]]^tempRow[7];
        d[6] = tempRow[4]^tempRow[5]^eTable[l[12]]^eTable[l[13]];
        d[7] = eTable[l[14]]^tempRow[5]^tempRow[6]^eTable[l[15]];
        d[8] = eTable[l[16]]^eTable[l[17]]^tempRow[10]^tempRow[11];
        d[9] = tempRow[8]^eTable[l[18]]^eTable[l[19]]^tempRow[11];
        d[10] = tempRow[8]^tempRow[9]^eTable[l[20]]^eTable[l[21]];
        d[11] = eTable[l[22]]^tempRow[9]^tempRow[10]^eTable[l[23]];
        d[12] = eTable[l[24]]^eTable[l[25]]^tempRow[14]^tempRow[15];
        d[13] = tempRow[12]^eTable[l[26]]^eTable[l[27]]^tempRow[15];
        d[14] = tempRow[12]^tempRow[13]^eTable[l[28]]^eTable[l[29]];
        d[15] = eTable[l[30]]^tempRow[13]^tempRow[14]^eTable[l[31]];                  
        next_state = 7;
    end
    7:begin
         w1[0] = {d[0],d[1],d[2],d[3]};
         w1[1] = {d[4],d[5],d[6],d[7]};
         w1[2] = {d[8],d[9],d[10],d[11]};
         w1[3] = {d[12],d[13],d[14],d[15]};
         next_state = 99;
      end
    99: begin
        cipher = {w1[0],w1[1],w1[2],w1[3]};
        encDone =  1;  
        next_state = 100;
    end
    100:begin
          encDone =  1;
          ledDone = 1;  
          next_state = 100;
     end
        

        
        
        
        
        
        
        
        
        
                                               
                                                
                                                
                                                
                                                
                                                
                                                
                                                                               
                                         
                                         
                                        
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                        
        
        
        
        
       
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
                  
                                 
                                 
                                 
                                 
                                 
                                 
                                 



                                 


        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
       
       
        
       
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
                             
                                 
                                 
                                 
                                 
                                 
                                 
                                 
                                 
                                 
                                 
                                 
                                 
                                 
        
        
        
       
        
        
        
        
        
        
        
        
        
        
        
        
       
        
           
           
           
           
           
           
           
           
          
           
           
           
           
           
           
           
                     
                        
                         
                         
                         
                         
                         




                         




                         
                         










                









      8:begin
                  tempStart1[0] = w1[0] ^ k[4];
                  tempStart1[1] = w1[1] ^ k[5];
                  tempStart1[2] = w1[2] ^ k[6];
                  tempStart1[3] = w1[3] ^ k[7];
                  next_state = 9;  
                 end
       9:begin
                       tempRow1[0] = sbox[tempStart1[0][31:24]];
                       tempRow1[13] = sbox[tempStart1[0][23:16]];
                       tempRow1[10] = sbox[tempStart1[0][15:8]];
                       tempRow1[7] = sbox[tempStart1[0][7:0]];        
                       tempRow1[4] = sbox[tempStart1[1][31:24]];
                       tempRow1[1] = sbox[tempStart1[1][23:16]];
                       tempRow1[14] = sbox[tempStart1[1][15:8]];
                       tempRow1[11] = sbox[tempStart1[1][7:0]];
                       tempRow1[8] = sbox[tempStart1[2][31:24]];
                       tempRow1[5] = sbox[tempStart1[2][23:16]];
                       tempRow1[2] = sbox[tempStart1[2][15:8]];
                       tempRow1[15] = sbox[tempStart1[2][7:0]];
                       tempRow1[12] = sbox[tempStart1[3][31:24]];
                       tempRow1[9] = sbox[tempStart1[3][23:16]];
                       tempRow1[6] = sbox[tempStart1[3][15:8]];
                       tempRow1[3] = sbox[tempStart1[3][7:0]]; 
                  next_state = 10;  
                  end
      10:begin
                            /* For b0*/
                l1[0] = lTable[tempRow1[0]] + lTable[2];
                if(l1[0] > 255)
                l1[0] = l1[0]-255;
                l1[1] = lTable[tempRow1[1]] + lTable[3];
                if(l1[1] > 255)
                l1[1] = l1[1]-255;
                /* For b1 */
                l1[2] = lTable[tempRow1[1]] + lTable[2];
                if(l1[2] > 255)
                l1[2] = l1[2]-255;
                l1[3] = lTable[tempRow1[2]] + lTable[3];
                if(l1[3] > 255)
                l1[3] = l1[3]-255;
                /* For b2*/
                l1[4] = lTable[tempRow1[2]] + lTable[2];
                if(l1[4] > 255)
                l1[4] = l1[4]-255;
                l1[5] = lTable[tempRow1[3]] + lTable[3];
                if(l1[5] > 255)
                l1[5] = l1[5]-255;
                /* For b3*/
                l1[6] = lTable[tempRow1[0]] + lTable[3];
                if(l1[6] > 255)
                l1[6] = l1[6]-255;
                l1[7] = lTable[tempRow1[3]] + lTable[2];
                if(l1[7] > 255)
                l1[7] = l1[7]-255;            
                /* For b4*/
                l1[8] = lTable[tempRow1[4]] + lTable[2];
                if(l1[8] > 255)
                l1[8] = l1[8]-255;
                l1[9] = lTable[tempRow1[5]] + lTable[3];
                if(l1[9] > 255)
                l1[9] = l1[9]-255;
                /* For b5 */
                l1[10] = lTable[tempRow1[5]] + lTable[2];
                if(l1[10] > 255)
                l1[10] = l1[10]-255;
                l1[11] = lTable[tempRow1[6]] + lTable[3];
                if(l1[11] > 255)
                l1[11] = l1[11]-255;
                /* For b6*/
                l1[12] = lTable[tempRow1[6]] + lTable[2];
                if(l1[12] > 255)
                l1[12] = l1[12]-255;
                l1[13] = lTable[tempRow1[7]] + lTable[3];
                if(l1[13] > 255)
                l1[13] = l1[13]-255;
                /* For b7*/
                l1[14] = lTable[tempRow1[4]] + lTable[3];
                if(l1[14] > 255)
                l1[14] = l1[14]-255;
                l1[15] = lTable[tempRow1[7]] + lTable[2];
                if(l1[15] > 255)
                l1[15] = l1[15]-255;    
                /* For b8*/
                l1[16] = lTable[tempRow1[8]] + lTable[2];
                if(l1[16] > 255)
                l1[16] = l1[16]-255;
                l1[17] = lTable[tempRow1[9]] + lTable[3];
                if(l1[17] > 255)
                l1[17] = l1[17]-255;
                /* For b9 */
                l1[18] = lTable[tempRow1[9]] + lTable[2];
                if(l1[18] > 255)
                l1[18] = l1[18]-255;
                l1[19] = lTable[tempRow1[10]] + lTable[3];
                if(l1[19] > 255)
                l1[19] = l1[19]-255;
                /* For b10*/
                l1[20] = lTable[tempRow1[10]] + lTable[2];
                if(l1[20] > 255)
                l1[20] = l1[20]-255;
                l1[21] = lTable[tempRow1[11]] + lTable[3];
                if(l1[21] > 255)
                l1[21] = l1[21]-255;
                /* For b11*/
                l1[22] = lTable[tempRow1[8]] + lTable[3];
                if(l1[22] > 255)
                l1[22] = l1[22]-255;
                l1[23] = lTable[tempRow1[11]] + lTable[2];
                if(l1[23] > 255)
                l1[23] = l1[23]-255;    
                /* For b12*/
                l1[24] = lTable[tempRow1[12]] + lTable[2];
                if(l1[24] > 255)
                l1[24] = l1[24]-255;
                l1[25] = lTable[tempRow1[13]] + lTable[3];
                if(l1[25] > 255)
                l1[25] = l1[25]-255;
                /* For b13 */
                l1[26] = lTable[tempRow1[13]] + lTable[2];
                if(l1[26] > 255)
                l1[26] = l1[26]-255;
                l1[27] = lTable[tempRow1[14]] + lTable[3];
                if(l1[27] > 255)
                l1[27] = l1[27]-255;
                /* For b14*/
                l1[28] = lTable[tempRow1[14]] + lTable[2];
                if(l1[28] > 255)
                l1[28] = l1[28]-255;
                l1[29] = lTable[tempRow1[15]] + lTable[3];
                if(l1[29] > 255)
                l1[29] = l1[29]-255;
                /* For b15*/
                l1[30] = lTable[tempRow1[12]] + lTable[3];
                if(l1[30] > 255)
                l1[30] = l1[30]-255;
                l1[31] = lTable[tempRow1[15]] + lTable[2];
                if(l1[31] > 255)
                l1[31] = l1[31]-255;                         
                      next_state = 11;
                    end
       11:begin
                      d1[0] = eTable[l1[0]]^eTable[l1[1]]^tempRow1[2]^tempRow1[3];
                       d1[1] = tempRow1[0]^eTable[l1[2]]^eTable[l1[3]]^tempRow1[3];
                       d1[2] = tempRow1[0]^tempRow1[1]^eTable[l1[4]]^eTable[l1[5]];
                       d1[3] = eTable[l1[6]]^tempRow1[1]^tempRow1[2]^eTable[l1[7]];
                       d1[4] = eTable[l1[8]]^eTable[l1[9]]^tempRow1[6]^tempRow1[7];
                       d1[5] = tempRow1[4]^eTable[l1[10]]^eTable[l1[11]]^tempRow1[7];
                       d1[6] = tempRow1[4]^tempRow1[5]^eTable[l1[12]]^eTable[l1[13]];
                       d1[7] = eTable[l1[14]]^tempRow1[5]^tempRow1[6]^eTable[l1[15]];
                       d1[8] = eTable[l1[16]]^eTable[l1[17]]^tempRow1[10]^tempRow1[11];
                       d1[9] = tempRow1[8]^eTable[l1[18]]^eTable[l1[19]]^tempRow1[11];
                       d1[10] = tempRow1[8]^tempRow1[9]^eTable[l1[20]]^eTable[l1[21]];
                       d1[11] = eTable[l1[22]]^tempRow1[9]^tempRow1[10]^eTable[l1[23]];
                       d1[12] = eTable[l1[24]]^eTable[l1[25]]^tempRow1[14]^tempRow1[15];
                       d1[13] = tempRow1[12]^eTable[l1[26]]^eTable[l1[27]]^tempRow1[15];
                       d1[14] = tempRow1[12]^tempRow1[13]^eTable[l1[28]]^eTable[l1[29]];
                       d1[15] = eTable[l1[30]]^tempRow1[13]^tempRow1[14]^eTable[l1[31]];   
                        next_state = 12;      
                      end
       12:begin
                       w2[0] = {d1[0],d1[1],d1[2],d1[3]};
                       w2[1] = {d1[4],d1[5],d1[6],d1[7]};
                       w2[2] = {d1[8],d1[9],d1[10],d1[11]};
                       w2[3] = {d1[12],d1[13],d1[14],d1[15]};
                        next_state = 13;
                  end
       13:begin
       
                         tempStart2[0] = w2[0] ^ k[8];
                        tempStart2[1] = w2[1] ^ k[9];
                        tempStart2[2] = w2[2] ^ k[10];
                        tempStart2[3] = w2[3] ^ k[11];
                        next_state = 14;
                    end
        14:begin
                           tempRow2[0] = sbox[tempStart2[0][31:24]];
                           tempRow2[13] = sbox[tempStart2[0][23:16]];
                           tempRow2[10] = sbox[tempStart2[0][15:8]];
                           tempRow2[7] = sbox[tempStart2[0][7:0]];        
                           tempRow2[4] = sbox[tempStart2[1][31:24]];
                           tempRow2[1] = sbox[tempStart2[1][23:16]];
                           tempRow2[14] = sbox[tempStart2[1][15:8]];
                           tempRow2[11] = sbox[tempStart2[1][7:0]];
                           tempRow2[8] = sbox[tempStart2[2][31:24]];
                           tempRow2[5] = sbox[tempStart2[2][23:16]];
                           tempRow2[2] = sbox[tempStart2[2][15:8]];
                           tempRow2[15] = sbox[tempStart2[2][7:0]];
                           tempRow2[12] = sbox[tempStart2[3][31:24]];
                           tempRow2[9] = sbox[tempStart2[3][23:16]];
                           tempRow2[6] = sbox[tempStart2[3][15:8]];
                           tempRow2[3] = sbox[tempStart2[3][7:0]]; 
                            next_state = 15;
                     end

       15:begin
                                                     /* For b0*/
                    l2[0] = lTable[tempRow2[0]] + lTable[2];
                    if(l2[0] > 255)
                    l2[0] = l2[0]-255;
                    l2[1] = lTable[tempRow2[1]] + lTable[3];
                    if(l2[1] > 255)
                    l2[1] = l2[1]-255;
                    /* For b1 */
                    l2[2] = lTable[tempRow2[1]] + lTable[2];
                    if(l2[2] > 255)
                    l2[2] = l2[2]-255;
                    l2[3] = lTable[tempRow2[2]] + lTable[3];
                    if(l2[3] > 255)
                    l2[3] = l2[3]-255;
                    /* For b2*/
                    l2[4] = lTable[tempRow2[2]] + lTable[2];
                    if(l2[4] > 255)
                    l2[4] = l2[4]-255;
                    l2[5] = lTable[tempRow2[3]] + lTable[3];
                    if(l2[5] > 255)
                    l2[5] = l2[5]-255;
                    /* For b3*/
                    l2[6] = lTable[tempRow2[0]] + lTable[3];
                    if(l2[6] > 255)
                    l2[6] = l2[6]-255;
                    l2[7] = lTable[tempRow2[3]] + lTable[2];
                    if(l2[7] > 255)
                    l2[7] = l2[7]-255;            
                    /* For b4*/
                    l2[8] = lTable[tempRow2[4]] + lTable[2];
                    if(l2[8] > 255)
                    l2[8] = l2[8]-255;
                    l2[9] = lTable[tempRow2[5]] + lTable[3];
                    if(l2[9] > 255)
                    l2[9] = l2[9]-255;
                    /* For b5 */
                    l2[10] = lTable[tempRow2[5]] + lTable[2];
                    if(l2[10] > 255)
                    l2[10] = l2[10]-255;
                    l2[11] = lTable[tempRow2[6]] + lTable[3];
                    if(l2[11] > 255)
                    l2[11] = l2[11]-255;
                    /* For b6*/
                    l2[12] = lTable[tempRow2[6]] + lTable[2];
                    if(l2[12] > 255)
                    l2[12] = l2[12]-255;
                    l2[13] = lTable[tempRow2[7]] + lTable[3];
                    if(l2[13] > 255)
                    l2[13] = l2[13]-255;
                    /* For b7*/
                    l2[14] = lTable[tempRow2[4]] + lTable[3];
                    if(l2[14] > 255)
                    l2[14] = l2[14]-255;
                    l2[15] = lTable[tempRow2[7]] + lTable[2];
                    if(l2[15] > 255)
                    l2[15] = l2[15]-255;    
                    /* For b8*/
                    l2[16] = lTable[tempRow2[8]] + lTable[2];
                    if(l2[16] > 255)
                    l2[16] = l2[16]-255;
                    l2[17] = lTable[tempRow2[9]] + lTable[3];
                    if(l2[17] > 255)
                    l2[17] = l2[17]-255;
                    /* For b9 */
                    l2[18] = lTable[tempRow2[9]] + lTable[2];
                    if(l2[18] > 255)
                    l2[18] = l2[18]-255;
                    l2[19] = lTable[tempRow2[10]] + lTable[3];
                    if(l2[19] > 255)
                    l2[19] = l2[19]-255;
                    /* For b10*/
                    l2[20] = lTable[tempRow2[10]] + lTable[2];
                    if(l2[20] > 255)
                    l2[20] = l2[20]-255;
                    l2[21] = lTable[tempRow2[11]] + lTable[3];
                    if(l2[21] > 255)
                    l2[21] = l2[21]-255;
                    /* For b11*/
                    l2[22] = lTable[tempRow2[8]] + lTable[3];
                    if(l2[22] > 255)
                    l2[22] = l2[22]-255;
                    l2[23] = lTable[tempRow2[11]] + lTable[2];
                    if(l2[23] > 255)
                    l2[23] = l2[23]-255;    
                    /* For b12*/
                    l2[24] = lTable[tempRow2[12]] + lTable[2];
                    if(l2[24] > 255)
                    l2[24] = l2[24]-255;
                    l2[25] = lTable[tempRow2[13]] + lTable[3];
                    if(l2[25] > 255)
                    l2[25] = l2[25]-255;
                    /* For b13 */
                    l2[26] = lTable[tempRow2[13]] + lTable[2];
                    if(l2[26] > 255)
                    l2[26] = l2[26]-255;
                    l2[27] = lTable[tempRow2[14]] + lTable[3];
                    if(l2[27] > 255)
                    l2[27] = l2[27]-255;
                    /* For b14*/
                    l2[28] = lTable[tempRow2[14]] + lTable[2];
                    if(l2[28] > 255)
                    l2[28] = l2[28]-255;
                    l2[29] = lTable[tempRow2[15]] + lTable[3];
                    if(l2[29] > 255)
                    l2[29] = l2[29]-255;
                    /* For b15*/
                    l2[30] = lTable[tempRow2[12]] + lTable[3];
                    if(l2[30] > 255)
                    l2[30] = l2[30]-255;
                    l2[31] = lTable[tempRow2[15]] + lTable[2];
                    if(l2[31] > 255)
                    l2[31] = l2[31]-255;
                         next_state = 16;
                 end
       16:begin 
                       d2[0] = eTable[l2[0]]^eTable[l2[1]]^tempRow2[2]^tempRow2[3];
                       d2[1] = tempRow2[0]^eTable[l2[2]]^eTable[l2[3]]^tempRow2[3];
                       d2[2] = tempRow2[0]^tempRow2[1]^eTable[l2[4]]^eTable[l2[5]];
                       d2[3] = eTable[l2[6]]^tempRow2[1]^tempRow2[2]^eTable[l2[7]];
                       d2[4] = eTable[l2[8]]^eTable[l2[9]]^tempRow2[6]^tempRow2[7];
                       d2[5] = tempRow2[4]^eTable[l2[10]]^eTable[l2[11]]^tempRow2[7];
                       d2[6] = tempRow2[4]^tempRow2[5]^eTable[l2[12]]^eTable[l2[13]];
                       d2[7] = eTable[l2[14]]^tempRow2[5]^tempRow2[6]^eTable[l2[15]];
                       d2[8] = eTable[l2[16]]^eTable[l2[17]]^tempRow2[10]^tempRow2[11];
                       d2[9] = tempRow2[8]^eTable[l2[18]]^eTable[l2[19]]^tempRow2[11];
                       d2[10] = tempRow2[8]^tempRow2[9]^eTable[l2[20]]^eTable[l2[21]];
                       d2[11] = eTable[l2[22]]^tempRow2[9]^tempRow2[10]^eTable[l2[23]];
                       d2[12] = eTable[l2[24]]^eTable[l2[25]]^tempRow2[14]^tempRow2[15];
                       d2[13] = tempRow2[12]^eTable[l2[26]]^eTable[l2[27]]^tempRow2[15];
                       d2[14] = tempRow2[12]^tempRow2[13]^eTable[l2[28]]^eTable[l2[29]];
                       d2[15] = eTable[l2[30]]^tempRow2[13]^tempRow2[14]^eTable[l2[31]];      
                       next_state = 17;
                      end
                   17: begin
                           w3[0] = {d2[0],d2[1],d2[2],d2[3]};
                           w3[1] = {d2[4],d2[5],d2[6],d2[7]};
                           w3[2] = {d2[8],d2[9],d2[10],d2[11]};
                           w3[3] = {d2[12],d2[13],d2[14],d2[15]};
                          next_state = 18;
                        end
                    18: begin
                          tempStart3[0] = w3[0] ^ k[12];
                          tempStart3[1] = w3[1] ^ k[13];
                          tempStart3[2] = w3[2] ^ k[14];
                          tempStart3[3] = w3[3] ^ k[15];
                        next_state = 19;
                    end
       19:begin
                       tempRow3[0] = sbox[tempStart3[0][31:24]];
                       tempRow3[13] = sbox[tempStart3[0][23:16]];
                       tempRow3[10] = sbox[tempStart3[0][15:8]];
                       tempRow3[7] = sbox[tempStart3[0][7:0]];        
                       tempRow3[4] = sbox[tempStart3[1][31:24]];
                       tempRow3[1] = sbox[tempStart3[1][23:16]];
                       tempRow3[14] = sbox[tempStart3[1][15:8]];
                       tempRow3[11] = sbox[tempStart3[1][7:0]];
                       tempRow3[8] = sbox[tempStart3[2][31:24]];
                       tempRow3[5] = sbox[tempStart3[2][23:16]];
                       tempRow3[2] = sbox[tempStart3[2][15:8]];
                       tempRow3[15] = sbox[tempStart3[2][7:0]];
                       tempRow3[12] = sbox[tempStart3[3][31:24]];
                       tempRow3[9] = sbox[tempStart3[3][23:16]];
                       tempRow3[6] = sbox[tempStart3[3][15:8]];
                       tempRow3[3] = sbox[tempStart3[3][7:0]];  
                      next_state =  20;             
                       end
       20:begin
                    l3[0] = lTable[tempRow3[0]] + lTable[2];
                       if(l3[0] > 255)
                       l3[0] = l3[0]-255;
                       l3[1] = lTable[tempRow3[1]] + lTable[3];
                       if(l3[1] > 255)
                       l3[1] = l3[1]-255;
                       /* For b1 */
                       l3[2] = lTable[tempRow3[1]] + lTable[2];
                       if(l3[2] > 255)
                       l3[2] = l3[2]-255;
                       l3[3] = lTable[tempRow3[2]] + lTable[3];
                       if(l3[3] > 255)
                       l3[3] = l3[3]-255;
                       /* For b2*/
                       l3[4] = lTable[tempRow3[2]] + lTable[2];
                       if(l3[4] > 255)
                       l3[4] = l3[4]-255;
                       l3[5] = lTable[tempRow3[3]] + lTable[3];
                       if(l3[5] > 255)
                       l3[5] = l3[5]-255;
                       /* For b3*/
                       l3[6] = lTable[tempRow3[0]] + lTable[3];
                       if(l3[6] > 255)
                       l3[6] = l3[6]-255;
                       l3[7] = lTable[tempRow3[3]] + lTable[2];
                       if(l3[7] > 255)
                       l3[7] = l3[7]-255;            
                       /* For b4*/
                       l3[8] = lTable[tempRow3[4]] + lTable[2];
                       if(l3[8] > 255)
                       l3[8] = l3[8]-255;
                       l3[9] = lTable[tempRow3[5]] + lTable[3];
                       if(l3[9] > 255)
                       l3[9] = l3[9]-255;
                       /* For b5 */
                       l3[10] = lTable[tempRow3[5]] + lTable[2];
                       if(l3[10] > 255)
                       l3[10] = l3[10]-255;
                       l3[11] = lTable[tempRow3[6]] + lTable[3];
                       if(l3[11] > 255)
                       l3[11] = l3[11]-255;
                       /* For b6*/
                       l3[12] = lTable[tempRow3[6]] + lTable[2];
                       if(l3[12] > 255)
                       l3[12] = l3[12]-255;
                       l3[13] = lTable[tempRow3[7]] + lTable[3];
                       if(l3[13] > 255)
                       l3[13] = l3[13]-255;
                       /* For b7*/
                       l3[14] = lTable[tempRow3[4]] + lTable[3];
                       if(l3[14] > 255)
                       l3[14] = l3[14]-255;
                       l3[15] = lTable[tempRow3[7]] + lTable[2];
                       if(l3[15] > 255)
                       l3[15] = l3[15]-255;    
                       /* For b8*/
                       l3[16] = lTable[tempRow3[8]] + lTable[2];
                       if(l3[16] > 255)
                       l3[16] = l3[16]-255;
                       l3[17] = lTable[tempRow3[9]] + lTable[3];
                       if(l3[17] > 255)
                       l3[17] = l3[17]-255;
                       /* For b9 */
                       l3[18] = lTable[tempRow3[9]] + lTable[2];
                       if(l3[18] > 255)
                       l3[18] = l3[18]-255;
                       l3[19] = lTable[tempRow3[10]] + lTable[3];
                       if(l3[19] > 255)
                       l3[19] = l3[19]-255;
                       /* For b10*/
                       l3[20] = lTable[tempRow3[10]] + lTable[2];
                       if(l3[20] > 255)
                       l3[20] = l3[20]-255;
                       l3[21] = lTable[tempRow3[11]] + lTable[3];
                       if(l3[21] > 255)
                       l3[21] = l3[21]-255;
                       /* For b11*/
                       l3[22] = lTable[tempRow3[8]] + lTable[3];
                       if(l3[22] > 255)
                       l3[22] = l3[22]-255;
                       l3[23] = lTable[tempRow3[11]] + lTable[2];
                       if(l3[23] > 255)
                       l3[23] = l3[23]-255;    
                       /* For b12*/
                       l3[24] = lTable[tempRow3[12]] + lTable[2];
                       if(l3[24] > 255)
                       l3[24] = l3[24]-255;
                       l3[25] = lTable[tempRow3[13]] + lTable[3];
                       if(l3[25] > 255)
                       l3[25] = l3[25]-255;
                       /* For b13 */
                       l3[26] = lTable[tempRow3[13]] + lTable[2];
                       if(l3[26] > 255)
                       l3[26] = l3[26]-255;
                       l3[27] = lTable[tempRow3[14]] + lTable[3];
                       if(l3[27] > 255)
                       l3[27] = l3[27]-255;
                       /* For b14*/
                       l3[28] = lTable[tempRow3[14]] + lTable[2];
                       if(l3[28] > 255)
                       l3[28] = l3[28]-255;
                       l3[29] = lTable[tempRow3[15]] + lTable[3];
                       if(l3[29] > 255)
                       l3[29] = l3[29]-255;
                       /* For b15*/
                       l3[30] = lTable[tempRow3[12]] + lTable[3];
                       if(l3[30] > 255)
                       l3[30] = l3[30]-255;
                       l3[31] = lTable[tempRow3[15]] + lTable[2];
                       if(l3[31] > 255)
                       l3[31] = l3[31]-255;
                          next_state = 21;    
                      end
       21:begin
                           d3[0] = eTable[l3[0]]^eTable[l3[1]]^tempRow3[2]^tempRow3[3];
                           d3[1] = tempRow3[0]^eTable[l3[2]]^eTable[l3[3]]^tempRow3[3];
                           d3[2] = tempRow3[0]^tempRow3[1]^eTable[l3[4]]^eTable[l3[5]];
                           d3[3] = eTable[l3[6]]^tempRow3[1]^tempRow3[2]^eTable[l3[7]];
                           d3[4] = eTable[l3[8]]^eTable[l3[9]]^tempRow3[6]^tempRow3[7];
                           d3[5] = tempRow3[4]^eTable[l3[10]]^eTable[l3[11]]^tempRow3[7];
                           d3[6] = tempRow3[4]^tempRow3[5]^eTable[l3[12]]^eTable[l3[13]];
                           d3[7] = eTable[l3[14]]^tempRow3[5]^tempRow3[6]^eTable[l3[15]];
                           d3[8] = eTable[l3[16]]^eTable[l3[17]]^tempRow3[10]^tempRow3[11];
                           d3[9] = tempRow3[8]^eTable[l3[18]]^eTable[l3[19]]^tempRow3[11];
                           d3[10] = tempRow3[8]^tempRow3[9]^eTable[l3[20]]^eTable[l3[21]];
                           d3[11] = eTable[l3[22]]^tempRow3[9]^tempRow3[10]^eTable[l3[23]];
                           d3[12] = eTable[l3[24]]^eTable[l3[25]]^tempRow3[14]^tempRow3[15];
                           d3[13] = tempRow3[12]^eTable[l3[26]]^eTable[l3[27]]^tempRow3[15];
                           d3[14] = tempRow3[12]^tempRow3[13]^eTable[l3[28]]^eTable[l3[29]];
                           d3[15] = eTable[l3[30]]^tempRow3[13]^tempRow3[14]^eTable[l3[31]]; 
                            next_state = 22;
                  end
                22: begin
                           w4[0] = {d3[0],d3[1],d3[2],d3[3]};
                           w4[1] = {d3[4],d3[5],d3[6],d3[7]};
                           w4[2] = {d3[8],d3[9],d3[10],d3[11]};
                           w4[3] = {d3[12],d3[13],d3[14],d3[15]};
                          next_state = 23;
                        end
                    23: begin
                          tempStart4[0] = w4[0] ^ k[16];
                          tempStart4[1] = w4[1] ^ k[17];
                          tempStart4[2] = w4[2] ^ k[18];
                          tempStart4[3] = w4[3] ^ k[19];
                        next_state = 24;
                    end
       24:begin
                       tempRow4[0] = sbox[tempStart4[0][31:24]];
                       tempRow4[13] = sbox[tempStart4[0][23:16]];
                       tempRow4[10] = sbox[tempStart4[0][15:8]];
                       tempRow4[7] = sbox[tempStart4[0][7:0]];        
                       tempRow4[4] = sbox[tempStart4[1][31:24]];
                       tempRow4[1] = sbox[tempStart4[1][23:16]];
                       tempRow4[14] = sbox[tempStart4[1][15:8]];
                       tempRow4[11] = sbox[tempStart4[1][7:0]];
                       tempRow4[8] = sbox[tempStart4[2][31:24]];
                       tempRow4[5] = sbox[tempStart4[2][23:16]];
                       tempRow4[2] = sbox[tempStart4[2][15:8]];
                       tempRow4[15] = sbox[tempStart4[2][7:0]];
                       tempRow4[12] = sbox[tempStart4[3][31:24]];
                       tempRow4[9] = sbox[tempStart4[3][23:16]];
                       tempRow4[6] = sbox[tempStart4[3][15:8]];
                       tempRow4[3] = sbox[tempStart4[3][7:0]];  
                      next_state =  25;             
                       end
       25:begin
l4[0] = lTable[tempRow4[0]] + lTable[2];
       if(l4[0] > 255)
       l4[0] = l4[0]-255;
       l4[1] = lTable[tempRow4[1]] + lTable[3];
       if(l4[1] > 255)
       l4[1] = l4[1]-255;
       /* For b1 */
       l4[2] = lTable[tempRow4[1]] + lTable[2];
       if(l4[2] > 255)
       l4[2] = l4[2]-255;
       l4[3] = lTable[tempRow4[2]] + lTable[3];
       if(l4[3] > 255)
       l4[3] = l4[3]-255;
       /* For b2*/
       l4[4] = lTable[tempRow4[2]] + lTable[2];
       if(l4[4] > 255)
       l4[4] = l4[4]-255;
       l4[5] = lTable[tempRow4[3]] + lTable[3];
       if(l4[5] > 255)
       l4[5] = l4[5]-255;
       /* For b3*/
       l4[6] = lTable[tempRow4[0]] + lTable[3];
       if(l4[6] > 255)
       l4[6] = l4[6]-255;
       l4[7] = lTable[tempRow4[3]] + lTable[2];
       if(l4[7] > 255)
       l4[7] = l4[7]-255;            
       /* For b4*/
       l4[8] = lTable[tempRow4[4]] + lTable[2];
       if(l4[8] > 255)
       l4[8] = l4[8]-255;
       l4[9] = lTable[tempRow4[5]] + lTable[3];
       if(l4[9] > 255)
       l4[9] = l4[9]-255;
       /* For b5 */
       l4[10] = lTable[tempRow4[5]] + lTable[2];
       if(l4[10] > 255)
       l4[10] = l4[10]-255;
       l4[11] = lTable[tempRow4[6]] + lTable[3];
       if(l4[11] > 255)
       l4[11] = l4[11]-255;
       /* For b6*/
       l4[12] = lTable[tempRow4[6]] + lTable[2];
       if(l4[12] > 255)
       l4[12] = l4[12]-255;
       l4[13] = lTable[tempRow4[7]] + lTable[3];
       if(l4[13] > 255)
       l4[13] = l4[13]-255;
       /* For b7*/
       l4[14] = lTable[tempRow4[4]] + lTable[3];
       if(l4[14] > 255)
       l4[14] = l4[14]-255;
       l4[15] = lTable[tempRow4[7]] + lTable[2];
       if(l4[15] > 255)
       l4[15] = l4[15]-255;    
       /* For b8*/
       l4[16] = lTable[tempRow4[8]] + lTable[2];
       if(l4[16] > 255)
       l4[16] = l4[16]-255;
       l4[17] = lTable[tempRow4[9]] + lTable[3];
       if(l4[17] > 255)
       l4[17] = l4[17]-255;
       /* For b9 */
       l4[18] = lTable[tempRow4[9]] + lTable[2];
       if(l4[18] > 255)
       l4[18] = l4[18]-255;
       l4[19] = lTable[tempRow4[10]] + lTable[3];
       if(l4[19] > 255)
       l4[19] = l4[19]-255;
       /* For b10*/
       l4[20] = lTable[tempRow4[10]] + lTable[2];
       if(l4[20] > 255)
       l4[20] = l4[20]-255;
       l4[21] = lTable[tempRow4[11]] + lTable[3];
       if(l4[21] > 255)
       l4[21] = l4[21]-255;
       /* For b11*/
       l4[22] = lTable[tempRow4[8]] + lTable[3];
       if(l4[22] > 255)
       l4[22] = l4[22]-255;
       l4[23] = lTable[tempRow4[11]] + lTable[2];
       if(l4[23] > 255)
       l4[23] = l4[23]-255;    
       /* For b12*/
       l4[24] = lTable[tempRow4[12]] + lTable[2];
       if(l4[24] > 255)
       l4[24] = l4[24]-255;
       l4[25] = lTable[tempRow4[13]] + lTable[3];
       if(l4[25] > 255)
       l4[25] = l4[25]-255;
       /* For b13 */
       l4[26] = lTable[tempRow4[13]] + lTable[2];
       if(l4[26] > 255)
       l4[26] = l4[26]-255;
       l4[27] = lTable[tempRow4[14]] + lTable[3];
       if(l4[27] > 255)
       l4[27] = l4[27]-255;
       /* For b14*/
       l4[28] = lTable[tempRow4[14]] + lTable[2];
       if(l4[28] > 255)
       l4[28] = l4[28]-255;
       l4[29] = lTable[tempRow4[15]] + lTable[3];
       if(l4[29] > 255)
       l4[29] = l4[29]-255;
       /* For b15*/
       l4[30] = lTable[tempRow4[12]] + lTable[3];
       if(l4[30] > 255)
       l4[30] = l4[30]-255;
       l4[31] = lTable[tempRow4[15]] + lTable[2];
       if(l4[31] > 255)
       l4[31] = l4[31]-255;
       next_state = 26;    
              end
     26:begin
     d4[0] = eTable[l4[0]]^eTable[l4[1]]^tempRow4[2]^tempRow4[3];
     d4[1] = 1;//tempRow4[0]^eTable[l4[2]]^eTable[l4[3]]^tempRow4[3];
     d4[2] = 2;//tempRow4[0]^tempRow4[1]^eTable[l4[4]]^eTable[l4[5]];
     d4[3] = 3;//eTable[l4[6]]^tempRow4[1]^tempRow4[2]^eTable[l4[7]];
     d4[4] = eTable[l4[8]]^eTable[l4[9]]^tempRow4[6]^tempRow4[7];
     d4[5] = tempRow4[4]^eTable[l4[10]]^eTable[l4[11]]^tempRow4[7];
     d4[6] = tempRow4[4]^tempRow4[5]^eTable[l4[12]]^eTable[l4[13]];
     d4[7] = eTable[l4[14]]^tempRow4[5]^tempRow4[6]^eTable[l4[15]];
     d4[8] = eTable[l4[16]]^eTable[l4[17]]^tempRow4[10]^tempRow4[11];
     d4[9] = tempRow4[8]^eTable[l4[18]]^eTable[l4[19]]^tempRow4[11];
     d4[10] = tempRow4[8]^tempRow4[9]^eTable[l4[20]]^eTable[l4[21]];
     d4[11] = eTable[l4[22]]^tempRow4[9]^tempRow4[10]^eTable[l4[23]];
     d4[12] = eTable[l4[24]]^eTable[l4[25]]^tempRow4[14]^tempRow4[15];
     d4[13] = tempRow4[12]^eTable[l4[26]]^eTable[l4[27]]^tempRow4[15];
     d4[14] = tempRow4[12]^tempRow4[13]^eTable[l4[28]]^eTable[l4[29]];
     d4[15] = eTable[l4[30]]^tempRow4[13]^tempRow4[14]^eTable[l4[31]]; 
                    next_state = 99;
          end
       
            
        default:begin
                    next_state = 0;
                end
         
    endcase
end 
    
    
endmodule
