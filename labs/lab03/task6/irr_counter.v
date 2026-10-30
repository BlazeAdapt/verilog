// irr_counter.v -- YOU write this.
// Counter 001 -> 010 -> 101 -> 111 -> 001 ... (q = Q2 Q1 Q0) from IC 74112 JK flip-flops (+ gates if needed). pre_n[i] / clr_n[i] go straight to PRE_n / CLR_n of the flip-flop that drives q[i].
`timescale 1ns/1ps
module irr_counter(input clk, input [2:0] pre_n, input [2:0] clr_n, output [2:0] q);
  wire q0, q1, q2;
  wire nq0, nq1, nq2;
  wire nq0_n, nq1_n, nq2_n;
  wire t0, t1, t2, t3;

  // next-state logic for 001 -> 010 -> 101 -> 111 -> 001 ...
  assign nq0 = ~(~q2 & ~q1 & q0);
  assign nq1 = (~q1 & q0) | (q2 & q1 & ~q0);
  assign nq2 = (~q2 & q1 & ~q0) | (q2 & ~q1 & ~q0) | (q2 & ~q1 & q0) | (q2 & q1 & ~q0);

  // JK excitation: J = next, K = ~next
  assign nq0_n = ~nq0;
  assign nq1_n = ~nq1;
  assign nq2_n = ~nq2;

  ic74112 U0 (.J1(nq0), .K1(nq0_n), .CLK1(clk), .PRE1_n(pre_n[0]), .CLR1_n(clr_n[0]),
              .J2(nq1), .K2(nq1_n), .CLK2(clk), .PRE2_n(pre_n[1]), .CLR2_n(clr_n[1]),
              .Q1(q0), .Q2(q1));
  ic74112 U1 (.J1(nq2), .K1(nq2_n), .CLK1(clk), .PRE1_n(pre_n[2]), .CLR1_n(clr_n[2]),
              .J2(1'b0), .K2(1'b0), .CLK2(1'b0), .PRE2_n(1'b1), .CLR2_n(1'b1),
              .Q1(q2), .Q2());

  assign q = {q2, q1, q0};
endmodule
