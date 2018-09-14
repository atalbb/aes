`timescale 10ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2018 11:19:49 PM
// Design Name: 
// Module Name: aescore
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


module aescore(input clk,
               input reset,
               input ready,
               input [1:0]start,
               input [1919:0]keyIn,
               input [127:0]dataIn,
               output [127:0]dataOut,
               //output [127:0]keyOut,
               output done
    );
//assign keyOut = keyIn[1919:1792];
//assign keyOut = keyIn[127:0];
//assign dataOut = dataIn;

//wire ready;
wire [127:0] r0_out;
wire [127:0] r1_out,r2_out,r3_out,r4_out,r5_out,r6_out,r7_out,r8_out,r9_out,r10_out,r11_out,r12_out,r13_out;
reg [127:0]  r0_reg,r1_reg,r2_reg,r3_reg,r4_reg,r5_reg,r6_reg,r7_reg,r8_reg,r9_reg,r10_reg,r11_reg,r12_reg,r13_reg;
//wire [127:0] keyout1,keyout2,keyout3,keyout4,keyout5,keyout6,keyout7,keyout8,keyout9,keyout10,keyout11,keyout12,keyout13;
reg decrypt,flag; 
assign r0_out = dataIn^keyIn[1919:1792]; // initial round
//assign ready = dataInReady & keyInReady;
rounds r1(.clk(clk),.decrypt_i(decrypt),.data(r0_out),.keyin(keyIn[1791:1664]),.rndout(r1_out));
rounds r2(.clk(clk),.decrypt_i(decrypt),.data(r1_out),.keyin(keyIn[1663:1536]),.rndout(r2_out));
rounds r3(.clk(clk),.decrypt_i(decrypt),.data(r2_out),.keyin(keyIn[1535:1408]),.rndout(r3_out));
rounds r4(.clk(clk),.decrypt_i(decrypt),.data(r3_out),.keyin(keyIn[1407:1280]),.rndout(r4_out));
rounds r5(.clk(clk),.decrypt_i(decrypt),.data(r4_out),.keyin(keyIn[1279:1152]),.rndout(r5_out));
rounds r6(.clk(clk),.decrypt_i(decrypt),.data(r5_out),.keyin(keyIn[1151:1024]),.rndout(r6_out));
rounds r7(.clk(clk),.decrypt_i(decrypt),.data(r6_out),.keyin(keyIn[1023:896]),.rndout(r7_out));
rounds r8(.clk(clk),.decrypt_i(decrypt),.data(r7_out),.keyin(keyIn[895:768]),.rndout(r8_out));
rounds r9(.clk(clk),.decrypt_i(decrypt),.data(r8_out),.keyin(keyIn[767:640]),.rndout(r9_out));
rounds r10(.clk(clk),.decrypt_i(decrypt),.data(r9_out),.keyin(keyIn[639:512]),.rndout(r10_out));
rounds r11(.clk(clk),.decrypt_i(decrypt),.data(r10_out),.keyin(keyIn[511:384]),.rndout(r11_out));
rounds r12(.clk(clk),.decrypt_i(decrypt),.data(r11_out),.keyin(keyIn[383:256]),.rndout(r12_out));
rounds r13(.clk(clk),.decrypt_i(decrypt),.data(r12_out),.keyin(keyIn[255:128]),.rndout(r13_out));
rounndlast r14(.clk(clk),.decrypt_i(decrypt),.rin(r13_out),.keylastin(keyIn[127:0]),.fout(dataOut));


//always @*begin
//    if(start == 1)
//        decrypt = 0;
//    else if(start == 2)
//        decrypt = 1;
//end
    always @(posedge clk or negedge reset)
begin

      if(!reset)begin
//          flag <= 0;
//          r0_reg <= 0;
//          r1_reg <= 0;                  
//          r2_reg <= 0;
//          r3_reg <= 0;
//          r4_reg <= 0;
//          r5_reg <= 0;
//          r6_reg <= 0;
//          r7_reg <= 0;
//          r8_reg <= 0;
//          r9_reg <= 0;
//          r10_reg <= 0;
//          r11_reg <= 0;
//          r12_reg <= 0;
//          r13_reg <= 0;                    
      end else begin
//            if(ready==1)begin
//                if(flag == 1)begin
//                    r0_reg <= r0_out;
//                    r1_reg <= r1_out;                  
//                    r2_reg <= r2_out;
//                    r3_reg <= r3_out;
//                    r4_reg <= r4_out;
//                    r5_reg <= r5_out;
//                    r6_reg <= r6_out;
//                    r7_reg <= r7_out;
//                    r8_reg <= r8_out;
//                    r9_reg <= r9_out;
//                    r10_reg <= r10_out;
//                    r11_reg <= r11_out;
//                    r12_reg <= r12_out;
//                    r13_reg <= r13_out;  
//                    flag <= 0;       
//                end else begin
//                    flag <= flag + 1;
//                end           
//            end
      end

end    
always @(posedge clk or negedge reset)begin
      if(!reset) begin
            decrypt <= 0;
      end 
      else begin
            if(start == 1)begin
                decrypt <= 0;
            end else if(start == 2)begin
                decrypt <= 1;
            end
      end
    end
endmodule