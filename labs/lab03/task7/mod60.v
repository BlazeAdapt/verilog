`timescale 1ns/1ps

module mod60(
    input clk,
    input rst,
    output [3:0] units,
    output [2:0] tens
);

    wire uqa, uqb, uqc, uqd;
    wire tqa, tqb, tqc, tqd;

    wire u_decode10;
    wire u_reset;

    wire t_decode6;
    wire t_reset;

    // Units: decode binary 10 (QD=1 and QB=1)
    ic7408 u_and (
        .A1(uqd), .B1(uqb),
        .A2(1'b0), .B2(1'b0),
        .A3(1'b0), .B3(1'b0),
        .A4(1'b0), .B4(1'b0),
        .Y1(u_decode10), .Y2(), .Y3(), .Y4()
    );

    // Include the external reset
    ic7432 u_or (
        .A1(u_decode10), .B1(rst),
        .A2(1'b0), .B2(1'b0),
        .A3(1'b0), .B3(1'b0),
        .A4(1'b0), .B4(1'b0),
        .Y1(u_reset), .Y2(), .Y3(), .Y4()
    );

    // Units counter: 0 to 9
    ic7493 units_counter (
        .CKA_n(clk),
        .CKB_n(uqa),
        .R01(u_reset),
        .R02(u_reset),
        .QA(uqa),
        .QB(uqb),
        .QC(uqc),
        .QD(uqd)
    );

    // Tens: decode binary 6 (QC=1 and QB=1)
    ic7408 t_and (
        .A1(tqc), .B1(tqb),
        .A2(1'b0), .B2(1'b0),
        .A3(1'b0), .B3(1'b0),
        .A4(1'b0), .B4(1'b0),
        .Y1(t_decode6), .Y2(), .Y3(), .Y4()
    );

    ic7432 t_or (
        .A1(t_decode6), .B1(rst),
        .A2(1'b0), .B2(1'b0),
        .A3(1'b0), .B3(1'b0),
        .A4(1'b0), .B4(1'b0),
        .Y1(t_reset), .Y2(), .Y3(), .Y4()
    );

    // Tens increments when units QD falls at the 9-to-0 rollover.
    ic7493 tens_counter (
        .CKA_n(uqd),
        .CKB_n(tqa),
        .R01(t_reset),
        .R02(t_reset),
        .QA(tqa),
        .QB(tqb),
        .QC(tqc),
        .QD(tqd)
    );

    assign units = {uqd, uqc, uqb, uqa};
    assign tens  = {tqc, tqb, tqa};

endmodule