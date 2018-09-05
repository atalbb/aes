`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/28/2017 05:56:32 PM
// Design Name: 
// Module Name: top
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




module top(input wire clk,
           input wire rst,
           input wire enHashIn,
           input wire [1:0]enc_dec,
           input wire ready,
           output TxD,
           output led0,
           output led1
           );
           
wire Hdone;
wire Mdone;
wire [1919:0]Hdo;
wire [127:0]Mdo;
wire [31:0]hashInBRAMOUT;
wire [31:0]DataInBRAMOUT;
wire [7:0]hashAddr;
wire [7:0]DataAddr;
wire plainTextDone;
wire [127:0]plainText;
wire cipherTextDone;
wire [127:0]cipherText;

reg dec_data_en,dec_key_en,enc_data_en,enc_key_en;


/* always block to update state every 1 clock cycle */   
always @ (posedge clk or negedge rst)begin
    if(!rst)begin 
    
    end else begin
        if(enc_dec == 2'b01)begin  
              if(Hdone == 1 && Mdone == 1)begin
                enc_data_en = 1;
                enc_key_en = 1;
              end
        end else if(enc_dec == 2'b10)begin
              if(Hdone == 1 && Mdone == 1)begin
                dec_data_en = 1;
                dec_key_en = 1;
              end
        end else begin
                enc_data_en = 0;
                enc_key_en = 0;
                dec_data_en = 0;
                dec_key_en = 0;
        end
    end
end   

counter C0(clk,rst,enHashIn,hashAddr);
counter C1(clk,rst,enHashIn,DataAddr);
blk_mem_gen_0 B0(clk,enHashIn,0,hashAddr,32'h0,hashInBRAMOUT);//BRAM for HashIn
blk_mem_gen_1 B1(clk,enHashIn,0,DataAddr,32'h0,DataInBRAMOUT);//BRAM for HashIn
HashMsgIn HM1(clk,rst,enHashIn,hashAddr,hashInBRAMOUT,Hdone,Hdo,0);
dataIn D1(clk,rst,enHashIn,DataAddr,DataInBRAMOUT,Mdone,0,Mdo);
aes_enc_core AES1(clk,rst,enc_data_en,enc_key_en,enc_dec,Hdo,Mdo,plainTextDone,plainText,led0);//,led1);
aes_dec_core AES2(clk,rst,dec_data_en,dec_key_en,enc_dec,Hdo,Mdo,cipherTextDone,cipherText,led1);//,led1);
uart_tx U1(clk,rst,enc_dec,plainText,cipherText,ready,TxD);

endmodule


