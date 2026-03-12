`timescale 1ns / 1ps

module FSM_Counter(
    input clk,
    input rst,
    input [15:0] switch_in,
    output reg [15:0] count_out,
    output reg [1:0] current_state 
);

    parameter IDLE  = 2'b00;
    parameter COUNT = 2'b01;

    reg [1:0] next_state;
    reg [15:0] counter;

    // State Transition
    always @(posedge clk or posedge rst) begin
        if (rst)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Next State Logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (switch_in > 16'd0) 
                    next_state = COUNT;
                else 
                    next_state = IDLE;
            end
            COUNT: begin
                if (counter == 16'd0)
                    next_state = IDLE;
                else
                    next_state = COUNT;
            end
            default: next_state = IDLE;
        endcase
    end

    // Counter Logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 16'd0;
            count_out <= 16'd0;
        end else begin
            case (current_state)
                IDLE: begin
                    counter <= switch_in; 
                    count_out <= switch_in;
                end
                COUNT: begin
                    if (counter > 0) begin
                        counter <= counter - 1;
                        count_out <= counter - 1;
                    end
                end
                default: ; // Do nothing
            endcase
        end
    end

endmodule // Ensure this is the very last line