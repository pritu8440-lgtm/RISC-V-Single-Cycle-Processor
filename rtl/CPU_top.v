//=============================================================
// RISC-V Single-Cycle CPU Top
//
// Integrates:
//   1. Instruction Fetch
//   2. Main Decoder
//   3. Datapath
//
// PC selection:
//   Normal  -> PC + 4
//   Branch  -> PC + immediate when Zero = 1
//   Jump    -> PC + immediate
//=============================================================

module CPU_top (
    input  wire clk,
    input  wire reset
);

    //=========================================================
    // Instruction Fetch Signals
    //=========================================================

    wire [31:0] pc;
    wire [31:0] instruction;
    wire [31:0] pc_plus_4;
    wire [31:0] pc_target;

    // Immediate and PC selection
    wire [31:0] immediate;
    wire        select_target;

    //=========================================================
    // Control Signals
    //=========================================================

    wire       RegWrite;
    wire       MemWrite;
    wire       MemToReg;
    wire       ALUSrcA;
    wire       ALUSrc;
    wire       Branch;
    wire       Jump;

    wire [1:0] ALUOp;
    wire [2:0] ImmSrc;

    //=========================================================
    // Datapath Outputs
    //=========================================================

    wire [31:0] alu_result;
    wire [31:0] memory_data;
    wire [31:0] write_back_data;
    wire        zero;

    //=========================================================
    // Instruction fields
    //=========================================================

    wire [6:0] opcode;

    assign opcode = instruction[6:0];

    //=========================================================
    // Immediate Generator
    //
    // We need the immediate here for PC target calculation.
    //=========================================================

    Imm_Gen u_pc_imm_gen (
        .instr (instruction),
        .ImmSrc(ImmSrc),
        .imm   (immediate)
    );

    //=========================================================
    // PC Selection Logic
    //
    // Branch taken when:
    //   Branch = 1 AND Zero = 1
    //
    // Jump is unconditional.
    //=========================================================

    assign select_target = Jump | (Branch & zero);

    //=========================================================
    // Instruction Fetch
    //=========================================================

    IF_top u_if_top (
        .clk          (clk),
        .reset        (reset),
        .immediate    (immediate),
        .select_target(select_target),

        .pc           (pc),
        .instruction  (instruction),
        .pc_plus_4    (pc_plus_4),
        .pc_target    (pc_target)
    );

    //=========================================================
    // Main Control Decoder
    //=========================================================

    MainDecoder u_main_decoder (
        .opcode   (opcode),

        .RegWrite (RegWrite),
        .MemWrite (MemWrite),
        .MemToReg (MemToReg),
        .ALUSrcA  (ALUSrcA),
        .ALUSrc   (ALUSrc),
        .Branch   (Branch),
        .Jump     (Jump),
        .ALUOp    (ALUOp),
        .ImmSrc   (ImmSrc)
    );

    //=========================================================
    // Datapath
    //=========================================================

    Datapath u_datapath (
        .clk           (clk),
        .reset         (reset),

        .instruction   (instruction),
        .pc            (pc),
        .pc_plus_4     (pc_plus_4),

        .RegWrite      (RegWrite),
        .MemWrite      (MemWrite),
        .MemToReg      (MemToReg),
        .ALUSrcA       (ALUSrcA),
        .ALUSrc        (ALUSrc),
        .Branch        (Branch),
        .Jump          (Jump),
        .ALUOp         (ALUOp),
        .ImmSrc        (ImmSrc),

        .alu_result    (alu_result),
        .memory_data   (memory_data),
        .write_back_data(write_back_data),
        .zero          (zero)
    );

endmodule
