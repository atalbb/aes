# Mapping CLK
set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property PACKAGE_PIN E3 [get_ports clk]
# Mapping RESET
set_property IOSTANDARD LVCMOS33 [get_ports rst]
set_property PACKAGE_PIN U9 [get_ports rst] 

set_property IOSTANDARD LVCMOS33 [get_ports {enHashIn}]
set_property PACKAGE_PIN U8 [get_ports {enHashIn}]

set_property IOSTANDARD LVCMOS33 [get_ports {ready}]
set_property PACKAGE_PIN R7 [get_ports {ready}]

set_property IOSTANDARD LVCMOS33 [get_ports {led0}]
set_property PACKAGE_PIN T8 [get_ports {led0}]

#set_property IOSTANDARD LVCMOS33 [get_ports {led1}]
#set_property PACKAGE_PIN V9 [get_ports {led1}]

#Mapping outputs
set_property IOSTANDARD LVCMOS33 [get_ports {TxD}]
set_property PACKAGE_PIN D4 [get_ports {TxD}]


set_property IOSTANDARD LVCMOS33 [get_ports {ledout[7]}]
set_property PACKAGE_PIN P2 [get_ports {ledout[7]}]

set_property IOSTANDARD LVCMOS33 [get_ports {ledout[6]}]
set_property PACKAGE_PIN R2 [get_ports {ledout[6]}]

set_property IOSTANDARD LVCMOS33 [get_ports {ledout[5]}]
set_property PACKAGE_PIN U1 [get_ports {ledout[5]}]

set_property IOSTANDARD LVCMOS33 [get_ports {ledout[4]}]
set_property PACKAGE_PIN P5 [get_ports {ledout[4]}]

set_property IOSTANDARD LVCMOS33 [get_ports {ledout[3]}]
set_property PACKAGE_PIN R1 [get_ports {ledout[3]}]

set_property IOSTANDARD LVCMOS33 [get_ports {ledout[2]}]
set_property PACKAGE_PIN V1 [get_ports {ledout[2]}]

set_property IOSTANDARD LVCMOS33 [get_ports {ledout[1]}]
set_property PACKAGE_PIN U3 [get_ports {ledout[1]}]

set_property IOSTANDARD LVCMOS33 [get_ports {ledout[0]}]
set_property PACKAGE_PIN V4 [get_ports {ledout[0]}]