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

clk = 0;
reset = 1;
WriteEnable = 0;

#10 reset = 0;

////////////////////////////////////////////////
// Test 1: Write to register x5
////////////////////////////////////////////////

WriteEnable = 1;
rd = 5;
WriteData = 32'hDEADBEEF;

#10;

rs1 = 5;
rs2 = 0;

#10;

$display("Read x5 = %h", ReadData1);

////////////////////////////////////////////////
// Test 2: Write to x0 (should stay zero)
////////////////////////////////////////////////

rd = 0;
WriteData = 32'hFFFFFFFF;

#10;

rs1 = 0;

#10;

$display("Read x0 = %h (should be 0)", ReadData1);

////////////////////////////////////////////////
// Test 3: Two simultaneous reads
////////////////////////////////////////////////

rd = 10;
WriteData = 32'h12345678;
#10;

rd = 11;
WriteData = 32'h87654321;
#10;

WriteEnable = 0;

rs1 = 10;
rs2 = 11;

#10;

$display("Read x10 = %h", ReadData1);
$display("Read x11 = %h", ReadData2);

////////////////////////////////////////////////
// Test 4: Overwrite register
////////////////////////////////////////////////

WriteEnable = 1;
rd = 5;
WriteData = 32'hAAAAAAAA;

#10;

WriteEnable = 0;
rs1 = 5;

#10;

$display("Overwrite x5 = %h", ReadData1);

////////////////////////////////////////////////
// Test 5: Reset behavior
////////////////////////////////////////////////

reset = 1;
#10;
reset = 0;

rs1 = 5;

#10;

$display("After reset x5 = %h", ReadData1);

#20 $finish;

end

endmodule