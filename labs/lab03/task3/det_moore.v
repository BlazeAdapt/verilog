`timescale 1ns/1ps

module det_moore(
    input clk,
    input rst_n,
    input x,
    output reg y
);

    localparam S0 = 3'd0;  // No matching prefix
    localparam S1 = 3'd1;  // Seen 0
    localparam S2 = 3'd2;  // Seen 01
    localparam S3 = 3'd3;  // Seen 011
    localparam S4 = 3'd4;  // Detected 0110

    reg [2:0] state, next_state;

    // State register: asynchronous active-low reset
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state <= S0;
        else
            state <= next_state;
    end

    // Next-state logic and Moore output
    always @(*) begin
        next_state = S0;
        y = 1'b0;

        case (state)
            S0: begin
                if (x == 1'b0)
                    next_state = S1;
                else
                    next_state = S0;
            end

            S1: begin
                if (x == 1'b0)
                    next_state = S1;
                else
                    next_state = S2;
            end

            S2: begin
                if (x == 1'b0)
                    next_state = S1;
                else
                    next_state = S3;
            end

            S3: begin
                if (x == 1'b0)
                    next_state = S4;
                else
                    next_state = S0;
            end

            S4: begin
                y = 1'b1;

                // Preserve overlapping matches
                if (x == 1'b0)
                    next_state = S1;
                else
                    next_state = S2;
            end

            default: begin
                next_state = S0;
                y = 1'b0;
            end
        endcase
    end

endmodule