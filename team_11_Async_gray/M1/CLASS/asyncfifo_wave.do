onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /tb/dut/rst
add wave -noupdate -radix unsigned /tb/dut/clk_w
add wave -noupdate -radix unsigned /tb/dut/wr_en
add wave -noupdate -radix unsigned /tb/dut/wptr
add wave -noupdate -radix unsigned /tb/dut/wdata
add wave -noupdate -radix unsigned /tb/dut/full
add wave -noupdate -radix unsigned /tb/dut/overflow
add wave -noupdate -radix unsigned /tb/dut/rptr_wr_clk
add wave -noupdate -radix unsigned /tb/dut/wr_toggle
add wave -noupdate -radix unsigned /tb/dut/rd_toggle_wr_clk
add wave -noupdate -radix unsigned /tb/dut/clk_r
add wave -noupdate -radix unsigned /tb/dut/rd_en
add wave -noupdate -radix unsigned /tb/dut/rdata
add wave -noupdate -radix unsigned /tb/dut/rptr
add wave -noupdate -radix unsigned /tb/dut/empty
add wave -noupdate -radix unsigned /tb/dut/underflow
add wave -noupdate -radix unsigned /tb/dut/wr_toggle_rd_clk
add wave -noupdate -radix unsigned /tb/dut/rd_toggle
add wave -noupdate -radix unsigned /tb/dut/wptr_rd_clk
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ps} {282 ps}
