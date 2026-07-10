module MEM_WB(
    input clk,
    input reset,

    // Data Signals
    input [31:0] ReadDataM,
    input [31:0] ALUResultM,
    input [31:0] PCPlus4M,

    input [4:0] RdM,

    // Control Signals
    input RegWriteM,
    input [1:0] ResultSrcM,

    // Data Outputs
    output reg [31:0] ReadDataW,
    output reg [31:0] ALUResultW,
    output reg [31:0] PCPlus4W,

    output reg [4:0] RdW,

    // Control Outputs
    output reg RegWriteW,
    output reg [1:0] ResultSrcW
);

always @(posedge clk) begin

    if(reset) begin
        ReadDataW  <= 32'b0;
        ALUResultW <= 32'b0;
        PCPlus4W   <= 32'b0;

        RdW        <= 5'b0;

        RegWriteW  <= 1'b0;
        ResultSrcW <= 2'b0;
    end

    else begin
        ReadDataW  <= ReadDataM;
        ALUResultW <= ALUResultM;
        PCPlus4W   <= PCPlus4M;

        RdW        <= RdM;

        RegWriteW  <= RegWriteM;
        ResultSrcW <= ResultSrcM;
    end
end

endmodule