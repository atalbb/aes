@echo off
set xv_path=C:\\Xilinx\\Vivado\\2017.2\\bin
call %xv_path%/xsim aes_enc_tb_time_synth -key {Post-Synthesis:sim_1:Timing:aes_enc_tb} -tclbatch aes_enc_tb.tcl -view C:/College/Thesis/VivadoProjects/AES_encrypt/aes_enc_tb_behav1.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
