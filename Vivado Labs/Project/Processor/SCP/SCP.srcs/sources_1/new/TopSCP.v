//module TopLevelProcessor(
//    input clk,
//    input reset,
//    input [15:0] switches,
//    output [15:0] leds
//);

//wire reset_clean;

//// WIRES
//wire Jump;

//// For JALR
//wire isJALR = (instruction[6:0] == 7'b1100111);

//// PC
//wire [31:0] PC, PC_next, PC_plus4, branchAddr;

//// Instruction
//wire [31:0] instruction;

//// Register File
//wire [31:0] ReadData1, ReadData2, WriteData;

//// Immediate
//wire [31:0] imm;

//// ALU
//wire [31:0] ALUResult;
//wire Zero;

//// Control Signals
//wire RegWrite, ALUSrc, MemRead, MemWrite, MemtoReg, Branch;
//wire [1:0] ALUOp;
//wire [3:0] ALUCtrl;

//// MUX outputs
//wire [31:0] ALU_input2;
//wire PCSrc;

//// Data Memory / IO
//wire [31:0] ReadData;


//// MODULE INSTANTIATION

////  NEWEST addition
//// Clock devider starts
//reg [31:0] counter = 0;

//always @(posedge clk) begin
//    counter <= counter + 1;
//end

////wire slow_clk = (counter[0] || 1'b1); // Forces simulation to use fast clock
//wire slow_clk = counter[23]; // VERY slow (~1 Hz)
// //wire slow_clk = clk;
// //Clock devider ends

//debouncer db_reset(
//    .clk(clk),
//    .pbin(reset),
//    .pbout(reset_clean)
//);

////wire reset_clean = reset;             // Bypasses debouncer for simulation

//// Program Counter
//ProgramCounter PC_reg(
//    .clk(slow_clk),
//    .reset(reset_clean),
//    .PC_in(PC_next),
//    .PC_out(PC)
//);

//// PC + 4
//pcAdder pc_add(
//    .a(PC),
//    .y(PC_plus4)
//);

//// Instruction Memory
//instructionMemory IM(
//    .instAddress(PC[9:2]),  // word aligned index
//    .instruction(instruction)
//);

//// Control Unit
//MainControl control(
//    .opcode(instruction[6:0]),
//    .RegWrite(RegWrite),
//    .ALUSrc(ALUSrc),
//    .MemRead(MemRead),
//    .MemWrite(MemWrite),
//    .MemtoReg(MemtoReg),
//    .Branch(Branch),
//    .ALUOp(ALUOp),
//    .Jump(Jump)
//);

//// Register File
//RegisterFile RF(
//    .clk(slow_clk),
//    .reset(reset_clean),
//    .WriteEnable(RegWrite),
//    .rs1(instruction[19:15]),
//    .rs2(instruction[24:20]),
//    .rd(instruction[11:7]),
//    .WriteData(WriteData),
//    .ReadData1(ReadData1),
//    .ReadData2(ReadData2)
//);

//// Immediate Generator
//immGen IMM(
//    .instr(instruction),
//    .imm_out(imm)
//);

//// ALU Control
//ALUControl ALUCTRL(
//    .ALUOp(ALUOp),
//    .funct3(instruction[14:12]),
//    .funct7(instruction[31:25]),
//    .ALUControl(ALUCtrl)
//);

//// ALU input mux
//mux2 ALU_mux(
//    .a(ReadData2),
//    .b(imm),
//    .sel(ALUSrc),
//    .y(ALU_input2)
//);

//// ALU
//ALU_32bit ALU(
//    .A(ReadData1),
//    .B(ALU_input2),
//    .ALUControl(ALUCtrl),
//    .Result(ALUResult),
//    .Zero(Zero)
//);

//// Branch Adder
//branchAdder BA(
//    .pc(PC),
//    .imm(imm),
//    .branchAddr(branchAddr)
//);

//// Branch decision
////assign PCSrc = Branch & Zero;
//wire isBEQ = (instruction[14:12] == 3'b000);
//wire isBNE = (instruction[14:12] == 3'b001);

//assign PCSrc = Branch & ((isBEQ & Zero) | (isBNE & !Zero));


//// PC MUX

