module PC_Mux (
    input  [31:0] pc_plus_4,
    input  [31:0] pc_target,
    input         select_target,
    output [31:0] next_pc
);

    assign next_pc = select_target ? pc_target : pc_plus_4;

endmodule
