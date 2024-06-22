import argparse
from typing import Union
import numpy as np
from numpy.typing import NDArray
import matplotlib.pyplot as plt

def create_wave_values(freq: Union[int, float], sampling_freq: Union[int, float],
                       samples_qty: int, bits: int
                       ) -> NDArray:
    """
    Create a sine wave of a given frequency (freq). It will be normalised

    :param freq: the frequency of the sine wave.
    :type freq: int or float
    :param sampling_freq: the frequency which will be sampled the sine.
    :type sampling_freq: int or float
    :param samples_qty: the quantity of samples to create.
    :type samples_qty: int
    :param bits: the quantity of bits used to discretize the signal.
    :type bits: int
    :return: a numpy array with the values of the sine.
    """
    t = np.linspace(0, samples_qty/sampling_freq, samples_qty, endpoint=False)

    # Generate the sine between 0 and 1
    normalized_wave = (np.sin(2 * np.pi * freq * t) + 1) / 2

    # Scale the wave upt o 2**(N-1)
    scaled_wave = normalized_wave * ((2**bits)-1)
    return scaled_wave.astype(np.int16)

def plot_wave(wave: NDArray):
    

def store_to_file(wave: NDArray, file: str):
    

def parse_args():
    parser = argparse.ArgumentParser(description="Utility to create a file with the values of a sine wave to modulate it.")
    parser.add_argument('--file', type=str, help="Output waveform signal file.")
    parser.add_argument('--freq', help="Frequency of the sine (in Hz).")
    parser.add_argument('--samples-qty', type=int, help="Quantity of samples of the wave.")
    parser.add_argument('--sampling-freq', help="Sampling frequency (in Hz).")
    parser.add_argument('--bits', help="The quantity of bits to discretize the signal.")
    return parser.parse_args()

if __name__ == "__main__":
    args = parse_args()
    wave = create_wave_values(args.freq, args.sampling_freq,
                              args.samples_qty, args.bits)
    store_to_file(wave, args.file)
