`timescale 1ns/1ps

module CPU_top_tb;

    reg clk;
    reg reset;

    //=========================================================
    // CPU Instance
    //=========================================================

    CPU_top uut (
        .clk   (clk),
        .reset (reset)
    );

    //=========================================================
    // Clock Generation
    //=========================================================

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    //=========================================================
    // Reset and Verification
    //=========================================================

    initial begin

        //=====================================================
        // VCD Waveform Generation
        //=====================================================

        $dumpfile("cpu_wave.vcd");
        $dumpvars(0, CPU_top_tb);

        //=====================================================
        // Reset
        //=====================================================

        reset = 1'b1;

        #20;

        reset = 1'b0;

        //=====================================================
        // Allow CPU to execute program
        //=====================================================

        #220;

        //=====================================================
        // Verification Results
        //=====================================================

        $display("");
        $display("==============================================");
        $display("       RISC-V CPU VERIFICATION RESULTS");
        $display("==============================================");

        //=====================================================
        // Basic ALU / Memory Tests
        //=====================================================

        $display("");
        $display("----- Basic ALU / Memory Tests -----");

        $display("x1  = %h",
                 uut.u_datapath.u_register_set.registers[1]);

        $display("x2  = %h",
                 uut.u_datapath.u_register_set.registers[2]);

        $display("x3  = %h",
                 uut.u_datapath.u_register_set.registers[3]);

        $display("x4  = %h",
                 uut.u_datapath.u_register_set.registers[4]);

        $display("x5  = %h",
                 uut.u_datapath.u_register_set.registers[5]);

        $display("x6  = %h",
                 uut.u_datapath.u_register_set.registers[6]);

        $display("x7  = %h",
                 uut.u_datapath.u_register_set.registers[7]);

        $display("x8  = %h",
                 uut.u_datapath.u_register_set.registers[8]);

        $display("Memory[0] = %h",
                 uut.u_datapath.u_data_memory.memory[0]);

        //=====================================================
        // ADDI
        //=====================================================

        if (uut.u_datapath.u_register_set.registers[1] == 32'd5)
            $display("PASS: ADDI x1 = 5");
        else
            $display("FAIL: ADDI x1");

        if (uut.u_datapath.u_register_set.registers[2] == 32'd10)
            $display("PASS: ADDI x2 = 10");
        else
            $display("FAIL: ADDI x2");

        //=====================================================
        // ADD
        //=====================================================

        if (uut.u_datapath.u_register_set.registers[3] == 32'd15)
            $display("PASS: ADD x3 = 15");
        else
            $display("FAIL: ADD x3");

        //=====================================================
        // SUB
        //=====================================================

        if (uut.u_datapath.u_register_set.registers[4] == 32'd5)
            $display("PASS: SUB x4 = 5");
        else
            $display("FAIL: SUB x4");

        //=====================================================
        // AND
        //=====================================================

        if (uut.u_datapath.u_register_set.registers[5] == 32'd0)
            $display("PASS: AND x5 = 0");
        else
            $display("FAIL: AND x5");

        //=====================================================
        // OR
        //=====================================================

        if (uut.u_datapath.u_register_set.registers[6] == 32'd15)
            $display("PASS: OR x6 = 15");
        else
            $display("FAIL: OR x6");

        //=====================================================
        // XOR
        //=====================================================

        if (uut.u_datapath.u_register_set.registers[7] == 32'd15)
            $display("PASS: XOR x7 = 15");
        else
            $display("FAIL: XOR x7");

        //=====================================================
        // SW
        //=====================================================

        if (uut.u_datapath.u_data_memory.memory[0] == 32'd15)
            $display("PASS: SW Memory[0] = 15");
        else
            $display("FAIL: SW Memory[0]");

        //=====================================================
        // LW
        //=====================================================

        if (uut.u_datapath.u_register_set.registers[8] == 32'd15)
            $display("PASS: LW x8 = 15");
        else
            $display("FAIL: LW x8");

        //=====================================================
        // Branch Test
        //=====================================================

        $display("");
        $display("----- Branch Test -----");

        // x9 should remain zero because BEQ skips
        // ADDI x9, x0, 1

        if (uut.u_datapath.u_register_set.registers[9] == 32'd0)
            $display("PASS: BEQ branch taken, x9 skipped");
        else
            $display("FAIL: BEQ branch");

        //=====================================================
        // LUI Test
        //=====================================================

        $display("");
        $display("----- LUI Test -----");

        $display("x11 = %h",
                 uut.u_datapath.u_register_set.registers[11]);

        if (uut.u_datapath.u_register_set.registers[11] == 32'h12345000)
            $display("PASS: LUI x11 = 0x12345000");
        else
            $display("FAIL: LUI x11");

        //=====================================================
        // AUIPC Test
        //=====================================================

        $display("");
        $display("----- AUIPC Test -----");

        $display("x12 = %h",
                 uut.u_datapath.u_register_set.registers[12]);

        if (uut.u_datapath.u_register_set.registers[12] == 32'h00001038)
            $display("PASS: AUIPC x12 = 0x00001038");
        else
            $display("FAIL: AUIPC x12");

        //=====================================================
        // JAL Test
        //=====================================================

        $display("");
        $display("----- JAL Test -----");

        $display("x13 = %h",
                 uut.u_datapath.u_register_set.registers[13]);

        $display("x14 = %h",
                 uut.u_datapath.u_register_set.registers[14]);

        $display("x15 = %h",
                 uut.u_datapath.u_register_set.registers[15]);

        // JAL writes PC + 4 into x13
        if (uut.u_datapath.u_register_set.registers[13] == 32'h00000040)
            $display("PASS: JAL link x13 = 0x00000040");
        else
            $display("FAIL: JAL link x13");

        // Instruction at x14 should be skipped
        if (uut.u_datapath.u_register_set.registers[14] == 32'd0)
            $display("PASS: JAL skipped x14 instruction");
        else
            $display("FAIL: JAL did not skip x14 instruction");

        // JAL target executes ADDI x15, x0, 2
        if (uut.u_datapath.u_register_set.registers[15] == 32'd2)
            $display("PASS: JAL target executed, x15 = 2");
        else
            $display("FAIL: JAL target");

        //=====================================================
        // Final Result
        //=====================================================

        $display("");
        $display("==============================================");
        $display("       VERIFICATION COMPLETE");
        $display("==============================================");

        #10;

        $finish;

    end

endmodule
