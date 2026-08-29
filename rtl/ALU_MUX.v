module ALU_MUX (
    input  [31:0] register_data,
    input  [31:0] immediate,
    input         select_immediate,
    output [31:0] alu_input
);

    assign alu_input = select_immediate
                      ? immediate
                      : register_data;

endmodule
