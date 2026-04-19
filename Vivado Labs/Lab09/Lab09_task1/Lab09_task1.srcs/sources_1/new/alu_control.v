`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2026 10:51:00 AM
// Design Name: 
// Module Name: alu_control
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


module ALUControl(
    input [1:0] ALUOp,
    input [2:0] funct3,
    input [6:0] funct7,
    output reg [3:0] ALUControl
);

always @(*) begin
    case(ALUOp)

        // Load/Store ? ADD
        2'b00: ALUControl = 4'b0010;

        // Branch ? SUB (for BEQ)
        2'b01: ALUControl = 4'b0110;

        // R-type / I-type
        2'b10: begin
            case(funct3)

                3'b000: begin
                    if (funct7 == 7'b0100000)
                        ALUControl = 4'b0110; // SUB
                    else
                        ALUControl = 4'b0010; // ADD / ADDI
                end

                3'b001: ALUControl = 4'b1000; // SLL
                3'b101: ALUControl = 4'b1001; // SRL
                3'b111: ALUControl = 4'b0000; // AND
                3'b110: ALUControl = 4'b0001; // OR
                3'b100: ALUControl = 4'b0011; // XOR

                default: ALUControl = 4'b0000;
            endcase
        end
        
        // U-type / Special
        2'b11: ALUControl = 4'b1111; // Custom code for "Pass B"

        default: ALUControl = 4'b0000;

    endcase
end

endmodule