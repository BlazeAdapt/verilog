// det_df.v -- YOU write this.
// Mealy detector for 0110 (overlapping), DATAFLOW style: assign statements for the next-state and output equations, plus two instances of dff (dff.v).
`timescale 1ns/1ps
module det_df(input clk, input rst_n, input x, output y);
  wire [1:0] state;
  wire [1:0] next_state;

  assign next_state = (state == 2'b00) ? (x ? 2'b00 : 2'b01) :
                     (state == 2'b01) ? (x ? 2'b10 : 2'b01) :
                     (state == 2'b10) ? (x ? 2'b11 : 2'b01) :
                                        (x ? 2'b00 : 2'b01);
  assign y = (state == 2'b11) & ~x;

  dff U0 (.clk(clk), .rst_n(rst_n), .d(next_state[0]), .q(state[0]));
  dff U1 (.clk(clk), .rst_n(rst_n), .d(next_state[1]), .q(state[1]));
endmodule
