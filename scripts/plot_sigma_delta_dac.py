import argparse
from typing import Union


def read_waveform_file(wave_file: str, freq: Union[int, float]) -> tuple:
    return analog_signal, sigma_delta_output


def plot_waveform(analog_signal: list, sigma_delta_output: list) -> None:


def parse_args():
    parser = argparse.ArgumentParser(description="Utility to plot sigma delta DAC behavior from a wave file.")
    parser.add_argument('--file', type=str, help="Waveform signal file.")
    parser.add_argument('--freq', help="Frequency of the modulator (in Hz).")
    return parser.parse_args()

if __name__ == "__main__":
    
    args = parse_args()
    analog_signal, sigma_delta_output = read_waveform_file(args.file, args.freq)
    plot_waveform(analog_signal, sigma_delta_output)
