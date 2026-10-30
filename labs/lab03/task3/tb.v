// tb.v -- Testbench for Lab 3 Task 3 (Sequence Detectors)
// Tests det_df and det_beh side by side, with extensions for det0101 and det_moore.
`timescale 1ns/1ps
module tb;
  reg clk = 0;
  reg rst_n = 0;
  reg x = 1;

  wire y_df;
  wire y_beh;
  wire y_0101_df;
  wire y_0101_beh;
  wire y_moore;

  det_df        U_DF        (.clk(clk), .rst_n(rst_n), .x(x), .y(y_df));
  det_beh       U_BEH       (.clk(clk), .rst_n(rst_n), .x(x), .y(y_beh));
  det0101_df    U_0101_DF   (.clk(clk), .rst_n(rst_n), .x(x), .y(y_0101_df));
  det0101_beh   U_0101_BEH  (.clk(clk), .rst_n(rst_n), .x(x), .y(y_0101_beh));
  det_moore     U_MOORE     (.clk(clk), .rst_n(rst_n), .x(x), .y(y_moore));

  // Clock generation: 10 ns period
  always #5 clk = ~clk;

  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, tb);
    end
  end

  // Test stream: 40 bits containing 0110, overlapping 0110110, near misses (0111, 0100, 010), etc.
  reg [39:0] stream = 40'b0110_110_0111_0100_0101_0101_11_0110_0010_1101;
  reg [3:0] hist = 4'b1111;
  reg [3:0] w;
  reg exp_0110;
  reg exp_0101;
  reg exp_moore = 0;
  integer n, err_df = 0, err_beh = 0;

  initial begin
    // Reset active for first 12 ns
    #12 rst_n = 1;

    for (n = 0; n < 40; n = n + 1) begin
      @(negedge clk);
      x = stream[39-n];

      // Sample Mealy outputs shortly after input change
      #2;
      w = {hist[2:0], x};
      exp_0110 = (w == 4'b0110);
      exp_0101 = (w == 4'b0101);

      if (y_df !== exp_0110) begin
        $display("cycle %2d (t=%0t): det_df FAIL: x=%b got y=%b expected %b", n, $time, x, y_df, exp_0110);
        err_df = err_df + 1;
      end
      if (y_beh !== exp_0110) begin
        $display("cycle %2d (t=%0t): det_beh FAIL: x=%b got y=%b expected %b", n, $time, x, y_beh, exp_0110);
        err_beh = err_beh + 1;
      end

      @(posedge clk);
      hist = w;
      #1;
      exp_moore = (hist == 4'b0110);
    end

    if (err_df == 0 && err_beh == 0)
      $display("ALL_DET_TESTS_PASSED");
    else
      $display("DET_TESTS_FAILED: det_df errs=%0d, det_beh errs=%0d", err_df, err_beh);

    $finish;
  end
endmodule
