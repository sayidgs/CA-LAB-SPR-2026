module DataMemory(
    input clk,
    input MemWrite,
    input MemRead,
    input [8:0] address, 
    input [31:0] write_data,
    output [31:0] read_data
);
    reg [31:0] memory [0:511];

    // --- ADD THIS INITIALIZATION BLOCK ---
    integer i;
    initial begin
        for (i = 0; i < 512; i = i + 1) begin
            memory[i] = 32'h00000000;
        end
    end

    always @(posedge clk) begin
        if(MemWrite)
            memory[address] <= write_data;
    end

    assign read_data = (MemRead) ? memory[address] : 32'b0;
endmodule
