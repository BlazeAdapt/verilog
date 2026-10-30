// tb.v -- Testbench for Lab 3 Task 6 (Irregular JK Counter)
// Forces all 8 states (000 to 111) via pre_n and clr_n, applies 5 clock pulses,
// and prints the sequence of states visited.
`timescale 1ns/1ps
module tb;
  parameter T = 400; // clock period in ns

  reg clk = 1;
  reg [2:0] pre_n = 3'b111;
  reg [2:0] clr_n = 3'b111;
  wire [2:0] q;

  irr_counter DUT (.clk(clk), .pre_n(pre_n), .clr_n(clr_n), .q(q));

  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, tb);
    end
  end

  integer state_idx, pulse;
  reg [2:0] start_state;

  initial begin
    #10;
    $display("=== Irregular JK Counter State Exploration ===");

    for (state_idx = 0; state_idx < 8; state_idx = state_idx + 1) begin
      start_state = state_idx[2:0];

      // While clock is high, assert preset/clear to force state
      // For each bit: if start_state[i]==1, pre_n=0, clr_n=1; if 0, pre_n=1, clr_n=0
      clk = 1;
      pre_n = ~start_state;
      clr_n = start_state;

      // Hold for at least 50 ns
      #60;

      // Release preset and clear
      pre_n = 3'b111;
      clr_n = 3'b111;
      #20;

      $write("Starting state %b: %b", start_state, q);

      // Apply 5 clock pulses (74112 toggles on falling clock edge)
      for (pulse = 1; pulse <= 5; pulse = pulse + 1) begin
        clk = 0;
        #(T / 2.0);
        clk = 1;
        #(T / 2.0);
        $write(" -> %b", q);
      end
      $write("\n");
      #40;
    end

    $finish;
  end
endmodule
