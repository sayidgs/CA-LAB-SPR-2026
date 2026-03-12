`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2026 09:08:46 AM
// Design Name: 
// Module Name: led
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


 module leds(
 input clk, rst,
 input [15:0] btns,
 input [31:0] writeData, // not to be written
 input writeEnable, // not to be used
 input readEnable,
 input [29:0] memAddress,
 input [15:0] switches,
 output reg [31:0] readData

    );
endmodule
