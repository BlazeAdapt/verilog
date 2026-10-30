# Lab 3, Task 8: answers

## (a)

The synchronous timing estimate is `T_min ≈ t_pcq + t_gate_path + t_su`. With `t_pcq=20 ns` and `t_su=15 ns`, add the delay of the longest gate path in your Task 5 design. The maximum frequency is `f_max = 1/T_min`.

## (b)

The testbench sweeps T from 100 ns down to 40 ns, clears the counter for each attempt, checks 20 rising edges, and treats any unknown (`x`) output as a failure. The final line must be exactly `RESULT: Tmin = <value> ns`.

## (c)

At the first failing period, identify the flip-flop whose D input changes within the 15 ns setup window. Include the simulator's setup-violation message and explain it using the measured clock-to-Q and gate delays.

## (d)

A ripple counter's delay grows with the number of cascaded stages because each stage waits for the previous stage's output. A synchronous counter updates all bits from a common clock, so its critical delay is dominated by clock-to-Q plus the longest combinational gate path and setup time. For 16 bits, the ripple design's delay grows roughly with the number of stages, while the synchronous design grows with the depth of its carry-detection logic.
