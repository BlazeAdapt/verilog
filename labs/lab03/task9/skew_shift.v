// skew_shift.v -- YOU write this.
// Two-stage shift register (one IC 7474). Flip-flop 1 is clocked by clk. Flip-flop 2 is clocked by clk delayed through N buffers (IC 7408 gates with both inputs tied together), built with a generate loop.
`timescale 1ns/1ps
module skew_shift #(parameter N = 0) (input clk, input clr_n, input d, output q1, output q2);
  wire clk_delayed;
  wire [N:0] clk_chain;
  assign clk_chain[0] = clk;

  genvar i;
  generate
    for (i = 0; i < N; i = i + 1) begin : g
      ic7408 Ubuf (.A1(clk_chain[i]), .B1(clk_chain[i]), .A2(1'b0), .B2(1'b0), .A3(1'b0), .B3(1'b0), .A4(1'b0), .B4(1'b0),
                  .Y1(clk_chain[i+1]), .Y2(), .Y3(), .Y4());
    end
  endgenerate

  assign clk_delayed = clk_chain[N];

  ic7474 Uff (.D1(d), .CLK1(clk), .PRE1_n(1'b1), .CLR1_n(clr_n),
              .D2(q1), .CLK2(clk_delayed), .PRE2_n(1'b1), .CLR2_n(clr_n),
              .Q1(q1), .Q2(q2));
endmodule
