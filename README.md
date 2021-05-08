# EELE468_FinalProject
Created my own custom sound effect in Simulink with control signals, converted it to VHDL, memory mapped it and controlled the registers using Linux.

The sound effect I chose to do was the chorus, and specifically made it a "Double Chorus". A chorus is done by modulating the input signal using a sine wave, so I did two separate modulations where the frequencies of the sine waves could be independently changed. The other control signals are:effect gain, volume, enable.
Once completed, the effect was converted into VHDL and memory mapped using the avalon interface. 
After being memory mapped and put on the FPGA, a driver was created for the sound effect, and linux scripts were used to control the sound effects control signals.
