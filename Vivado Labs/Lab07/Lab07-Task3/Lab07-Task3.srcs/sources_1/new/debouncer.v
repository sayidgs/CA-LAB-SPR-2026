`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2026 09:08:46 AM
// Design Name: 
// Module Name: debouncer
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module debouncer(
    input clk,
    input pbin,        // raw button input
    output reg pbout   // debounced output
);

reg [19:0] counter = 0;
reg sync_0 = 0, sync_1 = 0;
reg stable = 0;

// Step 1: Synchronize (avoid metastability)
always @(posedge clk) begin
    sync_0 <= pbin;
    sync_1 <= sync_0;
end

// Step 2: Debounce using counter
always @(posedge clk) begin
    if (sync_1 == stable) begin
        counter <= 0;
    end else begin
        counter <= counter + 1;
        if (counter == 20'd1_000_000) begin // ~10ms at 100MHz
            stable <= sync_1;
        end
    end
end

// Step 3: Output
always @(posedge clk) begin
    pbout <= stable;
end

endmodule