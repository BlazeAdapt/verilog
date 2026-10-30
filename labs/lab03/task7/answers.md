# Lab 3, Task 7: answers

## (a)

The units digit is a mod-10 7493 counter. Decode 10 (`1010`) from `QD AND QB`, OR it with `rst`, and connect it to both units reset pins. The tens counter's `CKA_n` is clocked from units QA: QA falls on the units transition from 9 to 0, once every ten input pulses. Decode tens value 6 (`0110`) from `QC AND QB`, OR it with `rst`, and connect it to both tens reset pins. The visible tens output is `{QC,QB,QA}`.

## (b)

At the 59→00 transition, the units digit rolls from 9 to 0 and its QA falling edge clocks the tens counter. The tens digit reaches 6 transiently in the underlying ripple sequence only if the reset path is too late; the decode/reset should force it back to zero. Use the VCD waveform to list all transient displayed values and exact times, then report when both digits settle. Determine the minimum period by sweeping `T`, and restore `T=400`.
