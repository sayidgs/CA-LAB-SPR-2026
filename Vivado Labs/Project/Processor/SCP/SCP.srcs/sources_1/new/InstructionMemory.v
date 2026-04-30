//module instructionMemory(
//    input [7:0] instAddress,
//    output reg [31:0] instruction
//);

//reg [31:0] memory [0:255];

//initial begin
//    $readmemh("program.mem", memory);
//end

//always @(*) begin
////    instruction = memory[instAddress >> 2];

//    instruction = memory[instAddress];
//end

//endmodule
  
module instructionMemory(
    input [7:0] instAddress,
    output reg [31:0] instruction
);

// 256 words x 32 bits = 1 KB of instruction memory
reg [31:0] memory [0:255];

initial begin
    $readmemh("program.mem", memory);
end

// Use instAddress directly (= PC[9:2] = PC/4) as the word index
always @(instAddress) begin
    instruction = memory[instAddress];
end

endmodule