// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.2 (win64) Build 1909853 Thu Jun 15 18:39:09 MDT 2017
// Date        : Fri Aug  4 16:56:47 2017
// Host        : LAPTOP-L1N8U9P6 running 64-bit major release  (build 9200)
// Command     : write_verilog -mode timesim -nolib -sdf_anno true -force -file
//               C:/College/Thesis/VivadoProjects/AES_encrypt/AES_encrypt/AES_encrypt.sim/sim_1/synth/timing/aes_enc_tb_time_synth.v
// Design      : top
// Purpose     : This verilog netlist is a timing simulation representation of the design and should not be modified or
//               synthesized. Please ensure that this netlist is used with the corresponding SDF file.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps
`define XIL_TIMING

module PlaintextAddrCounter
   (valid,
    plainTextAddr,
    enPlainTextIn_IBUF,
    clk,
    rst_IBUF);
  output valid;
  output [7:0]plainTextAddr;
  input enPlainTextIn_IBUF;
  input clk;
  input rst_IBUF;

  wire \addr[0]_i_1_n_0 ;
  wire \addr[7]_i_1_n_0 ;
  wire \addr[7]_i_3_n_0 ;
  wire clk;
  wire enPlainTextIn_IBUF;
  wire flag1_carry_i_1_n_0;
  wire flag1_carry_i_2_n_0;
  wire flag1_carry_i_3_n_0;
  wire flag1_carry_i_4_n_0;
  wire flag1_carry_i_5_n_0;
  wire flag1_carry_i_6_n_0;
  wire flag1_carry_i_7_n_0;
  wire flag1_carry_i_8_n_0;
  wire flag1_carry_n_0;
  wire flag1_carry_n_1;
  wire flag1_carry_n_2;
  wire flag1_carry_n_3;
  wire \flag[1]_i_1_n_0 ;
  wire \flag[1]_i_2_n_0 ;
  wire \flag[1]_i_3_n_0 ;
  wire \flag_reg_n_0_[1] ;
  wire [7:1]p_0_in;
  wire [7:2]p_0_in__0;
  wire [7:0]plainTextAddr;
  wire rst_IBUF;
  wire \temp[7]_i_1_n_0 ;
  wire [7:2]temp_reg__0;
  wire valid;
  wire valid_i_1_n_0;
  wire [3:0]NLW_flag1_carry_O_UNCONNECTED;

  LUT1 #(
    .INIT(2'h1)) 
    \addr[0]_i_1 
       (.I0(plainTextAddr[0]),
        .O(\addr[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \addr[1]_i_1 
       (.I0(plainTextAddr[0]),
        .I1(plainTextAddr[1]),
        .O(p_0_in[1]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \addr[2]_i_1 
       (.I0(plainTextAddr[0]),
        .I1(plainTextAddr[1]),
        .I2(plainTextAddr[2]),
        .O(p_0_in[2]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \addr[3]_i_1 
       (.I0(plainTextAddr[1]),
        .I1(plainTextAddr[0]),
        .I2(plainTextAddr[2]),
        .I3(plainTextAddr[3]),
        .O(p_0_in[3]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \addr[4]_i_1 
       (.I0(plainTextAddr[2]),
        .I1(plainTextAddr[0]),
        .I2(plainTextAddr[1]),
        .I3(plainTextAddr[3]),
        .I4(plainTextAddr[4]),
        .O(p_0_in[4]));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \addr[5]_i_1 
       (.I0(plainTextAddr[3]),
        .I1(plainTextAddr[1]),
        .I2(plainTextAddr[0]),
        .I3(plainTextAddr[2]),
        .I4(plainTextAddr[4]),
        .I5(plainTextAddr[5]),
        .O(p_0_in[5]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \addr[6]_i_1 
       (.I0(\addr[7]_i_3_n_0 ),
        .I1(plainTextAddr[6]),
        .O(p_0_in[6]));
  LUT4 #(
    .INIT(16'h0830)) 
    \addr[7]_i_1 
       (.I0(flag1_carry_n_0),
        .I1(enPlainTextIn_IBUF),
        .I2(\flag_reg_n_0_[1] ),
        .I3(valid),
        .O(\addr[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \addr[7]_i_2 
       (.I0(\addr[7]_i_3_n_0 ),
        .I1(plainTextAddr[6]),
        .I2(plainTextAddr[7]),
        .O(p_0_in[7]));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    \addr[7]_i_3 
       (.I0(plainTextAddr[5]),
        .I1(plainTextAddr[3]),
        .I2(plainTextAddr[1]),
        .I3(plainTextAddr[0]),
        .I4(plainTextAddr[2]),
        .I5(plainTextAddr[4]),
        .O(\addr[7]_i_3_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \addr_reg[0] 
       (.C(clk),
        .CE(\addr[7]_i_1_n_0 ),
        .CLR(\flag[1]_i_3_n_0 ),
        .D(\addr[0]_i_1_n_0 ),
        .Q(plainTextAddr[0]));
  FDCE #(
    .INIT(1'b0)) 
    \addr_reg[1] 
       (.C(clk),
        .CE(\addr[7]_i_1_n_0 ),
        .CLR(\flag[1]_i_3_n_0 ),
        .D(p_0_in[1]),
        .Q(plainTextAddr[1]));
  FDCE #(
    .INIT(1'b0)) 
    \addr_reg[2] 
       (.C(clk),
        .CE(\addr[7]_i_1_n_0 ),
        .CLR(\flag[1]_i_3_n_0 ),
        .D(p_0_in[2]),
        .Q(plainTextAddr[2]));
  FDCE #(
    .INIT(1'b0)) 
    \addr_reg[3] 
       (.C(clk),
        .CE(\addr[7]_i_1_n_0 ),
        .CLR(\flag[1]_i_3_n_0 ),
        .D(p_0_in[3]),
        .Q(plainTextAddr[3]));
  FDCE #(
    .INIT(1'b0)) 
    \addr_reg[4] 
       (.C(clk),
        .CE(\addr[7]_i_1_n_0 ),
        .CLR(\flag[1]_i_3_n_0 ),
        .D(p_0_in[4]),
        .Q(plainTextAddr[4]));
  FDCE #(
    .INIT(1'b0)) 
    \addr_reg[5] 
       (.C(clk),
        .CE(\addr[7]_i_1_n_0 ),
        .CLR(\flag[1]_i_3_n_0 ),
        .D(p_0_in[5]),
        .Q(plainTextAddr[5]));
  FDCE #(
    .INIT(1'b0)) 
    \addr_reg[6] 
       (.C(clk),
        .CE(\addr[7]_i_1_n_0 ),
        .CLR(\flag[1]_i_3_n_0 ),
        .D(p_0_in[6]),
        .Q(plainTextAddr[6]));
  FDCE #(
    .INIT(1'b0)) 
    \addr_reg[7] 
       (.C(clk),
        .CE(\addr[7]_i_1_n_0 ),
        .CLR(\flag[1]_i_3_n_0 ),
        .D(p_0_in[7]),
        .Q(plainTextAddr[7]));
  CARRY4 flag1_carry
       (.CI(1'b0),
        .CO({flag1_carry_n_0,flag1_carry_n_1,flag1_carry_n_2,flag1_carry_n_3}),
        .CYINIT(1'b0),
        .DI({flag1_carry_i_1_n_0,flag1_carry_i_2_n_0,flag1_carry_i_3_n_0,flag1_carry_i_4_n_0}),
        .O(NLW_flag1_carry_O_UNCONNECTED[3:0]),
        .S({flag1_carry_i_5_n_0,flag1_carry_i_6_n_0,flag1_carry_i_7_n_0,flag1_carry_i_8_n_0}));
  LUT4 #(
    .INIT(16'h2F02)) 
    flag1_carry_i_1
       (.I0(temp_reg__0[6]),
        .I1(plainTextAddr[6]),
        .I2(plainTextAddr[7]),
        .I3(temp_reg__0[7]),
        .O(flag1_carry_i_1_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    flag1_carry_i_2
       (.I0(temp_reg__0[4]),
        .I1(plainTextAddr[4]),
        .I2(plainTextAddr[5]),
        .I3(temp_reg__0[5]),
        .O(flag1_carry_i_2_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    flag1_carry_i_3
       (.I0(temp_reg__0[2]),
        .I1(plainTextAddr[2]),
        .I2(plainTextAddr[3]),
        .I3(temp_reg__0[3]),
        .O(flag1_carry_i_3_n_0));
  LUT2 #(
    .INIT(4'h7)) 
    flag1_carry_i_4
       (.I0(plainTextAddr[0]),
        .I1(plainTextAddr[1]),
        .O(flag1_carry_i_4_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    flag1_carry_i_5
       (.I0(temp_reg__0[6]),
        .I1(plainTextAddr[6]),
        .I2(temp_reg__0[7]),
        .I3(plainTextAddr[7]),
        .O(flag1_carry_i_5_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    flag1_carry_i_6
       (.I0(temp_reg__0[4]),
        .I1(plainTextAddr[4]),
        .I2(temp_reg__0[5]),
        .I3(plainTextAddr[5]),
        .O(flag1_carry_i_6_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    flag1_carry_i_7
       (.I0(temp_reg__0[2]),
        .I1(plainTextAddr[2]),
        .I2(temp_reg__0[3]),
        .I3(plainTextAddr[3]),
        .O(flag1_carry_i_7_n_0));
  LUT2 #(
    .INIT(4'h8)) 
    flag1_carry_i_8
       (.I0(plainTextAddr[0]),
        .I1(plainTextAddr[1]),
        .O(flag1_carry_i_8_n_0));
  LUT4 #(
    .INIT(16'h043C)) 
    \flag[1]_i_1 
       (.I0(flag1_carry_n_0),
        .I1(enPlainTextIn_IBUF),
        .I2(\flag_reg_n_0_[1] ),
        .I3(valid),
        .O(\flag[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hA8)) 
    \flag[1]_i_2 
       (.I0(enPlainTextIn_IBUF),
        .I1(\flag_reg_n_0_[1] ),
        .I2(valid),
        .O(\flag[1]_i_2_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \flag[1]_i_3 
       (.I0(rst_IBUF),
        .O(\flag[1]_i_3_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \flag_reg[1] 
       (.C(clk),
        .CE(\flag[1]_i_1_n_0 ),
        .CLR(\flag[1]_i_3_n_0 ),
        .D(\flag[1]_i_2_n_0 ),
        .Q(\flag_reg_n_0_[1] ));
  LUT1 #(
    .INIT(2'h1)) 
    \temp[2]_i_1 
       (.I0(temp_reg__0[2]),
        .O(p_0_in__0[2]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \temp[3]_i_1 
       (.I0(temp_reg__0[2]),
        .I1(temp_reg__0[3]),
        .O(p_0_in__0[3]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \temp[4]_i_1 
       (.I0(temp_reg__0[2]),
        .I1(temp_reg__0[3]),
        .I2(temp_reg__0[4]),
        .O(p_0_in__0[4]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \temp[5]_i_1 
       (.I0(temp_reg__0[3]),
        .I1(temp_reg__0[2]),
        .I2(temp_reg__0[4]),
        .I3(temp_reg__0[5]),
        .O(p_0_in__0[5]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \temp[6]_i_1 
       (.I0(temp_reg__0[4]),
        .I1(temp_reg__0[2]),
        .I2(temp_reg__0[3]),
        .I3(temp_reg__0[5]),
        .I4(temp_reg__0[6]),
        .O(p_0_in__0[6]));
  LUT3 #(
    .INIT(8'h04)) 
    \temp[7]_i_1 
       (.I0(valid),
        .I1(\flag_reg_n_0_[1] ),
        .I2(enPlainTextIn_IBUF),
        .O(\temp[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \temp[7]_i_2 
       (.I0(temp_reg__0[5]),
        .I1(temp_reg__0[3]),
        .I2(temp_reg__0[2]),
        .I3(temp_reg__0[4]),
        .I4(temp_reg__0[6]),
        .I5(temp_reg__0[7]),
        .O(p_0_in__0[7]));
  FDCE #(
    .INIT(1'b0)) 
    \temp_reg[2] 
       (.C(clk),
        .CE(\temp[7]_i_1_n_0 ),
        .CLR(\flag[1]_i_3_n_0 ),
        .D(p_0_in__0[2]),
        .Q(temp_reg__0[2]));
  FDCE #(
    .INIT(1'b0)) 
    \temp_reg[3] 
       (.C(clk),
        .CE(\temp[7]_i_1_n_0 ),
        .CLR(\flag[1]_i_3_n_0 ),
        .D(p_0_in__0[3]),
        .Q(temp_reg__0[3]));
  FDCE #(
    .INIT(1'b0)) 
    \temp_reg[4] 
       (.C(clk),
        .CE(\temp[7]_i_1_n_0 ),
        .CLR(\flag[1]_i_3_n_0 ),
        .D(p_0_in__0[4]),
        .Q(temp_reg__0[4]));
  FDCE #(
    .INIT(1'b0)) 
    \temp_reg[5] 
       (.C(clk),
        .CE(\temp[7]_i_1_n_0 ),
        .CLR(\flag[1]_i_3_n_0 ),
        .D(p_0_in__0[5]),
        .Q(temp_reg__0[5]));
  FDCE #(
    .INIT(1'b0)) 
    \temp_reg[6] 
       (.C(clk),
        .CE(\temp[7]_i_1_n_0 ),
        .CLR(\flag[1]_i_3_n_0 ),
        .D(p_0_in__0[6]),
        .Q(temp_reg__0[6]));
  FDCE #(
    .INIT(1'b0)) 
    \temp_reg[7] 
       (.C(clk),
        .CE(\temp[7]_i_1_n_0 ),
        .CLR(\flag[1]_i_3_n_0 ),
        .D(p_0_in__0[7]),
        .Q(temp_reg__0[7]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'h02)) 
    valid_i_1
       (.I0(enPlainTextIn_IBUF),
        .I1(\flag_reg_n_0_[1] ),
        .I2(valid),
        .O(valid_i_1_n_0));
  FDCE #(
    .INIT(1'b0)) 
    valid_reg
       (.C(clk),
        .CE(\flag[1]_i_1_n_0 ),
        .CLR(\flag[1]_i_3_n_0 ),
        .D(valid_i_1_n_0),
        .Q(valid));
endmodule

(* NotValidForBitStream *)
module top
   (clk,
    rst,
    enPlainTextIn,
    plainTextAddrValid,
    plainTextAddr);
  input clk;
  input rst;
  input enPlainTextIn;
  output plainTextAddrValid;
  output [7:0]plainTextAddr;

  wire clk;
  wire clk_IBUF;
  wire clk_IBUF_BUFG;
  wire enPlainTextIn;
  wire enPlainTextIn_IBUF;
  wire [7:0]plainTextAddr;
  wire plainTextAddrValid;
  wire plainTextAddrValid_OBUF;
  wire [7:0]plainTextAddr_OBUF;
  wire rst;
  wire rst_IBUF;

initial begin
 $sdf_annotate("aes_enc_tb_time_synth.sdf",,,,"tool_control");
end
  PlaintextAddrCounter PT1
       (.clk(clk_IBUF_BUFG),
        .enPlainTextIn_IBUF(enPlainTextIn_IBUF),
        .plainTextAddr(plainTextAddr_OBUF),
        .rst_IBUF(rst_IBUF),
        .valid(plainTextAddrValid_OBUF));
  BUFG clk_IBUF_BUFG_inst
       (.I(clk_IBUF),
        .O(clk_IBUF_BUFG));
  IBUF clk_IBUF_inst
       (.I(clk),
        .O(clk_IBUF));
  IBUF enPlainTextIn_IBUF_inst
       (.I(enPlainTextIn),
        .O(enPlainTextIn_IBUF));
  OBUF plainTextAddrValid_OBUF_inst
       (.I(plainTextAddrValid_OBUF),
        .O(plainTextAddrValid));
  OBUF \plainTextAddr_OBUF[0]_inst 
       (.I(plainTextAddr_OBUF[0]),
        .O(plainTextAddr[0]));
  OBUF \plainTextAddr_OBUF[1]_inst 
       (.I(plainTextAddr_OBUF[1]),
        .O(plainTextAddr[1]));
  OBUF \plainTextAddr_OBUF[2]_inst 
       (.I(plainTextAddr_OBUF[2]),
        .O(plainTextAddr[2]));
  OBUF \plainTextAddr_OBUF[3]_inst 
       (.I(plainTextAddr_OBUF[3]),
        .O(plainTextAddr[3]));
  OBUF \plainTextAddr_OBUF[4]_inst 
       (.I(plainTextAddr_OBUF[4]),
        .O(plainTextAddr[4]));
  OBUF \plainTextAddr_OBUF[5]_inst 
       (.I(plainTextAddr_OBUF[5]),
        .O(plainTextAddr[5]));
  OBUF \plainTextAddr_OBUF[6]_inst 
       (.I(plainTextAddr_OBUF[6]),
        .O(plainTextAddr[6]));
  OBUF \plainTextAddr_OBUF[7]_inst 
       (.I(plainTextAddr_OBUF[7]),
        .O(plainTextAddr[7]));
  IBUF rst_IBUF_inst
       (.I(rst),
        .O(rst_IBUF));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
