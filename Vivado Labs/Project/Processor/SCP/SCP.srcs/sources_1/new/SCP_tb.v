//`timescale 1ns/1ps

//module TopSCP_tb;

//reg clk;
//reg reset;
//reg [15:0] switches;
//wire [15:0] leds;

//// Instantiate DUT
//TopLevelProcessor uut(
//    .clk(clk),
//    .reset(reset),
//    .switches(switches),
//    .leds(leds)
//);

//initial begin
//    $dumpfile("TopSCP_tb.vcd");
//    $dumpvars(0, uut);

//    // Init
//    clk = 0;
//    reset = 1;
//    switches = 16'h0000;

//    #100;       // let things settle
//    reset = 0;  // release reset

//    // For simulation: force the internal slow clock to follow the testbench clock
//    // so the processor executes at simulation speed instead of waiting for counter[26].
//    force uut.slow_clk = clk;

//    // Stimulus: change switches while program runs
//    #200; switches = 16'h00FF;
//    #200; switches = 16'h0F0F;
//    #200; switches = 16'hFFFF;

//    // Let the DUT run some more cycles
//    #2000;

//    $display("Final LEDs = %h", leds);

//    // Clean up
//    release uut.slow_clk;
//    #10 $finish;
//end

//// 10 ns clock period (100 MHz)
//always #5 clk = ~clk;

//// Optional monitor
//always @(posedge clk) begin
//    if (leds !== 16'hzzzz) $display("%0t ns: LEDs = %h", $time, leds);
//end

//endmodule
