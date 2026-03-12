`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2026 12:29:53 PM
// Design Name: 
// Module Name: DataMemory
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



module DataMemory(

    input clk,
    input MemWrite,
    input MemRead,

    input [7:0] address,
    input [31:0] write_data,

    output reg [31:0] read_data
);

reg [31:0] memory [0:511];

integer i;

initial
begin
    for(i=0;i<512;i=i+1)
        memory[i] = 0;
end

always @(posedge clk)
begin
    if(MemWrite)
        memory[address] <= write_data;
end

always @(*)
begin
    if(MemRead)
        read_data = memory[address];
    else
        read_data = 32'b0;
end

endmodule