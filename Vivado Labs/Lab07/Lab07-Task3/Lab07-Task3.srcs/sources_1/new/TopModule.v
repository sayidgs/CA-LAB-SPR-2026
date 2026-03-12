`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2026 09:08:46 AM
// Design Name: 
// Module Name: TopModule
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




module top_rf_alu(

    input clk,
    input rst,

    input [3:0] switches,        // ALU operation select
    input start,           // start FSM

    output [15:0] leds,     // result display
    output [3:0] state_led // FSM state
);

/////////////////////////////////////////////////
// Register File signals
/////////////////////////////////////////////////

reg WriteEnable;
reg [4:0] rs1, rs2, rd;
reg [31:0] WriteData;

wire [31:0] ReadData1;
wire [31:0] ReadData2;

/////////////////////////////////////////////////
// ALU signals
/////////////////////////////////////////////////

wire [31:0] ALUResult;
wire Zero;

/////////////////////////////////////////////////
// Instantiate Register File
/////////////////////////////////////////////////

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

/////////////////////////////////////////////////
// Instantiate ALU
/////////////////////////////////////////////////

ALU_32bit ALU(
    .A(ReadData1),
    .B(ReadData2),
    .ALUControl(sw),
    .Result(ALUResult),
    .Zero(Zero)
);

/////////////////////////////////////////////////
// FSM
/////////////////////////////////////////////////

reg [3:0] state;

parameter IDLE = 0;
parameter WRITE_A = 1;
parameter WRITE_B = 2;
parameter EXECUTE = 3;
parameter STORE = 4;

always @(posedge clk or posedge reset)
begin

if(reset)
begin
    state <= IDLE;
    WriteEnable <= 0;
end

else

case(state)

/////////////////////////////////////////////////
// IDLE
/////////////////////////////////////////////////

IDLE:
begin
    WriteEnable <= 0;
    if(start)
        state <= WRITE_A;
end

/////////////////////////////////////////////////
// WRITE CONSTANT A
/////////////////////////////////////////////////

WRITE_A:
begin
    WriteEnable <= 1;
    rd <= 5'd1;
    WriteData <= 32'h10101010;
    state <= WRITE_B;
end

/////////////////////////////////////////////////
// WRITE CONSTANT B
/////////////////////////////////////////////////

WRITE_B:
begin
    rd <= 5'd2;
    WriteData <= 32'h01010101;
    state <= EXECUTE;
end

/////////////////////////////////////////////////
// EXECUTE ALU
/////////////////////////////////////////////////

EXECUTE:
begin
    WriteEnable <= 0;

    rs1 <= 5'd1;
    rs2 <= 5'd2;

    state <= STORE;
end

/////////////////////////////////////////////////
// STORE RESULT
/////////////////////////////////////////////////

STORE:
begin
    WriteEnable <= 1;
    rd <= 5'd3;
    WriteData <= ALUResult;

    state <= EXECUTE; // repeat operations
end

endcase

end

/////////////////////////////////////////////////
// LED OUTPUT
/////////////////////////////////////////////////

assign led = ALUResult[15:0];
assign state_led = state;

endmodule
