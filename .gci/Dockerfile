ARG ARCH
FROM ${ARCH}/python:3.11.1-slim-buster

# Install several packages used to test and simulate HDL code.
# For example, install iverilog package used to compile
# verilog HDL code (https://packages.debian.org/buster/iverilog)
RUN apt-get update \
    && apt-get -y install --no-install-recommends make \
                                                  build-essential\
                                                  iverilog \
                                                  git \
    && apt-get clean \
    && pip install --upgrade pip \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pip install --no-cache-dir cocotb \
    pytest \
    crc==1.2.0

COPY src /fpga_waveform_generator/src
COPY testbenchs /fpga_waveform_generator/testbenchs

WORKDIR /fpga_waveform_generator/testbenchs
