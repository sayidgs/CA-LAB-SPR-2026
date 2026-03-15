`timescale 1ns / 1ps

module RegisterFile_tb;

reg clk;
reg reset;
reg WriteEnable;

reg [4:0] rs1;
reg [4:0] rs2;
reg [4:0] rd;

reg [31:0] WriteData;

wire [31:0] ReadData1;
wire [31:0] ReadData2;

RegisterFile uut(
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

always #5 clk = ~clk;

initial begin
    // Initialize
    clk = 0;
    reset = 1;
    WriteEnable = 0;
    rd = 0; rs1 = 0; rs2 = 0; WriteData = 0;

    #15 reset = 0; // Reset released away from clock edge

    ////////////////////////////////////////////////
    // Test 1: Write to register x5
    ////////////////////////////////////////////////
    @(negedge clk); // Wait for falling edge to change inputs
    WriteEnable = 1;
    rd = 5;
    WriteData = 32'hDEADBEEF;

    @(negedge clk); // Wait one full cycle for write to happen
    WriteEnable = 0;
    rs1 = 5;
    
    @(negedge clk);
    $display("Read x5 = %h (Expected: DEADBEEF)", ReadData1);

    ////////////////////////////////////////////////
    // Test 2: Write to x0 (should stay zero)
    ////////////////////////////////////////////////
    @(negedge clk);
    WriteEnable = 1;
    rd = 0;
    WriteData = 32'hFFFFFFFF;

    @(negedge clk);
    WriteEnable = 0;
    rs1 = 0;

    @(negedge clk);
    $display("Read x0 = %h (Expected: 00000000)", ReadData1);

    // ... follow this pattern for other tests ...
    
    #50 $finish;
end
endmodule