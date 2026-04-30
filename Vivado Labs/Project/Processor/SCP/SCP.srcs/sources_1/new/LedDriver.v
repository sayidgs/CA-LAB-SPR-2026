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
