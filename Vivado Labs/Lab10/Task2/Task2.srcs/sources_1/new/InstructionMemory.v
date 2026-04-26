`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2026 11:57:08 AM
// Design Name: 
// Module Name: InstructionMemory
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

//module instructionMemory#(
//    parameter OPERAND_LENGTH = 31
//)(
//    input [OPERAND_LENGTH:0] instAddress,
//    output reg [31:0] instruction
//);

//reg [7:0] memory [0:255];

//initial begin
//    // Load memory file
//    $readmemh("program.mem", memory);
//end


//always @(*) begin
//    instruction = {
//        memory[instAddress],
//        memory[instAddress + 1],
//        memory[instAddress + 2],
//        memory[instAddress + 3]
//    };
//end

//endmodule


module instructionMemory(
    input [7:0] instAddress,
    output reg [31:0] instruction
);

reg [31:0] memory [0:255];

initial begin
    $readmemh("program.mem", memory);
end

always @(*) begin
//    instruction = memory[instAddress >> 2];

    instruction = memory[instAddress];
end

endmodule