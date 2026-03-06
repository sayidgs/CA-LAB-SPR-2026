`timescale 1ns / 1ps

module ALU_tb;

reg  [31:0] A;
reg  [31:0] B;
reg  [3:0]  ALUControl;

wire [31:0] Result;
wire Zero;

// Instantiate ALU
ALU_32bit uut (
    .A(A),
    .B(B),
    .ALUControl(ALUControl),
    .Result(Result),
    .Zero(Zero)
);

initial begin

    // waveform generation
    $dumpfile("ALU_waveform.vcd");
    $dumpvars(0, ALU_tb);

    // ADD
    A = 32'd10;
    B = 32'd5;
    ALUControl = 4'b0000;
    #10;

    // SUB
    A = 32'd10;
    B = 32'd5;
    ALUControl = 4'b0001;
    #10;

    // AND
    A = 32'hFF00FF00;
    B = 32'h0F0F0F0F;
    ALUControl = 4'b0010;
    #10;

    // OR
    A = 32'hAA55AA55;
    B = 32'h00FF00FF;
    ALUControl = 4'b0011;
    #10;

    // XOR
    A = 32'hAAAAAAAA;
    B = 32'hFFFFFFFF;
    ALUControl = 4'b0100;
    #10;

    // SLL
    A = 32'd4;
    B = 32'd2;
    ALUControl = 4'b0101;
    #10;

    // SRL
    A = 32'd32;
    B = 32'd2;
    ALUControl = 4'b0110;
    #10;

    // SLT (A < B)
    A = 32'd5;
    B = 32'd10;
    ALUControl = 4'b0111;
    #10;

    // Zero flag test
    A = 32'd5;
    B = 32'd5;
    ALUControl = 4'b0001;
    #10;

    $finish;

end

endmodule