`timescale 1ns/1ps
module bcd_counter(input clk, input rst, output [3:0] q);

  wire qa, qb, qc, qd;
  wire is_ten, reset_count;

  ic7408 G1 (
    .A1(qd), .B1(qb),
    .A2(1'b0), .B2(1'b0),
    .A3(1'b0), .B3(1'b0),
    .A4(1'b0), .B4(1'b0),
    .Y1(is_ten), .Y2(), .Y3(), .Y4()
  );

  ic7432 G2 (
    .A1(rst), .B1(is_ten),
    .A2(1'b0), .B2(1'b0),
    .A3(1'b0), .B3(1'b0),
    .A4(1'b0), .B4(1'b0),
    .Y1(reset_count), .Y2(), .Y3(), .Y4()
  );

  ic7493 U1 (
    .CKA_n(clk),
    .CKB_n(qa),
    .R01(reset_count),
    .R02(reset_count),
    .QA(qa),
    .QB(qb),
    .QC(qc),
    .QD(qd)
  );

  assign q = {qd, qc, qb, qa};

endmodule