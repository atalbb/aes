# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {Common 17-41} -limit 10000000
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir C:/College/Thesis/VivadoProjects/AES/AES.cache/wt [current_project]
set_property parent.project_path C:/College/Thesis/VivadoProjects/AES/AES.xpr [current_project]
set_property XPM_LIBRARIES XPM_MEMORY [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part digilentinc.com:nexys4:part0:1.1 [current_project]
set_property ip_output_repo c:/College/Thesis/VivadoProjects/AES/AES.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
add_files c:/College/Thesis/VivadoProjects/AES/Key.coe
read_verilog -library xil_defaultlib {
  C:/College/Thesis/VivadoProjects/AES/AES.srcs/sources_1/new/KeyIn.v
  C:/College/Thesis/VivadoProjects/AES/AES.srcs/sources_1/new/counter.v
  C:/College/Thesis/VivadoProjects/AES/AES.srcs/sources_1/new/key_expansion.v
  C:/College/Thesis/VivadoProjects/AES/AES.srcs/sources_1/new/top.v
}
read_ip -quiet c:/College/Thesis/VivadoProjects/AES/AES.srcs/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0.xci
set_property used_in_implementation false [get_files -all c:/College/Thesis/VivadoProjects/AES/AES.srcs/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0_ooc.xdc]
set_property is_locked true [get_files c:/College/Thesis/VivadoProjects/AES/AES.srcs/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0.xci]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}

synth_design -top top -part xc7a100tcsg324-1


write_checkpoint -force -noxdef top.dcp

catch { report_utilization -file top_utilization_synth.rpt -pb top_utilization_synth.pb }
