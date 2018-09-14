`timescale 10ns / 1ps

module shiftrow(sb,sr,decrypt);

input [127:0] sb;
input decrypt;
output [127:0] sr;

assign         sr[127:120] = (decrypt==0)? sb[127:120]:sb[127:120];  
assign         sr[119:112] = (decrypt==0)?sb[87:80]:sb[23:16];
assign         sr[111:104] = (decrypt==0)?sb[47:40]:sb[47:40];
assign         sr[103:96] =  (decrypt==0)?sb[7:0]:sb[71:64];
   
assign          sr[95:88] = (decrypt==0)? sb[95:88]:sb[95:88];
assign          sr[87:80] = (decrypt==0)? sb[55:48]:sb[119:112];
assign          sr[79:72] = (decrypt==0)? sb[15:8]:sb[15:8];
assign          sr[71:64] = (decrypt==0)? sb[103:96]:sb[39:32];
   
assign          sr[63:56] = (decrypt==0)? sb[63:56]:sb[63:56];
assign          sr[55:48] = (decrypt==0)? sb[23:16]:sb[87:80];
assign          sr[47:40] = (decrypt==0)? sb[111:104]:sb[111:104];
assign          sr[39:32] = (decrypt==0)? sb[71:64]:sb[7:0];
   
assign          sr[31:24] = (decrypt==0)? sb[31:24]:sb[31:24];
assign          sr[23:16] = (decrypt==0)? sb[119:112]:sb[55:48];
assign          sr[15:8] = (decrypt==0)? sb[79:72]:sb[79:72];
assign          sr[7:0] = (decrypt==0)? sb[39:32]:sb[103:96]; 


endmodule