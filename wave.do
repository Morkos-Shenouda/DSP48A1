onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dsp_tb/clk
add wave -noupdate -divider Inputs
add wave -noupdate -radix decimal /dsp_tb/A
add wave -noupdate -radix decimal /dsp_tb/B
add wave -noupdate -radix decimal /dsp_tb/C
add wave -noupdate -radix decimal /dsp_tb/D
add wave -noupdate /dsp_tb/CARRYIN
add wave -noupdate /dsp_tb/BCIN
add wave -noupdate /dsp_tb/PCIN
add wave -noupdate -divider Outputs
add wave -noupdate /dsp_tb/M
add wave -noupdate /dsp_tb/P
add wave -noupdate /dsp_tb/CARRYOUT
add wave -noupdate /dsp_tb/CARRYOUTF
add wave -noupdate -divider {opmode & enable}
add wave -noupdate /dsp_tb/OPMODE
add wave -noupdate /dsp_tb/CEA
add wave -noupdate /dsp_tb/CEB
add wave -noupdate /dsp_tb/CEC
add wave -noupdate /dsp_tb/CECARRYIN
add wave -noupdate /dsp_tb/CED
add wave -noupdate /dsp_tb/CEM
add wave -noupdate /dsp_tb/CEOPMODE
add wave -noupdate /dsp_tb/CEP
add wave -noupdate -divider rst
add wave -noupdate /dsp_tb/RSTA
add wave -noupdate /dsp_tb/RSTB
add wave -noupdate /dsp_tb/RSTC
add wave -noupdate /dsp_tb/RSTCARRYIN
add wave -noupdate /dsp_tb/RSTD
add wave -noupdate /dsp_tb/RSTM
add wave -noupdate /dsp_tb/RSTOPMODE
add wave -noupdate /dsp_tb/RSTP
add wave -noupdate -divider outputs
add wave -noupdate /dsp_tb/BCOUT
add wave -noupdate /dsp_tb/PCOUT
add wave -noupdate /dsp_tb/p_out_last
add wave -noupdate /dsp_tb/carryout_last
add wave -noupdate -divider debug
add wave -noupdate /dsp_tb/dut/A0_reg
add wave -noupdate /dsp_tb/dut/A1_reg
add wave -noupdate /dsp_tb/dut/B0_reg
add wave -noupdate /dsp_tb/dut/B1_Reg
add wave -noupdate /dsp_tb/dut/C_reg
add wave -noupdate /dsp_tb/dut/D_reg
add wave -noupdate /dsp_tb/dut/M_reg
add wave -noupdate /dsp_tb/dut/P_reg
add wave -noupdate /dsp_tb/dut/CARRYIN_reg
add wave -noupdate /dsp_tb/dut/CARRYOUT_reg
add wave -noupdate /dsp_tb/dut/opmode_reg
add wave -noupdate /dsp_tb/dut/Bin
add wave -noupdate /dsp_tb/dut/pre_adder_subtracter
add wave -noupdate /dsp_tb/dut/post_adder_subtracter
add wave -noupdate /dsp_tb/dut/CARRYOUT_post_adder_subtracter
add wave -noupdate /dsp_tb/dut/CARRYIN_mux
add wave -noupdate /dsp_tb/dut/x_out
add wave -noupdate /dsp_tb/dut/z_out
add wave -noupdate /dsp_tb/dut/c
add wave -noupdate /dsp_tb/dut/multiplier_out
add wave -noupdate /dsp_tb/dut/A
add wave -noupdate /dsp_tb/dut/B
add wave -noupdate /dsp_tb/dut/C
add wave -noupdate /dsp_tb/dut/D
add wave -noupdate /dsp_tb/dut/CARRYIN
add wave -noupdate /dsp_tb/dut/BCIN
add wave -noupdate /dsp_tb/dut/clk
add wave -noupdate /dsp_tb/dut/OPMODE
add wave -noupdate /dsp_tb/dut/CEA
add wave -noupdate /dsp_tb/dut/CEB
add wave -noupdate /dsp_tb/dut/CEC
add wave -noupdate /dsp_tb/dut/CECARRYIN
add wave -noupdate /dsp_tb/dut/CED
add wave -noupdate /dsp_tb/dut/CEM
add wave -noupdate /dsp_tb/dut/CEOPMODE
add wave -noupdate /dsp_tb/dut/CEP
add wave -noupdate /dsp_tb/dut/RSTA
add wave -noupdate /dsp_tb/dut/RSTB
add wave -noupdate /dsp_tb/dut/RSTC
add wave -noupdate /dsp_tb/dut/RSTCARRYIN
add wave -noupdate /dsp_tb/dut/RSTD
add wave -noupdate /dsp_tb/dut/RSTM
add wave -noupdate /dsp_tb/dut/RSTOPMODE
add wave -noupdate /dsp_tb/dut/RSTP
add wave -noupdate /dsp_tb/dut/BCOUT
add wave -noupdate /dsp_tb/dut/PCIN
add wave -noupdate /dsp_tb/dut/PCOUT
add wave -noupdate /dsp_tb/dut/A0_reg
add wave -noupdate /dsp_tb/dut/A1_reg
add wave -noupdate /dsp_tb/dut/B0_reg
add wave -noupdate /dsp_tb/dut/B1_Reg
add wave -noupdate /dsp_tb/dut/C_reg
add wave -noupdate /dsp_tb/dut/D_reg
add wave -noupdate /dsp_tb/dut/M_reg
add wave -noupdate /dsp_tb/dut/P_reg
add wave -noupdate /dsp_tb/dut/CARRYIN_reg
add wave -noupdate /dsp_tb/dut/CARRYOUT_reg
add wave -noupdate /dsp_tb/dut/opmode_reg
add wave -noupdate /dsp_tb/dut/Bin
add wave -noupdate /dsp_tb/dut/pre_adder_subtracter
add wave -noupdate /dsp_tb/dut/post_adder_subtracter
add wave -noupdate /dsp_tb/dut/CARRYOUT_post_adder_subtracter
add wave -noupdate /dsp_tb/dut/CARRYIN_mux
add wave -noupdate /dsp_tb/dut/x_out
add wave -noupdate /dsp_tb/dut/z_out
add wave -noupdate /dsp_tb/dut/c
add wave -noupdate /dsp_tb/dut/multiplier_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1005 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {1134 ns}
