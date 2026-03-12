//`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date: 03/11/2026 12:53:21 PM
//// Design Name: 
//// Module Name: topMod
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


//module top_module(
//    input clk,
//    input rst_btn,       // Physical reset button
//    input [15:0] sw_ext, // Physical switches
//    output [15:0] led_ext // Physical LEDs
//);

//    wire rst_debounced;
//    wire [15:0] current_count;
//    wire [31:0] sw_data_read;

//    // 1. Debounce the reset button
//    debouncer btn_rst (
//        .clk(clk),
//        .pbin(rst_btn),
//        .pbout(rst_debounced)
//    );

//    // 2. Instantiate the FSM Logic
//    FSM_Counter system_core (
//        .clk(clk),
//        .rst(rst_debounced),
//        .switch_in(sw_ext), 
//        .count_out(current_count)
//    );

//    // 3. Integrate provided LED interface (named 'switches' in your lab)
//    switches led_interface (
//        .clk(clk),
//        .rst(rst_debounced),
//        .writeData({16'b0, current_count}), // Sending 16-bit count to 32-bit port
//        .writeEnable(1'b1),
//        .readEnable(1'b0),
//        .memAddress(30'b0),
//        .leds(led_ext)
//    );

//    // 4. Integrate provided Switch interface (named 'leds' in your lab)
//    // This reads the physical switches into the system
//    leds switch_interface (
//        .clk(clk),
//        .rst(rst_debounced),
//        .btns(16'b0),
//        .writeData(32'b0),
//        .writeEnable(1'b0),
//        .readEnable(1'b1),
//        .memAddress(30'b0),
//        .switches(sw_ext),
//        .readData(sw_data_read)
//    );

//endmodule
