// shift4_nb.v -- YOU write this.
// 4-stage shift register, non-blocking assignments, one always block.
// d enters q[0] at each rising edge; q[0] moves to q[1], q[1] to q[2], q[2] to q[3].
`timescale 1ns/1ps
module shift4_nb(input clk, input d, output reg [3:0] q);
  always @(posedge clk) begin
    q[0] <= d;
    q[1] <= q[0];
    q[2] <= q[1];
    q[3] <= q[2];
  end
endmodule
