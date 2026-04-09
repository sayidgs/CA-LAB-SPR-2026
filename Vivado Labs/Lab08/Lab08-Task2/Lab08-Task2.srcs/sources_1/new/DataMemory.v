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

//Most RECENT ONE
module DataMemory(
    input clk,
    input MemWrite,
    input MemRead,
    input [8:0] address, 
    input [31:0] write_data,
    output [31:0] read_data
);
    reg [31:0] memory [0:511];

    // --- ADD THIS INITIALIZATION BLOCK ---
    integer i;
    initial begin
        for (i = 0; i < 512; i = i + 1) begin
            memory[i] = 32'h00000000;
        end
    end

    always @(posedge clk) begin
        if(MemWrite)
            memory[address] <= write_data;
    end

    assign read_data = (MemRead) ? memory[address] : 32'b0;
endmodule






//OLD NEWEST ONE
//module DataMemory(
//    input clk,
//    input MemWrite,
//    input MemRead,
//    input [8:0] address, // 2^9 = 512 entries
//    input [31:0] write_data,
//    output [31:0] read_data
//);
//    reg [31:0] memory [0:511];

//    reg [31:0] memory [0:511];

//    // Initialize memory to zero
//    integer i;
//    initial begin
//        for (i = 0; i < 512; i = i + 1) begin
//            memory[i] = 32'b0;
//        end
//    end

//    always @(posedge clk) begin
//        if(MemWrite)
//            memory[address] <= write_data;
//    end

//    // Asynchronous read (Common for Lab RAM)
//    assign read_data = (MemRead) ? memory[address] : 32'b0;
//endmodule





//OLD ONE
//module DataMemory(

//    input clk,
//    input MemWrite,
//    input MemRead,

//    input [7:0] address,
//    input [31:0] write_data,

//    output reg [31:0] read_data
//);

//reg [31:0] memory [0:511];

//integer i;

//initial
//begin
//    for(i=0;i<512;i=i+1)
//        memory[i] = 0;
//end

//always @(posedge clk)
//begin
//    if(MemWrite)
//        memory[address] <= write_data;
//end

//always @(*)
//begin
//    if(MemRead)
//        read_data = memory[address];
//    else
//        read_data = 32'b0;
//end

//endmodule