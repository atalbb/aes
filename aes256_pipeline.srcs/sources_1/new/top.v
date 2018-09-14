`timescale 10ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2018 11:19:49 PM
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
           input resetIn,
           input [1:0]startIn,
           input txDReady,
           output finalDone,          
           output txD
           //output [127:0]finalData
           //output [127:0]finalKey
    );

wire [127:0]dataAddr;
wire [127:0]keyAddr;
wire [31:0]keyout;
wire [31:0]dataout;
wire [127:0]dataO;
wire [1919:0]keyO;
//wire [127:0]keyO,keyBufOut;
//wire [127:0]dataO,dataBufOut;
wire en;
wire dataBufReady,keyBufReady;
wire [127:0]finalData;
//wire finalDone;
assign en = (startIn > 0)?1:0;
//assign _data = dataout;
//assign _key = keyout;

keyAddrCounter KC0(.clk(clkIn),
                    .rst(resetIn),
                    .start(startIn),
                    .keyAddrCount(keyAddr)                    
                    );    
dataAddrCounter DC0(.clk(clkIn),
                    .rst(resetIn),
                    .start(keyBufReady),
                    .dataAddrCount(dataAddr)                    
                    );          
key_mem_gen_0 K0 (
          .clka(clkIn),    // input wire clka
          .ena(en),      // input wire ena
          .wea(0),      // input wire [0 : 0] wea
          .addra(keyAddr),  // input wire [7 : 0] addra
          .dina(0),    // input wire [31 : 0] dina
          .douta(keyout)  // output wire [31 : 0] douta
        );
data_mem_gen_0 D0 (
      .clka(clkIn),    // input wire clka
      .ena(keyBufReady),      // input wire ena
      .wea(0),      // input wire [0 : 0] wea
      .addra(dataAddr),  // input wire [7 : 0] addra
      .dina(0),    // input wire [31 : 0] dina
      .douta(dataout)  // output wire [31 : 0] douta
    ); 
dataBuffer DB0(.clk(clkIn),
           .reset(resetIn),
           .enable(en),
           .addr(dataAddr),
           .dataIn(dataout),
           .dataOut(dataO),
           .dataReady(dataBufReady)
            );
keyBuffer KB0(.clk(clkIn),
              .reset(resetIn),
              .start(startIn),
              .addr(keyAddr),
              .keyIn(keyout),
              .keyOut(keyO),
              .keyReady(keyBufReady)
           );
aescore AES0(.clk(clkIn),
            .reset(resetIn),
            .ready(dataBufReady),
            .start(startIn),
            .keyIn(keyO),
            .dataIn(dataO),
            .dataOut(finalData),
            .done(finalDone)
              );
uart_tx U0   (.clk(clkIn),
              .reset(resetIn),
              .dataIn(finalData),
              .ready(txDReady),
              .TxD(txD));
//aescore AES0(.clk(clkIn),
//             .reset(resetIn),
//             .start(startIn),
//             .keyIn(keyO),
//             .dataIn(dataO),
//             .dataOut(finalData),
//             //.keyOut(finalKey),
//             .done(finalDone)
//               );
endmodule
