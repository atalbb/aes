#!/bin/sh

# 
# Vivado(TM)
# runme.sh: a Vivado-generated Runs Script for UNIX
# Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
# 

echo "This script was generated under a different operating system."
echo "Please update the PATH and LD_LIBRARY_PATH variables below, before executing this script"
exit

if [ -z "$PATH" ]; then
  PATH=C:/Xilinx/SDK/2017.1/bin;C:/Xilinx/Vivado/2017.1/ids_lite/ISE/bin/nt64;C:/Xilinx/Vivado/2017.1/ids_lite/ISE/lib/nt64:C:/Xilinx/Vivado/2017.1/bin
else
  PATH=C:/Xilinx/SDK/2017.1/bin;C:/Xilinx/Vivado/2017.1/ids_lite/ISE/bin/nt64;C:/Xilinx/Vivado/2017.1/ids_lite/ISE/lib/nt64:C:/Xilinx/Vivado/2017.1/bin:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=
else
  LD_LIBRARY_PATH=:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD='C:/College/Thesis/AES_2018/AES_After 9_10_2018/aes256_pipeline/aes256_pipeline.runs/key_mem_gen_0_synth_1'
cd "$HD_PWD"

HD_LOG=runme.log
/bin/touch $HD_LOG

ISEStep="./ISEWrap.sh"
EAStep()
{
     $ISEStep $HD_LOG "$@" >> $HD_LOG 2>&1
     if [ $? -ne 0 ]
     then
         exit
     fi
}

EAStep vivado -log key_mem_gen_0.vds -m64 -product Vivado -mode batch -messageDb vivado.pb -notrace -source key_mem_gen_0.tcl
