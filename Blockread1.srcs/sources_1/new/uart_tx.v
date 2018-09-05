`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:59:42 01/31/2011 
// Design Name: 
// Module Name:    uart_tx 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module uart_tx(clk,reset,enc_dec,plainTextIn,cipherTextIn,ready,TxD);

input clk,reset;
input ready;
input [127:0]plainTextIn;
input [127:0]cipherTextIn;
input [1:0]enc_dec;
output TxD;

reg [31:0]word[4:0];
reg [12:0]baud_count = 12'b0;
reg [3:0]bit_count = 4'b0;
reg start_bit_done,data_bit_done;
reg TxD;
reg [7:0]tx_buff[19:0];
reg [7:0]ledout;
reg [5:0]byte_count;

parameter bit_time =868 ;//10416;//5207;	// 9600 baud

// Concatenating 4 bit MSB and LSB to form 8-bit data
//assign tx_data = {tx_data_msb,tx_data_lsb};

// Procedural block to transmit START bit, 8 data bits and STOP bit
always @(posedge clk or negedge reset)
begin
 if(reset == 0)
  begin
   baud_count <= 0;
	bit_count <= 0; 
	TxD <= 1;
	start_bit_done <= 1;
	data_bit_done <= 1;
    tx_buff[0] <= 0;
    tx_buff[1] <= 0;
    tx_buff[2] <= 0;
    tx_buff[3] <= 0;
    tx_buff[4] <= 0;
    tx_buff[5] <= 0;
    tx_buff[6] <= 0;
    tx_buff[7] <= 0;
    tx_buff[8] <= 0;
    tx_buff[9] <= 0;
    tx_buff[10] <= 0;
    tx_buff[11] <= 0;
    tx_buff[12] <= 0;
    tx_buff[13] <= 0;
    tx_buff[14] <= 0;
    tx_buff[15] <= 0;
//    tx_buff[16] <= 0;
//    tx_buff[17] <= 0;
//    tx_buff[18] <= 0;
//    tx_buff[19] <= 0;
	byte_count <= 0;

	ledout <= 8'hff;
  end
 else if(ready)
 begin
//  tx_buff[0] <= plainTextIn[159:152];
// tx_buff[1] <= plainTextIn[151:144];
// tx_buff[2] <= plainTextIn[143:136];
// tx_buff[3] <= plainTextIn[135:128];
 if(enc_dec == 2'b01)begin
     tx_buff[0] <= plainTextIn[127:120];
     tx_buff[1] <= plainTextIn[119:112];
     tx_buff[2] <= plainTextIn[111:104];
     tx_buff[3] <= plainTextIn[103:96];
     
     tx_buff[4] <= plainTextIn[95:88];
     tx_buff[5] <= plainTextIn[87:80];
     tx_buff[6] <= plainTextIn[79:72];
     tx_buff[7] <= plainTextIn[71:64];
     
     tx_buff[8] <= plainTextIn[63:56];
     tx_buff[9] <= plainTextIn[55:48];
     tx_buff[10] <= plainTextIn[47:40];
     tx_buff[11] <= plainTextIn[39:32];
    
     tx_buff[12] <= plainTextIn[31:24];
     tx_buff[13] <= plainTextIn[23:16];
     tx_buff[14] <= plainTextIn[15:8];
     tx_buff[15] <= plainTextIn[7:0];
 end else if(enc_dec == 2'b10)begin
     tx_buff[0] <= cipherTextIn[127:120];
     tx_buff[1] <= cipherTextIn[119:112];
     tx_buff[2] <= cipherTextIn[111:104];
     tx_buff[3] <= cipherTextIn[103:96];
     
     tx_buff[4] <= cipherTextIn[95:88];
     tx_buff[5] <= cipherTextIn[87:80];
     tx_buff[6] <= cipherTextIn[79:72];
     tx_buff[7] <= cipherTextIn[71:64];
     
     tx_buff[8] <= cipherTextIn[63:56];
     tx_buff[9] <= cipherTextIn[55:48];
     tx_buff[10] <= cipherTextIn[47:40];
     tx_buff[11] <= cipherTextIn[39:32];
    
     tx_buff[12] <= cipherTextIn[31:24];
     tx_buff[13] <= cipherTextIn[23:16];
     tx_buff[14] <= cipherTextIn[15:8];
     tx_buff[15] <= cipherTextIn[7:0];
 end else begin
    tx_buff[0] <= 0;
     tx_buff[1] <= 0;
     tx_buff[2] <= 0;
     tx_buff[3] <= 0;
     tx_buff[4] <= 0;
     tx_buff[5] <= 0;
     tx_buff[6] <= 0;
     tx_buff[7] <= 0;
     tx_buff[8] <= 0;
     tx_buff[9] <= 0;
     tx_buff[10] <= 0;
     tx_buff[11] <= 0;
     tx_buff[12] <= 0;
     tx_buff[13] <= 0;
     tx_buff[14] <= 0;
     tx_buff[15] <= 0;
 end
  //ledout <= word;
  start_bit_done <= 0;
 end
 else if(!start_bit_done)		// Sending START bit ('0')
  begin
   TxD <= 0;
	 if(baud_count >= bit_time)
	  begin
	  	baud_count <= 0;
		start_bit_done <= 1;
		data_bit_done <= 0;
		//start_out <= 1;
	  end
	 else
	  begin
	   baud_count <= baud_count + 1;
		start_bit_done <= 0;
	  end
  end
 else if((bit_count < 8) && (!data_bit_done))					// Sending 8 DATA bits
  begin
   TxD <= tx_buff[byte_count][0];
	if(baud_count >= bit_time)
	  begin
	   baud_count <= 0;
		bit_count <= bit_count + 1;
		tx_buff[byte_count][6:0] <= tx_buff[byte_count][7:1];
	  end
	else
	  begin
	   baud_count <= baud_count + 1;
		data_bit_done <= 0;
	  end
  end
 else if(bit_count == 8)												// Sending STOP bit
  begin
   TxD <= 1;
	 if(baud_count >= bit_time)
	  begin
	   baud_count <= 0;
		bit_count <= 0;
		if(byte_count < 15)begin
		  start_bit_done <= 0;
		  byte_count <= byte_count + 1;
		end else begin
		  start_bit_done <= 1;
		end
		data_bit_done <= 1;
		//stop_out <= 1;
	  end
	 else
	  begin
	   baud_count <= baud_count + 1;
	  end
  end 
 else 
  begin
   baud_count <= 0;
	bit_count <= 0; 
	TxD <= 1;
	start_bit_done <= 1;
	data_bit_done <= 1;
	tx_buff[byte_count] <= 0;
  end  
end 


endmodule
