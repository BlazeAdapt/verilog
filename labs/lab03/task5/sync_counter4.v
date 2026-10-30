// sync_counter4.v -- YOU write this.
// 4-bit SYNCHRONOUS up counter from IC 7474 D flip-flops and gate chips in chips.v. q[0] is the LSB. clr_n (active LOW) clears all flip-flops.
`timescale 1ns/1ps
module sync_counter4(input clk, input clr_n, output [3:0] q);
  wire q0, q1, q2, q3;
  wire q0_n, carry2, carry3, t3;
  wire d0, d1, d2, d3;

  ic7404 Uinv0 (.A1(q0), .Y1(q0_n));
  assign d0 = q0_n;

  ic7408 Uand2 (.A1(q1), .B1(q0), .Y1(carry2));
  ic7486 Uxor1 (.A1(q1), .B1(q0), .Y1(d1));

  ic7408 Uand3a (.A1(q2), .B1(q1), .Y1(t3));
  ic7408 Uand3b (.A1(t3), .B1(q0), .Y1(carry3));
  ic7486 Uxor2 (.A1(q2), .B1(carry2), .Y1(d2));

  ic7486 Uxor3 (.A1(q3), .B1(carry3), .Y1(d3));

  ic7474 Uff0 (.D1(d0), .CLK1(clk), .PRE1_n(1'b1), .CLR1_n(clr_n),
               .D2(d1), .CLK2(clk), .PRE2_n(1'b1), .CLR2_n(clr_n),
               .Q1(q0), .Q2(q1));
  ic7474 Uff1 (.D1(d2), .CLK1(clk), .PRE1_n(1'b1), .CLR1_n(clr_n),
               .D2(d3), .CLK2(clk), .PRE2_n(1'b1), .CLR2_n(clr_n),
               .Q1(q2), .Q2(q3));

  assign q = {q3, q2, q1, q0};
endmodule
