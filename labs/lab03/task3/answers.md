# Lab 3, Task 3: answers

## (a)

For `0110`, use states representing the longest matched prefix: S0 = none, S1 = `0`, S2 = `01`, S3 = `011`. Reset enters S0. The Mealy output is 1 only when the current state is S3 and the current input is 0. After detecting `0110`, go to S1 because the final `0` can begin the next match.

| State | x=0: next/output | x=1: next/output |
|---|---|---|
| S0 | S1 / 0 | S0 / 0 |
| S1 | S1 / 0 | S2 / 0 |
| S2 | S1 / 0 | S3 / 0 |
| S3 | S1 / 1 | S0 / 0 |

With encoding S0=00, S1=01, S2=10, S3=11, the equations should be derived from this table and verified against the provided `det_df` implementation. Include your K-maps and circuit sketch in the submission.

## (b)

The behavioural implementation uses a state register with asynchronous active-low reset, a `case` statement for the next state, and combinational output logic. It implements the same transition table as the dataflow version.

## (c)

The testbench should use a 10 ns clock, keep reset low for 12 ns, and change `x` only on falling edges. It should compute expected output from a separate history shift register, not from either detector. Initialize history to `4'b1111` (or another value that cannot equal `0110`/`0101` before enough real bits have arrived), and compare after each input change. Include overlapping `0110110`, near misses, and a marker immediately after reset. The expected output for `0110` is 1 exactly when the latest four received bits equal `0110`.

## (d)

For `0101`, use states S0 = none, S1 = `0`, S2 = `01`, S3 = `010`. Output is 1 in S3 when the current input is 1. After a detection, return to S2 because the final `01` is a prefix of another match. The behavioural implementation changes the state transitions/output condition; the dataflow implementation requires new next-state/output equations and K-maps.

## (e)

A Moore detector needs five states: the four partial-match states plus a detection state. Its output is high only in the detection state, so it rises after the clock edge that stores the completed-pattern state, one state transition later than the Mealy output. A Mealy output can respond combinationally to a change in `x` while the clock cycle is in progress; a Moore output changes only when the state changes.

**Waveform evidence:** Add your measured comparison from the simulation and a state diagram/K-maps. The testbench and waveform are part of the manual requirements.
