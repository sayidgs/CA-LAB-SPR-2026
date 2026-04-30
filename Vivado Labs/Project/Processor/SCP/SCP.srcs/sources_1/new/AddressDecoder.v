//module AddressDecoder(

//    input [31:0] address,
//    input readEnable,
//    input writeEnable,

//    output DataMemRead,
//    output DataMemWrite,
//    output LEDWrite,
//    output SwitchReadEnable
//);

//wire [1:0] device;

//assign device = address[9:8];

//assign DataMemRead  = (device == 2'b00) && readEnable;
//assign DataMemWrite = (device == 2'b00) && writeEnable;
//assign LEDWrite = (device == 2'b01);
//assign SwitchReadEnable = (device == 2'b10);

//endmodule

//module AddressDecoder(
 
//    input [31:0] address,
//    input readEnable,
//    input writeEnable,
 
//    output DataMemRead,
//    output DataMemWrite,
//    output LEDWrite,
//    output SwitchReadEnable
//);
 
//wire [1:0] device;
 
//assign device = address[9:8];
 
//assign DataMemRead      = (device == 2'b00) && readEnable;
//assign DataMemWrite     = (device == 2'b00) && writeEnable;
//// BUG FIX: LEDWrite was always asserted for device==01; must be gated by writeEnable
//assign LEDWrite         = (device == 2'b01) && writeEnable;
//// BUG FIX: SwitchReadEnable was always asserted for device==10; must be gated by readEnable
//assign SwitchReadEnable = (device == 2'b10) && readEnable;
 
//endmodule


// AddressDecoder.v
//
// Memory Map (based on addr[9:8]):
//
//   addr[9:8] | Binary range    | Decimal range | Device
//   ----------|-----------------|---------------|--------
//     00       | 0x000 - 0x0FF  |    0 -  255   | Data Memory (lower)
//     01       | 0x100 - 0x1FF  |  256 -  511   | Data Memory (upper)
//     10       | 0x200 - 0x2FF  |  512 -  767   | LEDs
//     11       | 0x300 - 0x3FF  |  768 - 1023   | Switches
//
// NOTE: The assembly program uses:
//   s2 = 512 (0x200) -> addr[9:8]=10 -> LEDs
//   s1 = 768 (0x300) -> addr[9:8]=11 -> Switches
//
// The manual table listing "01->LEDs" is a binary typo:
//   512 decimal = 0b10_00000000, so addr[9:8]=10, NOT 01.
// This decoder matches the actual binary addresses.

module AddressDecoder(

    input [31:0] address,
    input readEnable,
    input writeEnable,

    output DataMemRead,
    output DataMemWrite,
    output LEDWrite,
    output SwitchReadEnable
);

wire [1:0] device;
assign device = address[9:8];

// Data Memory: addr[9:8] = 00 or 01 (full 512-word range 0x000-0x1FF)
assign DataMemRead      = (device[1] == 1'b0) && readEnable;
assign DataMemWrite     = (device[1] == 1'b0) && writeEnable;

// LEDs: addr[9:8] = 10  (0x200-0x2FF, decimal 512-767)
// BUG FIX: Must gate with writeEnable to only assert when actually writing
assign LEDWrite         = (device == 2'b10) && writeEnable;

// Switches: addr[9:8] = 11  (0x300-0x3FF, decimal 768-1023)
// BUG FIX: Must gate with readEnable to only assert when actually reading
assign SwitchReadEnable = (device == 2'b11) && readEnable;

endmodule