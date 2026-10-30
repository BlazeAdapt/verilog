# Lab 3, Task 5: answers

## (a)

For a 4-bit synchronous up-counter, the next-state equations are:

- D0 = NOT Q0
- D1 = Q1 XOR Q0
- D2 = Q2 XOR (Q1 AND Q0)
- D3 = Q3 XOR (Q2 AND Q1 AND Q0)

All four 7474 flip-flops share `clk`. Their active-low clear pins connect to `clr_n`; unused preset pins are tied inactive high. Draw the actual gate-level implementation and label each D equation.

## (b)

All flip-flops update 20 ns after the rising edge in the provided model. Since all outputs share the same clock and have the same clock-to-Q delay, the count changes together after the edge rather than rippling one stage at a time. Compare this with the sequence of intermediate values in Task 4(c).

## (c)

Find the longest path from a flip-flop output through the gate chain to a D input. The timing requirement is approximately `T >= t_pcq + t_gate_path + t_su`. Use the actual gates in your implementation and the measured frequency sweep in Task 8 to record the path and predicted minimum period.
