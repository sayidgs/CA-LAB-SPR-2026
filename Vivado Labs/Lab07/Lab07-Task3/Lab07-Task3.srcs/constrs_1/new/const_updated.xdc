## Clock (100 MHz on Basys3)
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.0 [get_ports clk]
#create_clock -period 10.000 -name sys_clk [get_ports clk]
#set_property PACKAGE_PIN W5 [get_ports clk]
#set_property IOSTANDARD LVCMOS33 [get_ports clk]



## Reset Button (BTNC)
set_property PACKAGE_PIN U18 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

## Start Button (BTNU)
set_property PACKAGE_PIN T18 [get_ports start]
set_property IOSTANDARD LVCMOS33 [get_ports start]

## Switches (SW0–SW3)
set_property PACKAGE_PIN V17 [get_ports {switches[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switches[0]}]

set_property PACKAGE_PIN V16 [get_ports {switches[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switches[1]}]

set_property PACKAGE_PIN W16 [get_ports {switches[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switches[2]}]

set_property PACKAGE_PIN W17 [get_ports {switches[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switches[3]}]


## LEDs (Result display)
set_property PACKAGE_PIN U16 [get_ports {leds[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[0]}]

set_property PACKAGE_PIN E19 [get_ports {leds[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[1]}]

set_property PACKAGE_PIN U19 [get_ports {leds[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[2]}]

set_property PACKAGE_PIN V19 [get_ports {leds[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[3]}]

set_property PACKAGE_PIN W18 [get_ports {leds[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[4]}]

set_property PACKAGE_PIN U15 [get_ports {leds[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[5]}]

set_property PACKAGE_PIN U14 [get_ports {leds[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[6]}]

set_property PACKAGE_PIN V14 [get_ports {leds[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[7]}]

set_property PACKAGE_PIN V13 [get_ports {leds[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[8]}]

set_property PACKAGE_PIN V3 [get_ports {leds[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[9]}]

set_property PACKAGE_PIN W3 [get_ports {leds[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[10]}]

set_property PACKAGE_PIN U3 [get_ports {leds[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[11]}]

#set_property PACKAGE_PIN P3 [get_ports {leds[12]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {leds[12]}]

#set_property PACKAGE_PIN N3 [get_ports {leds[13]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {leds[13]}]

#set_property PACKAGE_PIN P1 [get_ports {leds[14]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {leds[14]}]

#set_property PACKAGE_PIN L1 [get_ports {leds[15]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {leds[15]}]


## FSM State LEDs
set_property PACKAGE_PIN P3 [get_ports {state_led[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {state_led[0]}]

set_property PACKAGE_PIN N3 [get_ports {state_led[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {state_led[1]}]

set_property PACKAGE_PIN P1 [get_ports {state_led[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {state_led[2]}]

set_property PACKAGE_PIN L1 [get_ports {state_led[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {state_led[3]}]