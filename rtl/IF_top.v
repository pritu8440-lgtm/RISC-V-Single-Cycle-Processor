//=============================================================
// Instruction Fetch Top
//
// Integrates:
//   1. PC Top
//   2. Instruction Memory
//
// The PC provides the current instruction address.
// Instruction Memory returns the instruction stored at that
// address.
//
// PC update:
//   select_target = 0 -> PC + 4
//   select_target = 1 -> Branch/Jump target
//=============================================================

module IF_top (
    input  wire        clk,
    input  wire        reset,
    input  wire [31:0] immediate,
    input  wire        select_target,

    output wire [31:0] pc,
    output wire [31:0] instruction,
    output wire [31:0] pc_plus_4,
    output wire [31:0] pc_target
);

    //=========================================================
    // PC path
    //=========================================================

    PC_Top u_pc_top (
        .clk          (clk),
        .reset        (reset),
        .immediate    (immediate),
        .select_target(select_target),

        .pc           (pc),
        .pc_plus_4    (pc_plus_4),
        .pc_target    (pc_target)
    );

    //=========================================================
    // Instruction Memory
    //=========================================================

    Instruction_Memory u_instruction_memory (
        .address    (pc),
        .instruction(instruction)
    );

endmodule
