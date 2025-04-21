vlib work
vlog async_fifo_gray_tb.sv
vsim tb +test_name=UNDERFLOW
#add wave -position insertpoint sim:/tb/dut/*
do asyncfifo_wave.do
run -all
