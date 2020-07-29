# Silent audio motion

Silent audio motion, the system behind «Ver no es hablar» artwork

## Description

The device generates the movement of a magnet according to an input audio signal. For this purpose the device generates a PWM signal with polarity (positive and negative half cycle) to excite an electromagnet. This signal is proportional to an analog input signal (audio source). It has two symmetrical channels and it responds to different frequencies, signal levels and waveforms.

This repository includes all the necessary files of this project: The 3D files to be printed, the control board of the device and its firmware.

### Technical features

- Supply voltage: 12VDC
- Frequency range: 1KHz-0.1Hz (firmware capability)
- Input voltage: up to 3Vpp
- Input impedance: 20kΩ

### Status LED

The device includes an LED to show the state it is in, these states are:

- Permanent LED indicates that there is no signal on either channel, the output driver is off.
- Slow blinking LED (~8Hz) indicates clipping on output, input level needs to be lowered or ADJ trimmer needs to be adjusted if not calibrated.
- Fast flashing LED (~30Hz) indicates input level too high, input level needs to be lowered, input stage may be damaged.
- LED off in normal operation.

The status LED may take up to one second to respond to changes in the input.

## Testing the device

### Output driver test

Load the `test_outputs` program. It should generate signals on both output channels. The test firmware can generate different output patterns.
The test is successful when the solenoid connected to each channel moves at the frequency set in code, with the selected waveform.

### Input stage test

Load the 'test_inputs' program. The cursor of the trimmers must not be at the ends. This program must show per port the three inputs of each channel (use serial plotter). Connect an audio source with a signal below 10Hz to both channels.

The test is successful when:

- The values of the first and fourth signals should be the values of the inputs of the left and right audio channels respectively.
- The values of the second and fifth signals should be the values of the ADJ trimmers, and should be different from the ends.
- The values of the third and sixth signals are a comparison of the negative half-cycle with the TRG trimmers, and should show a square signal centered on the peaks of the audio inputs. If this square signal does not appear, move the TRG trimmers until it does.

One of the input signal half-cycles may be slightly smaller than the other.

## Calibrating the device

Set the 3Hz and 3Vpp sine wave signal to channel L, with the program 'test_inputs' loaded.

Adjust the ADJ trimmer immediately above the peak of the input signal, and below the STANDBY_THRESHOLD threshold (default 900). A good value is 817. Turning it counterclockwise increases the value, and turning it clockwise decreases it.

Change the frequency to 0.5Hz. Adjust the ADJ trimmer until it is as close to zero as possible. It should be shown only during negative half-cycles. Values too low show square signals during both half-cycles. Values too high are far from zero on negative half-cycles.
A good adjustment is to lower it until it is below zero and to go up until the trigger disappears in the positive semicircle, then add a quarter turn more. Turning clockwise lowers the value, turning counterclockwise raises it.

Repeat the process with the R channel.

Enter signal on both channels, the setting signals must overlap.
