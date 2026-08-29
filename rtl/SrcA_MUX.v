//=============================================================
// SrcA MUX
// Selects ALU operand A:
//
// ALUSrcA = 0 → rs1_data
// ALUSrcA = 1 → PC
//
// Used for normal instructions and AUIPC.
//=============================================================

module SrcA_MUX #(parameter N = 32)
(
    input  wire [N-1:0] rs1_data,
    input  wire [N-1:0] PC_reg,
    input  wire ALUSrcA,
    output wire [N-1:0] SrcA
);

assign SrcA = ALUSrcA ? PC_reg : rs1_data;

endmodule
