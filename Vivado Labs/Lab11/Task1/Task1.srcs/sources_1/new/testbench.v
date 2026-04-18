`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2026 10:24:30 AM
// Design Name: 
// Module Name: testbench
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



module tb_pc();

reg clk, reset, PCSrc;
reg [31:0] instr;
wire [31:0] PC;

wire [31:0] PC_next, PC_plus4, branchAddr, imm;

// Instantiate modules
ProgramCounter PC_reg(clk, reset, PC_next, PC);
pcAdder adder1(PC, PC_plus4);
immGen imm_gen(instr, imm);
branchAdder adder2(PC, imm, branchAddr);
mux2 mux(PC_plus4, branchAddr, PCSrc, PC_next);

// Clock generation
always #5 clk = ~clk;
   
//initial  @(posedge clk)
//    PCSrc = 1;

initial begin
    clk = 0;
    reset = 1;
    PCSrc = 0;
    instr = 32'b0;

    #10 reset = 0;

    // Sequential execution (PC + 4)
    #20;

    // Test branch instruction (B-type example)
    //instr = 32'b0000000_00010_00001_000_00000_1100011; // dummy beq
    //instr[0] = 32'h00000063; // simplest BEQ
    //instr = 32'h00a20293; // addi x5,x4,10
    //instr = 32'hff630293; // addi x5,x6,-10
    //instr = 32'h0003a283; // lw x5(0), x6
    instr = 32'h06400293; // li x5, 100
    
    PCSrc = 1;

    #20;

    PCSrc = 0;

    #40;

    $stop;
end

endmodule