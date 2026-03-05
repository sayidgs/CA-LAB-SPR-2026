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
    A <= 32'h10101010;
    B <= 32'h01010101;
end

// ALU instance
ALU alu_inst(
    .A(A),
    .B(B),
    .ALUControl(ALUControl),
    .ALUResult(ALUResult),
    .Zero(Zero)
);

// Display result on LEDs
assign leds = ALUResult[15:0];

endmodule