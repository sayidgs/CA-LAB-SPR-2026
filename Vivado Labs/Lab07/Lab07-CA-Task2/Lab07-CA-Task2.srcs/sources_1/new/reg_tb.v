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

// Clock generation
always #5 clk = ~clk;

initial begin

    $dumpfile("RegisterFile.vcd");
    $dumpvars(0, RegisterFile_tb);

    clk = 0;
    reset = 1;
    WriteEnable = 0;

    #10 reset = 0;

    // Test 1: Write to x5
    rd = 5;
    WriteData = 32'hDEADBEEF;
    WriteEnable = 1;
    #10;

    WriteEnable = 0;
    rs1 = 5;
    #10;

    // Test 2: Attempt write to x0
    rd = 0;
    WriteData = 32'hFFFFFFFF;
    WriteEnable = 1;
    #10;

    WriteEnable = 0;
    rs1 = 0;
    #10;

    // Test 3: Two simultaneous reads
    rd = 6;
    WriteData = 32'hAAAA5555;
    WriteEnable = 1;
    #10;

    WriteEnable = 0;
    rs1 = 5;
    rs2 = 6;
    #10;

    // Test 4: Overwrite register
    rd = 5;
    WriteData = 32'h12345678;
    WriteEnable = 1;
    #10;

    WriteEnable = 0;
    rs1 = 5;
    #10;

    // Test 5: Reset behavior
    reset = 1;
    #10;
    reset = 0;

    rs1 = 5;
    #10;

    $finish;
end

endmodule