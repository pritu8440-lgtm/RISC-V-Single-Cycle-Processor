module Data_Memory (
    input         clk,
    input         reset,
    input         MemWrite,
    input  [31:0] address,
    input  [31:0] write_data,
    output [31:0] read_data
);

    reg [31:0] memory [0:255];

    integer i;

    // Read operation
    assign read_data = memory[address[9:2]];

    // Write operation
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 256; i = i + 1)
                memory[i] <= 32'd0;
        end
        else if (MemWrite) begin
            memory[address[9:2]] <= write_data;
        end
    end

endmodule
