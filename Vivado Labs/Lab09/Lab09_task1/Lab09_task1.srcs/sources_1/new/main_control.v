`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2026 10:51:00 AM
// Design Name: 
// Module Name: main_control
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


module MainControl(
    input [6:0] opcode,
    output reg RegWrite,
    output reg ALUSrc,
    output reg MemRead,
    output reg MemWrite,
    output reg MemtoReg,
    output reg Branch,
    output reg [1:0] ALUOp
);

always @(*) begin
    // Default safe values
    

    case(opcode)

        // R-type (ADD, SUB, SLL, SRL, AND, OR, XOR)
        7'b0110011: begin
            RegWrite = 1;
            ALUSrc   = 0;
            ALUOp    = 2'b10;
        end

        // I-type (ADDI)
        7'b0010011: begin
            RegWrite = 1;
            ALUSrc   = 1;
            ALUOp    = 2'b10;
        end

        // Load (LW, LH, LB)
        7'b0000011: begin
            RegWrite = 1;
            ALUSrc   = 1;
            MemRead  = 1;
            MemtoReg = 1;
            ALUOp    = 2'b00;
        end

        // Store (SW, SH, SB)
        7'b0100011: begin
            ALUSrc   = 1;
            MemWrite = 1;
            ALUOp    = 2'b00;
        end

        // Branch (BEQ)
        7'b1100011: begin
            Branch = 1;
            ALUOp  = 2'b01;
        end

        default: begin
            // Keep defaults (safe)
            RegWrite = 0;
            ALUSrc   = 0;
            MemRead  = 0;
            MemWrite = 0;
            MemtoReg = 0;
            Branch   = 0;
            ALUOp    = 2'b00;
        end

    endcase
end

endmodule