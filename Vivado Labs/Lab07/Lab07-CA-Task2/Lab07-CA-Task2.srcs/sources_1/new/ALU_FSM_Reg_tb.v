`timescale 1ns / 1ps

module RF_ALU_FSM_tb;

reg clk;
reg reset;

reg WriteEnable;
reg [4:0] rs1, rs2, rd;
reg [31:0] WriteData;

reg [3:0] ALUControl;

wire [31:0] ReadData1;
wire [31:0] ReadData2;

wire [31:0] ALUResult;
wire Zero;

RegisterFile RF(
    .clk(clk),
    .reset(reset),
    .WriteEnable(WriteEnable),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .WriteData(WriteData),
    .ReadData1(ReadData1),
    .ReadData2(ReadData2)
);

ALU_32bit ALU(
    .A(ReadData1),
    .B(ReadData2),
    .ALUControl(ALUControl),
    .Result(ALUResult),
    .Zero(Zero)
);

always #5 clk = ~clk;

////////////////////////////////////////////////
// FSM States
////////////////////////////////////////////////

reg [3:0] state;

parameter IDLE = 0;
parameter WRITE_REGS = 1;
parameter ADD_OP = 2;
parameter SUB_OP = 3;
parameter AND_OP = 4;
parameter OR_OP = 5;
parameter XOR_OP = 6;
parameter SHIFT_OP = 7;
parameter CHECK_BEQ = 8;
parameter DONE = 9;

initial begin
clk = 0;
reset = 1;
state = IDLE;

#10 reset = 0;
end

always @(posedge clk) begin

case(state)

////////////////////////////////////////////////
// WRITE CONSTANTS
////////////////////////////////////////////////

WRITE_REGS:
begin
WriteEnable <= 1;

rd <= 1; WriteData <= 32'h10101010;
#10;

rd <= 2; WriteData <= 32'h01010101;
#10;

rd <= 3; WriteData <= 32'h00000005;
#10;

WriteEnable <= 0;

state <= ADD_OP;
end

////////////////////////////////////////////////
// ADD
////////////////////////////////////////////////

ADD_OP:
begin

rs1 <= 1;
rs2 <= 2;
ALUControl <= 4'b0000;

WriteEnable <= 1;
rd <= 4;
WriteData <= ALUResult;

state <= SUB_OP;

end

////////////////////////////////////////////////
// SUB
////////////////////////////////////////////////

SUB_OP:
begin

rs1 <= 1;
rs2 <= 2;
ALUControl <= 4'b0001;

rd <= 5;
WriteData <= ALUResult;

state <= AND_OP;

end

////////////////////////////////////////////////
// AND
////////////////////////////////////////////////

AND_OP:
begin

rs1 <= 1;
rs2 <= 2;
ALUControl <= 4'b0010;

rd <= 6;
WriteData <= ALUResult;

state <= OR_OP;

end

////////////////////////////////////////////////
// OR
////////////////////////////////////////////////

OR_OP:
begin

rs1 <= 1;
rs2 <= 2;
ALUControl <= 4'b0011;

rd <= 7;
WriteData <= ALUResult;

state <= XOR_OP;

end

////////////////////////////////////////////////
// XOR
////////////////////////////////////////////////

XOR_OP:
begin

rs1 <= 1;
rs2 <= 2;
ALUControl <= 4'b0100;

rd <= 8;
WriteData <= ALUResult;

state <= SHIFT_OP;

end

////////////////////////////////////////////////
// SHIFT
////////////////////////////////////////////////

SHIFT_OP:
begin

rs1 <= 1;
rs2 <= 3;
ALUControl <= 4'b0101;

rd <= 9;
WriteData <= ALUResult;

state <= CHECK_BEQ;

end

////////////////////////////////////////////////
// BEQ STYLE CHECK
////////////////////////////////////////////////

CHECK_BEQ:
begin

rs1 <= 1;
rs2 <= 1;
ALUControl <= 4'b0001;

if(Zero)
begin
rd <= 10;
WriteData <= 32'h1;
end

state <= DONE;

end

DONE:
begin
$display("FSM test completed");
#20 $finish;
end

default:
state <= WRITE_REGS;

endcase

end

endmodule