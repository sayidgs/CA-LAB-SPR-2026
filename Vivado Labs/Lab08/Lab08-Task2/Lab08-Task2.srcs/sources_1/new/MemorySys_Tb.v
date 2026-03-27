//`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date: 03/12/2026 12:29:53 PM
//// Design Name: 
//// Module Name: MemorySys_Tb
//// Project Name: 
//// Target Devices: 
//// Tool Versions: 
//// Description: 
//// 
//// Dependencies: 
//// 
//// Revision:
//// Revision 0.01 - File Created
//// Additional Comments:
//// 
////////////////////////////////////////////////////////////////////////////////////



//module MemorySystem_tb;

//reg clk;
//reg rst;

//reg [31:0] address;
//reg readEnable;
//reg writeEnable;
//reg [31:0] writeData;

//reg [15:0] switches;

//wire [31:0] readData;
//wire [15:0] leds;

//addressDecoderTop DUT(

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

///////////////////////////////////////////////////
//// Clock
///////////////////////////////////////////////////

//always #5 clk = ~clk;

///////////////////////////////////////////////////
//// Test
///////////////////////////////////////////////////

//initial
//begin

//clk = 0;
//rst = 1;

//readEnable = 0;
//writeEnable = 0;
////writeData = 0;
////switches = 0;
//#20 rst = 0;

///////////////////////////////////////////////////
//// WRITE DATA MEMORY
///////////////////////////////////////////////////

//address = 32'd20;        // Data memory
//writeData = 32'hAAAA5555;

//writeEnable = 1;
//#10;

//writeEnable = 0;

///////////////////////////////////////////////////
//// READ DATA MEMORY
///////////////////////////////////////////////////

//readEnable = 1;
//#10;

//readEnable = 0;

///////////////////////////////////////////////////
//// WRITE LED
///////////////////////////////////////////////////

//address = 32'd520;       // LED address (01)

//writeData = 32'h000000FF;

//writeEnable = 1;
//#10;

//writeEnable = 0;

///////////////////////////////////////////////////
//// READ SWITCH
///////////////////////////////////////////////////

//switches = 16'hABCD;

//address = 32'd800;       // Switch address (10)

//readEnable = 1;
//#10;

//readEnable = 0;

//#50 $finish;

//end

//endmodule

`timescale 1ns / 1ps

module MemorySystem_tb();

    // Inputs
    reg clk;
    reg rst;
    reg [31:0] address;
    reg readEnable;
    reg writeEnable;
    reg [31:0] writeData;
    reg [15:0] switches;

    // Outputs
    wire [31:0] readData;
    wire [15:0] leds;

    // Instantiate the Unit Under Test
    addressDecoderTop uut (
        .clk(clk), 
        .rst(rst), 
        .address(address), 
        .readEnable(readEnable), 
        .writeEnable(writeEnable), 
        .writeData(writeData), 
        .switches(switches), 
        .readData(readData), 
        .leds(leds)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 1;
        address = 0;
        readEnable = 0;
        writeEnable = 0;
        writeData = 0;
        switches = 0;

        // Wait for global reset
        #100;
        rst = 0;
        #20;

        // write 32'hABCD1234 to Address 10
        address = 32'h0000000A;
        writeData = 32'hABCD1234;
        writeEnable = 1;
        #10;
        writeEnable = 0;
        #10;

        // Read from Data Memory
        readEnable = 1;
        #10;
        // Verify readData is 32'hABCD1234
        readEnable = 0;
        #20;

        // Write to LEDs
        // write 16'hFFFF to LED 
        address = 32'h00000200;
        writeData = 32'h0000FFFF;
        writeEnable = 1;
        #10;
        writeEnable = 0;
        #20;

        // Read from Switches 
        switches = 16'h55AA;
        address = 32'h00000300; 
        readEnable = 1;
        #10;
        // Verify readData shows {16'b0, 16'h55AA}
        readEnable = 0;
        
        #50;
        $stop; 
    end
      

endmodule