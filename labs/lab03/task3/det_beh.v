`timescale 1ns/1ps
module det_beh(input clk, input rst_n, input x, output reg y);

  localparam S0 = 2'd0,  // No matching prefix
             S1 = 2'd1,  // Matched 0
             S2 = 2'd2,  // Matched 01
             S3 = 2'd3;  // Matched 011

  reg [1:0] state, next_state;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
      state <= S0;
    else
      state <= next_state;
  end

  always @(*) begin
    next_state = S0;
    y = 1'b0;

    case (state)
      S0: begin
        if (x == 1'b0) next_state = S1;
        else           next_state = S0;
      end

      S1: begin
        if (x == 1'b0) next_state = S1;
        else           next_state = S2;
      end

      S2: begin
        if (x == 1'b0) next_state = S1;
        else           next_state = S3;
      end

      S3: begin
        if (x == 1'b0) begin
          y = 1'b1;
          next_state = S1;
        end else begin
          next_state = S0;
        end
      end

      default: begin
        next_state = S0;
        y = 1'b0;
      end
    endcase
  end

endmodule