// tb.v -- Frequency sweep testbench for Lab 3 Task 8
// Sweeps period T from 100 ns down to 40 ns in 1 ns steps to find Tmin.
`timescale 1ns/1ps
module tb;
  reg clk;
  reg clr_n;
  wire [3:0] q;

  sync_counter4 DUT (.clk(clk), .clr_n(clr_n), .q(q));

  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, tb);
    end
  end

  integer T;
  integer edge_count;
  reg t_pass;
  integer Tmin;
  reg [3:0] exp_q;

  initial begin
    Tmin = 0;

    for (T = 100; T >= 40; T = T - 1) begin
      // Stop the clock, clear the counter, release clear
      clk = 0;
      clr_n = 0;
      #100;
      clr_n = 1;
      #20;

      t_pass = 1'b1;

      // Apply 20 rising clock edges with period T
      for (edge_count = 1; edge_count <= 20; edge_count = edge_count + 1) begin
        clk = 1;
        #(T / 2.0);
        clk = 0;
        #(T / 2.0 - 1.0);

        // Check count just before the next edge (x counts as wrong)
        exp_q = (edge_count) % 16;
        if (q !== exp_q) begin
          t_pass = 1'b0;
        end
        #1.0;
      end

      if (t_pass) begin
        $display("Period T = %0d ns: PASS", T);
        Tmin = T;
      end else begin
        $display("Period T = %0d ns: FAIL", T);
      end
    end

    // The autograder searches for this exact output line:
    $display("RESULT: Tmin = %0d ns", Tmin);
    $finish;
  end
endmodule
