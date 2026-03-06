//module ALU (
//    input  [31:0] A,
//    input  [31:0] B,
//    input  [3:0]  ALUControl,
//    output reg [31:0] ALUResult,
//    output Zero
//);

//always @(*) begin
//    case (ALUControl)
//        4'b0000: ALUResult = A + B;               // ADD
//        4'b0001: ALUResult = A - B;               // SUB
//        4'b0010: ALUResult = A & B;               // AND
//        4'b0011: ALUResult = A | B;               // OR
//        4'b0100: ALUResult = A ^ B;               // XOR
//        4'b0101: ALUResult = A << B[4:0];         // SLL (shift left logical)
//        4'b0110: ALUResult = A >> B[4:0];         // SRL (shift right logical)
//        4'b0111: ALUResult = (A < B) ? 32'b1 : 32'b0; // SLT
//        default: ALUResult = 32'b0;
//    endcase
//end

//assign Zero = (ALUResult == 32'b0);

//endmodule

module full_adder(
    input A,
    input B,
    input Cin,
    output Sum,
    output Cout
);

assign Sum  = A ^ B ^ Cin;
assign Cout = (A & B) | (Cin & (A ^ B));

endmodule

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

module ALU_32bit(

    input [31:0] A,
    input [31:0] B,
    input [3:0] ALUControl,

    output reg [31:0] Result,
    output Zero
);

wire [31:0] alu_result;
wire [31:0] carry;

wire Binvert;

assign Binvert = (ALUControl == 4'b0001); // only for SUB

genvar i;

generate
for(i=0;i<32;i=i+1) begin : ALU_CHAIN

    ALU_1bit alu(

        .A(A[i]),
        .B(B[i]),
        .Binvert(Binvert),

        .Cin(i==0 ? Binvert : carry[i-1]),

        .ALUControl(ALUControl),

        .Result(alu_result[i]),
        .Cout(carry[i])

    );

end
endgenerate

always @(*) begin

    case(ALUControl)

        4'b0101: Result = A << B[4:0];      // SLL
        4'b0110: Result = A >> B[4:0];      // SRL
        4'b0111: Result = (A < B) ? 32'd1 : 32'd0; // SLT

        default: Result = alu_result;       // all others

    endcase

end

assign Zero = (Result == 0);

endmodule