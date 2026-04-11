`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2026 10:24:30 AM
// Design Name: 
// Module Name: branchAdder
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


module branchAdder(
    input [31:0] pc,
    input [31:0] imm,
    output [31:0] branchAddr
);

//assign branchAddr = pc + (imm << 1);
assign branchAddr = pc + imm;

endmodule
