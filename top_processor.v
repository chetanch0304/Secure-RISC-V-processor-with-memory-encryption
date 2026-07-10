module top_processor(
    input clk,
    input reset
);

// Datapath -> Control Unit
wire [6:0] opcode;
wire [2:0] funct3;
wire [6:0] funct7;


// Control Unit -> Datapath
wire Jump;

wire RegWrite;
wire ALUSrc;
wire MemWrite;

wire [1:0] ResultSrc;      
wire [1:0] ImmSrc;
wire [2:0] ALUControl;

// internal only
wire Branch;


// Control Unit
control_unit CU(
    .opcode(opcode),
    .funct3(funct3),
    .funct7(funct7),
    .Jump(Jump),
    .ALUControl(ALUControl),
    .RegWrite(RegWrite),
    .ImmSrc(ImmSrc),
    .ALUSrc(ALUSrc),
    .MemWrite(MemWrite),
    .ResultSrc(ResultSrc),
    .Branch(Branch)
);


// Datapath
Data_Path DP(
    .clk(clk),
    .reset(reset),
    .Jump(Jump),
    .RegWrite(RegWrite),
    .ALUSrc(ALUSrc),
    .MemWrite(MemWrite),
    .ResultSrc(ResultSrc),
    .ALUControl(ALUControl),
    .ImmSrc(ImmSrc),
    .Branch(Branch),
    .opcode(opcode),
    .funct3(funct3),
    .funct7(funct7)
);

endmodule