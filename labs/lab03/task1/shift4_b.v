`timescale 1ns/1ps
module shift4_b(input clk, input d, output reg [3:0] q);
  always @(posedge clk) begin
    q[3] = q[2];
    q[2] = q[1];
    q[1] = q[0];
    q[0] = d;
  end
endmodule