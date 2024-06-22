# FPGA Waveform Generator

In this repository you will find an arbitrary waveform generator that can be implemented in a FPGA.

## 1-bit DAC

This generator uses a 1-bit DAC to generate the specified waveform. The 1-bit DAC is designed using Sigma-Delta modulation.

First of all, the input waveform should have a dynamic range of 16 bits (from 0 to 65535). This input waveform will be sampled in each clock cycle.
