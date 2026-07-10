module EX_MEM_reg(
    input clk,
    input reset,

    // Data Signals -->
    input [31:0] ALUResultE,
    input [31:0] WriteDataE,
    input [31:0] PCPlus4E,

    input [4:0] RdE,

    // Control Signals -->
    input RegWriteE,
    input [1:0] ResultSrcE,
    input MemWriteE,

    // Data Outputs -->
    output reg [31:0] ALUResultM,
    output reg [31:0] WriteDataM,
    output reg [31:0] PCPlus4M,

    output reg [4:0] RdM,

    // Control Outputs -->
    output reg RegWriteM,
    output reg [1:0] ResultSrcM,
    output reg MemWriteM
);

always @(posedge clk) begin

    if(reset) begin
        ALUResultM <= 32'b0;
        WriteDataM <= 32'b0;
        PCPlus4M   <= 32'b0;

        RdM        <= 5'b0;

        RegWriteM  <= 1'b0;
        ResultSrcM <= 2'b0;
        MemWriteM  <= 1'b0;
    end

    else begin
        ALUResultM <= ALUResultE;
        WriteDataM <= WriteDataE;
        PCPlus4M   <= PCPlus4E;

        RdM        <= RdE;

        RegWriteM  <= RegWriteE;
        ResultSrcM <= ResultSrcE;
        MemWriteM  <= MemWriteE;
    end
end

endmodule