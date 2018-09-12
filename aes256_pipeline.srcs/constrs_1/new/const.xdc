# Mapping CLK
set_property IOSTANDARD LVCMOS33 [get_ports clkIn]
set_property PACKAGE_PIN E3 [get_ports clkIn]
# Mapping RESET
set_property IOSTANDARD LVCMOS33 [get_ports resetIn]
set_property PACKAGE_PIN U9 [get_ports resetIn] 

set_property IOSTANDARD LVCMOS33 [get_ports {startIn[0]}]
set_property PACKAGE_PIN U8 [get_ports {startIn[0]}]

set_property IOSTANDARD LVCMOS33 [get_ports {startIn[1]}]
set_property PACKAGE_PIN R7 [get_ports {startIn[1]}]

set_property IOSTANDARD LVCMOS33 [get_ports {txDReady}]
set_property PACKAGE_PIN R6 [get_ports {txDReady}]

#Mapping outputs
set_property IOSTANDARD LVCMOS33 [get_ports {txD}]
set_property PACKAGE_PIN D4 [get_ports {txD}]

set_property IOSTANDARD LVCMOS33 [get_ports {finalDone}]
set_property PACKAGE_PIN T8 [get_ports {finalDone}]