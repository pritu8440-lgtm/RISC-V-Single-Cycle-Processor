//=============================================================
// Data Memory
//
// Used for:
//   LW -> Load data from memory
//   SW -> Store data into memory
//
// Addressing:
//   Word aligned
//   address[9:2] selects one of 256 words
//=============================================================

module Data_Memory (
    input        clk,
    input        MemWrite,

    input  [31:0] address,
    input  [31:0] write_data,

    output [31:0] read_data
);

    // 256 x 32-bit data memory
    reg [31:0] memory [0:255];

    //=========================================================
    // Write Operation
    // SW instruction
    //=========================================================

    always @(posedge clk) begin
        if (MemWrite) begin
            memory[address[9:2]] <= write_data;
        end
    end

    //=========================================================
    // Read Operation
    // LW instruction
    //=========================================================

    assign read_data = memory[address[9:2]];

endmodule
