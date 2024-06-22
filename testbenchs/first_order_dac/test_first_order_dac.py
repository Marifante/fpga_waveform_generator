import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer


CLOCK_FREQ_HZ   = 100*1e6
CLOCK_PERIOD_NS = 1e9/CLOCK_FREQ_HZ
BAUDRATE        = 921600
CLKS_PER_BIT    = int(CLOCK_FREQ_HZ/BAUDRATE)


async def reset_dut(sync_reset, duration, time_unit):
    sync_reset._log.info("Touching the reset button of the DUT! ({}{})".format(duration, time_unit))
    sync_reset.value = 1
    await Timer(duration, units=time_unit)
    sync_reset.value = 0
    sync_reset._log.info("The reset was completed!")

@cocotb.test()
async def test_first_order_dac__simple(dut):
    """
    Do a simple test of the first order dac module.
    """
    dut._log.info("Starting First order DAC simple testbench")
    clock = Clock(dut.i_clk, CLOCK_PERIOD_NS, units='ns')
    cocotb.start_soon(clock.start())

    dut.i_ce.value = 1 # active is high
    dut.i_func.value = 3300
    await reset_dut(dut.i_rst, CLOCK_PERIOD_NS, 'ns')

    await Timer(10*CLOCK_PERIOD_NS, units="ns")
