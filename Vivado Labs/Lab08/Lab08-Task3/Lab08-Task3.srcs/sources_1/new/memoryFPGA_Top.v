`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2026 09:05:24 PM
// Design Name: 
// Module Name: memoryFPGA_Top
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




//NEWEST ONE


//module memoryFPGA_Top(
//    input clk,
//    input rst,
//    input [15:0] switches,  // [15:8] = Address, [7:0] = Data
//    input btnU,             // Write Enable
//    input btnD,             // Read Enable
//    output [15:0] leds      // Display
//);

///////////////////////////////////////////////////
//// Internal signals
///////////////////////////////////////////////////
//wire [31:0] readData;
//reg [31:0] address;
//reg [31:0] writeData;

//wire readEnable;
//wire writeEnable;

///////////////////////////////////////////////////
//// Button mapping
///////////////////////////////////////////////////
//assign writeEnable = btnU;
//assign readEnable  = btnD;

///////////////////////////////////////////////////
//// FIXED: Improved Switch Mapping
///////////////////////////////////////////////////
//always @(*) begin
//    // Use top 8 switches for address (0-255)
//    // We set bits [9:8] to 00 to ensure we are targeting DATA MEMORY by default
//    address = {22'b0, 2'b00, switches[15:8]}; 
    
//    // Use bottom 8 switches for data
//    writeData = {24'b0, switches[7:0]};
//end

///////////////////////////////////////////////////
//// Memory System Instance
///////////////////////////////////////////////////
//addressDecoderTop memorySystem(
//    .clk(clk),
//    .rst(rst),
//    .address(address),
//    .readEnable(readEnable),
//    .writeEnable(writeEnable),
//    .writeData(writeData),
//    .switches(switches),
//    .readData(readData),
//    .leds(leds)
//);

//endmodule

// OLD ONE
//module memoryFPGA_Top(

//    input clk,
//    input rst,

//    input [15:0] switches,      // board switches
//    input btnU,           // write enable
//    input btnD,           // read enable

//    output [15:0] leds     // board LEDs
//);

///////////////////////////////////////////////////
//// Internal signals
///////////////////////////////////////////////////

//wire [31:0] readData;
//reg [31:0] address;
//reg [31:0] writeData;

//wire readEnable;
//wire writeEnable;

///////////////////////////////////////////////////
//// Button mapping
///////////////////////////////////////////////////

//assign writeEnable = btnU;
//assign readEnable  = btnD;

///////////////////////////////////////////////////
//// Address and data from switches
///////////////////////////////////////////////////

//always @(*) begin
//    address   = {22'b0, switches[9:0]};   // 10-bit memory map
//    writeData = {16'b0, switches};        // lower 16 bits from switches
//end

///////////////////////////////////////////////////
//// Memory System Instance
///////////////////////////////////////////////////

//addressDecoderTop memorySystem(

//.clk(clk),
//.rst(rst),

//.address(address),
//.readEnable(readEnable),
//.writeEnable(writeEnable),

//.writeData(writeData),

//.switches(switches),

//.readData(readData),
//.leds(leds)

//);

//endmodule


///MOST RECENT ONE
//module memoryFPGA_Top(
//    input clk,
//    input rst,
//    input [15:0] switches, 
//    input btnU, // Write Trigger
//    input btnD, // Read Trigger
//    input btnC, // ADDRESS SET Trigger (New)
//    output [15:0] leds
//);

//reg [31:0] latched_address;
//wire [31:0] readData;
//wire [31:0] writeData;

//// --- Task 3 Logic: Reusing switches ---
//// Press Center Button to lock in the address from switches
//always @(posedge clk or posedge rst) begin
//    if(rst) 
//        latched_address <= 32'b0;
//    else if(btnC)
//        latched_address <= {22'b0, switches[9:0]}; // Lab manual uses 10 bits
//end

//// Data to write always comes from the current state of switches
//assign writeData = {16'b0, switches};

//addressDecoderTop memorySystem(
//    .clk(clk),
//    .rst(rst),
//    .address(latched_address),
//    .readEnable(btnD),
//    .writeEnable(btnU),
//    .writeData(writeData),
//    .switches(switches),
//    .readData(readData),
//    .leds(leds)
//);

//endmodule


////////THE NEWEST ONE
module memoryFPGA_Top(
    input clk,
    input rst,
    input [15:0] switches, 
    input btnU, // Write Trigger (Manual pulse)
    input btnD, // Read Trigger (Manual pulse)
    input btnC, // Address Latch Trigger
    output [15:0] leds
);

    reg [31:0] latched_address;
    wire [31:0] readData_wire;
    wire [31:0] writeData_wire;
    
    // --- Latching Address ---
    // When Center Button is pressed, current switch values become the Memory Address
    always @(posedge clk or posedge rst) begin
        if(rst) 
            latched_address <= 32'b0;
        else if(btnC)
            latched_address <= {16'b0, switches}; 
    end

    // --- Data to Write ---
    // The data written to Memory/LEDs always comes from the current switch configuration
    assign writeData_wire = {16'b0, switches};

    // --- Module Integration ---
    addressDecoderTop memorySystem(
        .clk(clk),
        .rst(rst),
        .address(latched_address),
        .readEnable(btnD),    // Activated by Down Button
        .writeEnable(btnU),   // Activated by Up Button
        .writeData(writeData_wire),
        .switches(switches),
        .readData(readData_wire),
        .leds(leds)           // This connects to the physical FPGA LEDs
    );

endmodule
