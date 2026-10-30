# Lab 3, Task 4: answers

## (a)

Wire the 7493 `QA` output to `CKB_n`, and connect the external clock to `CKA_n`. Connect `rst` to both active-high reset inputs. The counter cycles from 0 to 15 and repeats. QA has period 2T, QB 4T, QC 8T, and QD 16T. It can also act as a frequency divider.

## (b)

The BCD counter decodes decimal 10 (`1010`) using `QD AND QB`. OR this decode with `rst` and connect the result to both 7493 reset inputs. The counter then resets to zero after reaching 10, producing the sequence 0 through 9.

## (c)

For the mod-16 transition 7→8, the ripple transitions occur approximately at +15 ns per stage: `0111 → 0110 → 0100 → 0000 → 1000` at +15, +30, +45, and +60 ns. For the BCD transition 9→0, the intermediate count 10 (`1010`) appears after the QA and QB propagation delays; the decode and asynchronous-reset path then clears the outputs. Confirm the exact transition timestamps and the duration of the transient count in your own VCD waveform and include them here.

A decoded “count = 8” can glitch during ripple transitions because the outputs do not change simultaneously. Use the waveform to list each transition in which the decode is momentarily true and its duration.

## (d)

The period must be long enough that the outputs have settled before the testbench reads them. The four-stage ripple path has up to four 15 ns stages (about 60 ns), so the period must be longer than the propagation path plus the testbench's 1 ns margin. The BCD counter adds a decode gate and reset propagation, so its worst-case limit can be longer. Record the smallest passing period for each counter from your own sweep, explain it from the delays, and restore `T=400`.
