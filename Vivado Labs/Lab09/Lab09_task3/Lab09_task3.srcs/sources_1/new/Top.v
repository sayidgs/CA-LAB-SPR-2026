`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2026 11:21:57 AM
// Design Name: 
// Module Name: Top
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


module top_control(
    input clk,
    input rst,
    input [15:0] sw,     // switches
    output reg [15:0] led
);

// ----------------------------
// Extract Instruction Fields
// ----------------------------
wire [6:0] opcode = sw[6:0];
wire [2:0] funct3 = sw[9:7];
wire [6:0] funct7 = {1'b0, sw[15:10]}; 
// padded to 7 bits

// ----------------------------
// Control Signals
// ----------------------------
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
ALUControl ac(
    .ALUOp(ALUOp),
    .funct3(funct3),
    .funct7(funct7),
    .ALUControl(ALUControl)
);

// ----------------------------
// FSM
// ----------------------------
reg [1:0] state, next_state;

parameter IDLE = 2'b00,
          READ = 2'b01,
          EXECUTE = 2'b10,
          DISPLAY = 2'b11;

// State Register
always @(posedge clk or posedge rst) begin
    if (rst)
        state <= IDLE;
    else
        state <= next_state;
end

// Next State Logic
always @(*) begin
    case(state)
        IDLE:     next_state = READ;
        READ:     next_state = EXECUTE;
        EXECUTE:  next_state = DISPLAY;
        DISPLAY:  next_state = IDLE;
        default:  next_state = IDLE;
    endcase
end

// Output Logic (LED Mapping)
always @(posedge clk) begin
    case(state)

        DISPLAY: begin
            led[0]  <= RegWrite;
            led[1]  <= ALUSrc;
            led[2]  <= MemRead;
            led[3]  <= MemWrite;
            led[4]  <= MemtoReg;
            led[5]  <= Branch;
            led[7:6] <= ALUOp;
            led[11:8] <= ALUControl;
            led[15:12] <= 4'b0000;
        end

        default: led <= 16'b0;

    endcase
end

endmodule