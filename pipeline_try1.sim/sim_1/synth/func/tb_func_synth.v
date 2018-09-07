// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.1 (win64) Build 1846317 Fri Apr 14 18:55:03 MDT 2017
// Date        : Thu Sep  6 18:59:17 2018
// Host        : DESKTOP-GJPCRJL running 64-bit major release  (build 9200)
// Command     : write_verilog -mode funcsim -nolib -force -file
//               C:/College/Thesis/AES_2018/fall2018/pipeline_try1/pipeline_try1.sim/sim_1/synth/func/tb_func_synth.v
// Design      : top
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "data_mem_gen_0,blk_mem_gen_v8_3_6,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_3_6,Vivado 2017.1" *) 
module data_mem_gen_0
   (clka,
    ena,
    wea,
    addra,
    dina,
    douta);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [7:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [31:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [31:0]douta;

  wire [7:0]addra;
  wire clka;
  wire [31:0]dina;
  wire [31:0]douta;
  wire ena;
  wire [0:0]wea;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [31:0]NLW_U0_doutb_UNCONNECTED;
  wire [7:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [7:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "8" *) 
  (* C_ADDRB_WIDTH = "8" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "1" *) 
  (* C_COUNT_36K_BRAM = "0" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     3.53845 mW" *) 
  (* C_FAMILY = "artix7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "data_mem_gen_0.mem" *) 
  (* C_INIT_FILE_NAME = "data_mem_gen_0.mif" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "1" *) 
  (* C_MEM_TYPE = "0" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "256" *) 
  (* C_READ_DEPTH_B = "256" *) 
  (* C_READ_WIDTH_A = "32" *) 
  (* C_READ_WIDTH_B = "32" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "1" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "256" *) 
  (* C_WRITE_DEPTH_B = "256" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "32" *) 
  (* C_WRITE_WIDTH_B = "32" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  data_mem_gen_0_blk_mem_gen_v8_3_6 U0
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(NLW_U0_doutb_UNCONNECTED[31:0]),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[7:0]),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[7:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[31:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web(1'b0));
endmodule

(* NDATA = "8" *) 
(* NotValidForBitStream *)
module top
   (clkIn,
    rstIn,
    loadKeyIn,
    loadDataIn,
    startIn,
    encDecSelectIn,
    dataout,
    dataDone);
  input clkIn;
  input rstIn;
  input loadKeyIn;
  input loadDataIn;
  input startIn;
  input [1:0]encDecSelectIn;
  output [127:0]dataout;
  output dataDone;

  wire clkIn;
  wire clkIn_IBUF;
  wire clkIn_IBUF_BUFG;
  wire dataAddrCount;
  wire \dataAddrCount[7]_i_3_n_0 ;
  wire \dataAddrCount[7]_i_4_n_0 ;
  wire [7:0]dataAddrCount_reg;
  wire [31:0]dataBram;
  wire dataDone;
  wire [127:0]dataout;
  wire loadDataIn;
  wire loadDataIn_IBUF;
  wire [7:0]p_0_in;
  wire rstIn;
  wire rstIn_IBUF;

  (* x_core_info = "blk_mem_gen_v8_3_6,Vivado 2017.1" *) 
  data_mem_gen_0 DATA1
       (.addra(dataAddrCount_reg),
        .clka(clkIn_IBUF_BUFG),
        .dina({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(dataBram),
        .ena(loadDataIn_IBUF),
        .wea(1'b0));
  BUFG clkIn_IBUF_BUFG_inst
       (.I(clkIn_IBUF),
        .O(clkIn_IBUF_BUFG));
  IBUF clkIn_IBUF_inst
       (.I(clkIn),
        .O(clkIn_IBUF));
  LUT1 #(
    .INIT(2'h1)) 
    \dataAddrCount[0]_i_1 
       (.I0(dataAddrCount_reg[0]),
        .O(p_0_in[0]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \dataAddrCount[1]_i_1 
       (.I0(dataAddrCount_reg[0]),
        .I1(dataAddrCount_reg[1]),
        .O(p_0_in[1]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \dataAddrCount[2]_i_1 
       (.I0(dataAddrCount_reg[0]),
        .I1(dataAddrCount_reg[1]),
        .I2(dataAddrCount_reg[2]),
        .O(p_0_in[2]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \dataAddrCount[3]_i_1 
       (.I0(dataAddrCount_reg[1]),
        .I1(dataAddrCount_reg[0]),
        .I2(dataAddrCount_reg[2]),
        .I3(dataAddrCount_reg[3]),
        .O(p_0_in[3]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \dataAddrCount[4]_i_1 
       (.I0(dataAddrCount_reg[2]),
        .I1(dataAddrCount_reg[0]),
        .I2(dataAddrCount_reg[1]),
        .I3(dataAddrCount_reg[3]),
        .I4(dataAddrCount_reg[4]),
        .O(p_0_in[4]));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \dataAddrCount[5]_i_1 
       (.I0(dataAddrCount_reg[3]),
        .I1(dataAddrCount_reg[1]),
        .I2(dataAddrCount_reg[0]),
        .I3(dataAddrCount_reg[2]),
        .I4(dataAddrCount_reg[4]),
        .I5(dataAddrCount_reg[5]),
        .O(p_0_in[5]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \dataAddrCount[6]_i_1 
       (.I0(\dataAddrCount[7]_i_4_n_0 ),
        .I1(dataAddrCount_reg[6]),
        .O(p_0_in[6]));
  LUT6 #(
    .INIT(64'h0000000000000010)) 
    \dataAddrCount[7]_i_1 
       (.I0(dataAddrCount_reg[7]),
        .I1(dataAddrCount_reg[4]),
        .I2(loadDataIn_IBUF),
        .I3(dataAddrCount_reg[3]),
        .I4(dataAddrCount_reg[5]),
        .I5(dataAddrCount_reg[6]),
        .O(dataAddrCount));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \dataAddrCount[7]_i_2 
       (.I0(\dataAddrCount[7]_i_4_n_0 ),
        .I1(dataAddrCount_reg[6]),
        .I2(dataAddrCount_reg[7]),
        .O(p_0_in[7]));
  LUT1 #(
    .INIT(2'h1)) 
    \dataAddrCount[7]_i_3 
       (.I0(rstIn_IBUF),
        .O(\dataAddrCount[7]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    \dataAddrCount[7]_i_4 
       (.I0(dataAddrCount_reg[5]),
        .I1(dataAddrCount_reg[3]),
        .I2(dataAddrCount_reg[1]),
        .I3(dataAddrCount_reg[0]),
        .I4(dataAddrCount_reg[2]),
        .I5(dataAddrCount_reg[4]),
        .O(\dataAddrCount[7]_i_4_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \dataAddrCount_reg[0] 
       (.C(clkIn_IBUF_BUFG),
        .CE(dataAddrCount),
        .CLR(\dataAddrCount[7]_i_3_n_0 ),
        .D(p_0_in[0]),
        .Q(dataAddrCount_reg[0]));
  FDCE #(
    .INIT(1'b0)) 
    \dataAddrCount_reg[1] 
       (.C(clkIn_IBUF_BUFG),
        .CE(dataAddrCount),
        .CLR(\dataAddrCount[7]_i_3_n_0 ),
        .D(p_0_in[1]),
        .Q(dataAddrCount_reg[1]));
  FDCE #(
    .INIT(1'b0)) 
    \dataAddrCount_reg[2] 
       (.C(clkIn_IBUF_BUFG),
        .CE(dataAddrCount),
        .CLR(\dataAddrCount[7]_i_3_n_0 ),
        .D(p_0_in[2]),
        .Q(dataAddrCount_reg[2]));
  FDCE #(
    .INIT(1'b0)) 
    \dataAddrCount_reg[3] 
       (.C(clkIn_IBUF_BUFG),
        .CE(dataAddrCount),
        .CLR(\dataAddrCount[7]_i_3_n_0 ),
        .D(p_0_in[3]),
        .Q(dataAddrCount_reg[3]));
  FDCE #(
    .INIT(1'b0)) 
    \dataAddrCount_reg[4] 
       (.C(clkIn_IBUF_BUFG),
        .CE(dataAddrCount),
        .CLR(\dataAddrCount[7]_i_3_n_0 ),
        .D(p_0_in[4]),
        .Q(dataAddrCount_reg[4]));
  FDCE #(
    .INIT(1'b0)) 
    \dataAddrCount_reg[5] 
       (.C(clkIn_IBUF_BUFG),
        .CE(dataAddrCount),
        .CLR(\dataAddrCount[7]_i_3_n_0 ),
        .D(p_0_in[5]),
        .Q(dataAddrCount_reg[5]));
  FDCE #(
    .INIT(1'b0)) 
    \dataAddrCount_reg[6] 
       (.C(clkIn_IBUF_BUFG),
        .CE(dataAddrCount),
        .CLR(\dataAddrCount[7]_i_3_n_0 ),
        .D(p_0_in[6]),
        .Q(dataAddrCount_reg[6]));
  FDCE #(
    .INIT(1'b0)) 
    \dataAddrCount_reg[7] 
       (.C(clkIn_IBUF_BUFG),
        .CE(dataAddrCount),
        .CLR(\dataAddrCount[7]_i_3_n_0 ),
        .D(p_0_in[7]),
        .Q(dataAddrCount_reg[7]));
  OBUF dataDone_OBUF_inst
       (.I(1'b0),
        .O(dataDone));
  OBUF \dataout_OBUF[0]_inst 
       (.I(1'b0),
        .O(dataout[0]));
  OBUF \dataout_OBUF[100]_inst 
       (.I(1'b0),
        .O(dataout[100]));
  OBUF \dataout_OBUF[101]_inst 
       (.I(1'b0),
        .O(dataout[101]));
  OBUF \dataout_OBUF[102]_inst 
       (.I(1'b0),
        .O(dataout[102]));
  OBUF \dataout_OBUF[103]_inst 
       (.I(1'b0),
        .O(dataout[103]));
  OBUF \dataout_OBUF[104]_inst 
       (.I(1'b0),
        .O(dataout[104]));
  OBUF \dataout_OBUF[105]_inst 
       (.I(1'b0),
        .O(dataout[105]));
  OBUF \dataout_OBUF[106]_inst 
       (.I(1'b0),
        .O(dataout[106]));
  OBUF \dataout_OBUF[107]_inst 
       (.I(1'b0),
        .O(dataout[107]));
  OBUF \dataout_OBUF[108]_inst 
       (.I(1'b0),
        .O(dataout[108]));
  OBUF \dataout_OBUF[109]_inst 
       (.I(1'b0),
        .O(dataout[109]));
  OBUF \dataout_OBUF[10]_inst 
       (.I(1'b0),
        .O(dataout[10]));
  OBUF \dataout_OBUF[110]_inst 
       (.I(1'b0),
        .O(dataout[110]));
  OBUF \dataout_OBUF[111]_inst 
       (.I(1'b0),
        .O(dataout[111]));
  OBUF \dataout_OBUF[112]_inst 
       (.I(1'b0),
        .O(dataout[112]));
  OBUF \dataout_OBUF[113]_inst 
       (.I(1'b0),
        .O(dataout[113]));
  OBUF \dataout_OBUF[114]_inst 
       (.I(1'b0),
        .O(dataout[114]));
  OBUF \dataout_OBUF[115]_inst 
       (.I(1'b0),
        .O(dataout[115]));
  OBUF \dataout_OBUF[116]_inst 
       (.I(1'b0),
        .O(dataout[116]));
  OBUF \dataout_OBUF[117]_inst 
       (.I(1'b0),
        .O(dataout[117]));
  OBUF \dataout_OBUF[118]_inst 
       (.I(1'b0),
        .O(dataout[118]));
  OBUF \dataout_OBUF[119]_inst 
       (.I(1'b0),
        .O(dataout[119]));
  OBUF \dataout_OBUF[11]_inst 
       (.I(1'b0),
        .O(dataout[11]));
  OBUF \dataout_OBUF[120]_inst 
       (.I(1'b0),
        .O(dataout[120]));
  OBUF \dataout_OBUF[121]_inst 
       (.I(1'b0),
        .O(dataout[121]));
  OBUF \dataout_OBUF[122]_inst 
       (.I(1'b0),
        .O(dataout[122]));
  OBUF \dataout_OBUF[123]_inst 
       (.I(1'b0),
        .O(dataout[123]));
  OBUF \dataout_OBUF[124]_inst 
       (.I(1'b0),
        .O(dataout[124]));
  OBUF \dataout_OBUF[125]_inst 
       (.I(1'b0),
        .O(dataout[125]));
  OBUF \dataout_OBUF[126]_inst 
       (.I(1'b0),
        .O(dataout[126]));
  OBUF \dataout_OBUF[127]_inst 
       (.I(1'b0),
        .O(dataout[127]));
  OBUF \dataout_OBUF[12]_inst 
       (.I(1'b0),
        .O(dataout[12]));
  OBUF \dataout_OBUF[13]_inst 
       (.I(1'b0),
        .O(dataout[13]));
  OBUF \dataout_OBUF[14]_inst 
       (.I(1'b0),
        .O(dataout[14]));
  OBUF \dataout_OBUF[15]_inst 
       (.I(1'b0),
        .O(dataout[15]));
  OBUF \dataout_OBUF[16]_inst 
       (.I(1'b0),
        .O(dataout[16]));
  OBUF \dataout_OBUF[17]_inst 
       (.I(1'b0),
        .O(dataout[17]));
  OBUF \dataout_OBUF[18]_inst 
       (.I(1'b0),
        .O(dataout[18]));
  OBUF \dataout_OBUF[19]_inst 
       (.I(1'b0),
        .O(dataout[19]));
  OBUF \dataout_OBUF[1]_inst 
       (.I(1'b0),
        .O(dataout[1]));
  OBUF \dataout_OBUF[20]_inst 
       (.I(1'b0),
        .O(dataout[20]));
  OBUF \dataout_OBUF[21]_inst 
       (.I(1'b0),
        .O(dataout[21]));
  OBUF \dataout_OBUF[22]_inst 
       (.I(1'b0),
        .O(dataout[22]));
  OBUF \dataout_OBUF[23]_inst 
       (.I(1'b0),
        .O(dataout[23]));
  OBUF \dataout_OBUF[24]_inst 
       (.I(1'b0),
        .O(dataout[24]));
  OBUF \dataout_OBUF[25]_inst 
       (.I(1'b0),
        .O(dataout[25]));
  OBUF \dataout_OBUF[26]_inst 
       (.I(1'b0),
        .O(dataout[26]));
  OBUF \dataout_OBUF[27]_inst 
       (.I(1'b0),
        .O(dataout[27]));
  OBUF \dataout_OBUF[28]_inst 
       (.I(1'b0),
        .O(dataout[28]));
  OBUF \dataout_OBUF[29]_inst 
       (.I(1'b0),
        .O(dataout[29]));
  OBUF \dataout_OBUF[2]_inst 
       (.I(1'b0),
        .O(dataout[2]));
  OBUF \dataout_OBUF[30]_inst 
       (.I(1'b0),
        .O(dataout[30]));
  OBUF \dataout_OBUF[31]_inst 
       (.I(1'b0),
        .O(dataout[31]));
  OBUF \dataout_OBUF[32]_inst 
       (.I(1'b0),
        .O(dataout[32]));
  OBUF \dataout_OBUF[33]_inst 
       (.I(1'b0),
        .O(dataout[33]));
  OBUF \dataout_OBUF[34]_inst 
       (.I(1'b0),
        .O(dataout[34]));
  OBUF \dataout_OBUF[35]_inst 
       (.I(1'b0),
        .O(dataout[35]));
  OBUF \dataout_OBUF[36]_inst 
       (.I(1'b0),
        .O(dataout[36]));
  OBUF \dataout_OBUF[37]_inst 
       (.I(1'b0),
        .O(dataout[37]));
  OBUF \dataout_OBUF[38]_inst 
       (.I(1'b0),
        .O(dataout[38]));
  OBUF \dataout_OBUF[39]_inst 
       (.I(1'b0),
        .O(dataout[39]));
  OBUF \dataout_OBUF[3]_inst 
       (.I(1'b0),
        .O(dataout[3]));
  OBUF \dataout_OBUF[40]_inst 
       (.I(1'b0),
        .O(dataout[40]));
  OBUF \dataout_OBUF[41]_inst 
       (.I(1'b0),
        .O(dataout[41]));
  OBUF \dataout_OBUF[42]_inst 
       (.I(1'b0),
        .O(dataout[42]));
  OBUF \dataout_OBUF[43]_inst 
       (.I(1'b0),
        .O(dataout[43]));
  OBUF \dataout_OBUF[44]_inst 
       (.I(1'b0),
        .O(dataout[44]));
  OBUF \dataout_OBUF[45]_inst 
       (.I(1'b0),
        .O(dataout[45]));
  OBUF \dataout_OBUF[46]_inst 
       (.I(1'b0),
        .O(dataout[46]));
  OBUF \dataout_OBUF[47]_inst 
       (.I(1'b0),
        .O(dataout[47]));
  OBUF \dataout_OBUF[48]_inst 
       (.I(1'b0),
        .O(dataout[48]));
  OBUF \dataout_OBUF[49]_inst 
       (.I(1'b0),
        .O(dataout[49]));
  OBUF \dataout_OBUF[4]_inst 
       (.I(1'b0),
        .O(dataout[4]));
  OBUF \dataout_OBUF[50]_inst 
       (.I(1'b0),
        .O(dataout[50]));
  OBUF \dataout_OBUF[51]_inst 
       (.I(1'b0),
        .O(dataout[51]));
  OBUF \dataout_OBUF[52]_inst 
       (.I(1'b0),
        .O(dataout[52]));
  OBUF \dataout_OBUF[53]_inst 
       (.I(1'b0),
        .O(dataout[53]));
  OBUF \dataout_OBUF[54]_inst 
       (.I(1'b0),
        .O(dataout[54]));
  OBUF \dataout_OBUF[55]_inst 
       (.I(1'b0),
        .O(dataout[55]));
  OBUF \dataout_OBUF[56]_inst 
       (.I(1'b0),
        .O(dataout[56]));
  OBUF \dataout_OBUF[57]_inst 
       (.I(1'b0),
        .O(dataout[57]));
  OBUF \dataout_OBUF[58]_inst 
       (.I(1'b0),
        .O(dataout[58]));
  OBUF \dataout_OBUF[59]_inst 
       (.I(1'b0),
        .O(dataout[59]));
  OBUF \dataout_OBUF[5]_inst 
       (.I(1'b0),
        .O(dataout[5]));
  OBUF \dataout_OBUF[60]_inst 
       (.I(1'b0),
        .O(dataout[60]));
  OBUF \dataout_OBUF[61]_inst 
       (.I(1'b0),
        .O(dataout[61]));
  OBUF \dataout_OBUF[62]_inst 
       (.I(1'b0),
        .O(dataout[62]));
  OBUF \dataout_OBUF[63]_inst 
       (.I(1'b0),
        .O(dataout[63]));
  OBUF \dataout_OBUF[64]_inst 
       (.I(1'b0),
        .O(dataout[64]));
  OBUF \dataout_OBUF[65]_inst 
       (.I(1'b0),
        .O(dataout[65]));
  OBUF \dataout_OBUF[66]_inst 
       (.I(1'b0),
        .O(dataout[66]));
  OBUF \dataout_OBUF[67]_inst 
       (.I(1'b0),
        .O(dataout[67]));
  OBUF \dataout_OBUF[68]_inst 
       (.I(1'b0),
        .O(dataout[68]));
  OBUF \dataout_OBUF[69]_inst 
       (.I(1'b0),
        .O(dataout[69]));
  OBUF \dataout_OBUF[6]_inst 
       (.I(1'b0),
        .O(dataout[6]));
  OBUF \dataout_OBUF[70]_inst 
       (.I(1'b0),
        .O(dataout[70]));
  OBUF \dataout_OBUF[71]_inst 
       (.I(1'b0),
        .O(dataout[71]));
  OBUF \dataout_OBUF[72]_inst 
       (.I(1'b0),
        .O(dataout[72]));
  OBUF \dataout_OBUF[73]_inst 
       (.I(1'b0),
        .O(dataout[73]));
  OBUF \dataout_OBUF[74]_inst 
       (.I(1'b0),
        .O(dataout[74]));
  OBUF \dataout_OBUF[75]_inst 
       (.I(1'b0),
        .O(dataout[75]));
  OBUF \dataout_OBUF[76]_inst 
       (.I(1'b0),
        .O(dataout[76]));
  OBUF \dataout_OBUF[77]_inst 
       (.I(1'b0),
        .O(dataout[77]));
  OBUF \dataout_OBUF[78]_inst 
       (.I(1'b0),
        .O(dataout[78]));
  OBUF \dataout_OBUF[79]_inst 
       (.I(1'b0),
        .O(dataout[79]));
  OBUF \dataout_OBUF[7]_inst 
       (.I(1'b0),
        .O(dataout[7]));
  OBUF \dataout_OBUF[80]_inst 
       (.I(1'b0),
        .O(dataout[80]));
  OBUF \dataout_OBUF[81]_inst 
       (.I(1'b0),
        .O(dataout[81]));
  OBUF \dataout_OBUF[82]_inst 
       (.I(1'b0),
        .O(dataout[82]));
  OBUF \dataout_OBUF[83]_inst 
       (.I(1'b0),
        .O(dataout[83]));
  OBUF \dataout_OBUF[84]_inst 
       (.I(1'b0),
        .O(dataout[84]));
  OBUF \dataout_OBUF[85]_inst 
       (.I(1'b0),
        .O(dataout[85]));
  OBUF \dataout_OBUF[86]_inst 
       (.I(1'b0),
        .O(dataout[86]));
  OBUF \dataout_OBUF[87]_inst 
       (.I(1'b0),
        .O(dataout[87]));
  OBUF \dataout_OBUF[88]_inst 
       (.I(1'b0),
        .O(dataout[88]));
  OBUF \dataout_OBUF[89]_inst 
       (.I(1'b0),
        .O(dataout[89]));
  OBUF \dataout_OBUF[8]_inst 
       (.I(1'b0),
        .O(dataout[8]));
  OBUF \dataout_OBUF[90]_inst 
       (.I(1'b0),
        .O(dataout[90]));
  OBUF \dataout_OBUF[91]_inst 
       (.I(1'b0),
        .O(dataout[91]));
  OBUF \dataout_OBUF[92]_inst 
       (.I(1'b0),
        .O(dataout[92]));
  OBUF \dataout_OBUF[93]_inst 
       (.I(1'b0),
        .O(dataout[93]));
  OBUF \dataout_OBUF[94]_inst 
       (.I(1'b0),
        .O(dataout[94]));
  OBUF \dataout_OBUF[95]_inst 
       (.I(1'b0),
        .O(dataout[95]));
  OBUF \dataout_OBUF[96]_inst 
       (.I(1'b0),
        .O(dataout[96]));
  OBUF \dataout_OBUF[97]_inst 
       (.I(1'b0),
        .O(dataout[97]));
  OBUF \dataout_OBUF[98]_inst 
       (.I(1'b0),
        .O(dataout[98]));
  OBUF \dataout_OBUF[99]_inst 
       (.I(1'b0),
        .O(dataout[99]));
  OBUF \dataout_OBUF[9]_inst 
       (.I(1'b0),
        .O(dataout[9]));
  IBUF loadDataIn_IBUF_inst
       (.I(loadDataIn),
        .O(loadDataIn_IBUF));
  IBUF rstIn_IBUF_inst
       (.I(rstIn),
        .O(rstIn_IBUF));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_generic_cstr" *) 
module data_mem_gen_0_blk_mem_gen_generic_cstr
   (douta,
    clka,
    ena,
    addra,
    dina,
    wea);
  output [31:0]douta;
  input clka;
  input ena;
  input [7:0]addra;
  input [31:0]dina;
  input [0:0]wea;

  wire [7:0]addra;
  wire clka;
  wire [31:0]dina;
  wire [31:0]douta;
  wire ena;
  wire [0:0]wea;

  data_mem_gen_0_blk_mem_gen_prim_width \ramloop[0].ram.r 
       (.addra(addra),
        .clka(clka),
        .dina(dina),
        .douta(douta),
        .ena(ena),
        .wea(wea));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module data_mem_gen_0_blk_mem_gen_prim_width
   (douta,
    clka,
    ena,
    addra,
    dina,
    wea);
  output [31:0]douta;
  input clka;
  input ena;
  input [7:0]addra;
  input [31:0]dina;
  input [0:0]wea;

  wire [7:0]addra;
  wire clka;
  wire [31:0]dina;
  wire [31:0]douta;
  wire ena;
  wire [0:0]wea;

  data_mem_gen_0_blk_mem_gen_prim_wrapper_init \prim_init.ram 
       (.addra(addra),
        .clka(clka),
        .dina(dina),
        .douta(douta),
        .ena(ena),
        .wea(wea));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module data_mem_gen_0_blk_mem_gen_prim_wrapper_init
   (douta,
    clka,
    ena,
    addra,
    dina,
    wea);
  output [31:0]douta;
  input clka;
  input ena;
  input [7:0]addra;
  input [31:0]dina;
  input [0:0]wea;

  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_32 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_33 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_34 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_35 ;
  wire [7:0]addra;
  wire clka;
  wire [31:0]dina;
  wire [31:0]douta;
  wire ena;
  wire [0:0]wea;

  (* box_type = "PRIMITIVE" *) 
  RAMB18E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h3322110077665544BBAA9988FFEEDDCCCCDDEEFF8899AABB4455667700112233),
    .INIT_01(256'h76543210FEDCBA9876543210FEDCBA9889ABCDEF0123456789ABCDEF01234567),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(18'h00000),
    .INIT_B(18'h00000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(18),
    .READ_WIDTH_B(18),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(18'h00000),
    .SRVAL_B(18'h00000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(18),
    .WRITE_WIDTH_B(18)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram 
       (.ADDRARDADDR({1'b0,addra,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ADDRBWRADDR({1'b0,addra,1'b1,1'b0,1'b0,1'b0,1'b0}),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DIADI(dina[15:0]),
        .DIBDI(dina[31:16]),
        .DIPADIP({1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0}),
        .DOADO(douta[15:0]),
        .DOBDO(douta[31:16]),
        .DOPADOP({\DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_32 ,\DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_33 }),
        .DOPBDOP({\DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_34 ,\DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_35 }),
        .ENARDEN(ena),
        .ENBWREN(ena),
        .REGCEAREGCE(1'b0),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .WEA({wea,wea}),
        .WEBWE({1'b0,1'b0,wea,wea}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_top" *) 
module data_mem_gen_0_blk_mem_gen_top
   (douta,
    clka,
    ena,
    addra,
    dina,
    wea);
  output [31:0]douta;
  input clka;
  input ena;
  input [7:0]addra;
  input [31:0]dina;
  input [0:0]wea;

  wire [7:0]addra;
  wire clka;
  wire [31:0]dina;
  wire [31:0]douta;
  wire ena;
  wire [0:0]wea;

  data_mem_gen_0_blk_mem_gen_generic_cstr \valid.cstr 
       (.addra(addra),
        .clka(clka),
        .dina(dina),
        .douta(douta),
        .ena(ena),
        .wea(wea));
endmodule

(* C_ADDRA_WIDTH = "8" *) (* C_ADDRB_WIDTH = "8" *) (* C_ALGORITHM = "1" *) 
(* C_AXI_ID_WIDTH = "4" *) (* C_AXI_SLAVE_TYPE = "0" *) (* C_AXI_TYPE = "1" *) 
(* C_BYTE_SIZE = "9" *) (* C_COMMON_CLK = "0" *) (* C_COUNT_18K_BRAM = "1" *) 
(* C_COUNT_36K_BRAM = "0" *) (* C_CTRL_ECC_ALGO = "NONE" *) (* C_DEFAULT_DATA = "0" *) 
(* C_DISABLE_WARN_BHV_COLL = "0" *) (* C_DISABLE_WARN_BHV_RANGE = "0" *) (* C_ELABORATION_DIR = "./" *) 
(* C_ENABLE_32BIT_ADDRESS = "0" *) (* C_EN_DEEPSLEEP_PIN = "0" *) (* C_EN_ECC_PIPE = "0" *) 
(* C_EN_RDADDRA_CHG = "0" *) (* C_EN_RDADDRB_CHG = "0" *) (* C_EN_SAFETY_CKT = "0" *) 
(* C_EN_SHUTDOWN_PIN = "0" *) (* C_EN_SLEEP_PIN = "0" *) (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     3.53845 mW" *) 
(* C_FAMILY = "artix7" *) (* C_HAS_AXI_ID = "0" *) (* C_HAS_ENA = "1" *) 
(* C_HAS_ENB = "0" *) (* C_HAS_INJECTERR = "0" *) (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
(* C_HAS_MEM_OUTPUT_REGS_B = "0" *) (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
(* C_HAS_REGCEA = "0" *) (* C_HAS_REGCEB = "0" *) (* C_HAS_RSTA = "0" *) 
(* C_HAS_RSTB = "0" *) (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
(* C_INITA_VAL = "0" *) (* C_INITB_VAL = "0" *) (* C_INIT_FILE = "data_mem_gen_0.mem" *) 
(* C_INIT_FILE_NAME = "data_mem_gen_0.mif" *) (* C_INTERFACE_TYPE = "0" *) (* C_LOAD_INIT_FILE = "1" *) 
(* C_MEM_TYPE = "0" *) (* C_MUX_PIPELINE_STAGES = "0" *) (* C_PRIM_TYPE = "1" *) 
(* C_READ_DEPTH_A = "256" *) (* C_READ_DEPTH_B = "256" *) (* C_READ_WIDTH_A = "32" *) 
(* C_READ_WIDTH_B = "32" *) (* C_RSTRAM_A = "0" *) (* C_RSTRAM_B = "0" *) 
(* C_RST_PRIORITY_A = "CE" *) (* C_RST_PRIORITY_B = "CE" *) (* C_SIM_COLLISION_CHECK = "ALL" *) 
(* C_USE_BRAM_BLOCK = "0" *) (* C_USE_BYTE_WEA = "0" *) (* C_USE_BYTE_WEB = "0" *) 
(* C_USE_DEFAULT_DATA = "1" *) (* C_USE_ECC = "0" *) (* C_USE_SOFTECC = "0" *) 
(* C_USE_URAM = "0" *) (* C_WEA_WIDTH = "1" *) (* C_WEB_WIDTH = "1" *) 
(* C_WRITE_DEPTH_A = "256" *) (* C_WRITE_DEPTH_B = "256" *) (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
(* C_WRITE_MODE_B = "WRITE_FIRST" *) (* C_WRITE_WIDTH_A = "32" *) (* C_WRITE_WIDTH_B = "32" *) 
(* C_XDEVICEFAMILY = "artix7" *) (* ORIG_REF_NAME = "blk_mem_gen_v8_3_6" *) (* downgradeipidentifiedwarnings = "yes" *) 
module data_mem_gen_0_blk_mem_gen_v8_3_6
   (clka,
    rsta,
    ena,
    regcea,
    wea,
    addra,
    dina,
    douta,
    clkb,
    rstb,
    enb,
    regceb,
    web,
    addrb,
    dinb,
    doutb,
    injectsbiterr,
    injectdbiterr,
    eccpipece,
    sbiterr,
    dbiterr,
    rdaddrecc,
    sleep,
    deepsleep,
    shutdown,
    rsta_busy,
    rstb_busy,
    s_aclk,
    s_aresetn,
    s_axi_awid,
    s_axi_awaddr,
    s_axi_awlen,
    s_axi_awsize,
    s_axi_awburst,
    s_axi_awvalid,
    s_axi_awready,
    s_axi_wdata,
    s_axi_wstrb,
    s_axi_wlast,
    s_axi_wvalid,
    s_axi_wready,
    s_axi_bid,
    s_axi_bresp,
    s_axi_bvalid,
    s_axi_bready,
    s_axi_arid,
    s_axi_araddr,
    s_axi_arlen,
    s_axi_arsize,
    s_axi_arburst,
    s_axi_arvalid,
    s_axi_arready,
    s_axi_rid,
    s_axi_rdata,
    s_axi_rresp,
    s_axi_rlast,
    s_axi_rvalid,
    s_axi_rready,
    s_axi_injectsbiterr,
    s_axi_injectdbiterr,
    s_axi_sbiterr,
    s_axi_dbiterr,
    s_axi_rdaddrecc);
  input clka;
  input rsta;
  input ena;
  input regcea;
  input [0:0]wea;
  input [7:0]addra;
  input [31:0]dina;
  output [31:0]douta;
  input clkb;
  input rstb;
  input enb;
  input regceb;
  input [0:0]web;
  input [7:0]addrb;
  input [31:0]dinb;
  output [31:0]doutb;
  input injectsbiterr;
  input injectdbiterr;
  input eccpipece;
  output sbiterr;
  output dbiterr;
  output [7:0]rdaddrecc;
  input sleep;
  input deepsleep;
  input shutdown;
  output rsta_busy;
  output rstb_busy;
  input s_aclk;
  input s_aresetn;
  input [3:0]s_axi_awid;
  input [31:0]s_axi_awaddr;
  input [7:0]s_axi_awlen;
  input [2:0]s_axi_awsize;
  input [1:0]s_axi_awburst;
  input s_axi_awvalid;
  output s_axi_awready;
  input [31:0]s_axi_wdata;
  input [0:0]s_axi_wstrb;
  input s_axi_wlast;
  input s_axi_wvalid;
  output s_axi_wready;
  output [3:0]s_axi_bid;
  output [1:0]s_axi_bresp;
  output s_axi_bvalid;
  input s_axi_bready;
  input [3:0]s_axi_arid;
  input [31:0]s_axi_araddr;
  input [7:0]s_axi_arlen;
  input [2:0]s_axi_arsize;
  input [1:0]s_axi_arburst;
  input s_axi_arvalid;
  output s_axi_arready;
  output [3:0]s_axi_rid;
  output [31:0]s_axi_rdata;
  output [1:0]s_axi_rresp;
  output s_axi_rlast;
  output s_axi_rvalid;
  input s_axi_rready;
  input s_axi_injectsbiterr;
  input s_axi_injectdbiterr;
  output s_axi_sbiterr;
  output s_axi_dbiterr;
  output [7:0]s_axi_rdaddrecc;

  wire \<const0> ;
  wire [7:0]addra;
  wire clka;
  wire [31:0]dina;
  wire [31:0]douta;
  wire ena;
  wire [0:0]wea;

  assign dbiterr = \<const0> ;
  assign doutb[31] = \<const0> ;
  assign doutb[30] = \<const0> ;
  assign doutb[29] = \<const0> ;
  assign doutb[28] = \<const0> ;
  assign doutb[27] = \<const0> ;
  assign doutb[26] = \<const0> ;
  assign doutb[25] = \<const0> ;
  assign doutb[24] = \<const0> ;
  assign doutb[23] = \<const0> ;
  assign doutb[22] = \<const0> ;
  assign doutb[21] = \<const0> ;
  assign doutb[20] = \<const0> ;
  assign doutb[19] = \<const0> ;
  assign doutb[18] = \<const0> ;
  assign doutb[17] = \<const0> ;
  assign doutb[16] = \<const0> ;
  assign doutb[15] = \<const0> ;
  assign doutb[14] = \<const0> ;
  assign doutb[13] = \<const0> ;
  assign doutb[12] = \<const0> ;
  assign doutb[11] = \<const0> ;
  assign doutb[10] = \<const0> ;
  assign doutb[9] = \<const0> ;
  assign doutb[8] = \<const0> ;
  assign doutb[7] = \<const0> ;
  assign doutb[6] = \<const0> ;
  assign doutb[5] = \<const0> ;
  assign doutb[4] = \<const0> ;
  assign doutb[3] = \<const0> ;
  assign doutb[2] = \<const0> ;
  assign doutb[1] = \<const0> ;
  assign doutb[0] = \<const0> ;
  assign rdaddrecc[7] = \<const0> ;
  assign rdaddrecc[6] = \<const0> ;
  assign rdaddrecc[5] = \<const0> ;
  assign rdaddrecc[4] = \<const0> ;
  assign rdaddrecc[3] = \<const0> ;
  assign rdaddrecc[2] = \<const0> ;
  assign rdaddrecc[1] = \<const0> ;
  assign rdaddrecc[0] = \<const0> ;
  assign rsta_busy = \<const0> ;
  assign rstb_busy = \<const0> ;
  assign s_axi_arready = \<const0> ;
  assign s_axi_awready = \<const0> ;
  assign s_axi_bid[3] = \<const0> ;
  assign s_axi_bid[2] = \<const0> ;
  assign s_axi_bid[1] = \<const0> ;
  assign s_axi_bid[0] = \<const0> ;
  assign s_axi_bresp[1] = \<const0> ;
  assign s_axi_bresp[0] = \<const0> ;
  assign s_axi_bvalid = \<const0> ;
  assign s_axi_dbiterr = \<const0> ;
  assign s_axi_rdaddrecc[7] = \<const0> ;
  assign s_axi_rdaddrecc[6] = \<const0> ;
  assign s_axi_rdaddrecc[5] = \<const0> ;
  assign s_axi_rdaddrecc[4] = \<const0> ;
  assign s_axi_rdaddrecc[3] = \<const0> ;
  assign s_axi_rdaddrecc[2] = \<const0> ;
  assign s_axi_rdaddrecc[1] = \<const0> ;
  assign s_axi_rdaddrecc[0] = \<const0> ;
  assign s_axi_rdata[31] = \<const0> ;
  assign s_axi_rdata[30] = \<const0> ;
  assign s_axi_rdata[29] = \<const0> ;
  assign s_axi_rdata[28] = \<const0> ;
  assign s_axi_rdata[27] = \<const0> ;
  assign s_axi_rdata[26] = \<const0> ;
  assign s_axi_rdata[25] = \<const0> ;
  assign s_axi_rdata[24] = \<const0> ;
  assign s_axi_rdata[23] = \<const0> ;
  assign s_axi_rdata[22] = \<const0> ;
  assign s_axi_rdata[21] = \<const0> ;
  assign s_axi_rdata[20] = \<const0> ;
  assign s_axi_rdata[19] = \<const0> ;
  assign s_axi_rdata[18] = \<const0> ;
  assign s_axi_rdata[17] = \<const0> ;
  assign s_axi_rdata[16] = \<const0> ;
  assign s_axi_rdata[15] = \<const0> ;
  assign s_axi_rdata[14] = \<const0> ;
  assign s_axi_rdata[13] = \<const0> ;
  assign s_axi_rdata[12] = \<const0> ;
  assign s_axi_rdata[11] = \<const0> ;
  assign s_axi_rdata[10] = \<const0> ;
  assign s_axi_rdata[9] = \<const0> ;
  assign s_axi_rdata[8] = \<const0> ;
  assign s_axi_rdata[7] = \<const0> ;
  assign s_axi_rdata[6] = \<const0> ;
  assign s_axi_rdata[5] = \<const0> ;
  assign s_axi_rdata[4] = \<const0> ;
  assign s_axi_rdata[3] = \<const0> ;
  assign s_axi_rdata[2] = \<const0> ;
  assign s_axi_rdata[1] = \<const0> ;
  assign s_axi_rdata[0] = \<const0> ;
  assign s_axi_rid[3] = \<const0> ;
  assign s_axi_rid[2] = \<const0> ;
  assign s_axi_rid[1] = \<const0> ;
  assign s_axi_rid[0] = \<const0> ;
  assign s_axi_rlast = \<const0> ;
  assign s_axi_rresp[1] = \<const0> ;
  assign s_axi_rresp[0] = \<const0> ;
  assign s_axi_rvalid = \<const0> ;
  assign s_axi_sbiterr = \<const0> ;
  assign s_axi_wready = \<const0> ;
  assign sbiterr = \<const0> ;
  GND GND
       (.G(\<const0> ));
  data_mem_gen_0_blk_mem_gen_v8_3_6_synth inst_blk_mem_gen
       (.addra(addra),
        .clka(clka),
        .dina(dina),
        .douta(douta),
        .ena(ena),
        .wea(wea));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_v8_3_6_synth" *) 
module data_mem_gen_0_blk_mem_gen_v8_3_6_synth
   (douta,
    clka,
    ena,
    addra,
    dina,
    wea);
  output [31:0]douta;
  input clka;
  input ena;
  input [7:0]addra;
  input [31:0]dina;
  input [0:0]wea;

  wire [7:0]addra;
  wire clka;
  wire [31:0]dina;
  wire [31:0]douta;
  wire ena;
  wire [0:0]wea;

  data_mem_gen_0_blk_mem_gen_top \gnbram.gnativebmg.native_blk_mem_gen 
       (.addra(addra),
        .clka(clka),
        .dina(dina),
        .douta(douta),
        .ena(ena),
        .wea(wea));
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