//// OLD ONE
////mux2 PC_mux(
////    .a(PC_plus4),
////    .b(branchAddr),
////    .sel(PCSrc),
////    .y(PC_next)
////);


//// Define the final PC source
//wire [31:0] PC_inter; // Middle wire between Branch mux and Jump mux

//// Branch Mux (Already exists as PC_mux in code)
//mux2 Branch_Mux (
//    .a(PC_plus4),
//    .b(branchAddr),
//    .sel(PCSrc),
//    .y(PC_inter)
//);

//// Jump target logic
//wire [31:0] jalr_target;
//assign jalr_target = (ALUResult) & 32'hFFFFFFFE;

//// Fixed Jump Mux for JALR
//mux2 Jump_Mux (
//    .a(PC_inter),
//    .b(isJALR ? jalr_target : branchAddr),
//    .sel(Jump),
//    .y(PC_next)
//);

////// New Jump Mux
////mux2 Jump_Mux (
////    .a(PC_inter),
////    .b(branchAddr), // In JAL, branchAddr (PC + Imm) is also the Jump Target
////    .sel(Jump),
////    .y(PC_next)
////);

//// Data Memory + IO
//addressDecoderTop MEM_IO(
//    .clk(slow_clk),
//    .rst(reset_clean),
//    .address(ALUResult),
//    .readEnable(MemRead),
//    .writeEnable(MemWrite),
//    .writeData(ReadData2),
//    .switches(switches),
//    .readData(ReadData),
//    .leds(leds)
//);

////assign leds = ALUResult[15:0];

//// Write Back MUX
////mux2 WB_mux(
////    .a(ALUResult),
////    .b(ReadData),
////    .sel(MemtoReg),
////    .y(WriteData)
////);
//assign WriteData = (Jump) ? PC_plus4 :
//                   (MemtoReg) ? ReadData :
//                   ALUResult;

//endmodule


module TopLevelProcessor(
    input clk,
    input reset,
    input [15:0] switches,
    output [15:0] leds
);

wire reset_clean;

// Control signals
wire Jump;

