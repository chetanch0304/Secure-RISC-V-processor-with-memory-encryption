module PCSrc_mux(
    input PCSrc,
    input [31:0] PCPlus4,
    input [31:0] PCTarget,
    output [31:0] PCNext
);

assign PCNext= PCSrc? PCTarget:PCPlus4;

endmodule