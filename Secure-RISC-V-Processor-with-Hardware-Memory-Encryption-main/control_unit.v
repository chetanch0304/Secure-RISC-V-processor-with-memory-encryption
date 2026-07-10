module control_unit(
    input [6:0] opcode,
    input [2:0] funct3,
    input [6:0] funct7,

    output wire Jump,
    output wire [2:0] ALUControl,
    output wire RegWrite,
    output wire [1:0] ImmSrc,
    output wire ALUSrc,
    output wire MemWrite,
    output wire [1:0] ResultSrc,
    output wire Branch
);

wire [1:0] ALUOp; 

main_decoder dut(opcode,RegWrite,ImmSrc,ALUSrc,MemWrite,ResultSrc,Branch,ALUOp,Jump);

alu_decoder uut(ALUOp,funct3,funct7,ALUControl);


endmodule