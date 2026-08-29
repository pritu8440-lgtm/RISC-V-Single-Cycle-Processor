module ALUDecoder (
    input  [1:0] ALUOp,
    input  [2:0] funct3,
    input        funct7_bit,

    output reg [3:0] ALUControl
);

    always @(*) begin

        case (ALUOp)

            //=================================================
            // Load / Store / JAL / LUI / AUIPC
            //=================================================
            2'b00: begin
                ALUControl = 4'b0000;   // ADD
            end

            //=================================================
            // Branch
            //=================================================
            2'b01: begin
                ALUControl = 4'b0001;   // SUB
            end

            //=================================================
            // R-Type
            //=================================================
            2'b10: begin

                case (funct3)

                    3'b000: begin
                        // ADD / SUB
                        if (funct7_bit)
                            ALUControl = 4'b0001;
                        else
                            ALUControl = 4'b0000;
                    end

                    3'b111:
                        ALUControl = 4'b0010; // AND

                    3'b110:
                        ALUControl = 4'b0011; // OR

                    3'b100:
                        ALUControl = 4'b0100; // XOR

                    3'b010:
                        ALUControl = 4'b0101; // SLT

                    default:
                        ALUControl = 4'b0000;

                endcase
            end

            //=================================================
            // I-Type ALU
            //=================================================
            2'b11: begin

                case (funct3)

                    3'b000:
                        ALUControl = 4'b0000; // ADDI

                    3'b111:
                        ALUControl = 4'b0010; // ANDI

                    3'b110:
                        ALUControl = 4'b0011; // ORI

                    3'b100:
                        ALUControl = 4'b0100; // XORI

                    3'b010:
                        ALUControl = 4'b0101; // SLTI

                    default:
                        ALUControl = 4'b0000;

                endcase
            end

            default:
                ALUControl = 4'b0000;

        endcase
    end

endmodule
