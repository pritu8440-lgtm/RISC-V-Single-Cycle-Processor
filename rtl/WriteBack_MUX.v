//=============================================================
// Write Back MUX
//
// Selects the value written back to the register file.
//
// MemToReg = 0, Jal = 0 -> ALU result
// MemToReg = 1          -> Data Memory result
// Jal      = 1          -> PC + 4
//
// JAL requires rd = PC + 4.
//=============================================================

module WriteBack_MUX (
    input  [31:0] alu_result,
    input  [31:0] memory_data,
    input  [31:0] pc_plus_4,

    input         MemToReg,
    input         Jal,

    output [31:0] write_back_data
);

    assign write_back_data = Jal
                           ? pc_plus_4
                           : (MemToReg ? memory_data : alu_result);

endmodule
