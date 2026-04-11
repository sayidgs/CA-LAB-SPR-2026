`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2026 11:57:08 AM
// Design Name: 
// Module Name: InstructionMemory
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

module instructionMemory#(
    parameter OPERAND_LENGTH = 31
)(
    input [OPERAND_LENGTH:0] instAddress,
    output reg [31:0] instruction
);

reg [7:0] memory [0:255];

initial begin
    // Load memory file
    $readmemh("program.mem", memory);
end


//initial begin


////    // 00a00213
////    memory[0]  = 8'h13;
////    memory[1]  = 8'h02;
////    memory[2]  = 8'ha0;
////    memory[3]  = 8'h00;

////    // 00f00293
////    memory[4]  = 8'h93;
////    memory[5]  = 8'h02;
////    memory[6]  = 8'hf0;
////    memory[7]  = 8'h00;

////    // 00428333
////    memory[8]  = 8'h33;
////    memory[9]  = 8'h83;
////    memory[10] = 8'h42;
////    memory[11] = 8'h00;

////    // 00a20393
////    memory[12] = 8'h93;
////    memory[13] = 8'h03;
////    memory[14] = 8'ha2;
////    memory[15] = 8'h00;







////    // Instruction 0: 10000297
////    memory[0]=8'h97; memory[1]=8'h02; memory[2]=8'h00; memory[3]=8'h10;

////    // Instruction 1: 00028293
////    memory[4]=8'h93; memory[5]=8'h82; memory[6]=8'h02; memory[7]=8'h00;

////    // Instruction 2: 0002a303
////    memory[8]=8'h03; memory[9]=8'ha3; memory[10]=8'h02; memory[11]=8'h00;

////    // Instruction 3: fe030ae3
////    memory[12]=8'he3; memory[13]=8'h0a; memory[14]=8'h03; memory[15]=8'hfe;

////    // Instruction 4: 00030513
////    memory[16]=8'h13; memory[17]=8'h05; memory[18]=8'h03; memory[19]=8'h00;

////    // Instruction 5: 008000ef
////    memory[20]=8'hef; memory[21]=8'h00; memory[22]=8'h80; memory[23]=8'h00;

////    // Instruction 6: fe9ff06f
////    memory[24]=8'h6f; memory[25]=8'hf0; memory[26]=8'h9f; memory[27]=8'hfe;

////    // Instruction 7: ff810113
////    memory[28]=8'h13; memory[29]=8'h01; memory[30]=8'h81; memory[31]=8'hff;

////    // Instruction 8: 00112223
////    memory[32]=8'h23; memory[33]=8'h22; memory[34]=8'h11; memory[35]=8'h00;

////    // Instruction 9: 00a12023
////    memory[36]=8'h23; memory[37]=8'h20; memory[38]=8'ha1; memory[39]=8'h00;

////    // Instruction 10: 00050393
////    memory[40]=8'h93; memory[41]=8'h03; memory[42]=8'h05; memory[43]=8'h00;

////    // Instruction 11: 10000e17
////    memory[44]=8'h17; memory[45]=8'h0e; memory[46]=8'h00; memory[47]=8'h10;

////    // Instruction 12: fdce0e13
////    memory[48]=8'h13; memory[49]=8'h0e; memory[50]=8'hce; memory[51]=8'hfd;

////    // Instruction 13: 000e2e83
////    memory[52]=8'h83; memory[53]=8'h2e; memory[54]=8'h0e; memory[55]=8'h00;

////    // Instruction 14: 020e9663
////    memory[56]=8'h63; memory[57]=8'h96; memory[58]=8'h0e; memory[59]=8'h02;

////    // Instruction 15: 10000f17
////    memory[60]=8'h17; memory[61]=8'h0f; memory[62]=8'h00; memory[63]=8'h10;

////    // Instruction 16: fc8f0f13
////    memory[64]=8'h13; memory[65]=8'h0f; memory[66]=8'h8f; memory[67]=8'hfc;

////    // Instruction 17: 007f2023
////    memory[68]=8'h23; memory[69]=8'h20; memory[70]=8'h7f; memory[71]=8'h00;

////    // Instruction 18: 02038663
////    memory[72]=8'h63; memory[73]=8'h86; memory[74]=8'h03; memory[75]=8'h02;

////    // Instruction 19: fff38393
////    memory[76]=8'h93; memory[77]=8'h83; memory[78]=8'hf3; memory[79]=8'hff;

////    // Instruction 20: 00018fb7
////    memory[80]=8'hb7; memory[81]=8'h8f; memory[82]=8'h01; memory[83]=8'h00;

////    // Instruction 21: 6a0f8f93
////    memory[84]=8'h93; memory[85]=8'h8f; memory[86]=8'h0f; memory[87]=8'h6a;

////    // Instruction 22: ffff8f93
////    memory[88]=8'h93; memory[89]=8'h8f; memory[90]=8'hff; memory[91]=8'hff;

////    // Instruction 23: fe0f9ee3
////    memory[92]=8'he3; memory[93]=8'h9e; memory[94]=8'h0f; memory[95]=8'hfe;

////    // Instruction 24: fcdff06f
////    memory[96]=8'h6f; memory[97]=8'hf0; memory[98]=8'hdf; memory[99]=8'hfc;

////    // Instruction 25: 10000f17
////    memory[100]=8'h17; memory[101]=8'h0f; memory[102]=8'h00; memory[103]=8'h10;

////    // Instruction 26: fa0f0f13
////    memory[104]=8'h13; memory[105]=8'h0f; memory[106]=8'h0f; memory[107]=8'hfa;

////    // Instruction 27: 000f2023
////    memory[108]=8'h23; memory[109]=8'h20; memory[110]=8'h0f; memory[111]=8'h00;

////    // Instruction 28: 0100006f
////    memory[112]=8'h6f; memory[113]=8'h00; memory[114]=8'h00; memory[115]=8'h01;

////    // Instruction 29: 10000f17
////    memory[116]=8'h17; memory[117]=8'h0f; memory[118]=8'h00; memory[119]=8'h10;

////    // Instruction 30: f90f0f13
////    memory[120]=8'h13; memory[121]=8'h0f; memory[122]=8'h0f; memory[123]=8'hf9;

////    // Instruction 31: 000f2023
////    memory[124]=8'h23; memory[125]=8'h20; memory[126]=8'h0f; memory[127]=8'h00;

////    // Instruction 32: 00412083
////    memory[128]=8'h83; memory[129]=8'h20; memory[130]=8'h41; memory[131]=8'h00;

////    // Instruction 33: 00012503
////    memory[132]=8'h03; memory[133]=8'h25; memory[134]=8'h01; memory[135]=8'h00;

////    // Instruction 34: 00810113
////    memory[136]=8'h13; memory[137]=8'h01; memory[138]=8'h81; memory[139]=8'h00;

////    // Instruction 35: 00008067
////    memory[140]=8'h67; memory[141]=8'h80; memory[142]=8'h00; memory[143]=8'h00;
//end

always @(*) begin
    instruction = {
        memory[instAddress],
        memory[instAddress + 1],
        memory[instAddress + 2],
        memory[instAddress + 3]
    };
end

endmodule