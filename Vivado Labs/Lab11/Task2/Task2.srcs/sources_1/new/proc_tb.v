//`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date: 04/11/2026 12:14:33 PM
//// Design Name: 
//// Module Name: proc_tb
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


////`timescale 1ns/1ps

////module tb_processor();

////reg clk;
////reg reset;
////reg [15:0] switches;

////wire [15:0] leds;

////// Instantiate your processor
////TopLevelProcessor uut (
////    .clk(clk),
////    .reset(reset),
////    .switches(switches),
////    .leds(leds)
////);

////// Clock generation (10ns period)
////always #5 clk = ~clk;

////// ==============================
////// TEST SEQUENCE
////// ==============================
////initial begin
////    // Initialize
////    clk = 0;
////    reset = 1;
////    switches = 16'd0;

////    // Apply reset
////    #20;
////    reset = 0;

////    // --------------------------
////    // TEST 1: WAIT STATE
////    // --------------------------
////    // switches = 0 ? should stay idle
////    #100;

////    // --------------------------
////    // TEST 2: START FSM
////    // --------------------------
////    switches = 16'd5;   // input value

////    #20;
////    switches = 16'd0;   // should be ignored after capture

////    // Let countdown happen
////    #500;

////    // --------------------------
////    // TEST 3: NEW INPUT
////    // --------------------------
////    switches = 16'd8;

////    #20;
////    switches = 0;

////    #500;

////    // --------------------------
////    // TEST 4: RESET
////    // --------------------------
////    reset = 1;
////    #20;
////    reset = 0;

////    #200;

////    $stop;
////end

////// ==============================
////// MONITOR OUTPUTS
////// ==============================
////initial begin
////    $monitor("Time=%0t | PC=%d | LED=%d | Switch=%d",
////              $time,
////              uut.PC_reg.PC_out,   // accessing internal PC
////              leds,
////              switches);
////end

////endmodule


//`timescale 1ns/1ps

//module tb_TopLevelProcessor;

//reg clk;
//reg reset;
//reg [15:0] switches;

//wire [15:0] leds;

//// Instantiate DUT
//TopLevelProcessor DUT (
//    .clk(clk),
//    .reset(reset),
//    .switches(switches),
//    .leds(leds)
//);

//// ==============================
//// CLOCK GENERATION
//// ==============================
//always #5 clk = ~clk;   // 100 MHz (for simulation only)

//// ==============================
//// INITIAL BLOCK
//// ==============================
//initial begin
//    clk = 0;
//    reset = 1;
//    switches = 16'd0;

//    // Hold reset for a few cycles
//    #20;
//    reset = 0;

//    // =====================================
//    // TEST 1: WAIT STATE (switch = 0)
//    // =====================================
//    #100;

//    // =====================================
//    // TEST 2: PROVIDE INPUT (start FSM)
//    // =====================================
//    switches = 16'd6;

//    #10;
//    switches = 16'd0;   // should be ignored after capture

//    // Let program execute (IMPORTANT: give enough cycles)
//    #2000;

//    // =====================================
//    // TEST 3: NEW INPUT
//    // =====================================
//    switches = 16'd3;

//    #10;
//    switches = 0;

//    #1500;

//    // =====================================
//    // TEST 4: GLOBAL RESET
//    // =====================================
//    reset = 1;
//    #20;
//    reset = 0;

//    #500;

//    $finish;
//end

//// ==============================
//// MONITOR (CRITICAL SIGNALS)
//// ==============================
//initial begin
//    $display("Time\tPC\t\tInstr\t\tLED\tSwitch");
//    $monitor("%0t\t%h\t%h\t%d\t%d",
//        $time,
//        DUT.PC,                 // PC
//        DUT.instruction,        // current instruction
//        leds,
//        switches
//    );
//end

//// ==============================
//// WAVEFORM DUMP
//// ==============================
//initial begin
//    $dumpfile("riscv_processor.vcd");
//    $dumpvars(0, tb_TopLevelProcessor);
//end

//endmodule

