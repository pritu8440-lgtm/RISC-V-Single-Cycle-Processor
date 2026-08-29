module Instruction_Memory (
    input  [31:0] address,
    output [31:0] instruction
);

    reg [31:0] memory [0:255];

    // Instruction memory is word-aligned.
    // PC[9:2] selects one of 256 instruction words.
    assign instruction = memory[address[9:2]];

    // Sample program for RTL simulation
    initial begin

        //=====================================================
        // Basic ALU / Memory / Branch Tests
        //=====================================================

        // ADDI x1, x0, 5
        memory[0] = 32'h00500093;

        // ADDI x2, x0, 10
        memory[1] = 32'h00A00113;

        // ADD x3, x1, x2
        memory[2] = 32'h002081B3;

        // SUB x4, x2, x1
        memory[3] = 32'h40110233;

        // AND x5, x1, x2
        memory[4] = 32'h0020F2B3;

        // OR x6, x1, x2
        memory[5] = 32'h0020E333;

        // XOR x7, x1, x2
        memory[6] = 32'h0020C3B3;

        // SW x3, 0(x0)
        memory[7] = 32'h00302023;

        // LW x8, 0(x0)
        memory[8] = 32'h00002403;

        // BEQ x1, x1, +8
        memory[9] = 32'h00108463;

        // This instruction should be skipped
        // ADDI x9, x0, 1
        memory[10] = 32'h00100493;

        // ADDI x10, x0, 2
        memory[11] = 32'h00200513;


        //=====================================================
        // LUI / AUIPC / JAL Tests
        //=====================================================

        // NOP
        memory[12] = 32'h00000013;

        // LUI x11, 0x12345
        // x11 = 0x12345000
        memory[13] = 32'h123455B7;

        // AUIPC x12, 0x1
        // PC = 0x38
        // x12 = 0x38 + 0x1000
        //     = 0x00001038
        memory[14] = 32'h00001617;

        // JAL x13, +8
        // Current PC = 0x3C
        // x13 should receive PC + 4 = 0x40
        // Target PC = 0x44
        memory[15] = 32'h008006EF;

        // This instruction should be skipped by JAL
        // ADDI x14, x0, 1
        memory[16] = 32'h00100713;

        // JAL target
        // ADDI x15, x0, 2
        memory[17] = 32'h00200793;

        // NOP
        memory[18] = 32'h00000013;

        // NOP
        memory[19] = 32'h00000013;

    end

endmodule
