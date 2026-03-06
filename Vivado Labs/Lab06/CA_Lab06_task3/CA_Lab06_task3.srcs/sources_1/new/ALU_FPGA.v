module ALU_FPGA(

    input clk,
    input rst,
    input [15:0] switches,
    
    output [15:0] leds
);

wire [31:0] ALUResult;
wire Zero;

reg [31:0] A;
reg [31:0] B;
wire [3:0] ALUControl;

assign ALUControl = switches[3:0];   // lower switches select operation

// Fixed operands
always @(posedge clk) begin
    A <= 32'h00000008; // 8 -> 01000
    B <= 32'h00000005; // 5 -> 00101
end

// ALU instance
ALU_32bit alu_inst(
    .A(A),
    .B(B),
    .ALUControl(ALUControl),
    .Result(ALUResult),
    .Zero(Zero)
);

// Display result on LEDs
assign leds = ALUResult[15:0];

endmodule