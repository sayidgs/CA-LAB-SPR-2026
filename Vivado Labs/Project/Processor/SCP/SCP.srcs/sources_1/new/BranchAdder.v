module branchAdder(
    input [31:0] pc,
    input [31:0] imm,
    output [31:0] branchAddr
);

//assign branchAddr = pc + (imm << 1);
assign branchAddr = pc + imm;

endmodule
