`timescale 10ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2018 04:45:43 PM
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


module top(input clkIn,
           input rstIn,
           input loadKeyIn,
           input loadDataIn,
           input startIn,
           input encDecSelectIn,
           output [127:0]dataout,
           //output [31:0]dataBram,
           //output [1:0]dataDoneOut
           output dataDone
    );
reg [7:0]dataAddrCount;
wire [31:0]dataBram;
wire [127:0]dataI;
wire dataStart;
parameter NDATA = 17;    // Number of 32 bit data in Data BRAM
/* always block to update state every 1 clock cycle */   
always @ (posedge clkIn or negedge rstIn)begin
    if(!rstIn)begin 
        dataAddrCount <= 0;
    end else begin
        if(loadDataIn)begin
            if(dataAddrCount < NDATA)begin
                dataAddrCount <= dataAddrCount + 1;
            end
        end
    end
end   
  
data_mem_gen_0 DATA1 (
  .clka(clkIn),    // input wire clka
  .ena(loadDataIn),      // input wire ena
  .wea(0),      // input wire [0 : 0] wea
  .addra(dataAddrCount),  // input wire [7 : 0] addra
  .dina(0),    // input wire [31 : 0] dina
  .douta(dataBram)  // output wire [31 : 0] douta
);


databuffer DB1( .clk(clkIn),
             .reset(rstIn),
             .enable(loadDataIn),
             .addr(dataAddrCount),
             .dataIn(dataBram),
             .dataOut(dataI),
             .dataReady(dataStart)
            );
    
aescipher u1(.clk(clkIn),
             .reset(rstIn),
             .load_i(dataStart),
             .decrypt_i(encDecSelectIn),
             .data_i(dataI),
             //.key(128'h 000102030405060708090a0b0c0d0e0f),
             .ready_o(dataDone),
             .data_o(dataout)
             );
endmodule
