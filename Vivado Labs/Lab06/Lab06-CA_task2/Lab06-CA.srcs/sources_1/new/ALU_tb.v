`timescale 1ns/1ps

module ALU_tb;

reg  [31:0] A, B;
reg  [3:0]  ALUControl;
wire [31:0] ALUResult;
wire Zero;

// Instantiate ALU
ALU uut (
    .A(A),
    .B(B),
    .ALUControl(ALUControl),
    .ALUResult(ALUResult),
    .Zero(Zero)
);

initial begin

    // Generate waveform file
    $dumpfile("ALU_waveform.vcd");
    $dumpvars(0, ALU_tb);

    // Test ADD
    A = 1; B = 1; ALUControl = 4'b0000; #10;
    
    // Test SUB
    A = 10; B = 1; ALUControl = 4'b0001; #10;

    // Test AND
    A = 8'hFF; B = 8'h00; ALUControl = 4'b0010; #10;

    // Test OR
    A = 8'hFA; B = 8'h00; ALUControl = 4'b0011; #10;

    // Test XOR
    A = 8'hAA; B = 8'hFF; ALUControl = 4'b0100; #10;

    // Test SLL
    A = 10; B = 2; ALUControl = 4'b0101; #10;

    // Test SRL
    A = 21; B = 3; ALUControl = 4'b0110; #10;

    // Test SLT
    A = 10; B = 5; ALUControl = 4'b0111; #10;

    // Test Zero flag
    A = 1; B = 5; ALUControl = 4'b0001; #10;

    $finish;
end

endmodule