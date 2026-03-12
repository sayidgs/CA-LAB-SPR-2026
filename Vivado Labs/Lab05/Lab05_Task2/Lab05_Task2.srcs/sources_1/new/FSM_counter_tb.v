`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2026 12:53:21 PM
// Design Name: 
// Module Name: FSM_counter_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module tb_FSM_Counter;
    reg clk;
    reg rst;
    reg [15:0] switch_in;
    wire [15:0] count_out;
    wire [1:0] current_state;

    // Instantiate Unit Under Test
    FSM_Counter uut (
        .clk(clk),
        .rst(rst),
        .switch_in(switch_in),
        .count_out(count_out),
        .current_state(current_state)
    );

    // Clock Generation (100MHz)
    always #5 clk = ~clk;

    initial begin
        // Initialize
        clk = 0;
        rst = 1;
        switch_in = 0;

        #20 rst = 0; // Release reset

        // Test 1: Apply non-zero switch value
        #10 switch_in = 16'd5;
        
        // Wait for countdown to finish
        #100;

        // Test 2: Apply another value
        #10 switch_in = 16'd10;
        
        // Test 3: Verify Reset during middle of count
        #30 rst = 1;
        #10 rst = 0;
        switch_in = 0;

        #50 $finish;
    end
endmodule
