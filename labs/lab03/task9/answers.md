# Lab 3, Task 9: answers

## (a)

Use two 7474 D flip-flops. FF1 has D=`d`, clock=`clk`, and output `q1`. FF2 has D=`q1`, clock equal to the clock after N buffers, and output `q2`. Both active-low clear pins connect to `clr_n`; unused active-low preset pins are tied high. Each buffer is one 7408 AND gate with both inputs tied to the previous clock signal. Use a `generate` loop so N=0 bypasses the chain.

## (b)

Each 7408 buffer adds 10 ns, so the second flip-flop's clock edge arrives `10N ns` after FF1's edge. FF1's Q changes 20 ns after its edge. Compare the relative timing against the 74112/7474 hold time of 5 ns and setup time of 15 ns. Complete the table using the simulation output for N=0..4, including the case where data is wrong despite no warning.

## (c)

For the second flip-flop to avoid a hold violation, the data launched by FF1 must not reach FF2's D too soon relative to FF2's delayed clock. In the simple model this requires `t_skew <= t_pcq - t_h` for the no-hold-violation case; evaluate the strict boundary using the model's timing-check convention. A slower clock does not fix a hold violation because hold is a minimum-delay constraint within the same edge, not a maximum-frequency constraint.

## (d)

If FF1's clock is delayed instead, the data arrives at FF2 earlier relative to its clock. That may improve hold timing but worsens setup timing because FF2 has less time to receive stable data before its active edge. The cost is a tighter maximum clock frequency.
