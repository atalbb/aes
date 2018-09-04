//`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date: 06/15/2017 12:58:31 PM
//// Design Name: 
//// Module Name: HashIn
//// Project Name: 
//// Target Devices: 
//// Tool Versions: 
//// Description: 
//// 
//// Dependencies: 
//// 
//// Revision:
//// Revision 0.01 - File Created
//// Additional Comments:
//// 
////////////////////////////////////////////////////////////////////////////////////


//module HashMsgIn(input wire clk,
//              input wire rst, 
//               input wire en,
//               input wire [31:0]addr, 
//               input wire [31:0]di,
//               output reg done,
//               output reg [1919:0]keyO,
//               output reg [127:0]dataO);
               
//parameter delay = 3'b0;
//parameter END_ADDR = 66;
//reg [31:0] RAM [66:0]; // 32bit RAM x 16 slots= 512 bit(64 Byte) RAM
//always @(posedge clk or negedge rst)begin
//  if(!rst) begin
//    done <= 0;
//    keyO <= 0;
//    dataO <= 0;
//  end 
//  else if(en)begin
//       if(addr < 66)begin 
//           RAM[addr] <= di;
//           if(addr == 65)begin 
//                 keyO <= {   RAM[1],RAM[2],RAM[3],RAM[4],RAM[5],RAM[6],RAM[7],RAM[8],RAM[9],
//                             RAM[10],RAM[11],RAM[12],RAM[13],RAM[14],RAM[15],RAM[16],RAM[17],RAM[18],RAM[19],
//                             RAM[20],RAM[21],RAM[22],RAM[23],RAM[24],RAM[25],RAM[26],RAM[27],RAM[28],RAM[29],
//                             RAM[30],RAM[31],RAM[32],RAM[33],RAM[34],RAM[35],RAM[36],RAM[37],RAM[38],RAM[39],
//                             RAM[40],RAM[41],RAM[42],RAM[43],RAM[44],RAM[45],RAM[46],RAM[47],RAM[48],RAM[49],
//                             RAM[50],RAM[51],RAM[52],RAM[53],RAM[54],RAM[55],RAM[56],RAM[57],RAM[58],RAM[59],RAM[60]};
                 
//                  //dataO <= {RAM[61],RAM[62],RAM[63],RAM[64]};
//           end
//       end else if(addr >= 66)
//                   done <= #delay 1;
//   end
//end
//endmodule


////module HashMsgIn(input wire clk,
////              input wire rst, 
////              input wire en,
////              input wire [31:0]addr, 
////              input wire [31:0]di,
////              output reg done,
////              output reg [1919:0]keyO,
////              output reg [127:0]dataO);
              

////parameter END_ADDR = 66; //(60 + 4 + 2)
////reg [31:0] RAM [69:0]; // 32bit RAM x 64 slots= 2048 bit(256 Byte) RAM

////always @(posedge clk or negedge rst)begin
////  if(!rst) begin
////    done <= 0;
////    keyO <= 0;
////    dataO <= 0;
////  end 
////  else if(en)begin
////       if(addr < 67)begin 
////             RAM[addr] <= di;
////             if(addr == 66)begin 
////                 keyO <= {RAM[2],RAM[3],RAM[4],RAM[5],RAM[6],RAM[7],RAM[8],RAM[9],
////                          RAM[10],RAM[11],RAM[12],RAM[13],RAM[14],RAM[15],RAM[16],RAM[17],RAM[18],RAM[19],
////                          RAM[20],RAM[21],RAM[22],RAM[23],RAM[24],RAM[25],RAM[26],RAM[27],RAM[28],RAM[29],
////                          RAM[30],RAM[31],RAM[32],RAM[33],RAM[34],RAM[35],RAM[36],RAM[37],RAM[38],RAM[39],
////                          RAM[40],RAM[41],RAM[42],RAM[43],RAM[44],RAM[45],RAM[46],RAM[47],RAM[48],RAM[49],
////                          RAM[50],RAM[51],RAM[52],RAM[53],RAM[54],RAM[55],RAM[56],RAM[57],RAM[58],RAM[59],RAM[60],RAM[61]};    
                              
////                 dataO <= {RAM[62],RAM[63],RAM[64],RAM[65]};  
////             end    
////       end else if(addr >= 67)
////            done <=  1;
////   end
////end
////endmodule

//module HashMsgIn(input wire clk,
//              input wire rst, 
//               input wire en,
//               input wire [31:0]addr, 
//               input wire [31:0]di,
//               output reg done,
//               output reg [1919:0]keyO,
//               output reg [127:0]dataO);
module HashMsgIn(input wire clk,
              input wire rst, 
               input wire en,
               input wire [31:0]addr, 
               input wire [31:0]di,
               output reg done,
               output reg [1919:0]hashO,
               output reg [127:0]msgO);
parameter delay = 3'b0;
parameter END_ADDR = 66;
reg [31:0] RAM [66:0]; // 32bit RAM x 16 slots= 512 bit(64 Byte) RAM
always @(posedge clk or negedge rst)begin
  if(!rst) begin
    done <= 0;
    hashO <= 0;
    msgO <= 0;
  end 
  else if(en)begin
       if(addr < END_ADDR)begin 
           RAM[addr-1] <= di;
           if(addr == END_ADDR-1)begin 
             hashO <= {RAM[0],RAM[1],RAM[2],RAM[3],RAM[4],RAM[5],RAM[6],RAM[7],RAM[8],RAM[9],
                                        RAM[10],RAM[11],RAM[12],RAM[13],RAM[14],RAM[15],RAM[16],RAM[17],RAM[18],RAM[19],
                                        RAM[20],RAM[21],RAM[22],RAM[23],RAM[24],RAM[25],RAM[26],RAM[27],RAM[28],RAM[29],
                                        RAM[30],RAM[31],RAM[32],RAM[33],RAM[34],RAM[35],RAM[36],RAM[37],RAM[38],RAM[39],
                                        RAM[40],RAM[41],RAM[42],RAM[43],RAM[44],RAM[45],RAM[46],RAM[47],RAM[48],RAM[49],
                                        RAM[50],RAM[51],RAM[52],RAM[53],RAM[54],RAM[55],RAM[56],RAM[57],RAM[58],RAM[59]};
           end
       end else if(addr >= END_ADDR)
                   done <= #delay 1;
   end
end

endmodule