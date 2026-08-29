module Imm_Gen (
    input  [31:0] instr,
    input  [2:0]  ImmSrc,
    output reg [31:0] imm
);

    always @(*) begin
        case (ImmSrc)

            // I-Type: ADDI, ANDI, ORI, XORI, LW, JALR
            3'b000:
                imm = {{20{instr[31]}}, instr[31:20]};

            // S-Type: SW
            3'b001:
                imm = {{20{instr[31]}},
                       instr[31:25],
                       instr[11:7]};

            // B-Type: BEQ, BNE, BLT, BGE
            3'b010:
                imm = {{19{instr[31]}},
                       instr[31],
                       instr[7],
                       instr[30:25],
                       instr[11:8],
                       1'b0};

            // J-Type: JAL
            3'b011:
                imm = {{11{instr[31]}},
                       instr[31],
                       instr[19:12],
                       instr[20],
                       instr[30:21],
                       1'b0};

            // U-Type: LUI, AUIPC
            3'b100:
                imm = {instr[31:12], 12'b0};

            default:
                imm = 32'b0;

        endcase
    end

endmodule
