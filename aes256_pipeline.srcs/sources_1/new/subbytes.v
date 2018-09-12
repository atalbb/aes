`timescale 10ns / 1ps

module subbytes(clk,data,s,decrypt);

input [127:0] data;
input decrypt,clk;
output reg[127:0]s;
wire [127:0]sb;
wire [127:0]Sbox;
wire [127:0]InvSbox;
wire encrypt;
assign encrypt = ~decrypt;
//assign sb = Sbox;


always @(*)begin
    if(decrypt == 0 )begin
        //sb[127:88] = Sbox[127:88];
        s = {Sbox[127:88],sb[87:0]};
    end else if(decrypt == 1)begin
        s = {InvSbox[127:88],sb[87:0]};
        //sb[127:88] = InvSbox[127:88];
    end
end


sbox_mem_gen_0 SB0 (.clka(clk),.ena(encrypt),.wea(0),.addra(data[127:120]),.dina(0),.douta(Sbox[127:120]));
sbox_mem_gen_0 SB1 (.clka(clk),.ena(encrypt),.wea(0),.addra(data[119:112]),.dina(0),.douta(Sbox[119:112]));
sbox_mem_gen_0 SB2 (.clka(clk),.ena(encrypt),.wea(0),.addra(data[111:104]),.dina(0),.douta(Sbox[111:104]));
sbox_mem_gen_0 SB3 (.clka(clk),.ena(encrypt),.wea(0),.addra(data[103:96]),.dina(0),.douta(Sbox[103:96]));
sbox_mem_gen_0 SB4 (.clka(clk),.ena(encrypt),.wea(0),.addra(data[95:88]),.dina(0),.douta(Sbox[95:88]));
//sbox_mem_gen_0 SB5 (.clka(clk),.wea(0),.addra(data[87:80]),.dina(0),.douta(Sbox[87:80]));
//sbox_mem_gen_0 SB6 (.clka(clk),.wea(0),.addra(data[79:72]),.dina(0),.douta(Sbox[79:72]));
//sbox_mem_gen_0 SB7 (.clka(clk),.wea(0),.addra(data[71:64]),.dina(0),.douta(Sbox[71:64]));

//sbox_mem_gen_0 SB8 (.clka(clk),.wea(0),.addra(data[63:56]),.dina(0),.douta(Sbox[63:56]));
//sbox_mem_gen_0 SB9 (.clka(clk),.wea(0),.addra(data[55:48]),.dina(0),.douta(Sbox[55:48]));
//sbox_mem_gen_0 SB10 (.clka(clk),.wea(0),.addra(data[47:40]),.dina(0),.douta(Sbox[47:40]));
//sbox_mem_gen_0 SB11 (.clka(clk),.wea(0),.addra(data[39:32]),.dina(0),.douta(Sbox[39:32]));

//sbox_mem_gen_0 SB12 (.clka(clk),.wea(0),.addra(data[31:24]),.dina(0),.douta(Sbox[31:24]));
//sbox_mem_gen_0 SB13 (.clka(clk),.wea(0),.addra(data[23:16]),.dina(0),.douta(Sbox[23:16]));
//sbox_mem_gen_0 SB14 (.clka(clk),.wea(0),.addra(data[15:8]),.dina(0),.douta(Sbox[15:8]));
//sbox_mem_gen_0 SB15 (.clka(clk),.wea(0),.addra(data[7:0]),.dina(0),.douta(Sbox[7:0]));


invSbox_mem_gen_0 ISB0 (.clka(clk),.ena(decrypt),.wea(0),.addra(data[127:120]),.dina(0),.douta(InvSbox[127:120]));
invSbox_mem_gen_0 ISB1 (.clka(clk),.ena(decrypt),.wea(0),.addra(data[119:112]),.dina(0),.douta(InvSbox[119:112]));
invSbox_mem_gen_0 ISB2 (.clka(clk),.ena(decrypt),.wea(0),.addra(data[111:104]),.dina(0),.douta(InvSbox[111:104]));
invSbox_mem_gen_0 ISB3 (.clka(clk),.ena(decrypt),.wea(0),.addra(data[103:96]),.dina(0),.douta(InvSbox[103:96]));
invSbox_mem_gen_0 ISB4 (.clka(clk),.ena(decrypt),.wea(0),.addra(data[95:88]),.dina(0),.douta(InvSbox[95:88]));
//invSbox_mem_gen_0 SB5 (.clka(clk),.wea(0),.addra(data[87:80]),.dina(0),.douta(InvSbox[87:80]));
//invSbox_mem_gen_0 SB6 (.clka(clk),.wea(0),.addra(data[79:72]),.dina(0),.douta(InvSbox[79:72]));
//invSbox_mem_gen_0 SB7 (.clka(clk),.wea(0),.addra(data[71:64]),.dina(0),.douta(InvSbox[71:64]));

//invSbox_mem_gen_0 SB8 (.clka(clk),.wea(0),.addra(data[63:56]),.dina(0),.douta(InvSbox[63:56]));
//invSbox_mem_gen_0 SB9 (.clka(clk),.wea(0),.addra(data[55:48]),.dina(0),.douta(InvSbox[55:48]));
//invSbox_mem_gen_0 SB10 (.clka(clk),.wea(0),.addra(data[47:40]),.dina(0),.douta(InvSbox[47:40]));
//invSbox_mem_gen_0 SB11 (.clka(clk),.wea(0),.addra(data[39:32]),.dina(0),.douta(InvSbox[39:32]));

//invSbox_mem_gen_0 SB12 (.clka(clk),.wea(0),.addra(data[31:24]),.dina(0),.douta(InvSbox[31:24]));
//invSbox_mem_gen_0 SB13 (.clka(clk),.wea(0),.addra(data[23:16]),.dina(0),.douta(InvSbox[23:16]));
//invSbox_mem_gen_0 SB14 (.clka(clk),.wea(0),.addra(data[15:8]),.dina(0),.douta(InvSbox[15:8]));
//invSbox_mem_gen_0 SB15 (.clka(clk),.wea(0),.addra(data[7:0]),.dina(0),.douta(InvSbox[7:0]));



//sbox q0( .a(data[127:120]),.c(sb[127:120]),.decrypt(decrypt) );
//sbox q1( .a(data[119:112]),.c(sb[119:112]),.decrypt(decrypt) );
//sbox q2( .a(data[111:104]),.c(sb[111:104]),.decrypt(decrypt) );
//sbox q3( .a(data[103:96]),.c(sb[103:96]),.decrypt(decrypt) );

//sbox q4( .a(data[95:88]),.c(sb[95:88]),.decrypt(decrypt) );
sbox q5( .a(data[87:80]),.c(sb[87:80]),.decrypt(decrypt) );
sbox q6( .a(data[79:72]),.c(sb[79:72]),.decrypt(decrypt) );
sbox q7( .a(data[71:64]),.c(sb[71:64]),.decrypt(decrypt) );

sbox q8( .a(data[63:56]),.c(sb[63:56]),.decrypt(decrypt) );
sbox q9( .a(data[55:48]),.c(sb[55:48]),.decrypt(decrypt) );
sbox q10(.a(data[47:40]),.c(sb[47:40]),.decrypt(decrypt) );
sbox q11(.a(data[39:32]),.c(sb[39:32]),.decrypt(decrypt) );

sbox q12(.a(data[31:24]),.c(sb[31:24]),.decrypt(decrypt) );
sbox q13(.a(data[23:16]),.c(sb[23:16]),.decrypt(decrypt) );
sbox q14(.a(data[15:8]),.c(sb[15:8]),.decrypt(decrypt) );
sbox q15(.a(data[7:0]),.c(sb[7:0]),.decrypt(decrypt) );
endmodule
