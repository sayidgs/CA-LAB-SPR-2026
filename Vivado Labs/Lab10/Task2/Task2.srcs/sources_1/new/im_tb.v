`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2026 12:02:45 PM
// Design Name: 
// Module Name: im_tb
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



module tb_lab10();

reg clk;
reg reset;

// Simulated I/O
reg [31:0] switches;
reg reset_btn;

wire [31:0] leds;

// Instantiate your processor
processor_top uut (
    .clk(clk),
    .reset(reset),
    .switches(switches),
    .reset_btn(reset_btn),
    .leds(leds)
);

// Clock generation (10ns ? 100MHz for sim)
always #5 clk = ~clk;

initial begin
    // Initialize
    clk = 0;
    reset = 1;
    switches = 0;
    reset_btn = 0;

    // Release reset
    #20;
    reset = 0;

    // -------------------------
    // TEST CASE 1: WAIT STATE
    // -------------------------
    // switches = 0 ? should stay idle
    #50;

    // -------------------------
    // TEST CASE 2: START FSM
    // -------------------------
    switches = 5;   // load value

    #20;
    switches = 0;   // should be ignored after capture

    // Let countdown happen
    #500;

    // -------------------------
    // TEST CASE 3: RESET DURING COUNTDOWN
    // -------------------------
    switches = 8;

    #20;
    reset_btn = 1;   // press reset

    #20;
    reset_btn = 0;

    #100;

    // -------------------------
    // TEST CASE 4: NEW INPUT
    // -------------------------
    switches = 3;

    #300;

    $stop;
end

// Monitor signals
initial begin
    $monitor("Time=%0t | LED=%d | Switch=%d | ResetBtn=%b",
              $time, leds, switches, reset_btn);
end


endmodule
