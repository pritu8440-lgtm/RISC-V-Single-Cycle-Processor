//=============================================================
// PC Top
//
// Integrates:
//   1. Program Counter
//   2. PC + 4
//   3. Branch/Jump Target
//   4. PC MUX
//
// next PC is selected between:
//   PC + 4
//   PC + immediate
//=============================================================

module PC_Top (
    input  wire        clk,
    input  wire        reset,
    input  wire [31:0] immediate,
    input  wire        select_target,

    output wire [31:0] pc,
    output wire [31:0] pc_plus_4,
    output wire [31:0] pc_target
);

    wire [31:0] next_pc;

    // PC register
    PC u_pc (
        .clk(clk),
        .reset(reset),
        .next_pc(next_pc),
        .pc(pc)
    );

    // PC + 4
    PC_Plus_4 u_pc_plus_4 (
        .pc(pc),
        .pc_plus_4(pc_plus_4)
    );

    // Branch / jump target
    PC_Target u_pc_target (
        .pc(pc),
        .immediate(immediate),
        .target(pc_target)
    );

    // Select next PC
    PC_Mux u_pc_mux (
        .pc_plus_4(pc_plus_4),
        .pc_target(pc_target),
        .select_target(select_target),
        .next_pc(next_pc)
    );

endmodule
