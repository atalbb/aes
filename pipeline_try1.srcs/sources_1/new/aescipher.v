`timescale 1ns / 1ps

//module aes(clk,reset,load_i,decrypt_i,data_i,key_i,ready_o,data_o);
//module aescipher(clk,datain,key,dataout);

module aescipher(clk,reset,load_i,decrypt_i,data_i,ready_o,data_o);
    input clk,reset,load_i,decrypt_i;
    output ready_o;
    input [127:0] data_i;
    //input [127:0] key;
    output[127:0] data_o;
    
    reg ready_o;
    //reg [127:0] data_o;
    
    wire [127:0] r0_out;
    wire [127:0] r1_out,r2_out,r3_out,r4_out,r5_out,r6_out,r7_out,r8_out,r9_out,r10_out,r11_out,r12_out,r13_out;
    reg [127:0]  r0_reg,r1_reg,r2_reg,r3_reg,r4_reg,r5_reg,r6_reg,r7_reg,r8_reg,r9_reg,r10_reg,r11_reg,r12_reg,r13_reg;
    wire [127:0] keyout1,keyout2,keyout3,keyout4,keyout5,keyout6,keyout7,keyout8,keyout9,keyout10,keyout11,keyout12,keyout13;
	 
	assign r0_out = (decrypt_i == 0)? (data_i ^ 128'h000102030405060708090a0b0c0d0e0f) : (data_i ^ 128'h24fc79ccbf0979e9371ac23c6d68de36) ; // initial round
	 
    rounds r1(.clk(clk),.reset(reset),.decrypt(decrypt_i),.rc(4'h0000),.data(r0_out),.rndout(r1_out));
    rounds r2(.clk(clk),.reset(reset),.decrypt(decrypt_i),.rc(4'h0001),.data(r1_out),.rndout(r2_out));
    rounds r3(.clk(clk),.reset(reset),.decrypt(decrypt_i),.rc(4'h0002),.data(r2_out),.rndout(r3_out));
    rounds r4(.clk(clk),.reset(reset),.decrypt(decrypt_i),.rc(4'h0003),.data(r3_out),.rndout(r4_out));
    rounds r5(.clk(clk),.reset(reset),.decrypt(decrypt_i),.rc(4'h0004),.data(r4_out),.rndout(r5_out));
    rounds r6(.clk(clk),.reset(reset),.decrypt(decrypt_i),.rc(4'h0005),.data(r5_out),.rndout(r6_out));
    rounds r7(.clk(clk),.reset(reset),.decrypt(decrypt_i),.rc(4'h0006),.data(r6_out),.rndout(r7_out));
    rounds r8(.clk(clk),.reset(reset),.decrypt(decrypt_i),.rc(4'h0007),.data(r7_out),.rndout(r8_out));
    rounds r9(.clk(clk),.reset(reset),.decrypt(decrypt_i),.rc(4'h0008),.data(r8_out),.rndout(r9_out));
    rounds r10(.clk(clk),.reset(reset),.decrypt(decrypt_i),.rc(4'h0009),.data(r9_out),.rndout(r10_out));
    rounds r11(.clk(clk),.reset(reset),.decrypt(decrypt_i),.rc(4'h000a),.data(r10_out),.rndout(r11_out));
    rounds r12(.clk(clk),.reset(reset),.decrypt(decrypt_i),.rc(4'h000b),.data(r11_out),.rndout(r12_out));
    rounds r13(.clk(clk),.reset(reset),.decrypt(decrypt_i),.rc(4'h000c),.data(r12_out),.rndout(r13_out));
    rounndlast r14(.clk(clk),.reset(reset),.decrypt(decrypt_i),.rc(4'h000d),.rin(r13_out),.keylastin(keyout13),.fout(data_o));
    

//registers:
    always @(posedge clk or negedge reset)
    begin
    
          if(!reset)begin
//                  r0_reg <= 0;
//                  r1_reg <= 0;                  
//                  r2_reg <= 0;
//                  r3_reg <= 0;
//                  r4_reg <= 0;
//                  r5_reg <= 0;
//                  r6_reg <= 0;
//                  r7_reg <= 0;
//                  r8_reg <= 0;
//                  r9_reg <= 0;
//                  r10_reg <= 0;
//                  r11_reg <= 0;
//                  r12_reg <= 0;
//                  r13_reg <= 0;                    
          end else begin
                if(load_i)begin
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
                end
          end
    
    end    
    
endmodule
