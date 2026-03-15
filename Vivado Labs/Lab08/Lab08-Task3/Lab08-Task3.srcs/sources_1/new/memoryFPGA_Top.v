`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2026 09:05:24 PM
// Design Name: 
// Module Name: memoryFPGA_Top
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


module memoryFPGA_Top(

    input clk,
    input rst,

    input [15:0] switches,      // board switches
    input btnU,           // write enable
    input btnD,           // read enable

    output [15:0] leds     // board LEDs
);

/////////////////////////////////////////////////
// Internal signals
/////////////////////////////////////////////////

wire [31:0] readData;
reg [31:0] address;
reg [31:0] writeData;

wire readEnable;
wire writeEnable;

/////////////////////////////////////////////////
// Button mapping
/////////////////////////////////////////////////

assign writeEnable = btnU;
assign readEnable  = btnD;

/////////////////////////////////////////////////
// Address and data from switches
/////////////////////////////////////////////////

always @(*) begin
    address   = {22'b0, switches[9:0]};   // 10-bit memory map
    writeData = {16'b0, switches};        // lower 16 bits from switches
end

/////////////////////////////////////////////////
// Memory System Instance
/////////////////////////////////////////////////

addressDecoderTop memorySystem(

.clk(clk),
.rst(rst),

.address(address),
.readEnable(readEnable),
.writeEnable(writeEnable),

.writeData(writeData),

.switches(switches),

.readData(readData),
.leds(leds)

);

endmodule
