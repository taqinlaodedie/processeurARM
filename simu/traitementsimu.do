vlib work

vcom -93 ../src/UAL.vhd
vcom -93 ../src/BancDeRegistres.vhd
vcom -93 ../src/UniteTraitement.vhd
vcom -93 UniteTraitement_tb.vhd

vsim UniteTraitement_tb

view signals
add wave Clk
add wave Reset
add wave busW
add wave OP

run -all
