# Lab 3, Task 1: answers

## (a)

For A (`<=`) and C (blocking assignments in reverse order), the three-stage shift-register values are the same. Values below are written `q1 q2 q3`.

| Edge | d | A: q1 q2 q3 | B: q1 q2 q3 | C: q1 q2 q3 |
|---:|:-:|:---:|:---:|:---:|
| 1 | 1 | 1xx | 111 | 1xx |
| 2 | 0 | 01x | 000 | 01x |
| 3 | 1 | 101 | 111 | 101 |
| 4 | 1 | 110 | 111 | 110 |
| 5 | 0 | 011 | 000 | 011 |

`B` updates `q1`, then immediately copies that new value to `q2` and `q3`, so all three outputs equal `d` after each edge. The first two C entries depend on the initial unknown register values; after enough edges, C matches A. (The reverse-order blocking implementation (C) has the same stage values as A.)

## (b)

A and C behave as three-stage shift registers. B does not: after every edge `q1 = q2 = q3 = d`. It describes three variables updated in sequence in one procedural block, not three independently delayed stages.

## (c)

With blocking assignments in separate `always` blocks, the output can depend on simulator scheduling because the language does not specify which triggered block runs first. Reordering the blocks can change the result. With non-blocking assignments, each right-hand side is evaluated before the scheduled updates take effect, so reordering the blocks does not change the intended shift-register behaviour.

## (d)

After edge 1, both implementations load `a=3, b=12`. With non-blocking assignments, subsequent edges swap the old values:

| Edge | `swap_nb` a,b |
|---:|---|
| 1 | 3, 12 |
| 2 | 12, 3 |
| 3 | 3, 12 |
| 4 | 12, 3 |

With blocking assignments, code like `a=b; b=a;` makes `b` read the already-updated `a`, so both become the old value of `b` rather than swapping.

## (e)

`shift4_nb` uses non-blocking assignments so each stage receives the previous stage's value from before the edge. `shift4_b` must assign in reverse order (`q[3]` down to `q[0]`) to preserve that behaviour with blocking assignments. Non-blocking assignments are the usual rule for clocked blocks because they model simultaneous flip-flop updates and avoid order-dependent bugs.
