module MainDecoder (
    input  [6:0] opcode,

    output reg       RegWrite,
    output reg       MemWrite,
    output reg       MemToReg,
    output reg       ALUSrc,
    output reg       Branch,
    output reg       Jump,
    output reg [2:0] ImmSrc
);

    always @(*) begin

        // Default control signals
        RegWrite = 1'b0;
        MemWrite = 1'b0;
        MemToReg = 1'b0;
        ALUSrc   = 1'b0;
        Branch   = 1'b0;
        Jump     = 1'b0;
        ImmSrc   = 3'b000;

        case (opcode)

            // R-Type instructions
            7'b0110011: begin
                RegWrite = 1'b1;
                ALUSrc   = 1'b0;
            end

            // I-Type ALU instructions
            7'b0010011: begin
                RegWrite = 1'b1;
                ALUSrc   = 1'b1;
                ImmSrc   = 3'b000;
            end

            // Load Word (LW)
            7'b0000011: begin
                RegWrite = 1'b1;
                MemToReg = 1'b1;
                ALUSrc   = 1'b1;
                ImmSrc   = 3'b000;
            end

            // Store Word (SW)
            7'b0100011: begin
                MemWrite = 1'b1;
                ALUSrc   = 1'b1;
                ImmSrc   = 3'b001;
            end

            // Branch Equal (BEQ)
            7'b1100011: begin
                Branch = 1'b1;
                ALUSrc = 1'b0;
                ImmSrc = 3'b010;
            end

            // Jump and Link (JAL)
            7'b1101111: begin
                RegWrite = 1'b1;
                Jump     = 1'b1;
                ImmSrc   = 3'b011;
            end

            // Load Upper Immediate (LUI)
            7'b0110111: begin
                RegWrite = 1'b1;
                ALUSrc   = 1'b1;
                ImmSrc   = 3'b100;
            end

            // Add Upper Immediate to PC (AUIPC)
            7'b0010111: begin
                RegWrite = 1'b1;
                ALUSrc   = 1'b1;
                ImmSrc   = 3'b100;
            end

            default: begin
                RegWrite = 1'b0;
                MemWrite = 1'b0;
                MemToReg = 1'b0;
                ALUSrc   = 1'b0;
                Branch   = 1'b0;
                Jump     = 1'b0;
                ImmSrc   = 3'b000;
            end

        endcase
    end

endmodule
