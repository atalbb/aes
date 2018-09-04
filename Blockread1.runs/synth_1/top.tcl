# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir C:/College/Thesis/AES_2018/AES_ENC_MEM/Blockread1.cache/wt [current_project]
set_property parent.project_path C:/College/Thesis/AES_2018/AES_ENC_MEM/Blockread1.xpr [current_project]
set_property XPM_LIBRARIES XPM_MEMORY [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part digilentinc.com:nexys4:part0:1.1 [current_project]
set_property ip_output_repo c:/College/Thesis/AES_2018/AES_ENC_MEM/Blockread1.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
add_files C:/College/Thesis/AES_2018/AES_ENC_MEM/key.coe
add_files C:/College/Thesis/AES_2018/AES_ENC_MEM/data.coe
read_verilog -library xil_defaultlib {
  C:/College/Thesis/AES_2018/AES_ENC_MEM/Blockread1.srcs/sources_1/new/HashIn.v
  C:/College/Thesis/AES_2018/AES_ENC_MEM/Blockread1.srcs/sources_1/new/core_logic.v
  C:/College/Thesis/AES_2018/AES_ENC_MEM/Blockread1.srcs/sources_1/new/counter.v
  C:/College/Thesis/AES_2018/AES_ENC_MEM/Blockread1.srcs/sources_1/new/dataIn.v
  C:/College/Thesis/AES_2018/AES_ENC_MEM/Blockread1.srcs/sources_1/new/uart_tx.v
  C:/College/Thesis/AES_2018/AES_ENC_MEM/Blockread1.srcs/sources_1/new/top.v
}
read_ip -quiet C:/College/Thesis/AES_2018/AES_ENC_MEM/Blockread1.srcs/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0.xci
set_property used_in_implementation false [get_files -all c:/College/Thesis/AES_2018/AES_ENC_MEM/Blockread1.srcs/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0_ooc.xdc]
set_property is_locked true [get_files C:/College/Thesis/AES_2018/AES_ENC_MEM/Blockread1.srcs/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0.xci]

read_ip -quiet C:/College/Thesis/AES_2018/AES_ENC_MEM/Blockread1.srcs/sources_1/ip/blk_mem_gen_1/blk_mem_gen_1.xci
set_property used_in_implementation false [get_files -all c:/College/Thesis/AES_2018/AES_ENC_MEM/Blockread1.srcs/sources_1/ip/blk_mem_gen_1/blk_mem_gen_1_ooc.xdc]
set_property is_locked true [get_files C:/College/Thesis/AES_2018/AES_ENC_MEM/Blockread1.srcs/sources_1/ip/blk_mem_gen_1/blk_mem_gen_1.xci]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/College/Thesis/AES_2018/AES_ENC_MEM/Blockread1.srcs/constrs_1/new/constr.xdc
set_property used_in_implementation false [get_files C:/College/Thesis/AES_2018/AES_ENC_MEM/Blockread1.srcs/constrs_1/new/constr.xdc]


synth_design -top top -part xc7a100tcsg324-1


write_checkpoint -force -noxdef top.dcp

catch { report_utilization -file top_utilization_synth.rpt -pb top_utilization_synth.pb }
