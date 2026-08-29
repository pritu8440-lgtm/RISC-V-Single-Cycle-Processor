//=============================================================
// RISC-V Single-Cycle Datapath
//
// Integrates:
//   Instruction Decoder
//   Register Set
//   Immediate Generator
//   SrcA MUX
//   ALU MUX
//   ALU Decoder
//   ALU
//   Data Memory
//   WriteBack MUX
//
// Supported instructions:
//   R-Type
//   I-Type ALU
//   LW
//   SW
//   BEQ
//   LUI
//   AUIPC
//=============================================================

module Datapath (
    input  wire        clk,
    input  wire        reset,

    input  wire [31:0] instruction,
    input  wire [31:0] pc,

    // Control signals
    input  wire        RegWrite,
    input  wire        MemWrite,
    input  wire        MemToReg,
    input  wire        ALUSrcA,
    input  wire        ALUSrc,
    input  wire [1:0]  ALUOp,
    input  wire [2:0]  ImmSrc,

    // Outputs
    output wire [31:0] alu_result,
    output wire [31:0] memory_data,
    output wire [31:0] write_back_data,
    output wire        zero
);

    //=========================================================
    // Instruction Decoder
    //=========================================================

    wire [6:0] opcode;
    wire [4:0] rd;
    wire [2:0] funct3;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [6:0] funct7;

    Instruction_Decoder u_instruction_decoder (
        .instruction(instruction),
        .opcode     (opcode),
        .rd         (rd),
        .funct3     (funct3),
        .rs1        (rs1),
        .rs2        (rs2),
        .funct7     (funct7)
    );

    //=========================================================
    // Register File
    //=========================================================

    wire [31:0] read_data1;
    wire [31:0] read_data2;

    Register_Set u_register_set (
        .clk        (clk),
        .reset      (reset),
        .rs1        (rs1),
        .rs2        (rs2),
        .rd         (rd),
        .write_data (write_back_data),
        .reg_write  (RegWrite),
        .read_data1 (read_data1),
        .read_data2 (read_data2)
    );

    //=========================================================
    // Immediate Generator
    //=========================================================

    wire [31:0] immediate;

    Imm_Gen u_imm_gen (
        .instr (instruction),
        .ImmSrc(ImmSrc),
        .imm   (immediate)
    );

    //=========================================================
    // ALU Input A MUX
    //
    // ALUSrcA = 0 -> Register rs1
    // ALUSrcA = 1 -> PC
    //
    // AUIPC uses PC as ALU input A.
    //=========================================================

    wire [31:0] alu_input_a;

    SrcA_MUX u_src_a_mux (
        .rs1_data(read_data1),
        .PC_reg  (pc),
        .ALUSrcA (ALUSrcA),
        .SrcA    (alu_input_a)
    );

    //=========================================================
    // ALU Input B MUX
    //
    // ALUSrc = 0 -> Register rs2
    // ALUSrc = 1 -> Immediate
    //=========================================================

    wire [31:0] alu_input_b;

    ALU_MUX u_alu_mux (
        .register_data   (read_data2),
        .immediate       (immediate),
        .select_immediate(ALUSrc),
        .alu_input       (alu_input_b)
    );

    //=========================================================
    // ALU Decoder
    //=========================================================

    wire [3:0] ALUControl;

    ALUDecoder u_alu_decoder (
        .ALUOp      (ALUOp),
        .funct3     (funct3),
        .funct7_bit (funct7[5]),
        .ALUControl (ALUControl)
    );

    //=========================================================
    // ALU
    //=========================================================

    ALU u_alu (
        .A         (alu_input_a),
        .B         (alu_input_b),
        .ALUControl(ALUControl),
        .Result    (alu_result),
        .Zero      (zero)
    );

    //=========================================================
    // Data Memory
    //
    // SW:
    //   ALU result -> address
    //   rs2        -> write data
    //
    // LW:
    //   ALU result -> address
    //   memory     -> memory_data
    //=========================================================

    Data_Memory u_data_memory (
        .clk       (clk),
        .MemWrite  (MemWrite),
        .address   (alu_result),
        .write_data(read_data2),
        .read_data (memory_data)
    );

    //=========================================================
    // Write Back MUX
    //
    // MemToReg = 0 -> ALU result
    // MemToReg = 1 -> Memory data
    //=========================================================

    WriteBack_MUX u_writeback_mux (
        .alu_result     (alu_result),
        .memory_data    (memory_data),
        .MemToReg       (MemToReg),
        .write_back_data(write_back_data)
    );

endmodule
