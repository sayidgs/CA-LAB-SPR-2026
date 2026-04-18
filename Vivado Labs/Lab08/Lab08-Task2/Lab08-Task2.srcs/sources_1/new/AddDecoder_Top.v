`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2026 12:29:53 PM
// Design Name: 
// Module Name: AddDecoder_Top
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



//module addressDecoderTop(

//input clk, rst,
//input [31:0] address,
//input readEnable, writeEnable,
//input [31:0] writeData,
//input [15:0] switches,

//output reg [31:0] readData,
//output reg [15:0] leds

//);

///////////////////////////////////////////////////
//// Decoder signals
///////////////////////////////////////////////////

//wire DataMemRead;
//wire DataMemWrite;
//wire LEDWrite;
//wire SwitchReadEnable;

///////////////////////////////////////////////////
//// Data Memory
///////////////////////////////////////////////////

//wire [31:0] memReadData;

///////////////////////////////////////////////////
//// Instantiate Address Decoder
///////////////////////////////////////////////////

//AddressDecoder decoder(

//.address(address),
//.readEnable(readEnable),
//.writeEnable(writeEnable),

//.DataMemRead(DataMemRead),
//.DataMemWrite(DataMemWrite),
//.LEDWrite(LEDWrite),
//.SwitchReadEnable(SwitchReadEnable)

//);

///////////////////////////////////////////////////
//// Data Memory Instance
///////////////////////////////////////////////////

//DataMemory DM(

//.clk(clk),
//.MemWrite(DataMemWrite),
//.MemRead(DataMemRead),

//.address(address[7:0]),
//.write_data(writeData),

//.read_data(memReadData)

//);

///////////////////////////////////////////////////
//// LED Write Logic
///////////////////////////////////////////////////

//always @(posedge clk or posedge rst)
//begin

//if(rst)
//    leds <= 0;

//else if(LEDWrite)
//    leds <= writeData[15:0];

//end

///////////////////////////////////////////////////
//// Read Data MUX
///////////////////////////////////////////////////

//always @(*)
//begin

//if(DataMemRead)
//    readData = memReadData;

//else if(SwitchReadEnable)
//    readData = {16'b0, switches};

//else
//    readData = 32'b0;

//end

//endmodule

////////////////////////////////////////////2nd NEWEST ONE

//module addressDecoderTop(
//    input clk, rst,
//    input [31:0] address,
//    input readEnable, writeEnable,
//    input [31:0] writeData,
//    input [15:0] switches,

//    output [31:0] readData, // Changed to wire for the mux
//    output reg [15:0] leds
//);

//// Internal Signals
//wire DataMemRead, DataMemWrite, LEDWrite, SwitchReadEnable;
//wire [31:0] memReadData;
//reg [31:0] muxReadData;

//// Instantiate Decoder
//AddressDecoder decoder(
//    .address(address),
//    .readEnable(readEnable),
//    .writeEnable(writeEnable),
//    .DataMemRead(DataMemRead),
//    .DataMemWrite(DataMemWrite),
//    .LEDWrite(LEDWrite),
//    .SwitchReadEnable(SwitchReadEnable)
//);

//// Instantiate Data Memory
//DataMemory DM(
//    .clk(clk),
//    .MemWrite(DataMemWrite),
//    .MemRead(DataMemRead),
//    .address(address[8:0]), // Standard 256-word depth
//    .write_data(writeData),
//    .read_data(memReadData)
//);

//// --- THE FIX: LED Logic ---
//// We want the LEDs to show:
//// 1. Data we just read from Memory (when readEnable is high)
//// 2. Data we explicitly wrote to the "LED Device" (when LEDWrite is high)
//always @(posedge clk or posedge rst) begin
//    if(rst)
//        leds <= 16'b0;
//    else if (DataMemRead)
//        leds <= memReadData[15:0];
//    else if (SwitchReadEnable)
//        leds <= switches;
//    else if (LEDWrite)
//        leds <= writeData[15:0];
//    else
//        leds <= leds; // Maintain current state explicitly
//end


//// Continuous assignment for readData output
//assign readData = muxReadData;

//always @(*) begin
//    if(DataMemRead)
//        muxReadData = memReadData;
//    else if(SwitchReadEnable)
//        muxReadData = {16'b0, switches};
//    else
//        muxReadData = 32'b0;
//end


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
    .address(address[8:0]), 
    .write_data(writeData),
    .read_data(memReadData)
);

// Task: Use 'switches' module to drive the LEDs
led_driver led_driver (
    .clk(clk),
    .rst(rst),
    .writeData(writeData),
    .writeEnable(LEDWrite),
    .leds(leds)

//    .clk(clk),
//    .rst(rst),
//    .writeData(writeData),
//    .writeEnable(LEDWrite),
//    .readEnable(1'b0),     // LEDs are write-only in this context
//    .memAddress(address[29:0]),
//    .readData(),           // Not used for reading
//    .leds(leds)            // Output to physical LEDs
);

// Task: Use 'leds' module to read the physical Switches
switch_reader switch_reader (
    .clk(clk),
    .rst(rst),
    .readEnable(SwitchReadEnable),
    .switches(switches),
    .readData(switchReadData)

//    .clk(clk),
//    .rst(rst),
//    .btns(16'b0),          // No buttons used for data
//    .writeData(writeData),
//    .writeEnable(1'b0),    // Switches are read-only
//    .readEnable(SwitchReadEnable),
//    .memAddress(address[29:0]),
//    .switches(switches),   // Input from physical switches
//    .readData(switchReadData)
);

// Mux for the final ReadData output
assign readData = (DataMemRead)      ? memReadData : 
                  (SwitchReadEnable) ? switchReadData : 
                  32'b0;

endmodule