// Detect JALR instruction (opcode = 1100111)
wire isJALR = (instruction[6:0] == 7'b1100111);

// PC wires
wire [31:0] PC, PC_next, PC_plus4, branchAddr;

// Instruction
wire [31:0] instruction;

// Register File outputs
wire [31:0] ReadData1, ReadData2, WriteData;

// Immediate
wire [31:0] imm;

// ALU
wire [31:0] ALUResult;
wire Zero;

// Control Signals
wire RegWrite, ALUSrc, MemRead, MemWrite, MemtoReg, Branch;
wire [1:0] ALUOp;
wire [3:0] ALUCtrl;

// MUX outputs
wire [31:0] ALU_input2;
wire PCSrc;

// Data Memory / IO read data
wire [31:0] ReadData;


// ============================================================
// Clock Divider
// counter[23] = ~6 Hz at 100 MHz  (100e6 / 2^23 = ~12 ticks/s, one toggle = ~6 Hz)
// Adjust the bit index to change execution speed:
//   counter[0]  = 50 MHz (fast, useful for simulation)
//   counter[21] = ~24 Hz
//   counter[23] = ~6 Hz  (good for FPGA LED visibility)
// ============================================================
reg [31:0] counter = 0;

always @(posedge clk) begin
    counter <= counter + 1;
end

wire slow_clk = counter[26];  // ~6 Hz - visible on LEDs during demo
// wire slow_clk = clk;        // Use this for simulation / testbench

// ============================================================
// Debounce reset button
// ============================================================
debouncer db_reset(
    .clk(clk),
    .pbin(reset),
    .pbout(reset_clean)
);

// ============================================================
// Program Counter
// ============================================================
ProgramCounter PC_reg(
    .clk(slow_clk),
    .reset(reset_clean),
    .PC_in(PC_next),
    .PC_out(PC)
);

// ============================================================
// PC + 4 adder
// ============================================================
pcAdder pc_add(
    .a(PC),
    .y(PC_plus4)
);

// ============================================================
// Instruction Memory
// Passes PC[9:2] - converts byte address to word index (PC/4).
// With 8-bit index this addresses 256 words = 1 KB of instructions.
// ============================================================
instructionMemory IM(
    .instAddress(PC[9:2]),
    .instruction(instruction)
);

// ============================================================
// Main Control Unit
// ============================================================
MainControl control(
    .opcode(instruction[6:0]),
    .RegWrite(RegWrite),
    .ALUSrc(ALUSrc),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .MemtoReg(MemtoReg),
    .Branch(Branch),
    .ALUOp(ALUOp),
    .Jump(Jump)
);

// ============================================================
// Register File
// ============================================================
RegisterFile RF(
    .clk(slow_clk),
    .reset(reset_clean),
    .WriteEnable(RegWrite),
    .rs1(instruction[19:15]),
    .rs2(instruction[24:20]),
    .rd(instruction[11:7]),
    .WriteData(WriteData),
    .ReadData1(ReadData1),
    .ReadData2(ReadData2)
);

// ============================================================
// Immediate Generator
// ============================================================
immGen IMM(
    .instr(instruction),
    .imm_out(imm)
);

// ============================================================
// ALU Control
// ============================================================
ALUControl ALUCTRL(
    .ALUOp(ALUOp),
    .funct3(instruction[14:12]),
    .funct7(instruction[31:25]),
    .ALUControl(ALUCtrl)
);

// ============================================================
// ALU Input Mux: selects register B or immediate
// ============================================================
mux2 ALU_mux(
    .a(ReadData2),
    .b(imm),
    .sel(ALUSrc),
    .y(ALU_input2)
);

// ============================================================
// ALU
// ============================================================
ALU_32bit ALU(
    .A(ReadData1),
    .B(ALU_input2),
    .ALUControl(ALUCtrl),
    .Result(ALUResult),
    .Zero(Zero)
);

// ============================================================
// Branch Adder: PC + immediate (ImmGen already encodes shift for B-type)
// ============================================================
branchAdder BA(
    .pc(PC),
    .imm(imm),
    .branchAddr(branchAddr)
);

// ============================================================
// Branch decision: supports BEQ (funct3=000) and BNE (funct3=001)
// ============================================================
wire isBEQ = (instruction[14:12] == 3'b000);
wire isBNE = (instruction[14:12] == 3'b001);

assign PCSrc = Branch & ((isBEQ & Zero) | (isBNE & ~Zero));

// ============================================================
// PC MUX chain:
//   Branch Mux: selects PC+4 or branchAddr
//   Jump Mux:   selects result of above or jump target
//
// JAL  target = PC + imm   (branchAddr, since ImmGen handles J-type)
// JALR target = (rs1 + imm) & ~1 = ALUResult & 0xFFFFFFFE
// ============================================================
wire [31:0] PC_inter;  // output of branch mux, input of jump mux

mux2 Branch_Mux(
    .a(PC_plus4),
    .b(branchAddr),
    .sel(PCSrc),
    .y(PC_inter)
);

// JALR target: rs1+imm (computed by ALU with ALUSrc=1, ALUOp=00/ADD), LSB cleared
wire [31:0] jalr_target;
assign jalr_target = ALUResult & 32'hFFFFFFFE;

// Jump mux: for JAL use branchAddr (PC+imm); for JALR use jalr_target
mux2 Jump_Mux(
    .a(PC_inter),
    .b(isJALR ? jalr_target : branchAddr),
    .sel(Jump),
    .y(PC_next)
);

// ============================================================
// Data Memory + Memory-Mapped I/O (LEDs and Switches)
// ============================================================
addressDecoderTop MEM_IO(
    .clk(slow_clk),
    .rst(reset_clean),
    .address(ALUResult),
    .readEnable(MemRead),
    .writeEnable(MemWrite),
    .writeData(ReadData2),
    .switches(switches),
    .readData(ReadData),
    .leds(leds)
);

// ============================================================
// Write-Back Mux:
//   Jump instruction  -> save PC+4 (return address) into rd
//   Memory load       -> write loaded data into rd
//   Otherwise         -> write ALU result into rd
// ============================================================
assign WriteData = (Jump)     ? PC_plus4  :
                   (MemtoReg) ? ReadData  :
                   ALUResult;

endmodule