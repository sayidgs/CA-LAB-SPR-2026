module RegisterFile(
    input clk,
    input reset,
    input WriteEnable,

    input [4:0] rs1,      // read address 1
    input [4:0] rs2,      // read address 2
    input [4:0] rd,       // write address

    input [31:0] WriteData,

    output [31:0] ReadData1,
    output [31:0] ReadData2
);

reg [31:0] regs [31:0];   // 32 registers

integer i;

always @(posedge clk or posedge reset)
begin
    if (reset) begin
        for(i=0;i<32;i=i+1)
            regs[i] <= 32'b0;
    end
    else if (WriteEnable && rd != 5'b00000) begin
        regs[rd] <= WriteData;
    end
end

// Read ports
assign ReadData1 = (rs1 == 0) ? 32'b0 : regs[rs1];
assign ReadData2 = (rs2 == 0) ? 32'b0 : regs[rs2];

endmodule