//module ALU_32bit(

//    input [31:0] A,
//    input [31:0] B,
//    input [3:0] ALUControl,

//    output reg [31:0] Result,
//    output Zero
//);

//wire [31:0] alu_result;
//wire [31:0] carry;

//wire Binvert;

//assign Binvert = (ALUControl == 4'b0001); // only for SUB

//genvar i;

//generate
//for(i=0;i<32;i=i+1) begin : ALU_CHAIN

//    ALU_1bit alu(

//        .A(A[i]),
//        .B(B[i]),
//        .Binvert(Binvert),

//        .Cin(i==0 ? Binvert : carry[i-1]),

//        .ALUControl(ALUControl),

//        .Result(alu_result[i]),
//        .Cout(carry[i])

//    );

//end
//endgenerate

//always @(*) begin

//    case(ALUControl)

//        4'b0101: Result = A << B[4:0];      // SLL
//        4'b0110: Result = A >> B[4:0];      // SRL
//        4'b0111: Result = (A < B) ? 32'd1 : 32'd0; // SLT
//        4'b1111: Result = B; // LUI: Result is just the immediate

//        default: Result = alu_result;       // all others

//    endcase

//end

//assign Zero = (Result == 0);

//endmodule

module ALU_32bit(

    input [31:0] A,
    input [31:0] B,
    input [3:0] ALUControl,

    output reg [31:0] Result,
    output Zero
);

wire [31:0] alu_result;
wire [32:0] carry;   // carry[0]=Cin of bit-0, carry[i+1]=Cout of bit-i

wire Binvert;

assign Binvert = (ALUControl == 4'b0001); // only for SUB

// Initial carry-in: Binvert (1 for SUB to implement two's complement, 0 for ADD)
assign carry[0] = Binvert;

genvar i;

generate
for(i = 0; i < 32; i = i + 1) begin : ALU_CHAIN

    ALU_1bit alu(
        .A(A[i]),
        .B(B[i]),
        .Binvert(Binvert),
        .Cin(carry[i]),       // fixed: was carry[i-1] which gave carry[-1] at i=0
        .ALUControl(ALUControl),
        .Result(alu_result[i]),
        .Cout(carry[i+1])
    );

end
endgenerate

always @(*) begin

    case(ALUControl)

        4'b0101: Result = A << B[4:0];                              // SLL
        4'b0110: Result = A >> B[4:0];                              // SRL
        4'b0111: Result = ($signed(A) < $signed(B)) ? 32'd1 : 32'd0; // SLT (signed)
        4'b1111: Result = B;                                        // LUI: pass immediate

        default: Result = alu_result;                               // ADD/SUB/AND/OR/XOR

    endcase

end

assign Zero = (Result == 32'b0);

endmodule