//=============================================================
// RISC-V Single-Cycle CPU Testbench
//=============================================================

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
    // 10 ns clock period
    //=========================================================

    initial begin
        clk = 1'b0;

        forever #5 clk = ~clk;
    end

    //=========================================================
    // Reset and Simulation
    //=========================================================

    initial begin

        reset = 1'b1;

        // Hold reset for 20 ns
        #20;

        reset = 1'b0;

        // Run processor
        #200;

        $finish;

    end

    //=========================================================
    // Monitor
    //=========================================================

    initial begin

        $monitor(
            "Time=%0t | PC=%h | Instruction=%h | ALU=%h | Zero=%b",
            $time,
            uut.pc,
            uut.instruction,
            uut.alu_result,
            uut.zero
        );

    end

endmodule
