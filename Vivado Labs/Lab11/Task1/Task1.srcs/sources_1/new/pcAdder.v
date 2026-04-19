`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2026 10:24:30 AM
// Design Name: 
// Module Name: pcAdder
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


//module pcAdder(
//    input [31:0] a,
//    output [31:0] y
//);

//assign y = a + 32'd4;

//endmodule


module pcAdder(
    input [31:0] a,
    output [31:0] y
);
    wire [31:0] carry;
    wire [31:0] b = 32'd4; // The value we are adding to PC

    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : FA_CHAIN
            full_adder fa_inst (
                .A(a[i]),
                .B(b[i]),
                .Cin(i == 0 ? 1'b0 : carry[i-1]),
                .Sum(y[i]),
                .Cout(carry[i])
            );
        end
    endgenerate

endmodule
