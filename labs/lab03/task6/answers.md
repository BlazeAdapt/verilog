# Lab 3, Task 6: answers

## (a)

The required sequence is `001 → 010 → 101 → 111 → 001`. Use three 74112 JK flip-flops, all clocked by `clk` (falling edge). Connect `pre_n[i]` and `clr_n[i]` directly to the corresponding flip-flop's active-low preset and clear. Derive each J/K excitation from the state table and choose unused-state transitions that lead back to the main sequence.

## (b)

The testbench forces all eight states by asserting preset for each bit that should be 1 and clear for each bit that should be 0. Change preset/clear only while the clock is high, hold for at least 50 ns, release, and then apply five clock pulses. Include the printed sequence for each starting state.

## (c)

The main cycle is `001 → 010 → 101 → 111 → 001`. To determine self-correction, trace transitions from `000`, `011`, `100`, and `110` using your chosen JK equations. The design is self-correcting if each of these states reaches the four-state cycle; report the longest number of pulses required based on your simulation.
