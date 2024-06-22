# defaults
SIM?=icarus

TOPLEVEL_LANG?=verilog

COCOTB_HDL_TIMEPRECISION=1ns

COMPILE_ARGS += -P first_order_dac.CLOCK_FREQ_HZ=100000000

VERILOG_SOURCES=$(shell pwd)/../../src/first_order_dac.v

TOPLEVEL:=first_order_dac

MODULE:=test_first_order_dac

include $(shell cocotb-config --makefiles)/Makefile.sim
