@echo off
set xv_path=C:\\Xilinx\\Vivado\\2017.1\\bin
call %xv_path%/xsim tb_time_impl -key {Post-Implementation:sim_1:Timing:tb} -tclbatch tb.tcl -view C:/College/Thesis/AES_2018/AES_After 9_10_2018/aes256_pipeline_simulation/tb_behav.wcfg -view C:/College/Thesis/AES_2018/AES_After 9_10_2018/aes256_pipeline_simulation/tb_behav1.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
