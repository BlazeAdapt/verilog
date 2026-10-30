// Autograder testbench for lab03 task8: frequency sweep of sync_counter4.
`timescale 1ns/1ps
module tb;
  reg clk;
  reg clr_n;
  wire [3:0] q;

  sync_counter4 DUT (.clk(clk), .clr_n(clr_n), .q(q));

  integer T;
  integer edge_count;
  reg t_pass;
  integer Tmin;
  reg [3:0] exp_q;

  initial begin
    Tmin = 0;

    for (T = 100; T >= 40; T = T - 1) begin
      clk = 0;
      clr_n = 0;
      #100;
      clr_n = 1;
      #20;

      t_pass = 1'b1;

      for (edge_count = 1; edge_count <= 20; edge_count = edge_count + 1) begin
        clk = 1;
        #(T / 2.0);
        clk = 0;
        #(T / 2.0 - 1.0);

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

    $display("RESULT: Tmin = %0d ns", Tmin);
    if (Tmin >= 50 && Tmin <= 70) begin
      $display("TASK8_PASSED");
    end
    $finish;
  end
endmodule
