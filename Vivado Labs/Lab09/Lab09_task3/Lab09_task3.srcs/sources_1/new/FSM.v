`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/09/2026 10:33:28 AM
// Design Name: 
// Module Name: FSM
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


module control_fsm(
input clk,
input rst,
output reg display_enable
);
// State Definition
reg [1:0] state, next_state;
parameter IDLE = 2'b00,
READ = 2'b01,
EXECUTE = 2'b10,
DISPLAY = 2'b11;
// State Register
always @(posedge clk or posedge rst)
begin
if(rst)
state <= IDLE;
else
state <= next_state;
end
// Next State Logic
always @(*)
begin
case(state)
IDLE:
next_state = READ;
READ:
next_state = EXECUTE;
EXECUTE:
next_state = DISPLAY;
DISPLAY:
next_state = IDLE;
default:
next_state = IDLE;
endcase
end
// Output Logic
always @(*)
begin
if(state == DISPLAY)
display_enable = 1;
else
display_enable = 0;
end
endmodule
