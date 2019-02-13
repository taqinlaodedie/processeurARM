vlib work

vcom -93 ../src/UAL.vhd
vcom -93 ../src/BancDeRegistres.vhd
vcom -93 ../src/ExtentionDeSigne.vhd
vcom -93 ../src/Multiplexeur2.vhd
vcom -93 ../src/MemoireDeDonnees.vhd
vcom -93 ../src/UniteTraitement.vhd
vcom -93 UniteTraitement_tb.vhd

vsim UniteTraitement_tb

view signals
add wave Clk
add wave busW
add wave OP
add wave Imm
add wave WE

run -all
