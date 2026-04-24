vlib work
vlog mux_pair.v
vlog dsp.v
vlog dsp_tb.v
vsim -voptargs=+acc work.dsp_tb
do wave.do;
# add wave *
run -all
#quit -sim