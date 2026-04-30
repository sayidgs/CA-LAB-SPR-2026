module switch_reader(
    input clk, 
    input rst,
    input readEnable,
    input [15:0] switches,
    output reg [31:0] readData
);

always @(posedge clk or posedge rst) begin
    if (rst)
        readData <= 32'b0;
    else if (readEnable)
        readData <= {16'b0, switches};
    else
        readData <= readData; // hold value
end

endmodule
