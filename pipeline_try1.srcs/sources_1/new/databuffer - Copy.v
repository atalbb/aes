`timescale 10ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2018 06:25:26 PM
// Design Name: 
// Module Name: databuffer
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


module databuffer(input clk,
                  input reset,
                  input enable,
                  input [7:0]addr,
                  input [31:0]dataIn,
                  output reg[127:0] dataOut,
                  output reg dataReady
                  );

parameter NDATA = 8;    // Number of 32 bit data in Data BRAM
//reg [7:0]addr;
reg [31:0] RAM [66:0]; // 32bit RAM x 16 slots= 512 bit(64 Byte) RAM
reg startFlag;


//always @(posedge clk or negedge reset)begin
//  if(!reset) begin
//    dataOut <= 0;
//    dataReady <= 0;
//    addr <= 0;
//    startFlag <= 0;
//  end 
//  else if(enable)begin
//        if(startFlag == 0) begin
//            startFlag <= 1;
//        end else if(startFlag == 1) begin
//            if(addr < NDATA)begin
//                addr <= addr + 1;
//            end
//        end
//  end
//end
//always @(addr)begin
//    RAM[addr] = dataIn;    
//    if((addr % 4)==3) begin
//        dataOut = {RAM[addr-3],RAM[addr-2],RAM[addr-1],RAM[addr]};
//        dataReady = 1;
//    end else begin
//        dataOut = 0;
//        dataReady = 0;
//    end
//end

//always @(posedge clk or negedge reset)begin
//  if(!reset) begin
//    dataOut <= 0;
//    dataReady <= 0;
//    addr <= 0;
//    startFlag <= 0;
//  end 
//  else if(enable)begin
//        if(addr < NDATA)begin
//            RAM[addr] = dataIn; 
//            addr = addr + 1;
//        end
//  end
//end

//always @(addr)begin   
//    if((addr % 4)==3) begin
//        dataOut = {RAM[addr-3],RAM[addr-2],RAM[addr-1],RAM[addr]}; 
//        dataReady = 1;
//    end else begin
//        dataOut = 0;
//        dataReady = 0;
//    end
//end

always @(posedge clk or negedge reset)begin
  if(!reset) begin
    dataOut <= 0;
    dataReady <= 0;
    //addr <= 0;
    startFlag <= 0;
  end 
  else if(enable)begin
       if(addr < 6)begin 
             RAM[addr-1] <= dataIn;
             if(addr == 5)begin 
                    dataOut <= {RAM[0],RAM[1],RAM[2],RAM[3]};
             end
       end else if(addr >= 6)
              dataReady <=  1;
  end
end

endmodule
