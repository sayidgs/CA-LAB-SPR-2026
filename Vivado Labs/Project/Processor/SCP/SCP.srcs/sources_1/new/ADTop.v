module addressDecoderTop(
    input clk, rst,
    input [31:0] address,
    input readEnable, writeEnable,
    input [31:0] writeData,
    input [15:0] switches,

    output [31:0] readData, 
    output [15:0] leds
);

// Internal Signals
wire DataMemRead, DataMemWrite, LEDWrite, SwitchReadEnable;
wire [31:0] memReadData;
wire [31:0] switchReadData; // Data read FROM the switches/btns module

// Instantiate Decoder
AddressDecoder decoder(
    .address(address),
    .readEnable(readEnable),
    .writeEnable(writeEnable),
    .DataMemRead(DataMemRead),
    .DataMemWrite(DataMemWrite),
    .LEDWrite(LEDWrite),
    .SwitchReadEnable(SwitchReadEnable)
);

// Instantiate Data Memory
DataMemory DM(
    .clk(clk),
    .MemWrite(DataMemWrite),
    .MemRead(DataMemRead),
    .address(address[10:2]), 
    .write_data(writeData),
    .read_data(memReadData)
);

// Task: Use 'switches' module to drive the LEDs
// CLOCK FIX: Use slow_clk instead of fast clk to match processor timing
led_driver led_driver (
    .clk(clk),
    .rst(rst),
    .writeData(writeData),
    .writeEnable(LEDWrite),
    .leds(leds)
);

// Task: Use 'leds' module to read the physical Switches
switch_reader switch_reader (
    .clk(clk),
    .rst(rst),
    .readEnable(SwitchReadEnable),
    .switches(switches),
    .readData(switchReadData)
);

// Mux for the final ReadData output
assign readData = (DataMemRead)      ? memReadData : 
                  (SwitchReadEnable) ? switchReadData : 
                  32'b0;

endmodule