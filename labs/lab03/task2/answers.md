# Lab 3, Task 2: answers

## (a)

- `sh_nb`: three flip-flops; `q2` is driven by the old `q1`, and `q3` by the old `q2`.
- `sh_b`: blocking assignments in forward order cause all three outputs to take `d` in the same event; synthesis can collapse the redundant stages.
- `sh_b_rev`: three flip-flops; reverse-order blocking assignments preserve the shift-register relationship.

This agrees with Task 1.

## (b)

`tmp_first` assigns `t = a & b` before `y <= t | c`, so the new combinational value of `t` is used by `y`; `t` need not be stored as a separate flip-flop. In `tmp_last`, `y` reads the old value of `t` before `t` is updated, so `t` must retain its value across clock edges and becomes a flip-flop. A variable assigned with `=` in a clocked block becomes storage when its old value is needed across clock events.

## (c)

`comb_if` infers a latch because `q` is not assigned when `en=0`; it holds its old value then. `comb_case` infers a latch for the unhandled `sel=2'b11` case. `comb_case_default` assigns `y` for every selector value and does not need a latch.

## (d)

`cnt_async` uses `always @(posedge clk or negedge rst_n)`, so reset acts immediately through an asynchronous reset pin. `cnt_sync` checks reset only at `posedge clk`, so reset takes effect at the next clock edge. In synthesis, the asynchronous version appears as a flip-flop with an asynchronous reset; the synchronous version has reset logic in the data path.

## (e)

The original edge detector leaves `prev` uninitialized, so the first comparison may be unknown and synthesis can infer unintended storage for `pulse` if it is not assigned on every path. Initializing `prev` to zero and assigning `pulse` on every rising edge gives `pulse <= btn & ~prev; prev <= btn;`. The output is high for one clock when `btn` changes from 0 to 1.

## (f)

The priority encoder must assign both `y` and `valid` for every input combination. The `else` case sets `y=0` and `valid=0`, so no latch is required. Priority is `r[3]`, then `r[2]`, then `r[1]`, then `r[0]`; the highest-numbered asserted request wins.

**Sketches:** The manual asks for hand-drawn circuit sketches based on the Yosys synthesis drawings. Add your own labelled sketches or images here; textual descriptions alone do not replace the requested drawings.
