// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.1 (win64) Build 1846317 Fri Apr 14 18:55:03 MDT 2017
// Date        : Mon May 14 23:07:43 2018
// Host        : DESKTOP-GJPCRJL running 64-bit major release  (build 9200)
// Command     : write_verilog -mode funcsim -nolib -force -file
//               C:/College/Thesis/AES_2018/aes_enc_only/aes_enc_only.sim/sim_1/synth/func/enc_testbench_func_synth.v
// Design      : top
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module aes_enc_core
   (led0_OBUF,
    clk_IBUF_BUFG,
    rst,
    encStart_IBUF);
  output led0_OBUF;
  input clk_IBUF_BUFG;
  input rst;
  input encStart_IBUF;

  wire clk_IBUF_BUFG;
  wire [6:0]curr_state;
  wire [6:6]curr_state_reg;
  wire \curr_state_reg_n_0_[0] ;
  wire \curr_state_reg_n_0_[1] ;
  wire \curr_state_reg_n_0_[2] ;
  wire \curr_state_reg_n_0_[3] ;
  wire \curr_state_reg_n_0_[4] ;
  wire \curr_state_reg_n_0_[5] ;
  wire encStart_IBUF;
  wire led0_OBUF;
  wire ledDone_reg_i_1_n_0;
  wire ledDone_reg_i_2_n_0;
  wire [6:0]next_state;
  wire \next_state_inferred__0/next_state_reg[2]_i_1_n_0 ;
  wire \next_state_inferred__0/next_state_reg[2]_i_2_n_0 ;
  wire \next_state_inferred__0/next_state_reg[3]_i_2_n_0 ;
  wire \next_state_inferred__0/next_state_reg[4]_i_1_n_0 ;
  wire \next_state_inferred__0/next_state_reg[5]_i_1_n_0 ;
  wire \next_state_inferred__0/next_state_reg[5]_i_2_n_0 ;
  wire \next_state_inferred__0/next_state_reg[5]_i_3_n_0 ;
  wire \next_state_inferred__0/next_state_reg[5]_i_4_n_0 ;
  wire \next_state_inferred__0/next_state_reg[6]_i_1_n_0 ;
  wire \next_state_inferred__0/next_state_reg[6]_i_3_n_0 ;
  wire \next_state_reg[0]_i_1_n_0 ;
  wire \next_state_reg[1]_i_1_n_0 ;
  wire \next_state_reg[3]_i_1_n_0 ;
  wire \next_state_reg[6]_i_2_n_0 ;
  wire \next_state_reg[6]_i_4_n_0 ;
  wire rst;

  FDCE #(
    .INIT(1'b0)) 
    \curr_state_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(rst),
        .D(next_state[0]),
        .Q(\curr_state_reg_n_0_[0] ));
  FDCE #(
    .INIT(1'b0)) 
    \curr_state_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(rst),
        .D(next_state[1]),
        .Q(\curr_state_reg_n_0_[1] ));
  FDCE #(
    .INIT(1'b0)) 
    \curr_state_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(rst),
        .D(next_state[2]),
        .Q(\curr_state_reg_n_0_[2] ));
  FDCE #(
    .INIT(1'b0)) 
    \curr_state_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(rst),
        .D(next_state[3]),
        .Q(\curr_state_reg_n_0_[3] ));
  FDCE #(
    .INIT(1'b0)) 
    \curr_state_reg[4] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(rst),
        .D(next_state[4]),
        .Q(\curr_state_reg_n_0_[4] ));
  FDCE #(
    .INIT(1'b0)) 
    \curr_state_reg[5] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(rst),
        .D(next_state[5]),
        .Q(\curr_state_reg_n_0_[5] ));
  FDCE #(
    .INIT(1'b0)) 
    \curr_state_reg[6] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(rst),
        .D(next_state[6]),
        .Q(curr_state_reg));
  (* equivalent_register_removal = "no" *) 
  FDCE #(
    .INIT(1'b0)) 
    \curr_state_reg_rep[0] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(rst),
        .D(next_state[0]),
        .Q(curr_state[0]));
  (* equivalent_register_removal = "no" *) 
  FDCE #(
    .INIT(1'b0)) 
    \curr_state_reg_rep[1] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(rst),
        .D(next_state[1]),
        .Q(curr_state[1]));
  (* equivalent_register_removal = "no" *) 
  FDCE #(
    .INIT(1'b0)) 
    \curr_state_reg_rep[2] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(rst),
        .D(next_state[2]),
        .Q(curr_state[2]));
  (* equivalent_register_removal = "no" *) 
  FDCE #(
    .INIT(1'b0)) 
    \curr_state_reg_rep[3] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(rst),
        .D(next_state[3]),
        .Q(curr_state[3]));
  (* equivalent_register_removal = "no" *) 
  FDCE #(
    .INIT(1'b0)) 
    \curr_state_reg_rep[4] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(rst),
        .D(next_state[4]),
        .Q(curr_state[4]));
  (* equivalent_register_removal = "no" *) 
  FDCE #(
    .INIT(1'b0)) 
    \curr_state_reg_rep[5] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(rst),
        .D(next_state[5]),
        .Q(curr_state[5]));
  (* equivalent_register_removal = "no" *) 
  FDCE #(
    .INIT(1'b0)) 
    \curr_state_reg_rep[6] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(rst),
        .D(next_state[6]),
        .Q(curr_state[6]));
  (* XILINX_LEGACY_PRIM = "LD" *) 
  LDCE #(
    .INIT(1'b0)) 
    ledDone_reg
       (.CLR(1'b0),
        .D(curr_state_reg),
        .G(ledDone_reg_i_1_n_0),
        .GE(1'b1),
        .Q(led0_OBUF));
  LUT6 #(
    .INIT(64'h0000000000000081)) 
    ledDone_reg_i_1
       (.I0(curr_state_reg),
        .I1(\curr_state_reg_n_0_[5] ),
        .I2(\curr_state_reg_n_0_[2] ),
        .I3(\curr_state_reg_n_0_[1] ),
        .I4(\curr_state_reg_n_0_[0] ),
        .I5(ledDone_reg_i_2_n_0),
        .O(ledDone_reg_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'hE)) 
    ledDone_reg_i_2
       (.I0(\curr_state_reg_n_0_[4] ),
        .I1(\curr_state_reg_n_0_[3] ),
        .O(ledDone_reg_i_2_n_0));
  LUT6 #(
    .INIT(64'h34003C3C4C00CCCC)) 
    \next_state_inferred__0/next_state_reg[2]_i_1 
       (.I0(curr_state[5]),
        .I1(curr_state[2]),
        .I2(curr_state[0]),
        .I3(\next_state_inferred__0/next_state_reg[2]_i_2_n_0 ),
        .I4(curr_state[6]),
        .I5(curr_state[1]),
        .O(\next_state_inferred__0/next_state_reg[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \next_state_inferred__0/next_state_reg[2]_i_2 
       (.I0(curr_state[3]),
        .I1(curr_state[4]),
        .O(\next_state_inferred__0/next_state_reg[2]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hA8)) 
    \next_state_inferred__0/next_state_reg[3]_i_2 
       (.I0(curr_state[6]),
        .I1(curr_state[5]),
        .I2(curr_state[4]),
        .O(\next_state_inferred__0/next_state_reg[3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000078F0F0F0)) 
    \next_state_inferred__0/next_state_reg[4]_i_1 
       (.I0(curr_state[3]),
        .I1(curr_state[2]),
        .I2(curr_state[4]),
        .I3(curr_state[0]),
        .I4(curr_state[1]),
        .I5(curr_state[6]),
        .O(\next_state_inferred__0/next_state_reg[4]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h02FF0200)) 
    \next_state_inferred__0/next_state_reg[5]_i_1 
       (.I0(curr_state[0]),
        .I1(curr_state[6]),
        .I2(curr_state[5]),
        .I3(\next_state_inferred__0/next_state_reg[5]_i_2_n_0 ),
        .I4(\next_state_inferred__0/next_state_reg[5]_i_3_n_0 ),
        .O(\next_state_inferred__0/next_state_reg[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'hE000)) 
    \next_state_inferred__0/next_state_reg[5]_i_2 
       (.I0(curr_state[3]),
        .I1(curr_state[6]),
        .I2(curr_state[4]),
        .I3(\next_state_inferred__0/next_state_reg[5]_i_4_n_0 ),
        .O(\next_state_inferred__0/next_state_reg[5]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00400420CCCCCCCC)) 
    \next_state_inferred__0/next_state_reg[5]_i_3 
       (.I0(curr_state[3]),
        .I1(curr_state[5]),
        .I2(curr_state[1]),
        .I3(curr_state[2]),
        .I4(curr_state[0]),
        .I5(curr_state[6]),
        .O(\next_state_inferred__0/next_state_reg[5]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hD5DF5555)) 
    \next_state_inferred__0/next_state_reg[5]_i_4 
       (.I0(curr_state[3]),
        .I1(curr_state[2]),
        .I2(curr_state[0]),
        .I3(curr_state[5]),
        .I4(curr_state[1]),
        .O(\next_state_inferred__0/next_state_reg[5]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'h60)) 
    \next_state_inferred__0/next_state_reg[6]_i_1 
       (.I0(curr_state[6]),
        .I1(curr_state[4]),
        .I2(\next_state_inferred__0/next_state_reg[6]_i_3_n_0 ),
        .O(\next_state_inferred__0/next_state_reg[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h8000010500005D75)) 
    \next_state_inferred__0/next_state_reg[6]_i_3 
       (.I0(curr_state[5]),
        .I1(curr_state[1]),
        .I2(curr_state[2]),
        .I3(curr_state[0]),
        .I4(curr_state[4]),
        .I5(curr_state[3]),
        .O(\next_state_inferred__0/next_state_reg[6]_i_3_n_0 ));
  (* XILINX_LEGACY_PRIM = "LD" *) 
  LDCE #(
    .INIT(1'b0)) 
    \next_state_reg[0] 
       (.CLR(1'b0),
        .D(\next_state_reg[0]_i_1_n_0 ),
        .G(\next_state_reg[6]_i_2_n_0 ),
        .GE(1'b1),
        .Q(next_state[0]));
  LUT6 #(
    .INIT(64'h0055005500551555)) 
    \next_state_reg[0]_i_1 
       (.I0(curr_state[0]),
        .I1(curr_state[3]),
        .I2(curr_state[2]),
        .I3(curr_state[6]),
        .I4(curr_state[5]),
        .I5(curr_state[4]),
        .O(\next_state_reg[0]_i_1_n_0 ));
  (* XILINX_LEGACY_PRIM = "LD" *) 
  LDCE #(
    .INIT(1'b0)) 
    \next_state_reg[1] 
       (.CLR(1'b0),
        .D(\next_state_reg[1]_i_1_n_0 ),
        .G(\next_state_reg[6]_i_2_n_0 ),
        .GE(1'b1),
        .Q(next_state[1]));
  LUT6 #(
    .INIT(64'h0014141414141414)) 
    \next_state_reg[1]_i_1 
       (.I0(\next_state_inferred__0/next_state_reg[3]_i_2_n_0 ),
        .I1(curr_state[0]),
        .I2(curr_state[1]),
        .I3(curr_state[3]),
        .I4(curr_state[2]),
        .I5(curr_state[6]),
        .O(\next_state_reg[1]_i_1_n_0 ));
  (* XILINX_LEGACY_PRIM = "LD" *) 
  LDCE #(
    .INIT(1'b0)) 
    \next_state_reg[2] 
       (.CLR(1'b0),
        .D(\next_state_inferred__0/next_state_reg[2]_i_1_n_0 ),
        .G(\next_state_reg[6]_i_2_n_0 ),
        .GE(1'b1),
        .Q(next_state[2]));
  (* XILINX_LEGACY_PRIM = "LD" *) 
  LDCE #(
    .INIT(1'b0)) 
    \next_state_reg[3] 
       (.CLR(1'b0),
        .D(\next_state_reg[3]_i_1_n_0 ),
        .G(\next_state_reg[6]_i_2_n_0 ),
        .GE(1'b1),
        .Q(next_state[3]));
  LUT6 #(
    .INIT(64'h00000000406A0AAA)) 
    \next_state_reg[3]_i_1 
       (.I0(curr_state[3]),
        .I1(curr_state[0]),
        .I2(curr_state[2]),
        .I3(curr_state[6]),
        .I4(curr_state[1]),
        .I5(\next_state_inferred__0/next_state_reg[3]_i_2_n_0 ),
        .O(\next_state_reg[3]_i_1_n_0 ));
  (* XILINX_LEGACY_PRIM = "LD" *) 
  LDCE #(
    .INIT(1'b0)) 
    \next_state_reg[4] 
       (.CLR(1'b0),
        .D(\next_state_inferred__0/next_state_reg[4]_i_1_n_0 ),
        .G(\next_state_reg[6]_i_2_n_0 ),
        .GE(1'b1),
        .Q(next_state[4]));
  (* XILINX_LEGACY_PRIM = "LD" *) 
  LDCE #(
    .INIT(1'b0)) 
    \next_state_reg[5] 
       (.CLR(1'b0),
        .D(\next_state_inferred__0/next_state_reg[5]_i_1_n_0 ),
        .G(\next_state_reg[6]_i_2_n_0 ),
        .GE(1'b1),
        .Q(next_state[5]));
  (* XILINX_LEGACY_PRIM = "LD" *) 
  LDCE #(
    .INIT(1'b0)) 
    \next_state_reg[6] 
       (.CLR(1'b0),
        .D(\next_state_inferred__0/next_state_reg[6]_i_1_n_0 ),
        .G(\next_state_reg[6]_i_2_n_0 ),
        .GE(1'b1),
        .Q(next_state[6]));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \next_state_reg[6]_i_2 
       (.I0(encStart_IBUF),
        .I1(\curr_state_reg_n_0_[5] ),
        .I2(curr_state_reg),
        .I3(\next_state_reg[6]_i_4_n_0 ),
        .O(\next_state_reg[6]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'hFFFFFEEF)) 
    \next_state_reg[6]_i_4 
       (.I0(\curr_state_reg_n_0_[3] ),
        .I1(\curr_state_reg_n_0_[4] ),
        .I2(\curr_state_reg_n_0_[0] ),
        .I3(\curr_state_reg_n_0_[1] ),
        .I4(\curr_state_reg_n_0_[2] ),
        .O(\next_state_reg[6]_i_4_n_0 ));
endmodule

(* NotValidForBitStream *)
module top
   (clk,
    rst,
    encStart,
    ready,
    TxD,
    led0,
    ledout);
  input clk;
  input rst;
  input encStart;
  input ready;
  output TxD;
  output led0;
  output [7:0]ledout;

  wire TxD;
  wire TxD_OBUF;
  wire U1_n_1;
  wire clk;
  wire clk_IBUF;
  wire clk_IBUF_BUFG;
  wire encStart;
  wire encStart_IBUF;
  wire led0;
  wire led0_OBUF;
  wire [7:0]ledout;
  wire ready;
  wire ready_IBUF;
  wire rst;
  wire rst_IBUF;

  aes_enc_core AES1
       (.clk_IBUF_BUFG(clk_IBUF_BUFG),
        .encStart_IBUF(encStart_IBUF),
        .led0_OBUF(led0_OBUF),
        .rst(U1_n_1));
  OBUF TxD_OBUF_inst
       (.I(TxD_OBUF),
        .O(TxD));
  uart_tx U1
       (.TxD_OBUF(TxD_OBUF),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .ready_IBUF(ready_IBUF),
        .rst_IBUF(rst_IBUF),
        .\tx_buff_reg[1][0]_0 (U1_n_1));
  BUFG clk_IBUF_BUFG_inst
       (.I(clk_IBUF),
        .O(clk_IBUF_BUFG));
  IBUF clk_IBUF_inst
       (.I(clk),
        .O(clk_IBUF));
  IBUF encStart_IBUF_inst
       (.I(encStart),
        .O(encStart_IBUF));
  OBUF led0_OBUF_inst
       (.I(led0_OBUF),
        .O(led0));
  OBUFT \ledout_OBUF[0]_inst 
       (.I(1'b0),
        .O(ledout[0]),
        .T(1'b1));
  OBUFT \ledout_OBUF[1]_inst 
       (.I(1'b0),
        .O(ledout[1]),
        .T(1'b1));
  OBUFT \ledout_OBUF[2]_inst 
       (.I(1'b0),
        .O(ledout[2]),
        .T(1'b1));
  OBUFT \ledout_OBUF[3]_inst 
       (.I(1'b0),
        .O(ledout[3]),
        .T(1'b1));
  OBUFT \ledout_OBUF[4]_inst 
       (.I(1'b0),
        .O(ledout[4]),
        .T(1'b1));
  OBUFT \ledout_OBUF[5]_inst 
       (.I(1'b0),
        .O(ledout[5]),
        .T(1'b1));
  OBUFT \ledout_OBUF[6]_inst 
       (.I(1'b0),
        .O(ledout[6]),
        .T(1'b1));
  OBUFT \ledout_OBUF[7]_inst 
       (.I(1'b0),
        .O(ledout[7]),
        .T(1'b1));
  IBUF ready_IBUF_inst
       (.I(ready),
        .O(ready_IBUF));
  IBUF rst_IBUF_inst
       (.I(rst),
        .O(rst_IBUF));
endmodule

module uart_tx
   (TxD_OBUF,
    \tx_buff_reg[1][0]_0 ,
    clk_IBUF_BUFG,
    rst_IBUF,
    ready_IBUF);
  output TxD_OBUF;
  output \tx_buff_reg[1][0]_0 ;
  input clk_IBUF_BUFG;
  input rst_IBUF;
  input ready_IBUF;

  wire TxD0_out;
  wire TxD_OBUF;
  wire TxD_i_2_n_0;
  wire TxD_i_3_n_0;
  wire TxD_i_4_n_0;
  wire TxD_i_5_n_0;
  wire TxD_i_6_n_0;
  wire TxD_i_7_n_0;
  wire [12:0]baud_count;
  wire [12:1]baud_count0;
  wire baud_count1;
  wire \baud_count[12]_i_10_n_0 ;
  wire \baud_count[12]_i_11_n_0 ;
  wire \baud_count[12]_i_3_n_0 ;
  wire \baud_count[12]_i_4_n_0 ;
  wire \baud_count[12]_i_6_n_0 ;
  wire \baud_count[12]_i_7_n_0 ;
  wire \baud_count[12]_i_8_n_0 ;
  wire \baud_count[12]_i_9_n_0 ;
  wire \baud_count[4]_i_3_n_0 ;
  wire \baud_count[4]_i_4_n_0 ;
  wire \baud_count[4]_i_5_n_0 ;
  wire \baud_count[4]_i_6_n_0 ;
  wire \baud_count[8]_i_3_n_0 ;
  wire \baud_count[8]_i_4_n_0 ;
  wire \baud_count[8]_i_5_n_0 ;
  wire \baud_count[8]_i_6_n_0 ;
  wire \baud_count_reg[12]_i_5_n_1 ;
  wire \baud_count_reg[12]_i_5_n_2 ;
  wire \baud_count_reg[12]_i_5_n_3 ;
  wire \baud_count_reg[4]_i_2_n_0 ;
  wire \baud_count_reg[4]_i_2_n_1 ;
  wire \baud_count_reg[4]_i_2_n_2 ;
  wire \baud_count_reg[4]_i_2_n_3 ;
  wire \baud_count_reg[8]_i_2_n_0 ;
  wire \baud_count_reg[8]_i_2_n_1 ;
  wire \baud_count_reg[8]_i_2_n_2 ;
  wire \baud_count_reg[8]_i_2_n_3 ;
  wire bit_count;
  wire \bit_count[3]_i_3_n_0 ;
  wire [3:0]bit_count_reg__0;
  wire byte_count;
  wire \byte_count[5]_i_3_n_0 ;
  wire [5:0]byte_count_reg__0;
  wire clk_IBUF_BUFG;
  wire data_bit_done_i_1_n_0;
  wire data_bit_done_reg_n_0;
  wire [12:0]p_0_in;
  wire [3:0]p_0_in__0;
  wire [5:0]p_0_in__0__0;
  wire p_3_in;
  wire ready_IBUF;
  wire rst_IBUF;
  wire start_bit_done;
  wire start_bit_done_i_1_n_0;
  wire [6:1]tx_buff;
  wire [6:6]tx_buff0_out;
  wire \tx_buff[0][6]_i_1_n_0 ;
  wire \tx_buff[0][6]_i_2_n_0 ;
  wire \tx_buff[0][6]_i_3_n_0 ;
  wire \tx_buff[0][6]_i_4_n_0 ;
  wire \tx_buff[10][6]_i_1_n_0 ;
  wire \tx_buff[10][6]_i_2_n_0 ;
  wire \tx_buff[10][7]_i_1_n_0 ;
  wire \tx_buff[10][7]_i_2_n_0 ;
  wire \tx_buff[11][6]_i_1_n_0 ;
  wire \tx_buff[11][6]_i_2_n_0 ;
  wire \tx_buff[11][6]_i_3_n_0 ;
  wire \tx_buff[11][6]_i_4_n_0 ;
  wire \tx_buff[12][2]_i_1_n_0 ;
  wire \tx_buff[12][6]_i_1_n_0 ;
  wire \tx_buff[12][6]_i_2_n_0 ;
  wire \tx_buff[12][6]_i_3_n_0 ;
  wire \tx_buff[13][1]_i_1_n_0 ;
  wire \tx_buff[13][4]_i_1_n_0 ;
  wire \tx_buff[13][6]_i_1_n_0 ;
  wire \tx_buff[13][6]_i_2_n_0 ;
  wire \tx_buff[13][6]_i_3_n_0 ;
  wire \tx_buff[13][7]_i_1_n_0 ;
  wire \tx_buff[13][7]_i_2_n_0 ;
  wire \tx_buff[14][0]_i_1_n_0 ;
  wire \tx_buff[14][3]_i_1_n_0 ;
  wire \tx_buff[14][5]_i_1_n_0 ;
  wire \tx_buff[14][6]_i_1_n_0 ;
  wire \tx_buff[14][6]_i_2_n_0 ;
  wire \tx_buff[14][6]_i_3_n_0 ;
  wire \tx_buff[14][6]_i_4_n_0 ;
  wire \tx_buff[14][6]_i_5_n_0 ;
  wire \tx_buff[15][0]_i_1_n_0 ;
  wire \tx_buff[15][1]_i_1_n_0 ;
  wire \tx_buff[15][2]_i_1_n_0 ;
  wire \tx_buff[15][3]_i_1_n_0 ;
  wire \tx_buff[15][4]_i_1_n_0 ;
  wire \tx_buff[15][5]_i_1_n_0 ;
  wire \tx_buff[15][6]_i_1_n_0 ;
  wire \tx_buff[15][6]_i_2_n_0 ;
  wire \tx_buff[15][6]_i_3_n_0 ;
  wire \tx_buff[15][6]_i_4_n_0 ;
  wire \tx_buff[15][7]_i_1_n_0 ;
  wire \tx_buff[15][7]_i_2_n_0 ;
  wire \tx_buff[15][7]_i_3_n_0 ;
  wire \tx_buff[16][5]_i_1_n_0 ;
  wire \tx_buff[16][5]_i_2_n_0 ;
  wire \tx_buff[16][5]_i_3_n_0 ;
  wire \tx_buff[16][5]_i_4_n_0 ;
  wire \tx_buff[16][5]_i_5_n_0 ;
  wire \tx_buff[16][5]_i_6_n_0 ;
  wire \tx_buff[16][6]_i_1_n_0 ;
  wire \tx_buff[16][6]_i_2_n_0 ;
  wire \tx_buff[17][5]_i_1_n_0 ;
  wire \tx_buff[17][5]_i_2_n_0 ;
  wire \tx_buff[17][5]_i_3_n_0 ;
  wire \tx_buff[17][5]_i_4_n_0 ;
  wire \tx_buff[17][5]_i_5_n_0 ;
  wire \tx_buff[17][5]_i_6_n_0 ;
  wire \tx_buff[17][5]_i_7_n_0 ;
  wire \tx_buff[17][6]_i_1_n_0 ;
  wire \tx_buff[17][6]_i_2_n_0 ;
  wire \tx_buff[17][6]_i_3_n_0 ;
  wire \tx_buff[18][0]_i_2_n_0 ;
  wire \tx_buff[18][0]_i_3_n_0 ;
  wire \tx_buff[18][0]_i_4_n_0 ;
  wire \tx_buff[18][0]_i_5_n_0 ;
  wire \tx_buff[18][0]_i_6_n_0 ;
  wire \tx_buff[18][0]_i_7_n_0 ;
  wire \tx_buff[18][1]_i_2_n_0 ;
  wire \tx_buff[18][1]_i_3_n_0 ;
  wire \tx_buff[18][1]_i_4_n_0 ;
  wire \tx_buff[18][1]_i_5_n_0 ;
  wire \tx_buff[18][1]_i_6_n_0 ;
  wire \tx_buff[18][1]_i_7_n_0 ;
  wire \tx_buff[18][2]_i_2_n_0 ;
  wire \tx_buff[18][2]_i_3_n_0 ;
  wire \tx_buff[18][2]_i_4_n_0 ;
  wire \tx_buff[18][2]_i_5_n_0 ;
  wire \tx_buff[18][2]_i_6_n_0 ;
  wire \tx_buff[18][2]_i_7_n_0 ;
  wire \tx_buff[18][3]_i_2_n_0 ;
  wire \tx_buff[18][3]_i_3_n_0 ;
  wire \tx_buff[18][3]_i_4_n_0 ;
  wire \tx_buff[18][3]_i_5_n_0 ;
  wire \tx_buff[18][3]_i_6_n_0 ;
  wire \tx_buff[18][3]_i_7_n_0 ;
  wire \tx_buff[18][4]_i_2_n_0 ;
  wire \tx_buff[18][4]_i_3_n_0 ;
  wire \tx_buff[18][4]_i_4_n_0 ;
  wire \tx_buff[18][4]_i_5_n_0 ;
  wire \tx_buff[18][4]_i_6_n_0 ;
  wire \tx_buff[18][4]_i_7_n_0 ;
  wire \tx_buff[18][5]_i_10_n_0 ;
  wire \tx_buff[18][5]_i_11_n_0 ;
  wire \tx_buff[18][5]_i_12_n_0 ;
  wire \tx_buff[18][5]_i_13_n_0 ;
  wire \tx_buff[18][5]_i_14_n_0 ;
  wire \tx_buff[18][5]_i_15_n_0 ;
  wire \tx_buff[18][5]_i_1_n_0 ;
  wire \tx_buff[18][5]_i_2_n_0 ;
  wire \tx_buff[18][5]_i_4_n_0 ;
  wire \tx_buff[18][5]_i_5_n_0 ;
  wire \tx_buff[18][5]_i_6_n_0 ;
  wire \tx_buff[18][5]_i_8_n_0 ;
  wire \tx_buff[18][5]_i_9_n_0 ;
  wire \tx_buff[18][6]_i_1_n_0 ;
  wire \tx_buff[18][6]_i_3_n_0 ;
  wire \tx_buff[18][6]_i_4_n_0 ;
  wire \tx_buff[18][6]_i_5_n_0 ;
  wire \tx_buff[18][6]_i_6_n_0 ;
  wire \tx_buff[18][6]_i_7_n_0 ;
  wire \tx_buff[18][6]_i_8_n_0 ;
  wire \tx_buff[19][5]_i_1_n_0 ;
  wire \tx_buff[19][5]_i_2_n_0 ;
  wire \tx_buff[19][5]_i_3_n_0 ;
  wire \tx_buff[19][5]_i_4_n_0 ;
  wire \tx_buff[19][6]_i_1_n_0 ;
  wire \tx_buff[1][6]_i_1_n_0 ;
  wire \tx_buff[2][6]_i_1_n_0 ;
  wire \tx_buff[2][6]_i_2_n_0 ;
  wire \tx_buff[2][7]_i_1_n_0 ;
  wire \tx_buff[3][6]_i_1_n_0 ;
  wire \tx_buff[3][6]_i_2_n_0 ;
  wire \tx_buff[4][6]_i_1_n_0 ;
  wire \tx_buff[4][6]_i_2_n_0 ;
  wire \tx_buff[4][6]_i_3_n_0 ;
  wire \tx_buff[4][7]_i_1_n_0 ;
  wire \tx_buff[5][6]_i_1_n_0 ;
  wire \tx_buff[5][6]_i_2_n_0 ;
  wire \tx_buff[5][7]_i_1_n_0 ;
  wire \tx_buff[5][7]_i_2_n_0 ;
  wire \tx_buff[6][6]_i_1_n_0 ;
  wire \tx_buff[6][6]_i_2_n_0 ;
  wire \tx_buff[6][6]_i_3_n_0 ;
  wire \tx_buff[6][6]_i_4_n_0 ;
  wire \tx_buff[6][6]_i_5_n_0 ;
  wire \tx_buff[6][7]_i_1_n_0 ;
  wire \tx_buff[6][7]_i_2_n_0 ;
  wire \tx_buff[7][6]_i_1_n_0 ;
  wire \tx_buff[7][6]_i_2_n_0 ;
  wire \tx_buff[7][6]_i_3_n_0 ;
  wire \tx_buff[7][7]_i_1_n_0 ;
  wire \tx_buff[8][6]_i_1_n_0 ;
  wire \tx_buff[9][6]_i_1_n_0 ;
  wire [6:0]\tx_buff_reg[0]__0 ;
  wire [7:0]\tx_buff_reg[10]__0 ;
  wire [6:0]\tx_buff_reg[11]__0 ;
  wire [6:0]\tx_buff_reg[12]__0 ;
  wire [7:0]\tx_buff_reg[13]__0 ;
  wire [6:0]\tx_buff_reg[14]__0 ;
  wire [7:0]\tx_buff_reg[15]__0 ;
  wire [6:0]\tx_buff_reg[16]__0 ;
  wire [6:0]\tx_buff_reg[17]__0 ;
  wire [6:0]\tx_buff_reg[18]__0 ;
  wire [6:0]\tx_buff_reg[19]__0 ;
  wire \tx_buff_reg[1][0]_0 ;
  wire [6:0]\tx_buff_reg[1]__0 ;
  wire [7:0]\tx_buff_reg[2]__0 ;
  wire [6:0]\tx_buff_reg[3]__0 ;
  wire [7:0]\tx_buff_reg[4]__0 ;
  wire [7:0]\tx_buff_reg[5]__0 ;
  wire [7:0]\tx_buff_reg[6]__0 ;
  wire [7:0]\tx_buff_reg[7]__0 ;
  wire [6:0]\tx_buff_reg[8]__0 ;
  wire [6:0]\tx_buff_reg[9]__0 ;
  wire [3:3]\NLW_baud_count_reg[12]_i_5_CO_UNCONNECTED ;

  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAA808)) 
    TxD_i_1
       (.I0(start_bit_done),
        .I1(TxD_i_2_n_0),
        .I2(byte_count_reg__0[4]),
        .I3(TxD_i_3_n_0),
        .I4(data_bit_done_reg_n_0),
        .I5(bit_count_reg__0[3]),
        .O(TxD0_out));
  LUT6 #(
    .INIT(64'hCCFFAAF0CC00AAF0)) 
    TxD_i_2
       (.I0(TxD_i_4_n_0),
        .I1(TxD_i_5_n_0),
        .I2(TxD_i_6_n_0),
        .I3(byte_count_reg__0[2]),
        .I4(byte_count_reg__0[3]),
        .I5(TxD_i_7_n_0),
        .O(TxD_i_2_n_0));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    TxD_i_3
       (.I0(\tx_buff_reg[17]__0 [0]),
        .I1(\tx_buff_reg[19]__0 [0]),
        .I2(byte_count_reg__0[1]),
        .I3(byte_count_reg__0[0]),
        .I4(\tx_buff_reg[16]__0 [0]),
        .I5(\tx_buff_reg[18]__0 [0]),
        .O(TxD_i_3_n_0));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    TxD_i_4
       (.I0(\tx_buff_reg[5]__0 [0]),
        .I1(\tx_buff_reg[7]__0 [0]),
        .I2(byte_count_reg__0[1]),
        .I3(byte_count_reg__0[0]),
        .I4(\tx_buff_reg[4]__0 [0]),
        .I5(\tx_buff_reg[6]__0 [0]),
        .O(TxD_i_4_n_0));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    TxD_i_5
       (.I0(\tx_buff_reg[13]__0 [0]),
        .I1(\tx_buff_reg[15]__0 [0]),
        .I2(byte_count_reg__0[1]),
        .I3(byte_count_reg__0[0]),
        .I4(\tx_buff_reg[12]__0 [0]),
        .I5(\tx_buff_reg[14]__0 [0]),
        .O(TxD_i_5_n_0));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    TxD_i_6
       (.I0(\tx_buff_reg[1]__0 [0]),
        .I1(\tx_buff_reg[3]__0 [0]),
        .I2(byte_count_reg__0[1]),
        .I3(byte_count_reg__0[0]),
        .I4(\tx_buff_reg[0]__0 [0]),
        .I5(\tx_buff_reg[2]__0 [0]),
        .O(TxD_i_6_n_0));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    TxD_i_7
       (.I0(\tx_buff_reg[9]__0 [0]),
        .I1(\tx_buff_reg[11]__0 [0]),
        .I2(byte_count_reg__0[1]),
        .I3(byte_count_reg__0[0]),
        .I4(\tx_buff_reg[8]__0 [0]),
        .I5(\tx_buff_reg[10]__0 [0]),
        .O(TxD_i_7_n_0));
  FDPE #(
    .INIT(1'b1)) 
    TxD_reg
       (.C(clk_IBUF_BUFG),
        .CE(p_3_in),
        .D(TxD0_out),
        .PRE(\tx_buff_reg[1][0]_0 ),
        .Q(TxD_OBUF));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'h02)) 
    \baud_count[0]_i_1 
       (.I0(\baud_count[12]_i_3_n_0 ),
        .I1(baud_count[0]),
        .I2(\baud_count[12]_i_4_n_0 ),
        .O(p_0_in[0]));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \baud_count[10]_i_1 
       (.I0(\baud_count[12]_i_3_n_0 ),
        .I1(\baud_count[12]_i_4_n_0 ),
        .I2(baud_count0[10]),
        .O(p_0_in[10]));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \baud_count[11]_i_1 
       (.I0(\baud_count[12]_i_3_n_0 ),
        .I1(\baud_count[12]_i_4_n_0 ),
        .I2(baud_count0[11]),
        .O(p_0_in[11]));
  LUT1 #(
    .INIT(2'h1)) 
    \baud_count[12]_i_1 
       (.I0(ready_IBUF),
        .O(p_3_in));
  LUT1 #(
    .INIT(2'h2)) 
    \baud_count[12]_i_10 
       (.I0(baud_count[10]),
        .O(\baud_count[12]_i_10_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \baud_count[12]_i_11 
       (.I0(baud_count[9]),
        .O(\baud_count[12]_i_11_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \baud_count[12]_i_2 
       (.I0(\baud_count[12]_i_3_n_0 ),
        .I1(\baud_count[12]_i_4_n_0 ),
        .I2(baud_count0[12]),
        .O(p_0_in[12]));
  LUT6 #(
    .INIT(64'h57575757575757F7)) 
    \baud_count[12]_i_3 
       (.I0(start_bit_done),
        .I1(data_bit_done_reg_n_0),
        .I2(bit_count_reg__0[3]),
        .I3(bit_count_reg__0[2]),
        .I4(bit_count_reg__0[0]),
        .I5(bit_count_reg__0[1]),
        .O(\baud_count[12]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hBBBBBBBBBBBBBBB3)) 
    \baud_count[12]_i_4 
       (.I0(\baud_count[12]_i_6_n_0 ),
        .I1(\baud_count[12]_i_7_n_0 ),
        .I2(baud_count[3]),
        .I3(baud_count[2]),
        .I4(baud_count[7]),
        .I5(baud_count[4]),
        .O(\baud_count[12]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h88808080)) 
    \baud_count[12]_i_6 
       (.I0(baud_count[9]),
        .I1(baud_count[8]),
        .I2(baud_count[7]),
        .I3(baud_count[6]),
        .I4(baud_count[5]),
        .O(\baud_count[12]_i_6_n_0 ));
  LUT3 #(
    .INIT(8'h01)) 
    \baud_count[12]_i_7 
       (.I0(baud_count[12]),
        .I1(baud_count[11]),
        .I2(baud_count[10]),
        .O(\baud_count[12]_i_7_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \baud_count[12]_i_8 
       (.I0(baud_count[12]),
        .O(\baud_count[12]_i_8_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \baud_count[12]_i_9 
       (.I0(baud_count[11]),
        .O(\baud_count[12]_i_9_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \baud_count[1]_i_1 
       (.I0(\baud_count[12]_i_3_n_0 ),
        .I1(\baud_count[12]_i_4_n_0 ),
        .I2(baud_count0[1]),
        .O(p_0_in[1]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \baud_count[2]_i_1 
       (.I0(\baud_count[12]_i_3_n_0 ),
        .I1(\baud_count[12]_i_4_n_0 ),
        .I2(baud_count0[2]),
        .O(p_0_in[2]));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \baud_count[3]_i_1 
       (.I0(\baud_count[12]_i_3_n_0 ),
        .I1(\baud_count[12]_i_4_n_0 ),
        .I2(baud_count0[3]),
        .O(p_0_in[3]));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \baud_count[4]_i_1 
       (.I0(\baud_count[12]_i_3_n_0 ),
        .I1(\baud_count[12]_i_4_n_0 ),
        .I2(baud_count0[4]),
        .O(p_0_in[4]));
  LUT1 #(
    .INIT(2'h2)) 
    \baud_count[4]_i_3 
       (.I0(baud_count[4]),
        .O(\baud_count[4]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \baud_count[4]_i_4 
       (.I0(baud_count[3]),
        .O(\baud_count[4]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \baud_count[4]_i_5 
       (.I0(baud_count[2]),
        .O(\baud_count[4]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \baud_count[4]_i_6 
       (.I0(baud_count[1]),
        .O(\baud_count[4]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \baud_count[5]_i_1 
       (.I0(\baud_count[12]_i_3_n_0 ),
        .I1(\baud_count[12]_i_4_n_0 ),
        .I2(baud_count0[5]),
        .O(p_0_in[5]));
  LUT3 #(
    .INIT(8'h20)) 
    \baud_count[6]_i_1 
       (.I0(\baud_count[12]_i_3_n_0 ),
        .I1(\baud_count[12]_i_4_n_0 ),
        .I2(baud_count0[6]),
        .O(p_0_in[6]));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \baud_count[7]_i_1 
       (.I0(\baud_count[12]_i_3_n_0 ),
        .I1(\baud_count[12]_i_4_n_0 ),
        .I2(baud_count0[7]),
        .O(p_0_in[7]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \baud_count[8]_i_1 
       (.I0(\baud_count[12]_i_3_n_0 ),
        .I1(\baud_count[12]_i_4_n_0 ),
        .I2(baud_count0[8]),
        .O(p_0_in[8]));
  LUT1 #(
    .INIT(2'h2)) 
    \baud_count[8]_i_3 
       (.I0(baud_count[8]),
        .O(\baud_count[8]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \baud_count[8]_i_4 
       (.I0(baud_count[7]),
        .O(\baud_count[8]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \baud_count[8]_i_5 
       (.I0(baud_count[6]),
        .O(\baud_count[8]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \baud_count[8]_i_6 
       (.I0(baud_count[5]),
        .O(\baud_count[8]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \baud_count[9]_i_1 
       (.I0(\baud_count[12]_i_3_n_0 ),
        .I1(\baud_count[12]_i_4_n_0 ),
        .I2(baud_count0[9]),
        .O(p_0_in[9]));
  FDCE #(
    .INIT(1'b0)) 
    \baud_count_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(p_3_in),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(p_0_in[0]),
        .Q(baud_count[0]));
  FDCE #(
    .INIT(1'b0)) 
    \baud_count_reg[10] 
       (.C(clk_IBUF_BUFG),
        .CE(p_3_in),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(p_0_in[10]),
        .Q(baud_count[10]));
  FDCE #(
    .INIT(1'b0)) 
    \baud_count_reg[11] 
       (.C(clk_IBUF_BUFG),
        .CE(p_3_in),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(p_0_in[11]),
        .Q(baud_count[11]));
  FDCE #(
    .INIT(1'b0)) 
    \baud_count_reg[12] 
       (.C(clk_IBUF_BUFG),
        .CE(p_3_in),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(p_0_in[12]),
        .Q(baud_count[12]));
  CARRY4 \baud_count_reg[12]_i_5 
       (.CI(\baud_count_reg[8]_i_2_n_0 ),
        .CO({\NLW_baud_count_reg[12]_i_5_CO_UNCONNECTED [3],\baud_count_reg[12]_i_5_n_1 ,\baud_count_reg[12]_i_5_n_2 ,\baud_count_reg[12]_i_5_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(baud_count0[12:9]),
        .S({\baud_count[12]_i_8_n_0 ,\baud_count[12]_i_9_n_0 ,\baud_count[12]_i_10_n_0 ,\baud_count[12]_i_11_n_0 }));
  FDCE #(
    .INIT(1'b0)) 
    \baud_count_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(p_3_in),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(p_0_in[1]),
        .Q(baud_count[1]));
  FDCE #(
    .INIT(1'b0)) 
    \baud_count_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(p_3_in),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(p_0_in[2]),
        .Q(baud_count[2]));
  FDCE #(
    .INIT(1'b0)) 
    \baud_count_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(p_3_in),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(p_0_in[3]),
        .Q(baud_count[3]));
  FDCE #(
    .INIT(1'b0)) 
    \baud_count_reg[4] 
       (.C(clk_IBUF_BUFG),
        .CE(p_3_in),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(p_0_in[4]),
        .Q(baud_count[4]));
  CARRY4 \baud_count_reg[4]_i_2 
       (.CI(1'b0),
        .CO({\baud_count_reg[4]_i_2_n_0 ,\baud_count_reg[4]_i_2_n_1 ,\baud_count_reg[4]_i_2_n_2 ,\baud_count_reg[4]_i_2_n_3 }),
        .CYINIT(baud_count[0]),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(baud_count0[4:1]),
        .S({\baud_count[4]_i_3_n_0 ,\baud_count[4]_i_4_n_0 ,\baud_count[4]_i_5_n_0 ,\baud_count[4]_i_6_n_0 }));
  FDCE #(
    .INIT(1'b0)) 
    \baud_count_reg[5] 
       (.C(clk_IBUF_BUFG),
        .CE(p_3_in),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(p_0_in[5]),
        .Q(baud_count[5]));
  FDCE #(
    .INIT(1'b0)) 
    \baud_count_reg[6] 
       (.C(clk_IBUF_BUFG),
        .CE(p_3_in),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(p_0_in[6]),
        .Q(baud_count[6]));
  FDCE #(
    .INIT(1'b0)) 
    \baud_count_reg[7] 
       (.C(clk_IBUF_BUFG),
        .CE(p_3_in),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(p_0_in[7]),
        .Q(baud_count[7]));
  FDCE #(
    .INIT(1'b0)) 
    \baud_count_reg[8] 
       (.C(clk_IBUF_BUFG),
        .CE(p_3_in),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(p_0_in[8]),
        .Q(baud_count[8]));
  CARRY4 \baud_count_reg[8]_i_2 
       (.CI(\baud_count_reg[4]_i_2_n_0 ),
        .CO({\baud_count_reg[8]_i_2_n_0 ,\baud_count_reg[8]_i_2_n_1 ,\baud_count_reg[8]_i_2_n_2 ,\baud_count_reg[8]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(baud_count0[8:5]),
        .S({\baud_count[8]_i_3_n_0 ,\baud_count[8]_i_4_n_0 ,\baud_count[8]_i_5_n_0 ,\baud_count[8]_i_6_n_0 }));
  FDCE #(
    .INIT(1'b0)) 
    \baud_count_reg[9] 
       (.C(clk_IBUF_BUFG),
        .CE(p_3_in),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(p_0_in[9]),
        .Q(baud_count[9]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'h01)) 
    \bit_count[0]_i_1 
       (.I0(data_bit_done_reg_n_0),
        .I1(bit_count_reg__0[3]),
        .I2(bit_count_reg__0[0]),
        .O(p_0_in__0[0]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT4 #(
    .INIT(16'h0110)) 
    \bit_count[1]_i_1 
       (.I0(bit_count_reg__0[3]),
        .I1(data_bit_done_reg_n_0),
        .I2(bit_count_reg__0[0]),
        .I3(bit_count_reg__0[1]),
        .O(p_0_in__0[1]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT5 #(
    .INIT(32'h00070008)) 
    \bit_count[2]_i_1 
       (.I0(bit_count_reg__0[1]),
        .I1(bit_count_reg__0[0]),
        .I2(data_bit_done_reg_n_0),
        .I3(bit_count_reg__0[3]),
        .I4(bit_count_reg__0[2]),
        .O(p_0_in__0[2]));
  LUT6 #(
    .INIT(64'h00000000B0B0B0A0)) 
    \bit_count[3]_i_1 
       (.I0(\baud_count[12]_i_4_n_0 ),
        .I1(\bit_count[3]_i_3_n_0 ),
        .I2(start_bit_done),
        .I3(bit_count_reg__0[3]),
        .I4(data_bit_done_reg_n_0),
        .I5(ready_IBUF),
        .O(bit_count));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT5 #(
    .INIT(32'h00000080)) 
    \bit_count[3]_i_2 
       (.I0(bit_count_reg__0[2]),
        .I1(bit_count_reg__0[0]),
        .I2(bit_count_reg__0[1]),
        .I3(data_bit_done_reg_n_0),
        .I4(bit_count_reg__0[3]),
        .O(p_0_in__0[3]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT4 #(
    .INIT(16'h0100)) 
    \bit_count[3]_i_3 
       (.I0(bit_count_reg__0[1]),
        .I1(bit_count_reg__0[0]),
        .I2(bit_count_reg__0[2]),
        .I3(bit_count_reg__0[3]),
        .O(\bit_count[3]_i_3_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \bit_count_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(bit_count),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(p_0_in__0[0]),
        .Q(bit_count_reg__0[0]));
  FDCE #(
    .INIT(1'b0)) 
    \bit_count_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(bit_count),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(p_0_in__0[1]),
        .Q(bit_count_reg__0[1]));
  FDCE #(
    .INIT(1'b0)) 
    \bit_count_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(bit_count),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(p_0_in__0[2]),
        .Q(bit_count_reg__0[2]));
  FDCE #(
    .INIT(1'b0)) 
    \bit_count_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(bit_count),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(p_0_in__0[3]),
        .Q(bit_count_reg__0[3]));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \byte_count[0]_i_1 
       (.I0(byte_count_reg__0[0]),
        .O(p_0_in__0__0[0]));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \byte_count[1]_i_1 
       (.I0(byte_count_reg__0[0]),
        .I1(byte_count_reg__0[1]),
        .O(p_0_in__0__0[1]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \byte_count[2]_i_1 
       (.I0(byte_count_reg__0[2]),
        .I1(byte_count_reg__0[1]),
        .I2(byte_count_reg__0[0]),
        .O(p_0_in__0__0[2]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \byte_count[3]_i_1 
       (.I0(byte_count_reg__0[0]),
        .I1(byte_count_reg__0[1]),
        .I2(byte_count_reg__0[2]),
        .I3(byte_count_reg__0[3]),
        .O(p_0_in__0__0[3]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \byte_count[4]_i_1 
       (.I0(byte_count_reg__0[2]),
        .I1(byte_count_reg__0[1]),
        .I2(byte_count_reg__0[0]),
        .I3(byte_count_reg__0[3]),
        .I4(byte_count_reg__0[4]),
        .O(p_0_in__0__0[4]));
  LUT6 #(
    .INIT(64'h0000000000008880)) 
    \byte_count[5]_i_1 
       (.I0(\baud_count[12]_i_4_n_0 ),
        .I1(start_bit_done),
        .I2(bit_count_reg__0[3]),
        .I3(data_bit_done_reg_n_0),
        .I4(ready_IBUF),
        .I5(\byte_count[5]_i_3_n_0 ),
        .O(byte_count));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \byte_count[5]_i_2 
       (.I0(byte_count_reg__0[3]),
        .I1(byte_count_reg__0[0]),
        .I2(byte_count_reg__0[1]),
        .I3(byte_count_reg__0[2]),
        .I4(byte_count_reg__0[4]),
        .I5(byte_count_reg__0[5]),
        .O(p_0_in__0__0[5]));
  LUT6 #(
    .INIT(64'hEEEEFEEEFFFFFFFF)) 
    \byte_count[5]_i_3 
       (.I0(byte_count_reg__0[5]),
        .I1(byte_count_reg__0[4]),
        .I2(byte_count_reg__0[2]),
        .I3(byte_count_reg__0[3]),
        .I4(\tx_buff[15][7]_i_3_n_0 ),
        .I5(\bit_count[3]_i_3_n_0 ),
        .O(\byte_count[5]_i_3_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \byte_count_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(byte_count),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(p_0_in__0__0[0]),
        .Q(byte_count_reg__0[0]));
  FDCE #(
    .INIT(1'b0)) 
    \byte_count_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(byte_count),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(p_0_in__0__0[1]),
        .Q(byte_count_reg__0[1]));
  FDCE #(
    .INIT(1'b0)) 
    \byte_count_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(byte_count),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(p_0_in__0__0[2]),
        .Q(byte_count_reg__0[2]));
  FDCE #(
    .INIT(1'b0)) 
    \byte_count_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(byte_count),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(p_0_in__0__0[3]),
        .Q(byte_count_reg__0[3]));
  FDCE #(
    .INIT(1'b0)) 
    \byte_count_reg[4] 
       (.C(clk_IBUF_BUFG),
        .CE(byte_count),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(p_0_in__0__0[4]),
        .Q(byte_count_reg__0[4]));
  FDCE #(
    .INIT(1'b0)) 
    \byte_count_reg[5] 
       (.C(clk_IBUF_BUFG),
        .CE(byte_count),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(p_0_in__0__0[5]),
        .Q(byte_count_reg__0[5]));
  LUT1 #(
    .INIT(2'h1)) 
    \curr_state[6]_i_1 
       (.I0(rst_IBUF),
        .O(\tx_buff_reg[1][0]_0 ));
  LUT6 #(
    .INIT(64'hFFFF0000F3F3D000)) 
    data_bit_done_i_1
       (.I0(\bit_count[3]_i_3_n_0 ),
        .I1(\baud_count[12]_i_4_n_0 ),
        .I2(start_bit_done),
        .I3(bit_count_reg__0[3]),
        .I4(data_bit_done_reg_n_0),
        .I5(ready_IBUF),
        .O(data_bit_done_i_1_n_0));
  FDPE #(
    .INIT(1'b1)) 
    data_bit_done_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(data_bit_done_i_1_n_0),
        .PRE(\tx_buff_reg[1][0]_0 ),
        .Q(data_bit_done_reg_n_0));
  LUT6 #(
    .INIT(64'h0F0B0C0C0F0B0C08)) 
    start_bit_done_i_1
       (.I0(\byte_count[5]_i_3_n_0 ),
        .I1(start_bit_done),
        .I2(ready_IBUF),
        .I3(baud_count1),
        .I4(\baud_count[12]_i_4_n_0 ),
        .I5(\bit_count[3]_i_3_n_0 ),
        .O(start_bit_done_i_1_n_0));
  FDPE #(
    .INIT(1'b1)) 
    start_bit_done_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(start_bit_done_i_1_n_0),
        .PRE(\tx_buff_reg[1][0]_0 ),
        .Q(start_bit_done));
  LUT6 #(
    .INIT(64'hAAAAAAEAAAAAAAAA)) 
    \tx_buff[0][6]_i_1 
       (.I0(\tx_buff[0][6]_i_2_n_0 ),
        .I1(\tx_buff[6][6]_i_4_n_0 ),
        .I2(\tx_buff[0][6]_i_3_n_0 ),
        .I3(byte_count_reg__0[5]),
        .I4(byte_count_reg__0[0]),
        .I5(\baud_count[12]_i_4_n_0 ),
        .O(\tx_buff[0][6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF00000100)) 
    \tx_buff[0][6]_i_2 
       (.I0(\baud_count[12]_i_3_n_0 ),
        .I1(byte_count_reg__0[5]),
        .I2(byte_count_reg__0[4]),
        .I3(\tx_buff[4][6]_i_3_n_0 ),
        .I4(\tx_buff[0][6]_i_4_n_0 ),
        .I5(ready_IBUF),
        .O(\tx_buff[0][6]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \tx_buff[0][6]_i_3 
       (.I0(byte_count_reg__0[2]),
        .I1(byte_count_reg__0[1]),
        .O(\tx_buff[0][6]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \tx_buff[0][6]_i_4 
       (.I0(byte_count_reg__0[3]),
        .I1(byte_count_reg__0[2]),
        .O(\tx_buff[0][6]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFF800000)) 
    \tx_buff[10][6]_i_1 
       (.I0(\baud_count[12]_i_4_n_0 ),
        .I1(byte_count_reg__0[1]),
        .I2(\tx_buff[18][5]_i_4_n_0 ),
        .I3(\tx_buff[18][5]_i_5_n_0 ),
        .I4(\tx_buff[10][6]_i_2_n_0 ),
        .I5(ready_IBUF),
        .O(\tx_buff[10][6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT3 #(
    .INIT(8'h10)) 
    \tx_buff[10][6]_i_2 
       (.I0(byte_count_reg__0[0]),
        .I1(byte_count_reg__0[4]),
        .I2(byte_count_reg__0[3]),
        .O(\tx_buff[10][6]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFDFFFFFF0000)) 
    \tx_buff[10][7]_i_1 
       (.I0(\tx_buff[13][7]_i_2_n_0 ),
        .I1(byte_count_reg__0[2]),
        .I2(byte_count_reg__0[0]),
        .I3(\tx_buff[10][7]_i_2_n_0 ),
        .I4(ready_IBUF),
        .I5(\tx_buff_reg[10]__0 [7]),
        .O(\tx_buff[10][7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \tx_buff[10][7]_i_2 
       (.I0(byte_count_reg__0[1]),
        .I1(byte_count_reg__0[3]),
        .O(\tx_buff[10][7]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hEEFEEEEEEEEEEEEE)) 
    \tx_buff[11][6]_i_1 
       (.I0(ready_IBUF),
        .I1(\tx_buff[11][6]_i_3_n_0 ),
        .I2(\tx_buff[14][6]_i_4_n_0 ),
        .I3(\tx_buff[15][7]_i_3_n_0 ),
        .I4(\tx_buff[11][6]_i_4_n_0 ),
        .I5(\baud_count[12]_i_4_n_0 ),
        .O(\tx_buff[11][6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \tx_buff[11][6]_i_2 
       (.I0(tx_buff0_out),
        .I1(ready_IBUF),
        .O(\tx_buff[11][6]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000001000000)) 
    \tx_buff[11][6]_i_3 
       (.I0(\tx_buff[17][5]_i_5_n_0 ),
        .I1(byte_count_reg__0[4]),
        .I2(byte_count_reg__0[2]),
        .I3(byte_count_reg__0[3]),
        .I4(byte_count_reg__0[1]),
        .I5(\tx_buff[17][5]_i_6_n_0 ),
        .O(\tx_buff[11][6]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \tx_buff[11][6]_i_4 
       (.I0(byte_count_reg__0[3]),
        .I1(byte_count_reg__0[2]),
        .O(\tx_buff[11][6]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF000000B8)) 
    \tx_buff[12][2]_i_1 
       (.I0(\tx_buff[18][2]_i_3_n_0 ),
        .I1(byte_count_reg__0[4]),
        .I2(\tx_buff[18][2]_i_2_n_0 ),
        .I3(bit_count_reg__0[3]),
        .I4(data_bit_done_reg_n_0),
        .I5(ready_IBUF),
        .O(\tx_buff[12][2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFEEEEEEEEEEEEEEE)) 
    \tx_buff[12][6]_i_1 
       (.I0(ready_IBUF),
        .I1(\tx_buff[12][6]_i_2_n_0 ),
        .I2(\baud_count[12]_i_4_n_0 ),
        .I3(\tx_buff[12][6]_i_3_n_0 ),
        .I4(start_bit_done),
        .I5(baud_count1),
        .O(\tx_buff[12][6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000010)) 
    \tx_buff[12][6]_i_2 
       (.I0(\tx_buff[17][5]_i_5_n_0 ),
        .I1(byte_count_reg__0[0]),
        .I2(byte_count_reg__0[3]),
        .I3(byte_count_reg__0[1]),
        .I4(byte_count_reg__0[4]),
        .I5(\tx_buff[14][6]_i_5_n_0 ),
        .O(\tx_buff[12][6]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000008)) 
    \tx_buff[12][6]_i_3 
       (.I0(byte_count_reg__0[3]),
        .I1(byte_count_reg__0[2]),
        .I2(byte_count_reg__0[5]),
        .I3(byte_count_reg__0[1]),
        .I4(byte_count_reg__0[0]),
        .I5(byte_count_reg__0[4]),
        .O(\tx_buff[12][6]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0101010000000100)) 
    \tx_buff[13][1]_i_1 
       (.I0(ready_IBUF),
        .I1(bit_count_reg__0[3]),
        .I2(data_bit_done_reg_n_0),
        .I3(\tx_buff[18][1]_i_2_n_0 ),
        .I4(byte_count_reg__0[4]),
        .I5(\tx_buff[18][1]_i_3_n_0 ),
        .O(\tx_buff[13][1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF000000B8)) 
    \tx_buff[13][4]_i_1 
       (.I0(\tx_buff[18][4]_i_3_n_0 ),
        .I1(byte_count_reg__0[4]),
        .I2(\tx_buff[18][4]_i_2_n_0 ),
        .I3(bit_count_reg__0[3]),
        .I4(data_bit_done_reg_n_0),
        .I5(ready_IBUF),
        .O(\tx_buff[13][4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hEAAAAAAAAAAAAAAA)) 
    \tx_buff[13][6]_i_1 
       (.I0(\tx_buff[13][6]_i_2_n_0 ),
        .I1(\baud_count[12]_i_4_n_0 ),
        .I2(byte_count_reg__0[2]),
        .I3(byte_count_reg__0[3]),
        .I4(\tx_buff[13][6]_i_3_n_0 ),
        .I5(\tx_buff[14][6]_i_4_n_0 ),
        .O(\tx_buff[13][6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF00000001)) 
    \tx_buff[13][6]_i_2 
       (.I0(\tx_buff[17][5]_i_6_n_0 ),
        .I1(\tx_buff[15][7]_i_2_n_0 ),
        .I2(byte_count_reg__0[4]),
        .I3(byte_count_reg__0[1]),
        .I4(\tx_buff[17][5]_i_5_n_0 ),
        .I5(ready_IBUF),
        .O(\tx_buff[13][6]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \tx_buff[13][6]_i_3 
       (.I0(byte_count_reg__0[0]),
        .I1(byte_count_reg__0[1]),
        .O(\tx_buff[13][6]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF7FFFFFFF0000)) 
    \tx_buff[13][7]_i_1 
       (.I0(\tx_buff[13][7]_i_2_n_0 ),
        .I1(\tx_buff[13][6]_i_3_n_0 ),
        .I2(byte_count_reg__0[2]),
        .I3(byte_count_reg__0[3]),
        .I4(ready_IBUF),
        .I5(\tx_buff_reg[13]__0 [7]),
        .O(\tx_buff[13][7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0002000200020000)) 
    \tx_buff[13][7]_i_2 
       (.I0(start_bit_done),
        .I1(\bit_count[3]_i_3_n_0 ),
        .I2(byte_count_reg__0[4]),
        .I3(byte_count_reg__0[5]),
        .I4(data_bit_done_reg_n_0),
        .I5(bit_count_reg__0[3]),
        .O(\tx_buff[13][7]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0101010000000100)) 
    \tx_buff[14][0]_i_1 
       (.I0(ready_IBUF),
        .I1(bit_count_reg__0[3]),
        .I2(data_bit_done_reg_n_0),
        .I3(\tx_buff[18][0]_i_2_n_0 ),
        .I4(byte_count_reg__0[4]),
        .I5(\tx_buff[18][0]_i_3_n_0 ),
        .O(\tx_buff[14][0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF000000B8)) 
    \tx_buff[14][3]_i_1 
       (.I0(\tx_buff[18][3]_i_3_n_0 ),
        .I1(byte_count_reg__0[4]),
        .I2(\tx_buff[18][3]_i_2_n_0 ),
        .I3(bit_count_reg__0[3]),
        .I4(data_bit_done_reg_n_0),
        .I5(ready_IBUF),
        .O(\tx_buff[14][3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF000000B8)) 
    \tx_buff[14][5]_i_1 
       (.I0(\tx_buff[18][5]_i_11_n_0 ),
        .I1(byte_count_reg__0[4]),
        .I2(\tx_buff[18][5]_i_10_n_0 ),
        .I3(bit_count_reg__0[3]),
        .I4(data_bit_done_reg_n_0),
        .I5(ready_IBUF),
        .O(\tx_buff[14][5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hEAAAAAAAAAAAAAAA)) 
    \tx_buff[14][6]_i_1 
       (.I0(\tx_buff[14][6]_i_2_n_0 ),
        .I1(\baud_count[12]_i_4_n_0 ),
        .I2(byte_count_reg__0[2]),
        .I3(byte_count_reg__0[3]),
        .I4(\tx_buff[14][6]_i_3_n_0 ),
        .I5(\tx_buff[14][6]_i_4_n_0 ),
        .O(\tx_buff[14][6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF00000004)) 
    \tx_buff[14][6]_i_2 
       (.I0(\tx_buff[14][6]_i_5_n_0 ),
        .I1(\tx_buff[10][7]_i_2_n_0 ),
        .I2(byte_count_reg__0[4]),
        .I3(byte_count_reg__0[0]),
        .I4(\tx_buff[17][5]_i_5_n_0 ),
        .I5(ready_IBUF),
        .O(\tx_buff[14][6]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \tx_buff[14][6]_i_3 
       (.I0(byte_count_reg__0[1]),
        .I1(byte_count_reg__0[0]),
        .O(\tx_buff[14][6]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT5 #(
    .INIT(32'h00000002)) 
    \tx_buff[14][6]_i_4 
       (.I0(start_bit_done),
        .I1(bit_count_reg__0[3]),
        .I2(data_bit_done_reg_n_0),
        .I3(byte_count_reg__0[4]),
        .I4(byte_count_reg__0[5]),
        .O(\tx_buff[14][6]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF55575555)) 
    \tx_buff[14][6]_i_5 
       (.I0(byte_count_reg__0[2]),
        .I1(bit_count_reg__0[1]),
        .I2(bit_count_reg__0[0]),
        .I3(bit_count_reg__0[2]),
        .I4(bit_count_reg__0[3]),
        .I5(byte_count_reg__0[5]),
        .O(\tx_buff[14][6]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF000000B8)) 
    \tx_buff[15][0]_i_1 
       (.I0(\tx_buff[18][0]_i_3_n_0 ),
        .I1(byte_count_reg__0[4]),
        .I2(\tx_buff[18][0]_i_2_n_0 ),
        .I3(bit_count_reg__0[3]),
        .I4(data_bit_done_reg_n_0),
        .I5(ready_IBUF),
        .O(\tx_buff[15][0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF000000B8)) 
    \tx_buff[15][1]_i_1 
       (.I0(\tx_buff[18][1]_i_3_n_0 ),
        .I1(byte_count_reg__0[4]),
        .I2(\tx_buff[18][1]_i_2_n_0 ),
        .I3(bit_count_reg__0[3]),
        .I4(data_bit_done_reg_n_0),
        .I5(ready_IBUF),
        .O(\tx_buff[15][1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0101010000000100)) 
    \tx_buff[15][2]_i_1 
       (.I0(ready_IBUF),
        .I1(bit_count_reg__0[3]),
        .I2(data_bit_done_reg_n_0),
        .I3(\tx_buff[18][2]_i_2_n_0 ),
        .I4(byte_count_reg__0[4]),
        .I5(\tx_buff[18][2]_i_3_n_0 ),
        .O(\tx_buff[15][2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0101010000000100)) 
    \tx_buff[15][3]_i_1 
       (.I0(ready_IBUF),
        .I1(bit_count_reg__0[3]),
        .I2(data_bit_done_reg_n_0),
        .I3(\tx_buff[18][3]_i_2_n_0 ),
        .I4(byte_count_reg__0[4]),
        .I5(\tx_buff[18][3]_i_3_n_0 ),
        .O(\tx_buff[15][3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0101010000000100)) 
    \tx_buff[15][4]_i_1 
       (.I0(ready_IBUF),
        .I1(bit_count_reg__0[3]),
        .I2(data_bit_done_reg_n_0),
        .I3(\tx_buff[18][4]_i_2_n_0 ),
        .I4(byte_count_reg__0[4]),
        .I5(\tx_buff[18][4]_i_3_n_0 ),
        .O(\tx_buff[15][4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0101010000000100)) 
    \tx_buff[15][5]_i_1 
       (.I0(ready_IBUF),
        .I1(bit_count_reg__0[3]),
        .I2(data_bit_done_reg_n_0),
        .I3(\tx_buff[18][5]_i_10_n_0 ),
        .I4(byte_count_reg__0[4]),
        .I5(\tx_buff[18][5]_i_11_n_0 ),
        .O(\tx_buff[15][5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF0000008F)) 
    \tx_buff[15][6]_i_1 
       (.I0(\baud_count[12]_i_4_n_0 ),
        .I1(\tx_buff[16][5]_i_6_n_0 ),
        .I2(\baud_count[12]_i_3_n_0 ),
        .I3(\tx_buff[15][6]_i_3_n_0 ),
        .I4(\tx_buff[15][6]_i_4_n_0 ),
        .I5(ready_IBUF),
        .O(\tx_buff[15][6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \tx_buff[15][6]_i_2 
       (.I0(ready_IBUF),
        .I1(tx_buff0_out),
        .O(\tx_buff[15][6]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT4 #(
    .INIT(16'h7FFF)) 
    \tx_buff[15][6]_i_3 
       (.I0(byte_count_reg__0[2]),
        .I1(byte_count_reg__0[3]),
        .I2(byte_count_reg__0[1]),
        .I3(byte_count_reg__0[0]),
        .O(\tx_buff[15][6]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \tx_buff[15][6]_i_4 
       (.I0(byte_count_reg__0[5]),
        .I1(byte_count_reg__0[4]),
        .O(\tx_buff[15][6]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFEFFFF0000)) 
    \tx_buff[15][7]_i_1 
       (.I0(\tx_buff[15][7]_i_2_n_0 ),
        .I1(\tx_buff[15][7]_i_3_n_0 ),
        .I2(\baud_count[12]_i_3_n_0 ),
        .I3(\tx_buff[15][6]_i_4_n_0 ),
        .I4(ready_IBUF),
        .I5(\tx_buff_reg[15]__0 [7]),
        .O(\tx_buff[15][7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \tx_buff[15][7]_i_2 
       (.I0(byte_count_reg__0[3]),
        .I1(byte_count_reg__0[2]),
        .O(\tx_buff[15][7]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \tx_buff[15][7]_i_3 
       (.I0(byte_count_reg__0[0]),
        .I1(byte_count_reg__0[1]),
        .O(\tx_buff[15][7]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h00000000FF200000)) 
    \tx_buff[16][5]_i_1 
       (.I0(\baud_count[12]_i_4_n_0 ),
        .I1(byte_count_reg__0[2]),
        .I2(\tx_buff[16][5]_i_3_n_0 ),
        .I3(\tx_buff[16][5]_i_4_n_0 ),
        .I4(\tx_buff[18][5]_i_6_n_0 ),
        .I5(baud_count1),
        .O(\tx_buff[16][5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h8888A88888888888)) 
    \tx_buff[16][5]_i_2 
       (.I0(\tx_buff[18][5]_i_6_n_0 ),
        .I1(\tx_buff[16][5]_i_4_n_0 ),
        .I2(\tx_buff[16][5]_i_5_n_0 ),
        .I3(\tx_buff[16][5]_i_6_n_0 ),
        .I4(byte_count_reg__0[2]),
        .I5(\baud_count[12]_i_4_n_0 ),
        .O(\tx_buff[16][5]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT5 #(
    .INIT(32'h00000002)) 
    \tx_buff[16][5]_i_3 
       (.I0(start_bit_done),
        .I1(bit_count_reg__0[3]),
        .I2(data_bit_done_reg_n_0),
        .I3(byte_count_reg__0[1]),
        .I4(byte_count_reg__0[5]),
        .O(\tx_buff[16][5]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000004)) 
    \tx_buff[16][5]_i_4 
       (.I0(baud_count1),
        .I1(start_bit_done),
        .I2(byte_count_reg__0[2]),
        .I3(byte_count_reg__0[1]),
        .I4(\bit_count[3]_i_3_n_0 ),
        .I5(byte_count_reg__0[5]),
        .O(\tx_buff[16][5]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \tx_buff[16][5]_i_5 
       (.I0(byte_count_reg__0[5]),
        .I1(byte_count_reg__0[1]),
        .O(\tx_buff[16][5]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'h10)) 
    \tx_buff[16][5]_i_6 
       (.I0(data_bit_done_reg_n_0),
        .I1(bit_count_reg__0[3]),
        .I2(start_bit_done),
        .O(\tx_buff[16][5]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hBBBFBFBF88808080)) 
    \tx_buff[16][6]_i_1 
       (.I0(tx_buff0_out),
        .I1(\tx_buff[18][5]_i_6_n_0 ),
        .I2(\tx_buff[16][5]_i_4_n_0 ),
        .I3(\tx_buff[16][5]_i_3_n_0 ),
        .I4(\tx_buff[16][6]_i_2_n_0 ),
        .I5(\tx_buff_reg[16]__0 [6]),
        .O(\tx_buff[16][6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000000FFFDFFFC)) 
    \tx_buff[16][6]_i_2 
       (.I0(\tx_buff[18][6]_i_8_n_0 ),
        .I1(baud_count[10]),
        .I2(baud_count[11]),
        .I3(baud_count[12]),
        .I4(\baud_count[12]_i_6_n_0 ),
        .I5(byte_count_reg__0[2]),
        .O(\tx_buff[16][6]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'h08)) 
    \tx_buff[17][5]_i_1 
       (.I0(\tx_buff[17][5]_i_3_n_0 ),
        .I1(\tx_buff[17][5]_i_4_n_0 ),
        .I2(baud_count1),
        .O(\tx_buff[17][5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAAA000200020002)) 
    \tx_buff[17][5]_i_2 
       (.I0(\tx_buff[17][5]_i_4_n_0 ),
        .I1(byte_count_reg__0[2]),
        .I2(\tx_buff[17][5]_i_5_n_0 ),
        .I3(\tx_buff[17][5]_i_6_n_0 ),
        .I4(\tx_buff[17][5]_i_7_n_0 ),
        .I5(\baud_count[12]_i_4_n_0 ),
        .O(\tx_buff[17][5]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000001000000000)) 
    \tx_buff[17][5]_i_3 
       (.I0(byte_count_reg__0[2]),
        .I1(baud_count1),
        .I2(start_bit_done),
        .I3(byte_count_reg__0[5]),
        .I4(\bit_count[3]_i_3_n_0 ),
        .I5(byte_count_reg__0[0]),
        .O(\tx_buff[17][5]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT5 #(
    .INIT(32'h00000008)) 
    \tx_buff[17][5]_i_4 
       (.I0(byte_count_reg__0[4]),
        .I1(rst_IBUF),
        .I2(ready_IBUF),
        .I3(byte_count_reg__0[3]),
        .I4(byte_count_reg__0[1]),
        .O(\tx_buff[17][5]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'h1F)) 
    \tx_buff[17][5]_i_5 
       (.I0(data_bit_done_reg_n_0),
        .I1(bit_count_reg__0[3]),
        .I2(start_bit_done),
        .O(\tx_buff[17][5]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF55575555)) 
    \tx_buff[17][5]_i_6 
       (.I0(byte_count_reg__0[0]),
        .I1(bit_count_reg__0[1]),
        .I2(bit_count_reg__0[0]),
        .I3(bit_count_reg__0[2]),
        .I4(bit_count_reg__0[3]),
        .I5(byte_count_reg__0[5]),
        .O(\tx_buff[17][5]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h0000000200000000)) 
    \tx_buff[17][5]_i_7 
       (.I0(start_bit_done),
        .I1(bit_count_reg__0[3]),
        .I2(data_bit_done_reg_n_0),
        .I3(byte_count_reg__0[5]),
        .I4(byte_count_reg__0[2]),
        .I5(byte_count_reg__0[0]),
        .O(\tx_buff[17][5]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hFEFFFFFF02000000)) 
    \tx_buff[17][6]_i_1 
       (.I0(tx_buff0_out),
        .I1(byte_count_reg__0[1]),
        .I2(byte_count_reg__0[3]),
        .I3(\tx_buff[17][6]_i_2_n_0 ),
        .I4(\tx_buff[17][6]_i_3_n_0 ),
        .I5(\tx_buff_reg[17]__0 [6]),
        .O(\tx_buff[17][6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'h40)) 
    \tx_buff[17][6]_i_2 
       (.I0(ready_IBUF),
        .I1(rst_IBUF),
        .I2(byte_count_reg__0[4]),
        .O(\tx_buff[17][6]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h3B00FFFF3B003B00)) 
    \tx_buff[17][6]_i_3 
       (.I0(\baud_count[12]_i_6_n_0 ),
        .I1(\baud_count[12]_i_7_n_0 ),
        .I2(\tx_buff[18][6]_i_8_n_0 ),
        .I3(\tx_buff[17][5]_i_7_n_0 ),
        .I4(\tx_buff[17][5]_i_6_n_0 ),
        .I5(\tx_buff[18][5]_i_8_n_0 ),
        .O(\tx_buff[17][6]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hCCFFAAF0CC00AAF0)) 
    \tx_buff[18][0]_i_2 
       (.I0(\tx_buff[18][0]_i_4_n_0 ),
        .I1(\tx_buff[18][0]_i_5_n_0 ),
        .I2(\tx_buff[18][0]_i_6_n_0 ),
        .I3(byte_count_reg__0[2]),
        .I4(byte_count_reg__0[3]),
        .I5(\tx_buff[18][0]_i_7_n_0 ),
        .O(\tx_buff[18][0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \tx_buff[18][0]_i_3 
       (.I0(\tx_buff_reg[17]__0 [1]),
        .I1(\tx_buff_reg[19]__0 [1]),
        .I2(byte_count_reg__0[1]),
        .I3(byte_count_reg__0[0]),
        .I4(\tx_buff_reg[16]__0 [1]),
        .I5(\tx_buff_reg[18]__0 [1]),
        .O(\tx_buff[18][0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \tx_buff[18][0]_i_4 
       (.I0(\tx_buff_reg[5]__0 [1]),
        .I1(\tx_buff_reg[7]__0 [1]),
        .I2(byte_count_reg__0[1]),
        .I3(byte_count_reg__0[0]),
        .I4(\tx_buff_reg[4]__0 [1]),
        .I5(\tx_buff_reg[6]__0 [1]),
        .O(\tx_buff[18][0]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \tx_buff[18][0]_i_5 
       (.I0(\tx_buff_reg[13]__0 [1]),
        .I1(\tx_buff_reg[15]__0 [1]),
        .I2(byte_count_reg__0[1]),
        .I3(byte_count_reg__0[0]),
        .I4(\tx_buff_reg[12]__0 [1]),
        .I5(\tx_buff_reg[14]__0 [1]),
        .O(\tx_buff[18][0]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \tx_buff[18][0]_i_6 
       (.I0(\tx_buff_reg[1]__0 [1]),
        .I1(\tx_buff_reg[3]__0 [1]),
        .I2(byte_count_reg__0[1]),
        .I3(byte_count_reg__0[0]),
        .I4(\tx_buff_reg[0]__0 [1]),
        .I5(\tx_buff_reg[2]__0 [1]),
        .O(\tx_buff[18][0]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \tx_buff[18][0]_i_7 
       (.I0(\tx_buff_reg[9]__0 [1]),
        .I1(\tx_buff_reg[11]__0 [1]),
        .I2(byte_count_reg__0[1]),
        .I3(byte_count_reg__0[0]),
        .I4(\tx_buff_reg[8]__0 [1]),
        .I5(\tx_buff_reg[10]__0 [1]),
        .O(\tx_buff[18][0]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hCCFFAAF0CC00AAF0)) 
    \tx_buff[18][1]_i_2 
       (.I0(\tx_buff[18][1]_i_4_n_0 ),
        .I1(\tx_buff[18][1]_i_5_n_0 ),
        .I2(\tx_buff[18][1]_i_6_n_0 ),
        .I3(byte_count_reg__0[2]),
        .I4(byte_count_reg__0[3]),
        .I5(\tx_buff[18][1]_i_7_n_0 ),
        .O(\tx_buff[18][1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \tx_buff[18][1]_i_3 
       (.I0(\tx_buff_reg[17]__0 [2]),
        .I1(\tx_buff_reg[19]__0 [2]),
        .I2(byte_count_reg__0[1]),
        .I3(byte_count_reg__0[0]),
        .I4(\tx_buff_reg[16]__0 [2]),
        .I5(\tx_buff_reg[18]__0 [2]),
        .O(\tx_buff[18][1]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \tx_buff[18][1]_i_4 
       (.I0(\tx_buff_reg[5]__0 [2]),
        .I1(\tx_buff_reg[7]__0 [2]),
        .I2(byte_count_reg__0[1]),
        .I3(byte_count_reg__0[0]),
        .I4(\tx_buff_reg[4]__0 [2]),
        .I5(\tx_buff_reg[6]__0 [2]),
        .O(\tx_buff[18][1]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \tx_buff[18][1]_i_5 
       (.I0(\tx_buff_reg[13]__0 [2]),
        .I1(\tx_buff_reg[15]__0 [2]),
        .I2(byte_count_reg__0[1]),
        .I3(byte_count_reg__0[0]),
        .I4(\tx_buff_reg[12]__0 [2]),
        .I5(\tx_buff_reg[14]__0 [2]),
        .O(\tx_buff[18][1]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \tx_buff[18][1]_i_6 
       (.I0(\tx_buff_reg[1]__0 [2]),
        .I1(\tx_buff_reg[3]__0 [2]),
        .I2(byte_count_reg__0[1]),
        .I3(byte_count_reg__0[0]),
        .I4(\tx_buff_reg[0]__0 [2]),
        .I5(\tx_buff_reg[2]__0 [2]),
        .O(\tx_buff[18][1]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \tx_buff[18][1]_i_7 
       (.I0(\tx_buff_reg[9]__0 [2]),
        .I1(\tx_buff_reg[11]__0 [2]),
        .I2(byte_count_reg__0[1]),
        .I3(byte_count_reg__0[0]),
        .I4(\tx_buff_reg[8]__0 [2]),
        .I5(\tx_buff_reg[10]__0 [2]),
        .O(\tx_buff[18][1]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hCCFFAAF0CC00AAF0)) 
    \tx_buff[18][2]_i_2 
       (.I0(\tx_buff[18][2]_i_4_n_0 ),
        .I1(\tx_buff[18][2]_i_5_n_0 ),
        .I2(\tx_buff[18][2]_i_6_n_0 ),
        .I3(byte_count_reg__0[2]),
        .I4(byte_count_reg__0[3]),
        .I5(\tx_buff[18][2]_i_7_n_0 ),
        .O(\tx_buff[18][2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \tx_buff[18][2]_i_3 
       (.I0(\tx_buff_reg[17]__0 [3]),
        .I1(\tx_buff_reg[19]__0 [3]),
        .I2(byte_count_reg__0[1]),
        .I3(byte_count_reg__0[0]),
        .I4(\tx_buff_reg[16]__0 [3]),
        .I5(\tx_buff_reg[18]__0 [3]),
        .O(\tx_buff[18][2]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \tx_buff[18][2]_i_4 
       (.I0(\tx_buff_reg[5]__0 [3]),
        .I1(\tx_buff_reg[7]__0 [3]),
        .I2(byte_count_reg__0[1]),
        .I3(byte_count_reg__0[0]),
        .I4(\tx_buff_reg[4]__0 [3]),
        .I5(\tx_buff_reg[6]__0 [3]),
        .O(\tx_buff[18][2]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \tx_buff[18][2]_i_5 
       (.I0(\tx_buff_reg[13]__0 [3]),
        .I1(\tx_buff_reg[15]__0 [3]),
        .I2(byte_count_reg__0[1]),
        .I3(byte_count_reg__0[0]),
        .I4(\tx_buff_reg[12]__0 [3]),
        .I5(\tx_buff_reg[14]__0 [3]),
        .O(\tx_buff[18][2]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \tx_buff[18][2]_i_6 
       (.I0(\tx_buff_reg[1]__0 [3]),
        .I1(\tx_buff_reg[3]__0 [3]),
        .I2(byte_count_reg__0[1]),
        .I3(byte_count_reg__0[0]),
        .I4(\tx_buff_reg[0]__0 [3]),
        .I5(\tx_buff_reg[2]__0 [3]),
        .O(\tx_buff[18][2]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \tx_buff[18][2]_i_7 
       (.I0(\tx_buff_reg[9]__0 [3]),
        .I1(\tx_buff_reg[11]__0 [3]),
        .I2(byte_count_reg__0[1]),
        .I3(byte_count_reg__0[0]),
        .I4(\tx_buff_reg[8]__0 [3]),
        .I5(\tx_buff_reg[10]__0 [3]),
        .O(\tx_buff[18][2]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hCCFFAAF0CC00AAF0)) 
    \tx_buff[18][3]_i_2 
       (.I0(\tx_buff[18][3]_i_4_n_0 ),
        .I1(\tx_buff[18][3]_i_5_n_0 ),
        .I2(\tx_buff[18][3]_i_6_n_0 ),
        .I3(byte_count_reg__0[2]),
        .I4(byte_count_reg__0[3]),
        .I5(\tx_buff[18][3]_i_7_n_0 ),
        .O(\tx_buff[18][3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \tx_buff[18][3]_i_3 
       (.I0(\tx_buff_reg[17]__0 [4]),
        .I1(\tx_buff_reg[19]__0 [4]),
        .I2(byte_count_reg__0[1]),
        .I3(byte_count_reg__0[0]),
        .I4(\tx_buff_reg[16]__0 [4]),
        .I5(\tx_buff_reg[18]__0 [4]),
        .O(\tx_buff[18][3]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \tx_buff[18][3]_i_4 
       (.I0(\tx_buff_reg[5]__0 [4]),
        .I1(\tx_buff_reg[7]__0 [4]),
        .I2(byte_count_reg__0[1]),
        .I3(byte_count_reg__0[0]),
        .I4(\tx_buff_reg[4]__0 [4]),
        .I5(\tx_buff_reg[6]__0 [4]),
        .O(\tx_buff[18][3]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \tx_buff[18][3]_i_5 
       (.I0(\tx_buff_reg[13]__0 [4]),
        .I1(\tx_buff_reg[15]__0 [4]),
        .I2(byte_count_reg__0[1]),
        .I3(byte_count_reg__0[0]),
        .I4(\tx_buff_reg[12]__0 [4]),
        .I5(\tx_buff_reg[14]__0 [4]),
        .O(\tx_buff[18][3]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \tx_buff[18][3]_i_6 
       (.I0(\tx_buff_reg[1]__0 [4]),
        .I1(\tx_buff_reg[3]__0 [4]),
        .I2(byte_count_reg__0[1]),
        .I3(byte_count_reg__0[0]),
        .I4(\tx_buff_reg[0]__0 [4]),
        .I5(\tx_buff_reg[2]__0 [4]),
        .O(\tx_buff[18][3]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \tx_buff[18][3]_i_7 
       (.I0(\tx_buff_reg[9]__0 [4]),
        .I1(\tx_buff_reg[11]__0 [4]),
        .I2(byte_count_reg__0[1]),
        .I3(byte_count_reg__0[0]),
        .I4(\tx_buff_reg[8]__0 [4]),
        .I5(\tx_buff_reg[10]__0 [4]),
        .O(\tx_buff[18][3]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hCCFFAAF0CC00AAF0)) 
    \tx_buff[18][4]_i_2 
       (.I0(\tx_buff[18][4]_i_4_n_0 ),
        .I1(\tx_buff[18][4]_i_5_n_0 ),
        .I2(\tx_buff[18][4]_i_6_n_0 ),
        .I3(byte_count_reg__0[2]),
        .I4(byte_count_reg__0[3]),
        .I5(\tx_buff[18][4]_i_7_n_0 ),
        .O(\tx_buff[18][4]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \tx_buff[18][4]_i_3 
       (.I0(\tx_buff_reg[17]__0 [5]),
        .I1(\tx_buff_reg[19]__0 [5]),
        .I2(byte_count_reg__0[1]),
        .I3(byte_count_reg__0[0]),
        .I4(\tx_buff_reg[16]__0 [5]),
        .I5(\tx_buff_reg[18]__0 [5]),
        .O(\tx_buff[18][4]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \tx_buff[18][4]_i_4 
       (.I0(\tx_buff_reg[5]__0 [5]),
        .I1(\tx_buff_reg[7]__0 [5]),
        .I2(byte_count_reg__0[1]),
        .I3(byte_count_reg__0[0]),
        .I4(\tx_buff_reg[4]__0 [5]),
        .I5(\tx_buff_reg[6]__0 [5]),
        .O(\tx_buff[18][4]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \tx_buff[18][4]_i_5 
       (.I0(\tx_buff_reg[13]__0 [5]),
        .I1(\tx_buff_reg[15]__0 [5]),
        .I2(byte_count_reg__0[1]),
        .I3(byte_count_reg__0[0]),
        .I4(\tx_buff_reg[12]__0 [5]),
        .I5(\tx_buff_reg[14]__0 [5]),
        .O(\tx_buff[18][4]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \tx_buff[18][4]_i_6 
       (.I0(\tx_buff_reg[1]__0 [5]),
        .I1(\tx_buff_reg[3]__0 [5]),
        .I2(byte_count_reg__0[1]),
        .I3(byte_count_reg__0[0]),
        .I4(\tx_buff_reg[0]__0 [5]),
        .I5(\tx_buff_reg[2]__0 [5]),
        .O(\tx_buff[18][4]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \tx_buff[18][4]_i_7 
       (.I0(\tx_buff_reg[9]__0 [5]),
        .I1(\tx_buff_reg[11]__0 [5]),
        .I2(byte_count_reg__0[1]),
        .I3(byte_count_reg__0[0]),
        .I4(\tx_buff_reg[8]__0 [5]),
        .I5(\tx_buff_reg[10]__0 [5]),
        .O(\tx_buff[18][4]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h00000000FF800000)) 
    \tx_buff[18][5]_i_1 
       (.I0(\baud_count[12]_i_4_n_0 ),
        .I1(byte_count_reg__0[1]),
        .I2(\tx_buff[18][5]_i_4_n_0 ),
        .I3(\tx_buff[18][5]_i_5_n_0 ),
        .I4(\tx_buff[18][5]_i_6_n_0 ),
        .I5(baud_count1),
        .O(\tx_buff[18][5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCCFFAAF0CC00AAF0)) 
    \tx_buff[18][5]_i_10 
       (.I0(\tx_buff[18][5]_i_12_n_0 ),
        .I1(\tx_buff[18][5]_i_13_n_0 ),
        .I2(\tx_buff[18][5]_i_14_n_0 ),
        .I3(byte_count_reg__0[2]),
        .I4(byte_count_reg__0[3]),
        .I5(\tx_buff[18][5]_i_15_n_0 ),
        .O(\tx_buff[18][5]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \tx_buff[18][5]_i_11 
       (.I0(\tx_buff_reg[17]__0 [6]),
        .I1(\tx_buff_reg[19]__0 [6]),
        .I2(byte_count_reg__0[1]),
        .I3(byte_count_reg__0[0]),
        .I4(\tx_buff_reg[16]__0 [6]),
        .I5(\tx_buff_reg[18]__0 [6]),
        .O(\tx_buff[18][5]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \tx_buff[18][5]_i_12 
       (.I0(\tx_buff_reg[5]__0 [6]),
        .I1(\tx_buff_reg[7]__0 [6]),
        .I2(byte_count_reg__0[1]),
        .I3(byte_count_reg__0[0]),
        .I4(\tx_buff_reg[4]__0 [6]),
        .I5(\tx_buff_reg[6]__0 [6]),
        .O(\tx_buff[18][5]_i_12_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \tx_buff[18][5]_i_13 
       (.I0(\tx_buff_reg[13]__0 [6]),
        .I1(\tx_buff_reg[15]__0 [6]),
        .I2(byte_count_reg__0[1]),
        .I3(byte_count_reg__0[0]),
        .I4(\tx_buff_reg[12]__0 [6]),
        .I5(\tx_buff_reg[14]__0 [6]),
        .O(\tx_buff[18][5]_i_13_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \tx_buff[18][5]_i_14 
       (.I0(\tx_buff_reg[1]__0 [6]),
        .I1(\tx_buff_reg[3]__0 [6]),
        .I2(byte_count_reg__0[1]),
        .I3(byte_count_reg__0[0]),
        .I4(\tx_buff_reg[0]__0 [6]),
        .I5(\tx_buff_reg[2]__0 [6]),
        .O(\tx_buff[18][5]_i_14_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \tx_buff[18][5]_i_15 
       (.I0(\tx_buff_reg[9]__0 [6]),
        .I1(\tx_buff_reg[11]__0 [6]),
        .I2(byte_count_reg__0[1]),
        .I3(byte_count_reg__0[0]),
        .I4(\tx_buff_reg[8]__0 [6]),
        .I5(\tx_buff_reg[10]__0 [6]),
        .O(\tx_buff[18][5]_i_15_n_0 ));
  LUT6 #(
    .INIT(64'hAA00800080008000)) 
    \tx_buff[18][5]_i_2 
       (.I0(\tx_buff[18][5]_i_6_n_0 ),
        .I1(\tx_buff[18][5]_i_8_n_0 ),
        .I2(\tx_buff[18][5]_i_9_n_0 ),
        .I3(byte_count_reg__0[1]),
        .I4(\tx_buff[18][5]_i_4_n_0 ),
        .I5(\baud_count[12]_i_4_n_0 ),
        .O(\tx_buff[18][5]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT5 #(
    .INIT(32'h00000002)) 
    \tx_buff[18][5]_i_4 
       (.I0(start_bit_done),
        .I1(bit_count_reg__0[3]),
        .I2(data_bit_done_reg_n_0),
        .I3(byte_count_reg__0[2]),
        .I4(byte_count_reg__0[5]),
        .O(\tx_buff[18][5]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0000001000000000)) 
    \tx_buff[18][5]_i_5 
       (.I0(byte_count_reg__0[2]),
        .I1(baud_count1),
        .I2(start_bit_done),
        .I3(byte_count_reg__0[5]),
        .I4(\bit_count[3]_i_3_n_0 ),
        .I5(byte_count_reg__0[1]),
        .O(\tx_buff[18][5]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'h00000008)) 
    \tx_buff[18][5]_i_6 
       (.I0(byte_count_reg__0[4]),
        .I1(rst_IBUF),
        .I2(ready_IBUF),
        .I3(byte_count_reg__0[3]),
        .I4(byte_count_reg__0[0]),
        .O(\tx_buff[18][5]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \tx_buff[18][5]_i_7 
       (.I0(bit_count_reg__0[3]),
        .I1(data_bit_done_reg_n_0),
        .O(baud_count1));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT4 #(
    .INIT(16'h00A8)) 
    \tx_buff[18][5]_i_8 
       (.I0(start_bit_done),
        .I1(bit_count_reg__0[3]),
        .I2(data_bit_done_reg_n_0),
        .I3(byte_count_reg__0[2]),
        .O(\tx_buff[18][5]_i_8_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT5 #(
    .INIT(32'h55555551)) 
    \tx_buff[18][5]_i_9 
       (.I0(byte_count_reg__0[5]),
        .I1(bit_count_reg__0[3]),
        .I2(bit_count_reg__0[2]),
        .I3(bit_count_reg__0[0]),
        .I4(bit_count_reg__0[1]),
        .O(\tx_buff[18][5]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'hBBBFBFBF88808080)) 
    \tx_buff[18][6]_i_1 
       (.I0(tx_buff0_out),
        .I1(\tx_buff[18][5]_i_6_n_0 ),
        .I2(\tx_buff[18][5]_i_5_n_0 ),
        .I3(\tx_buff[18][5]_i_4_n_0 ),
        .I4(\tx_buff[18][6]_i_3_n_0 ),
        .I5(\tx_buff_reg[18]__0 [6]),
        .O(\tx_buff[18][6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAA8A808080)) 
    \tx_buff[18][6]_i_2 
       (.I0(\tx_buff[18][6]_i_4_n_0 ),
        .I1(\tx_buff[18][6]_i_5_n_0 ),
        .I2(byte_count_reg__0[3]),
        .I3(\tx_buff[18][6]_i_6_n_0 ),
        .I4(byte_count_reg__0[2]),
        .I5(\tx_buff[18][6]_i_7_n_0 ),
        .O(tx_buff0_out));
  LUT6 #(
    .INIT(64'hFFFDFFFC00000000)) 
    \tx_buff[18][6]_i_3 
       (.I0(\tx_buff[18][6]_i_8_n_0 ),
        .I1(baud_count[10]),
        .I2(baud_count[11]),
        .I3(baud_count[12]),
        .I4(\baud_count[12]_i_6_n_0 ),
        .I5(byte_count_reg__0[1]),
        .O(\tx_buff[18][6]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'h01)) 
    \tx_buff[18][6]_i_4 
       (.I0(data_bit_done_reg_n_0),
        .I1(bit_count_reg__0[3]),
        .I2(byte_count_reg__0[4]),
        .O(\tx_buff[18][6]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hF0C00A0000C00A00)) 
    \tx_buff[18][6]_i_5 
       (.I0(\tx_buff_reg[10]__0 [7]),
        .I1(\tx_buff_reg[13]__0 [7]),
        .I2(byte_count_reg__0[0]),
        .I3(byte_count_reg__0[1]),
        .I4(byte_count_reg__0[2]),
        .I5(\tx_buff_reg[15]__0 [7]),
        .O(\tx_buff[18][6]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \tx_buff[18][6]_i_6 
       (.I0(\tx_buff_reg[5]__0 [7]),
        .I1(\tx_buff_reg[7]__0 [7]),
        .I2(byte_count_reg__0[1]),
        .I3(byte_count_reg__0[0]),
        .I4(\tx_buff_reg[4]__0 [7]),
        .I5(\tx_buff_reg[6]__0 [7]),
        .O(\tx_buff[18][6]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'h00000008)) 
    \tx_buff[18][6]_i_7 
       (.I0(\tx_buff_reg[2]__0 [7]),
        .I1(byte_count_reg__0[1]),
        .I2(byte_count_reg__0[0]),
        .I3(byte_count_reg__0[2]),
        .I4(byte_count_reg__0[3]),
        .O(\tx_buff[18][6]_i_7_n_0 ));
  LUT4 #(
    .INIT(16'h0001)) 
    \tx_buff[18][6]_i_8 
       (.I0(baud_count[3]),
        .I1(baud_count[2]),
        .I2(baud_count[7]),
        .I3(baud_count[4]),
        .O(\tx_buff[18][6]_i_8_n_0 ));
  LUT4 #(
    .INIT(16'h4440)) 
    \tx_buff[19][5]_i_1 
       (.I0(\baud_count[12]_i_3_n_0 ),
        .I1(\tx_buff[19][5]_i_3_n_0 ),
        .I2(data_bit_done_reg_n_0),
        .I3(bit_count_reg__0[3]),
        .O(\tx_buff[19][5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h2020002000200020)) 
    \tx_buff[19][5]_i_2 
       (.I0(rst_IBUF),
        .I1(ready_IBUF),
        .I2(\tx_buff[19][5]_i_4_n_0 ),
        .I3(\baud_count[12]_i_3_n_0 ),
        .I4(\tx_buff[16][5]_i_6_n_0 ),
        .I5(\baud_count[12]_i_4_n_0 ),
        .O(\tx_buff[19][5]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000001000000000)) 
    \tx_buff[19][5]_i_3 
       (.I0(\tx_buff[0][6]_i_4_n_0 ),
        .I1(byte_count_reg__0[5]),
        .I2(byte_count_reg__0[4]),
        .I3(\tx_buff[15][7]_i_3_n_0 ),
        .I4(ready_IBUF),
        .I5(rst_IBUF),
        .O(\tx_buff[19][5]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000080)) 
    \tx_buff[19][5]_i_4 
       (.I0(byte_count_reg__0[0]),
        .I1(byte_count_reg__0[1]),
        .I2(byte_count_reg__0[4]),
        .I3(byte_count_reg__0[5]),
        .I4(byte_count_reg__0[2]),
        .I5(byte_count_reg__0[3]),
        .O(\tx_buff[19][5]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hBBFBFBFB88080808)) 
    \tx_buff[19][6]_i_1 
       (.I0(tx_buff0_out),
        .I1(\tx_buff[19][5]_i_3_n_0 ),
        .I2(\baud_count[12]_i_3_n_0 ),
        .I3(\tx_buff[16][5]_i_6_n_0 ),
        .I4(\baud_count[12]_i_4_n_0 ),
        .I5(\tx_buff_reg[19]__0 [6]),
        .O(\tx_buff[19][6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAFFAEAAAAAEAE)) 
    \tx_buff[1][6]_i_1 
       (.I0(ready_IBUF),
        .I1(\tx_buff[7][6]_i_2_n_0 ),
        .I2(byte_count_reg__0[1]),
        .I3(\baud_count[12]_i_4_n_0 ),
        .I4(byte_count_reg__0[2]),
        .I5(\tx_buff[5][6]_i_2_n_0 ),
        .O(\tx_buff[1][6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAEAAAAAAAAAAAAAA)) 
    \tx_buff[2][6]_i_1 
       (.I0(\tx_buff[2][6]_i_2_n_0 ),
        .I1(\baud_count[12]_i_4_n_0 ),
        .I2(byte_count_reg__0[2]),
        .I3(byte_count_reg__0[1]),
        .I4(\tx_buff[6][6]_i_3_n_0 ),
        .I5(\tx_buff[6][6]_i_4_n_0 ),
        .O(\tx_buff[2][6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF02000000)) 
    \tx_buff[2][6]_i_2 
       (.I0(\tx_buff[6][6]_i_5_n_0 ),
        .I1(byte_count_reg__0[2]),
        .I2(byte_count_reg__0[0]),
        .I3(\tx_buff[18][5]_i_9_n_0 ),
        .I4(byte_count_reg__0[1]),
        .I5(ready_IBUF),
        .O(\tx_buff[2][6]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFF7FFFF0000)) 
    \tx_buff[2][7]_i_1 
       (.I0(\tx_buff[13][7]_i_2_n_0 ),
        .I1(\tx_buff[14][6]_i_3_n_0 ),
        .I2(byte_count_reg__0[2]),
        .I3(byte_count_reg__0[3]),
        .I4(ready_IBUF),
        .I5(\tx_buff_reg[2]__0 [7]),
        .O(\tx_buff[2][7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFBAAAAABABAAAAA)) 
    \tx_buff[3][6]_i_1 
       (.I0(ready_IBUF),
        .I1(byte_count_reg__0[2]),
        .I2(\tx_buff[7][6]_i_2_n_0 ),
        .I3(\baud_count[12]_i_4_n_0 ),
        .I4(byte_count_reg__0[1]),
        .I5(\tx_buff[3][6]_i_2_n_0 ),
        .O(\tx_buff[3][6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000001000000000)) 
    \tx_buff[3][6]_i_2 
       (.I0(byte_count_reg__0[4]),
        .I1(byte_count_reg__0[3]),
        .I2(\tx_buff[16][5]_i_6_n_0 ),
        .I3(byte_count_reg__0[5]),
        .I4(byte_count_reg__0[2]),
        .I5(byte_count_reg__0[0]),
        .O(\tx_buff[3][6]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAAEAAAAAAAAAAAAA)) 
    \tx_buff[4][6]_i_1 
       (.I0(\tx_buff[4][6]_i_2_n_0 ),
        .I1(\baud_count[12]_i_4_n_0 ),
        .I2(byte_count_reg__0[2]),
        .I3(byte_count_reg__0[0]),
        .I4(\tx_buff[16][5]_i_5_n_0 ),
        .I5(\tx_buff[6][6]_i_4_n_0 ),
        .O(\tx_buff[4][6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF00000100)) 
    \tx_buff[4][6]_i_2 
       (.I0(byte_count_reg__0[3]),
        .I1(byte_count_reg__0[4]),
        .I2(\tx_buff[17][5]_i_5_n_0 ),
        .I3(\tx_buff[4][6]_i_3_n_0 ),
        .I4(\tx_buff[14][6]_i_5_n_0 ),
        .I5(ready_IBUF),
        .O(\tx_buff[4][6]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \tx_buff[4][6]_i_3 
       (.I0(byte_count_reg__0[0]),
        .I1(byte_count_reg__0[1]),
        .O(\tx_buff[4][6]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFDFFFFFFF0000)) 
    \tx_buff[4][7]_i_1 
       (.I0(\tx_buff[13][7]_i_2_n_0 ),
        .I1(byte_count_reg__0[1]),
        .I2(byte_count_reg__0[2]),
        .I3(\tx_buff[6][7]_i_2_n_0 ),
        .I4(ready_IBUF),
        .I5(\tx_buff_reg[4]__0 [7]),
        .O(\tx_buff[4][7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFBAAAAABABAAAAA)) 
    \tx_buff[5][6]_i_1 
       (.I0(ready_IBUF),
        .I1(byte_count_reg__0[1]),
        .I2(\tx_buff[7][6]_i_2_n_0 ),
        .I3(\baud_count[12]_i_4_n_0 ),
        .I4(byte_count_reg__0[2]),
        .I5(\tx_buff[5][6]_i_2_n_0 ),
        .O(\tx_buff[5][6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000200000000)) 
    \tx_buff[5][6]_i_2 
       (.I0(byte_count_reg__0[0]),
        .I1(byte_count_reg__0[5]),
        .I2(byte_count_reg__0[1]),
        .I3(byte_count_reg__0[4]),
        .I4(byte_count_reg__0[3]),
        .I5(\tx_buff[16][5]_i_6_n_0 ),
        .O(\tx_buff[5][6]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF7FFFFFFF0000)) 
    \tx_buff[5][7]_i_1 
       (.I0(\tx_buff[13][7]_i_2_n_0 ),
        .I1(byte_count_reg__0[2]),
        .I2(byte_count_reg__0[0]),
        .I3(\tx_buff[5][7]_i_2_n_0 ),
        .I4(ready_IBUF),
        .I5(\tx_buff_reg[5]__0 [7]),
        .O(\tx_buff[5][7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \tx_buff[5][7]_i_2 
       (.I0(byte_count_reg__0[1]),
        .I1(byte_count_reg__0[3]),
        .O(\tx_buff[5][7]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hEAAAAAAAAAAAAAAA)) 
    \tx_buff[6][6]_i_1 
       (.I0(\tx_buff[6][6]_i_2_n_0 ),
        .I1(\baud_count[12]_i_4_n_0 ),
        .I2(byte_count_reg__0[1]),
        .I3(byte_count_reg__0[2]),
        .I4(\tx_buff[6][6]_i_3_n_0 ),
        .I5(\tx_buff[6][6]_i_4_n_0 ),
        .O(\tx_buff[6][6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF20000000)) 
    \tx_buff[6][6]_i_2 
       (.I0(\tx_buff[6][6]_i_5_n_0 ),
        .I1(byte_count_reg__0[0]),
        .I2(byte_count_reg__0[2]),
        .I3(\tx_buff[18][5]_i_9_n_0 ),
        .I4(byte_count_reg__0[1]),
        .I5(ready_IBUF),
        .O(\tx_buff[6][6]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \tx_buff[6][6]_i_3 
       (.I0(byte_count_reg__0[5]),
        .I1(byte_count_reg__0[0]),
        .O(\tx_buff[6][6]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT5 #(
    .INIT(32'h00000002)) 
    \tx_buff[6][6]_i_4 
       (.I0(start_bit_done),
        .I1(bit_count_reg__0[3]),
        .I2(data_bit_done_reg_n_0),
        .I3(byte_count_reg__0[3]),
        .I4(byte_count_reg__0[4]),
        .O(\tx_buff[6][6]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT5 #(
    .INIT(32'h10101000)) 
    \tx_buff[6][6]_i_5 
       (.I0(byte_count_reg__0[3]),
        .I1(byte_count_reg__0[4]),
        .I2(start_bit_done),
        .I3(bit_count_reg__0[3]),
        .I4(data_bit_done_reg_n_0),
        .O(\tx_buff[6][6]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF7FFFFFFF0000)) 
    \tx_buff[6][7]_i_1 
       (.I0(\tx_buff[13][7]_i_2_n_0 ),
        .I1(byte_count_reg__0[2]),
        .I2(byte_count_reg__0[1]),
        .I3(\tx_buff[6][7]_i_2_n_0 ),
        .I4(ready_IBUF),
        .I5(\tx_buff_reg[6]__0 [7]),
        .O(\tx_buff[6][7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \tx_buff[6][7]_i_2 
       (.I0(byte_count_reg__0[0]),
        .I1(byte_count_reg__0[3]),
        .O(\tx_buff[6][7]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFEAAAAAEAEAAAAA)) 
    \tx_buff[7][6]_i_1 
       (.I0(ready_IBUF),
        .I1(byte_count_reg__0[1]),
        .I2(\tx_buff[7][6]_i_2_n_0 ),
        .I3(\baud_count[12]_i_4_n_0 ),
        .I4(byte_count_reg__0[2]),
        .I5(\tx_buff[7][6]_i_3_n_0 ),
        .O(\tx_buff[7][6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000000000000E0)) 
    \tx_buff[7][6]_i_2 
       (.I0(data_bit_done_reg_n_0),
        .I1(bit_count_reg__0[3]),
        .I2(start_bit_done),
        .I3(byte_count_reg__0[4]),
        .I4(byte_count_reg__0[3]),
        .I5(\tx_buff[17][5]_i_6_n_0 ),
        .O(\tx_buff[7][6]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0001000000000000)) 
    \tx_buff[7][6]_i_3 
       (.I0(byte_count_reg__0[3]),
        .I1(\tx_buff[15][7]_i_3_n_0 ),
        .I2(byte_count_reg__0[5]),
        .I3(byte_count_reg__0[4]),
        .I4(baud_count1),
        .I5(start_bit_done),
        .O(\tx_buff[7][6]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFDFFFFF0000)) 
    \tx_buff[7][7]_i_1 
       (.I0(\tx_buff[13][7]_i_2_n_0 ),
        .I1(byte_count_reg__0[3]),
        .I2(byte_count_reg__0[2]),
        .I3(\tx_buff[15][7]_i_3_n_0 ),
        .I4(ready_IBUF),
        .I5(\tx_buff_reg[7]__0 [7]),
        .O(\tx_buff[7][7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFF200000)) 
    \tx_buff[8][6]_i_1 
       (.I0(\baud_count[12]_i_4_n_0 ),
        .I1(byte_count_reg__0[2]),
        .I2(\tx_buff[16][5]_i_3_n_0 ),
        .I3(\tx_buff[16][5]_i_4_n_0 ),
        .I4(\tx_buff[10][6]_i_2_n_0 ),
        .I5(ready_IBUF),
        .O(\tx_buff[8][6]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF0200)) 
    \tx_buff[9][6]_i_1 
       (.I0(\tx_buff[17][6]_i_3_n_0 ),
        .I1(byte_count_reg__0[1]),
        .I2(byte_count_reg__0[4]),
        .I3(byte_count_reg__0[3]),
        .I4(ready_IBUF),
        .O(\tx_buff[9][6]_i_1_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[0][0] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[0][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][0]_i_1_n_0 ),
        .Q(\tx_buff_reg[0]__0 [0]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[0][1] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[0][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][1]_i_1_n_0 ),
        .Q(\tx_buff_reg[0]__0 [1]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[0][2] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[0][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[12][2]_i_1_n_0 ),
        .Q(\tx_buff_reg[0]__0 [2]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[0][3] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[0][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[14][3]_i_1_n_0 ),
        .Q(\tx_buff_reg[0]__0 [3]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[0][4] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[0][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][4]_i_1_n_0 ),
        .Q(\tx_buff_reg[0]__0 [4]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[0][5] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[0][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][5]_i_1_n_0 ),
        .Q(\tx_buff_reg[0]__0 [5]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[0][6] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[0][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[11][6]_i_2_n_0 ),
        .Q(\tx_buff_reg[0]__0 [6]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[10][0] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[10][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[14][0]_i_1_n_0 ),
        .Q(\tx_buff_reg[10]__0 [0]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[10][1] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[10][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[13][1]_i_1_n_0 ),
        .Q(\tx_buff_reg[10]__0 [1]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[10][2] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[10][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][2]_i_1_n_0 ),
        .Q(\tx_buff_reg[10]__0 [2]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[10][3] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[10][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[14][3]_i_1_n_0 ),
        .Q(\tx_buff_reg[10]__0 [3]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[10][4] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[10][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][4]_i_1_n_0 ),
        .Q(\tx_buff_reg[10]__0 [4]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[10][5] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[10][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[14][5]_i_1_n_0 ),
        .Q(\tx_buff_reg[10]__0 [5]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[10][6] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[10][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[11][6]_i_2_n_0 ),
        .Q(\tx_buff_reg[10]__0 [6]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[10][7] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[10][7]_i_1_n_0 ),
        .Q(\tx_buff_reg[10]__0 [7]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[11][0] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[11][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][0]_i_1_n_0 ),
        .Q(\tx_buff_reg[11]__0 [0]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[11][1] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[11][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][1]_i_1_n_0 ),
        .Q(\tx_buff_reg[11]__0 [1]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[11][2] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[11][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[12][2]_i_1_n_0 ),
        .Q(\tx_buff_reg[11]__0 [2]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[11][3] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[11][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[14][3]_i_1_n_0 ),
        .Q(\tx_buff_reg[11]__0 [3]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[11][4] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[11][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[13][4]_i_1_n_0 ),
        .Q(\tx_buff_reg[11]__0 [4]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[11][5] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[11][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[14][5]_i_1_n_0 ),
        .Q(\tx_buff_reg[11]__0 [5]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[11][6] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[11][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[11][6]_i_2_n_0 ),
        .Q(\tx_buff_reg[11]__0 [6]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[12][0] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[12][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[14][0]_i_1_n_0 ),
        .Q(\tx_buff_reg[12]__0 [0]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[12][1] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[12][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][1]_i_1_n_0 ),
        .Q(\tx_buff_reg[12]__0 [1]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[12][2] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[12][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[12][2]_i_1_n_0 ),
        .Q(\tx_buff_reg[12]__0 [2]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[12][3] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[12][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[14][3]_i_1_n_0 ),
        .Q(\tx_buff_reg[12]__0 [3]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[12][4] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[12][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][4]_i_1_n_0 ),
        .Q(\tx_buff_reg[12]__0 [4]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[12][5] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[12][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][5]_i_1_n_0 ),
        .Q(\tx_buff_reg[12]__0 [5]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[12][6] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[12][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][6]_i_2_n_0 ),
        .Q(\tx_buff_reg[12]__0 [6]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[13][0] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[13][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][0]_i_1_n_0 ),
        .Q(\tx_buff_reg[13]__0 [0]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[13][1] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[13][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[13][1]_i_1_n_0 ),
        .Q(\tx_buff_reg[13]__0 [1]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[13][2] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[13][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][2]_i_1_n_0 ),
        .Q(\tx_buff_reg[13]__0 [2]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[13][3] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[13][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[14][3]_i_1_n_0 ),
        .Q(\tx_buff_reg[13]__0 [3]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[13][4] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[13][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[13][4]_i_1_n_0 ),
        .Q(\tx_buff_reg[13]__0 [4]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[13][5] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[13][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[14][5]_i_1_n_0 ),
        .Q(\tx_buff_reg[13]__0 [5]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[13][6] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[13][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][6]_i_2_n_0 ),
        .Q(\tx_buff_reg[13]__0 [6]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[13][7] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[13][7]_i_1_n_0 ),
        .Q(\tx_buff_reg[13]__0 [7]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[14][0] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[14][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[14][0]_i_1_n_0 ),
        .Q(\tx_buff_reg[14]__0 [0]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[14][1] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[14][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][1]_i_1_n_0 ),
        .Q(\tx_buff_reg[14]__0 [1]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[14][2] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[14][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][2]_i_1_n_0 ),
        .Q(\tx_buff_reg[14]__0 [2]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[14][3] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[14][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[14][3]_i_1_n_0 ),
        .Q(\tx_buff_reg[14]__0 [3]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[14][4] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[14][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][4]_i_1_n_0 ),
        .Q(\tx_buff_reg[14]__0 [4]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[14][5] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[14][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[14][5]_i_1_n_0 ),
        .Q(\tx_buff_reg[14]__0 [5]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[14][6] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[14][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][6]_i_2_n_0 ),
        .Q(\tx_buff_reg[14]__0 [6]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[15][0] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[15][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][0]_i_1_n_0 ),
        .Q(\tx_buff_reg[15]__0 [0]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[15][1] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[15][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][1]_i_1_n_0 ),
        .Q(\tx_buff_reg[15]__0 [1]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[15][2] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[15][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][2]_i_1_n_0 ),
        .Q(\tx_buff_reg[15]__0 [2]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[15][3] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[15][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][3]_i_1_n_0 ),
        .Q(\tx_buff_reg[15]__0 [3]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[15][4] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[15][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][4]_i_1_n_0 ),
        .Q(\tx_buff_reg[15]__0 [4]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[15][5] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[15][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][5]_i_1_n_0 ),
        .Q(\tx_buff_reg[15]__0 [5]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[15][6] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[15][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][6]_i_2_n_0 ),
        .Q(\tx_buff_reg[15]__0 [6]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[15][7] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][7]_i_1_n_0 ),
        .Q(\tx_buff_reg[15]__0 [7]));
  FDRE #(
    .INIT(1'b0)) 
    \tx_buff_reg[16][0] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[16][5]_i_2_n_0 ),
        .D(tx_buff[1]),
        .Q(\tx_buff_reg[16]__0 [0]),
        .R(\tx_buff[16][5]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \tx_buff_reg[16][1] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[16][5]_i_2_n_0 ),
        .D(tx_buff[2]),
        .Q(\tx_buff_reg[16]__0 [1]),
        .R(\tx_buff[16][5]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \tx_buff_reg[16][2] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[16][5]_i_2_n_0 ),
        .D(tx_buff[3]),
        .Q(\tx_buff_reg[16]__0 [2]),
        .R(\tx_buff[16][5]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \tx_buff_reg[16][3] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[16][5]_i_2_n_0 ),
        .D(tx_buff[4]),
        .Q(\tx_buff_reg[16]__0 [3]),
        .R(\tx_buff[16][5]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \tx_buff_reg[16][4] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[16][5]_i_2_n_0 ),
        .D(tx_buff[5]),
        .Q(\tx_buff_reg[16]__0 [4]),
        .R(\tx_buff[16][5]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \tx_buff_reg[16][5] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[16][5]_i_2_n_0 ),
        .D(tx_buff[6]),
        .Q(\tx_buff_reg[16]__0 [5]),
        .R(\tx_buff[16][5]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \tx_buff_reg[16][6] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\tx_buff[16][6]_i_1_n_0 ),
        .Q(\tx_buff_reg[16]__0 [6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \tx_buff_reg[17][0] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[17][5]_i_2_n_0 ),
        .D(tx_buff[1]),
        .Q(\tx_buff_reg[17]__0 [0]),
        .R(\tx_buff[17][5]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \tx_buff_reg[17][1] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[17][5]_i_2_n_0 ),
        .D(tx_buff[2]),
        .Q(\tx_buff_reg[17]__0 [1]),
        .R(\tx_buff[17][5]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \tx_buff_reg[17][2] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[17][5]_i_2_n_0 ),
        .D(tx_buff[3]),
        .Q(\tx_buff_reg[17]__0 [2]),
        .R(\tx_buff[17][5]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \tx_buff_reg[17][3] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[17][5]_i_2_n_0 ),
        .D(tx_buff[4]),
        .Q(\tx_buff_reg[17]__0 [3]),
        .R(\tx_buff[17][5]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \tx_buff_reg[17][4] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[17][5]_i_2_n_0 ),
        .D(tx_buff[5]),
        .Q(\tx_buff_reg[17]__0 [4]),
        .R(\tx_buff[17][5]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \tx_buff_reg[17][5] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[17][5]_i_2_n_0 ),
        .D(tx_buff[6]),
        .Q(\tx_buff_reg[17]__0 [5]),
        .R(\tx_buff[17][5]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \tx_buff_reg[17][6] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\tx_buff[17][6]_i_1_n_0 ),
        .Q(\tx_buff_reg[17]__0 [6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \tx_buff_reg[18][0] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[18][5]_i_2_n_0 ),
        .D(tx_buff[1]),
        .Q(\tx_buff_reg[18]__0 [0]),
        .R(\tx_buff[18][5]_i_1_n_0 ));
  MUXF7 \tx_buff_reg[18][0]_i_1 
       (.I0(\tx_buff[18][0]_i_2_n_0 ),
        .I1(\tx_buff[18][0]_i_3_n_0 ),
        .O(tx_buff[1]),
        .S(byte_count_reg__0[4]));
  FDRE #(
    .INIT(1'b0)) 
    \tx_buff_reg[18][1] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[18][5]_i_2_n_0 ),
        .D(tx_buff[2]),
        .Q(\tx_buff_reg[18]__0 [1]),
        .R(\tx_buff[18][5]_i_1_n_0 ));
  MUXF7 \tx_buff_reg[18][1]_i_1 
       (.I0(\tx_buff[18][1]_i_2_n_0 ),
        .I1(\tx_buff[18][1]_i_3_n_0 ),
        .O(tx_buff[2]),
        .S(byte_count_reg__0[4]));
  FDRE #(
    .INIT(1'b0)) 
    \tx_buff_reg[18][2] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[18][5]_i_2_n_0 ),
        .D(tx_buff[3]),
        .Q(\tx_buff_reg[18]__0 [2]),
        .R(\tx_buff[18][5]_i_1_n_0 ));
  MUXF7 \tx_buff_reg[18][2]_i_1 
       (.I0(\tx_buff[18][2]_i_2_n_0 ),
        .I1(\tx_buff[18][2]_i_3_n_0 ),
        .O(tx_buff[3]),
        .S(byte_count_reg__0[4]));
  FDRE #(
    .INIT(1'b0)) 
    \tx_buff_reg[18][3] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[18][5]_i_2_n_0 ),
        .D(tx_buff[4]),
        .Q(\tx_buff_reg[18]__0 [3]),
        .R(\tx_buff[18][5]_i_1_n_0 ));
  MUXF7 \tx_buff_reg[18][3]_i_1 
       (.I0(\tx_buff[18][3]_i_2_n_0 ),
        .I1(\tx_buff[18][3]_i_3_n_0 ),
        .O(tx_buff[4]),
        .S(byte_count_reg__0[4]));
  FDRE #(
    .INIT(1'b0)) 
    \tx_buff_reg[18][4] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[18][5]_i_2_n_0 ),
        .D(tx_buff[5]),
        .Q(\tx_buff_reg[18]__0 [4]),
        .R(\tx_buff[18][5]_i_1_n_0 ));
  MUXF7 \tx_buff_reg[18][4]_i_1 
       (.I0(\tx_buff[18][4]_i_2_n_0 ),
        .I1(\tx_buff[18][4]_i_3_n_0 ),
        .O(tx_buff[5]),
        .S(byte_count_reg__0[4]));
  FDRE #(
    .INIT(1'b0)) 
    \tx_buff_reg[18][5] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[18][5]_i_2_n_0 ),
        .D(tx_buff[6]),
        .Q(\tx_buff_reg[18]__0 [5]),
        .R(\tx_buff[18][5]_i_1_n_0 ));
  MUXF7 \tx_buff_reg[18][5]_i_3 
       (.I0(\tx_buff[18][5]_i_10_n_0 ),
        .I1(\tx_buff[18][5]_i_11_n_0 ),
        .O(tx_buff[6]),
        .S(byte_count_reg__0[4]));
  FDRE #(
    .INIT(1'b0)) 
    \tx_buff_reg[18][6] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\tx_buff[18][6]_i_1_n_0 ),
        .Q(\tx_buff_reg[18]__0 [6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \tx_buff_reg[19][0] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[19][5]_i_2_n_0 ),
        .D(tx_buff[1]),
        .Q(\tx_buff_reg[19]__0 [0]),
        .R(\tx_buff[19][5]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \tx_buff_reg[19][1] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[19][5]_i_2_n_0 ),
        .D(tx_buff[2]),
        .Q(\tx_buff_reg[19]__0 [1]),
        .R(\tx_buff[19][5]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \tx_buff_reg[19][2] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[19][5]_i_2_n_0 ),
        .D(tx_buff[3]),
        .Q(\tx_buff_reg[19]__0 [2]),
        .R(\tx_buff[19][5]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \tx_buff_reg[19][3] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[19][5]_i_2_n_0 ),
        .D(tx_buff[4]),
        .Q(\tx_buff_reg[19]__0 [3]),
        .R(\tx_buff[19][5]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \tx_buff_reg[19][4] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[19][5]_i_2_n_0 ),
        .D(tx_buff[5]),
        .Q(\tx_buff_reg[19]__0 [4]),
        .R(\tx_buff[19][5]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \tx_buff_reg[19][5] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[19][5]_i_2_n_0 ),
        .D(tx_buff[6]),
        .Q(\tx_buff_reg[19]__0 [5]),
        .R(\tx_buff[19][5]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \tx_buff_reg[19][6] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\tx_buff[19][6]_i_1_n_0 ),
        .Q(\tx_buff_reg[19]__0 [6]),
        .R(1'b0));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[1][0] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[1][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][0]_i_1_n_0 ),
        .Q(\tx_buff_reg[1]__0 [0]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[1][1] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[1][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][1]_i_1_n_0 ),
        .Q(\tx_buff_reg[1]__0 [1]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[1][2] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[1][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[12][2]_i_1_n_0 ),
        .Q(\tx_buff_reg[1]__0 [2]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[1][3] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[1][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][3]_i_1_n_0 ),
        .Q(\tx_buff_reg[1]__0 [3]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[1][4] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[1][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[13][4]_i_1_n_0 ),
        .Q(\tx_buff_reg[1]__0 [4]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[1][5] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[1][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[14][5]_i_1_n_0 ),
        .Q(\tx_buff_reg[1]__0 [5]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[1][6] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[1][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][6]_i_2_n_0 ),
        .Q(\tx_buff_reg[1]__0 [6]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[2][0] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[2][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[14][0]_i_1_n_0 ),
        .Q(\tx_buff_reg[2]__0 [0]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[2][1] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[2][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][1]_i_1_n_0 ),
        .Q(\tx_buff_reg[2]__0 [1]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[2][2] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[2][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[12][2]_i_1_n_0 ),
        .Q(\tx_buff_reg[2]__0 [2]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[2][3] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[2][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[14][3]_i_1_n_0 ),
        .Q(\tx_buff_reg[2]__0 [3]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[2][4] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[2][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][4]_i_1_n_0 ),
        .Q(\tx_buff_reg[2]__0 [4]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[2][5] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[2][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[14][5]_i_1_n_0 ),
        .Q(\tx_buff_reg[2]__0 [5]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[2][6] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[2][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][6]_i_2_n_0 ),
        .Q(\tx_buff_reg[2]__0 [6]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[2][7] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[2][7]_i_1_n_0 ),
        .Q(\tx_buff_reg[2]__0 [7]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[3][0] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[3][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][0]_i_1_n_0 ),
        .Q(\tx_buff_reg[3]__0 [0]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[3][1] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[3][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[13][1]_i_1_n_0 ),
        .Q(\tx_buff_reg[3]__0 [1]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[3][2] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[3][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][2]_i_1_n_0 ),
        .Q(\tx_buff_reg[3]__0 [2]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[3][3] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[3][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][3]_i_1_n_0 ),
        .Q(\tx_buff_reg[3]__0 [3]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[3][4] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[3][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[13][4]_i_1_n_0 ),
        .Q(\tx_buff_reg[3]__0 [4]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[3][5] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[3][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[14][5]_i_1_n_0 ),
        .Q(\tx_buff_reg[3]__0 [5]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[3][6] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[3][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[11][6]_i_2_n_0 ),
        .Q(\tx_buff_reg[3]__0 [6]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[4][0] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[4][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[14][0]_i_1_n_0 ),
        .Q(\tx_buff_reg[4]__0 [0]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[4][1] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[4][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][1]_i_1_n_0 ),
        .Q(\tx_buff_reg[4]__0 [1]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[4][2] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[4][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][2]_i_1_n_0 ),
        .Q(\tx_buff_reg[4]__0 [2]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[4][3] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[4][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][3]_i_1_n_0 ),
        .Q(\tx_buff_reg[4]__0 [3]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[4][4] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[4][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[13][4]_i_1_n_0 ),
        .Q(\tx_buff_reg[4]__0 [4]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[4][5] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[4][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][5]_i_1_n_0 ),
        .Q(\tx_buff_reg[4]__0 [5]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[4][6] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[4][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][6]_i_2_n_0 ),
        .Q(\tx_buff_reg[4]__0 [6]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[4][7] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[4][7]_i_1_n_0 ),
        .Q(\tx_buff_reg[4]__0 [7]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[5][0] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[5][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[14][0]_i_1_n_0 ),
        .Q(\tx_buff_reg[5]__0 [0]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[5][1] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[5][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[13][1]_i_1_n_0 ),
        .Q(\tx_buff_reg[5]__0 [1]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[5][2] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[5][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[12][2]_i_1_n_0 ),
        .Q(\tx_buff_reg[5]__0 [2]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[5][3] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[5][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[14][3]_i_1_n_0 ),
        .Q(\tx_buff_reg[5]__0 [3]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[5][4] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[5][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][4]_i_1_n_0 ),
        .Q(\tx_buff_reg[5]__0 [4]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[5][5] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[5][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][5]_i_1_n_0 ),
        .Q(\tx_buff_reg[5]__0 [5]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[5][6] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[5][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][6]_i_2_n_0 ),
        .Q(\tx_buff_reg[5]__0 [6]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[5][7] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[5][7]_i_1_n_0 ),
        .Q(\tx_buff_reg[5]__0 [7]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[6][0] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[6][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][0]_i_1_n_0 ),
        .Q(\tx_buff_reg[6]__0 [0]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[6][1] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[6][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[13][1]_i_1_n_0 ),
        .Q(\tx_buff_reg[6]__0 [1]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[6][2] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[6][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[12][2]_i_1_n_0 ),
        .Q(\tx_buff_reg[6]__0 [2]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[6][3] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[6][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[14][3]_i_1_n_0 ),
        .Q(\tx_buff_reg[6]__0 [3]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[6][4] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[6][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][4]_i_1_n_0 ),
        .Q(\tx_buff_reg[6]__0 [4]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[6][5] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[6][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[14][5]_i_1_n_0 ),
        .Q(\tx_buff_reg[6]__0 [5]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[6][6] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[6][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[11][6]_i_2_n_0 ),
        .Q(\tx_buff_reg[6]__0 [6]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[6][7] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[6][7]_i_1_n_0 ),
        .Q(\tx_buff_reg[6]__0 [7]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[7][0] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[7][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[14][0]_i_1_n_0 ),
        .Q(\tx_buff_reg[7]__0 [0]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[7][1] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[7][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[13][1]_i_1_n_0 ),
        .Q(\tx_buff_reg[7]__0 [1]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[7][2] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[7][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][2]_i_1_n_0 ),
        .Q(\tx_buff_reg[7]__0 [2]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[7][3] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[7][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][3]_i_1_n_0 ),
        .Q(\tx_buff_reg[7]__0 [3]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[7][4] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[7][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][4]_i_1_n_0 ),
        .Q(\tx_buff_reg[7]__0 [4]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[7][5] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[7][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][5]_i_1_n_0 ),
        .Q(\tx_buff_reg[7]__0 [5]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[7][6] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[7][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][6]_i_2_n_0 ),
        .Q(\tx_buff_reg[7]__0 [6]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[7][7] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[7][7]_i_1_n_0 ),
        .Q(\tx_buff_reg[7]__0 [7]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[8][0] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[8][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[14][0]_i_1_n_0 ),
        .Q(\tx_buff_reg[8]__0 [0]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[8][1] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[8][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[13][1]_i_1_n_0 ),
        .Q(\tx_buff_reg[8]__0 [1]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[8][2] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[8][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[12][2]_i_1_n_0 ),
        .Q(\tx_buff_reg[8]__0 [2]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[8][3] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[8][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][3]_i_1_n_0 ),
        .Q(\tx_buff_reg[8]__0 [3]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[8][4] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[8][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[13][4]_i_1_n_0 ),
        .Q(\tx_buff_reg[8]__0 [4]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[8][5] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[8][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][5]_i_1_n_0 ),
        .Q(\tx_buff_reg[8]__0 [5]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[8][6] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[8][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][6]_i_2_n_0 ),
        .Q(\tx_buff_reg[8]__0 [6]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[9][0] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[9][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[14][0]_i_1_n_0 ),
        .Q(\tx_buff_reg[9]__0 [0]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[9][1] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[9][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[13][1]_i_1_n_0 ),
        .Q(\tx_buff_reg[9]__0 [1]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[9][2] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[9][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][2]_i_1_n_0 ),
        .Q(\tx_buff_reg[9]__0 [2]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[9][3] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[9][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[15][3]_i_1_n_0 ),
        .Q(\tx_buff_reg[9]__0 [3]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[9][4] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[9][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[13][4]_i_1_n_0 ),
        .Q(\tx_buff_reg[9]__0 [4]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[9][5] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[9][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[14][5]_i_1_n_0 ),
        .Q(\tx_buff_reg[9]__0 [5]));
  FDCE #(
    .INIT(1'b0)) 
    \tx_buff_reg[9][6] 
       (.C(clk_IBUF_BUFG),
        .CE(\tx_buff[9][6]_i_1_n_0 ),
        .CLR(\tx_buff_reg[1][0]_0 ),
        .D(\tx_buff[11][6]_i_2_n_0 ),
        .Q(\tx_buff_reg[9]__0 [6]));
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
