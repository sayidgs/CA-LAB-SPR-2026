`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2026 12:29:53 PM
// Design Name: 
// Module Name: MemorySys_Tb
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



module MemorySystem_tb;

reg clk;
reg rst;

reg [31:0] address;
reg readEnable;
reg writeEnable;
reg [31:0] writeData;

reg [15:0] switches;

wire [31:0] readData;
wire [15:0] leds;

addressDecoderTop DUT(

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

/////////////////////////////////////////////////
// Clock
/////////////////////////////////////////////////

always #5 clk = ~clk;

/////////////////////////////////////////////////
// Test
/////////////////////////////////////////////////

initial
begin

clk = 0;
rst = 1;

readEnable = 0;
writeEnable = 0;

#20 rst = 0;

/////////////////////////////////////////////////
// WRITE DATA MEMORY
/////////////////////////////////////////////////

address = 32'd20;        // Data memory
writeData = 32'hAAAA5555;

writeEnable = 1;
#10;

writeEnable = 0;

/////////////////////////////////////////////////
// READ DATA MEMORY
/////////////////////////////////////////////////

readEnable = 1;
#10;

readEnable = 0;

/////////////////////////////////////////////////
// WRITE LED
/////////////////////////////////////////////////

address = 32'd520;       // LED address (01)

writeData = 32'h000000FF;

writeEnable = 1;
#10;

writeEnable = 0;

/////////////////////////////////////////////////
// READ SWITCH
/////////////////////////////////////////////////

switches = 16'hABCD;

address = 32'd800;       // Switch address (10)

readEnable = 1;
#10;

readEnable = 0;

#50 $finish;

end

endmodule