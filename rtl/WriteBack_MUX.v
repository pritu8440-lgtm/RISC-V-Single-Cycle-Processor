//=============================================================
// Write Back MUX
//
// Selects the value that will be written back to the register
// file.
//
// MemToReg = 0 -> ALU result
// MemToReg = 1 -> Data Memory result
//
// Used for:
//   R-type / I-type -> ALU result
//   LW             -> Data Memory result
//=============================================================

module WriteBack_MUX (
    input  [31:0] alu_result,
    input  [31:0] memory_data,
    input         MemToReg,
    output [31:0] write_back_data
);

assign write_back_data = MemToReg ? memory_data : alu_result;

endmodule
