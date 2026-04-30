module ALUControl(
    input [1:0] ALUOp,
    input [2:0] funct3,
    input [6:0] funct7,
    output reg [3:0] ALUControl
);

//always @(*) begin
//    case(ALUOp)

//        // Load/Store ? ADD
//        2'b00: ALUControl = 4'b0000;

//        // Branch ? SUB (for BEQ)
//        2'b01: ALUControl = 4'b0110;

//        // R-type / I-type
//        2'b10: begin
//            case(funct3)

//                3'b000: ALUControl = (funct7 == 7'b0100000) ? 4'b0001 : 4'b0000; // SUB / ADD
//                3'b001: ALUControl = 4'b0101; // SLL
//                3'b101: ALUControl = 4'b0110; // SRL
//                3'b111: ALUControl = 4'b0010; // AND
//                3'b110: ALUControl = 4'b0011; // OR
//                3'b100: ALUControl = 4'b0100; // XOR
//                3'b010: ALUControl = 4'b0111; // SLT

//                default: ALUControl = 4'b0000;
//            endcase
//        end
        
//        // U-type / Special
//        2'b11: ALUControl = 4'b1111; // Custom code for "Pass B"

//        default: ALUControl = 4'b0000;

//    endcase
//end

//endmodule

always @(*) begin
    case(ALUOp)
 
        // Load/Store -> ADD (compute address: base + offset)
        2'b00: ALUControl = 4'b0000;
 
        // Branch -> SUB (compute A - B, then check Zero flag for BEQ/BNE)
        // BUG FIX: was 4'b0110 (SRL) - must be 4'b0001 (SUB)
        2'b01: ALUControl = 4'b0001;
 
        // R-type / I-type: decode from funct3 / funct7
        2'b10: begin
            case(funct3)
                3'b000: ALUControl = (funct7 == 7'b0100000) ? 4'b0001 : 4'b0000; // SUB / ADD
                3'b001: ALUControl = 4'b0101; // SLL
                3'b101: ALUControl = 4'b0110; // SRL
                3'b111: ALUControl = 4'b0010; // AND
                3'b110: ALUControl = 4'b0011; // OR
                3'b100: ALUControl = 4'b0100; // XOR
                3'b010: ALUControl = 4'b0111; // SLT
                default: ALUControl = 4'b0000;
            endcase
        end
 
        // U-type (LUI) -> Pass immediate through as result
        2'b11: ALUControl = 4'b1111;
 
        default: ALUControl = 4'b0000;
 
    endcase
end
 
endmodule
