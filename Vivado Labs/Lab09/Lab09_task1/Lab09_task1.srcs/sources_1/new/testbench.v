`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2026 10:51:00 AM
// Design Name: 
// Module Name: testbench
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


`timescale 1ns/1ps

module tb_control;

reg [6:0] opcode;
reg [2:0] funct3;
reg [6:0] funct7;

wire RegWrite, ALUSrc, MemRead, MemWrite, MemtoReg, Branch;
wire [1:0] ALUOp;
wire [3:0] ALUControl;

// Instantiate Main Control
MainControl mc(
    .opcode(opcode),
    .RegWrite(RegWrite),
    .ALUSrc(ALUSrc),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .MemtoReg(MemtoReg),
    .Branch(Branch),
    .ALUOp(ALUOp)
);

// Instantiate ALU Control
ALUControl alu_ctrl(
    .ALUOp(ALUOp),
    .funct3(funct3),
    .funct7(funct7),
    .ALUControl(ALUControl)
);

initial begin
    $dumpfile("control.vcd");
    $dumpvars(0, tb_control);

    // -------- R-TYPE --------
    opcode = 7'b0110011;

    // ADD
    funct3 = 3'b000; funct7 = 7'b0000000; #10;

    // SUB
    funct7 = 7'b0100000; #10;

    // SLL
    funct3 = 3'b001; funct7 = 7'b0000000; #10;

    // SRL
    funct3 = 3'b101; #10;

    // AND
    funct3 = 3'b111; #10;

    // OR
    funct3 = 3'b110; #10;

    // XOR
    funct3 = 3'b100; #10;

    // -------- I-TYPE (ADDI) --------
    opcode = 7'b0010011;
    funct3 = 3'b000; funct7 = 7'b0000000; #10;

    // -------- LOAD --------
    opcode = 7'b0000011; #10;

    // -------- STORE --------
    opcode = 7'b0100011; #10;

    // -------- BEQ --------
    opcode = 7'b1100011; #10;

    $finish;
end

endmodule