`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2026 12:29:53 PM
// Design Name: 
// Module Name: AddDecoder_Top
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



module addressDecoderTop(

input clk, rst,
input [31:0] address,
input readEnable, writeEnable,
input [31:0] writeData,
input [15:0] switches,

output reg [31:0] readData,
output reg [15:0] leds

);

/////////////////////////////////////////////////
// Decoder signals
/////////////////////////////////////////////////

wire DataMemRead;
wire DataMemWrite;
wire LEDWrite;
wire SwitchReadEnable;

/////////////////////////////////////////////////
// Data Memory
/////////////////////////////////////////////////

wire [31:0] memReadData;

/////////////////////////////////////////////////
// Instantiate Address Decoder
/////////////////////////////////////////////////

AddressDecoder decoder(

.address(address),
.readEnable(readEnable),
.writeEnable(writeEnable),

.DataMemRead(DataMemRead),
.DataMemWrite(DataMemWrite),
.LEDWrite(LEDWrite),
.SwitchReadEnable(SwitchReadEnable)

);

/////////////////////////////////////////////////
// Data Memory Instance
/////////////////////////////////////////////////

DataMemory DM(

.clk(clk),
.MemWrite(DataMemWrite),
.MemRead(DataMemRead),

.address(address[7:0]),
.write_data(writeData),

.read_data(memReadData)

);

/////////////////////////////////////////////////
// LED Write Logic
/////////////////////////////////////////////////

always @(posedge clk or posedge rst)
begin

if(rst)
    leds <= 0;

else if(LEDWrite)
    leds <= writeData[15:0];

end

/////////////////////////////////////////////////
// Read Data MUX
/////////////////////////////////////////////////

always @(*)
begin

if(DataMemRead)
    readData = memReadData;

else if(SwitchReadEnable)
    readData = {16'b0, switches};

else
    readData = 32'b0;

end

endmodule
