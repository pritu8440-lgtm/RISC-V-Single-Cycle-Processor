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
    // Clock
    //=========================================================

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    //=========================================================
    // Reset and Test
    //=========================================================

    initial begin

        reset = 1'b1;

        // Reset CPU
        #20;
        reset = 1'b0;

        // Allow program to execute
        #130;

        //=====================================================
        // Register Checks
        //=====================================================

        $display("");
        $display("==============================================");
        $display("       RISC-V CPU VERIFICATION RESULTS");
        $display("==============================================");

        $display("x1  = %0d", uut.u_datapath.u_register_set.registers[1]);
        $display("x2  = %0d", uut.u_datapath.u_register_set.registers[2]);
        $display("x3  = %0d", uut.u_datapath.u_register_set.registers[3]);
        $display("x4  = %0d", uut.u_datapath.u_register_set.registers[4]);
        $display("x5  = %0d", uut.u_datapath.u_register_set.registers[5]);
        $display("x6  = %0d", uut.u_datapath.u_register_set.registers[6]);
        $display("x7  = %0d", uut.u_datapath.u_register_set.registers[7]);
        $display("x8  = %0d", uut.u_datapath.u_register_set.registers[8]);

        $display("");
        $display("Memory[0] = %0d",
                 uut.u_datapath.u_data_memory.memory[0]);

        //=====================================================
        // Automatic PASS / FAIL checks
        //=====================================================

        if (uut.u_datapath.u_register_set.registers[1] == 32'd5)
            $display("PASS: x1 = 5");
        else
            $display("FAIL: x1 expected 5");

        if (uut.u_datapath.u_register_set.registers[2] == 32'd10)
            $display("PASS: x2 = 10");
        else
            $display("FAIL: x2 expected 10");

        if (uut.u_datapath.u_register_set.registers[3] == 32'd15)
            $display("PASS: x3 = 15");
        else
            $display("FAIL: x3 expected 15");

        if (uut.u_datapath.u_register_set.registers[4] == 32'd5)
            $display("PASS: x4 = 5");
        else
            $display("FAIL: x4 expected 5");

        if (uut.u_datapath.u_register_set.registers[5] == 32'd0)
            $display("PASS: x5 = 0");
        else
            $display("FAIL: x5 expected 0");

        if (uut.u_datapath.u_register_set.registers[6] == 32'd15)
            $display("PASS: x6 = 15");
        else
            $display("FAIL: x6 expected 15");

        if (uut.u_datapath.u_register_set.registers[7] == 32'd15)
            $display("PASS: x7 = 15");
        else
            $display("FAIL: x7 expected 15");

        if (uut.u_datapath.u_register_set.registers[8] == 32'd15)
            $display("PASS: x8 = 15");
        else
            $display("FAIL: x8 expected 15");

        if (uut.u_datapath.u_data_memory.memory[0] == 32'd15)
            $display("PASS: Memory[0] = 15");
        else
            $display("FAIL: Memory[0] expected 15");

        $display("");
        $display("==============================================");

        #10;
        $finish;

    end

endmodule
