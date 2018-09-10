# Mapping CLK
set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property PACKAGE_PIN E3 [get_ports clk]
# Mapping RESET
set_property IOSTANDARD LVCMOS33 [get_ports rst]
set_property PACKAGE_PIN U9 [get_ports rst] 

set_property IOSTANDARD LVCMOS33 [get_ports {decrypt_i}]
set_property PACKAGE_PIN U8 [get_ports {decrypt_i}]

set_property IOSTANDARD LVCMOS33 [get_ports {start}]
set_property PACKAGE_PIN R7 [get_ports {start}]

set_property IOSTANDARD LVCMOS33 [get_ports {ready}]
set_property PACKAGE_PIN R6 [get_ports {ready}]

#Mapping outputs
set_property IOSTANDARD LVCMOS33 [get_ports {TxD}]
set_property PACKAGE_PIN D4 [get_ports {TxD}]

set_property IOSTANDARD LVCMOS33 [get_ports {finalDone}]
set_property PACKAGE_PIN T8 [get_ports {finalDone}]

