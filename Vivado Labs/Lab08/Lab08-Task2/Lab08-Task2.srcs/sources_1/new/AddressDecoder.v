`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2026 12:29:53 PM
// Design Name: 
// Module Name: AddressDecoder
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


module AddressDecoder(

    input [31:0] address,
    input readEnable,
    input writeEnable,

    output DataMemRead,
    output DataMemWrite,
    output LEDWrite,
    output SwitchReadEnable
);

wire [1:0] device;

assign device = address[9:8];

assign DataMemRead  = (device == 2'b00) & readEnable;
assign DataMemWrite = (device == 2'b00) & writeEnable;

assign LEDWrite = (device == 2'b01) & writeEnable;

assign SwitchReadEnable = (device == 2'b10) & readEnable;

endmodule
