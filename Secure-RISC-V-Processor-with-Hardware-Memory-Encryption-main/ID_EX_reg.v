module ID_EX_reg(
    input clk,reset,
    input FlushE,

    // Data Signals
    input [31:0] RD1D,
    input [31:0] RD2D,
    input [31:0] PCD,
    input [31:0] PCPlus4D,
    input [31:0] ImmExtD,

    input [4:0] Rs1D,
    input [4:0] Rs2D,
    input [4:0] RdD,

    input [2:0] funct3D,

    // Control Signals
    input RegWriteD,
    input [1:0] ResultSrcD,
    input MemWriteD,
    input JumpD,
    input BranchD,
    input ALUSrcD,
    input [2:0] ALUControlD,

    // Data Outputs
    output reg [31:0] RD1E,
    output reg [31:0] RD2E,
    output reg [31:0] PCE,
    output reg [31:0] PCPlus4E,
    output reg [31:0] ImmExtE,

    output reg [4:0] Rs1E,
    output reg [4:0] Rs2E,
    output reg [4:0] RdE,

    output reg [2:0] funct3E,

    // Control Outputs
    output reg RegWriteE,
    output reg [1:0] ResultSrcE,
    output reg MemWriteE,
    output reg JumpE,
    output reg BranchE,
    output reg ALUSrcE,
    output reg [2:0] ALUControlE
);

always @(posedge clk) begin

    if(reset||FlushE) begin
        RD1E<=32'b0;
        RD2E<=32'b0;
        PCE<=32'b0;
        PCPlus4E<=32'b0;
        ImmExtE<=32'b0;

        Rs1E<=5'b0;
        Rs2E<=5'b0;
        RdE<=5'b0;

        funct3E<=3'b0;

       
        RegWriteE<=0;
        ResultSrcE<=2'b0;
        MemWriteE<=0;
        JumpE<=0;
        BranchE<=0;
        ALUSrcE<=0;
        ALUControlE<=3'b0;
    end

    else begin
        RD1E        <= RD1D;
        RD2E        <= RD2D;
        PCE         <= PCD;
        PCPlus4E    <= PCPlus4D;
        ImmExtE     <= ImmExtD;

        Rs1E        <= Rs1D;
        Rs2E        <= Rs2D;
        RdE         <= RdD;

        funct3E     <= funct3D;

        RegWriteE   <= RegWriteD;
        ResultSrcE  <= ResultSrcD;
        MemWriteE   <= MemWriteD;
        JumpE       <= JumpD;
        BranchE     <= BranchD;
        ALUSrcE     <= ALUSrcD;
        ALUControlE <= ALUControlD;
    end
end

endmodule