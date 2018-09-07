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
//reg [7:0]addr;
reg [31:0] RAM [16:0]; // 32bit RAM x 16 slots= 512 bit(64 Byte) RAM


always @(posedge clk or negedge reset)begin
  if(!reset) begin
    dataOut <= 0;
    dataReady <= 0;
  end 
  else if(enable)begin
       if(addr < 17)begin 
             RAM[addr-1] <= dataIn;
       end 
       if(addr == 5)begin 
              dataOut <= {RAM[0],RAM[1],RAM[2],RAM[3]};
              dataReady <=  1;
       end else if(addr == 9)begin
              dataOut <= {RAM[4],RAM[5],RAM[6],RAM[7]};
              dataReady <=  1;       
       end else if(addr == 13)begin
              dataOut <= {RAM[8],RAM[9],RAM[10],RAM[11]};
              dataReady <=  1;     
       end else if(addr == 17)begin
              dataOut <= {RAM[12],RAM[13],RAM[14],RAM[15]};
              dataReady <=  1; 
       end else begin
              //dataReady <=  0;
       end
  end
end

endmodule
