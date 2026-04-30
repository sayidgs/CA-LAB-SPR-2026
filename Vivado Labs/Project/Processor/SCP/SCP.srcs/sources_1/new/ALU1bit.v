module ALU_1bit(
    input A,
    input B,
    input Binvert,
    input Cin,
    input [3:0] ALUControl,

    output reg Result,
    output Cout
);

wire B_mux;
wire sum;
wire carry;

assign B_mux = B ^ Binvert;

full_adder FA(
    .A(A),
    .B(B_mux),
    .Cin(Cin),
    .Sum(sum),
    .Cout(carry)
);

always @(*) begin
    case(ALUControl)

        4'b0000: Result = sum;        // ADD
        4'b0001: Result = sum;        // SUB
        4'b0010: Result = A & B;      // AND
        4'b0011: Result = A | B;      // OR
        4'b0100: Result = A ^ B;      // XOR
        default: Result = sum;

    endcase
end

assign Cout = carry;

endmodule