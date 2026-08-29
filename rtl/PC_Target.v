module PC_Target (
    input  [31:0] pc,
    input  [31:0] immediate,
    output [31:0] target
);

    assign target = pc + immediate;

endmodule
