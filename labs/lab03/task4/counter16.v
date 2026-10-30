`timescale 1ns/1ps
module counter16(input clk, input rst, output [3:0] q);

  wire qa, qb, qc, qd;

  ic7493 U1 (
    .CKA_n(clk),
    .CKB_n(qa),
    .R01(rst),
    .R02(rst),
    .QA(qa),
    .QB(qb),
    .QC(qc),
    .QD(qd)
  );

  assign q = {qd, qc, qb, qa};

endmodule