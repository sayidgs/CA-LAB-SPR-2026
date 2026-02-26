module ALU_Top (
    input CLK,
    input RST,
    input [3:0] SW,          // Switches for ALUControl
    output [31:0] LED,       // LEDs for ALU result
    output LED_Zero          // Zero flag LED
);

// Fixed Operands
localparam [31:0] A = 32'h10101010;
localparam [31:0] B = 32'h01010101;

// FSM States
reg [1:0] state;
localparam IDLE = 2'b00,
           READ = 2'b01,
           EXEC = 2'b10,
           DISP = 2'b11;

reg [3:0] ALUControl_reg;
wire [31:0] ALUResult;
wire Zero;

// Instantiate ALU
ALU alu_inst (
    .A(A),
    .B(B),
    .ALUControl(ALUControl_reg),
    .ALUResult(ALUResult),
    .Zero(Zero)
);

// FSM Logic
always @(posedge CLK or posedge RST) begin
    if (RST)
        state <= IDLE;
    else begin
        case (state)
            IDLE: state <= READ;
            READ: state <= EXEC;
            EXEC: state <= DISP;
            DISP: state <= READ;
        endcase
    end
end

// Capture switch input
always @(posedge CLK) begin
    if (state == READ)
        ALUControl_reg <= SW;
end

// Output to LEDs
assign LED = ALUResult;
assign LED_Zero = Zero;

endmodule