`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2026 09:08:46 AM
// Design Name: 
// Module Name: led
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


module led_driver(
    input clk, 
    input rst,
    input [31:0] writeData,
    input writeEnable,
    output reg [15:0] leds
);

always @(posedge clk or posedge rst) begin
    if (rst)
        leds <= 16'b0;
    else if (writeEnable)
        leds <= writeData[15:0];
end

endmodule



//module leds(
//    input clk, rst,
//    input [15:0] btns,
//    input [31:0] writeData,
//    input writeEnable,
//    input readEnable,
//    input [29:0] memAddress,
//    input [15:0] switches,
//    output reg [31:0] readData
//);
//    // Reads physical switches into the system bus
//    always @(posedge clk or posedge rst) begin
//        if(rst) readData <= 32'b0;
//        else if(readEnable) readData <= {16'b0, switches};
//        else readData <= 32'b0;
//    end
//endmodule