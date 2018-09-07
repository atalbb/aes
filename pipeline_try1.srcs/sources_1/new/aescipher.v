`timescale 1ns / 1ps

//module aes(clk,reset,load_i,decrypt_i,data_i,key_i,ready_o,data_o);
//module aescipher(clk,datain,key,dataout);

module aescipher(clk,reset,load_i,decrypt_i,data_i,key,ready_o,data_o);
    input clk,reset,load_i,decrypt_i;
    output ready_o;
    input [127:0] data_i;
    input [127:0] key;
    output[127:0] data_o;
    
    reg ready_o;
    //reg [127:0] data_o;
    
    wire [127:0] r0_out;
    wire [127:0] r1_out,r2_out,r3_out,r4_out,r5_out,r6_out,r7_out,r8_out,r9_out,r10_out,r11_out,r12_out,r13_out;
    reg [127:0]  r0_reg,r1_reg,r2_reg,r3_reg,r4_reg,r5_reg,r6_reg,r7_reg,r8_reg,r9_reg,r10_reg,r11_reg,r12_reg,r13_reg;
    wire [127:0] keyout1,keyout2,keyout3,keyout4,keyout5,keyout6,keyout7,keyout8,keyout9,keyout10,keyout11,keyout12,keyout13;
	 
	assign r0_out = data_i^key; // initial round
	 
    rounds r1(.clk(clk),.rc(4'h0000),.data(r0_reg),.rndout(r1_out));
    rounds r2(.clk(clk),.rc(4'h0001),.data(r1_reg),.rndout(r2_out));
    rounds r3(.clk(clk),.rc(4'h0002),.data(r2_reg),.rndout(r3_out));
    rounds r4(.clk(clk),.rc(4'h0003),.data(r3_reg),.rndout(r4_out));
    rounds r5(.clk(clk),.rc(4'h0004),.data(r4_reg),.rndout(r5_out));
    rounds r6(.clk(clk),.rc(4'h0005),.data(r5_reg),.rndout(r6_out));
    rounds r7(.clk(clk),.rc(4'h0006),.data(r6_reg),.rndout(r7_out));
    rounds r8(.clk(clk),.rc(4'h0007),.data(r7_reg),.rndout(r8_out));
    rounds r9(.clk(clk),.rc(4'h0008),.data(r8_reg),.rndout(r9_out));
    rounds r10(.clk(clk),.rc(4'h0009),.data(r9_reg),.rndout(r10_out));
    rounds r11(.clk(clk),.rc(4'h000a),.data(r10_reg),.rndout(r11_out));
    rounds r12(.clk(clk),.rc(4'h000b),.data(r11_reg),.rndout(r12_out));
    rounds r13(.clk(clk),.rc(4'h000c),.data(r12_reg),.rndout(r13_out));
    rounndlast r14(.clk(clk),.rc(4'h000d),.rin(r13_reg),.keylastin(keyout13),.fout(data_o));
    

//registers:
    always @(posedge clk or negedge reset)
    begin
    
          if(!reset)begin
              
                    
          end else begin
                if(load_i)begin
                    r0_reg <= r0_out;
                    r1_reg <= r1_out;                  
                    r2_reg <= r2_out;
                    r3_reg <= r3_out;
                    r4_reg <= r4_out;
                    r5_reg <= r5_out;
                    r6_reg <= r6_out;
                    r7_reg <= r7_out;
                    r8_reg <= r8_out;
                    r9_reg <= r9_out;
                    r10_reg <= r10_out;
                    r11_reg <= r11_out;
                    r12_reg <= r12_out;
                    r13_reg <= r13_out;
                    
                end
          end
    
    end    
    
endmodule
