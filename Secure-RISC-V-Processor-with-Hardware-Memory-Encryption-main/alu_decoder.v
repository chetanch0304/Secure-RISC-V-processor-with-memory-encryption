module alu_decoder(
    input [1:0] ALUOp,
    input [2:0] funct3,
    input [6:0] funct7,
    output reg [2:0] ALUControl
);

always @(*) begin
case(ALUOp) 

    2'b00: ALUControl= 3'b000;  // for lw/sw type instructions(add)

    2'b01: ALUControl= 3'b001;  // for beq type instructions(subtract)

    2'b10: begin
                case(funct3)
                    3'b000:  ALUControl= (funct7==7'b0100000)? 3'b001:3'b000;  //SUB/ADD

                    3'b010: ALUControl=3'b101; //SLT

                    3'b110: ALUControl=3'b011; //OR

                    3'b111: ALUControl=3'b010; //AND

                    default: ALUControl=3'bxxx;
                endcase
            end

    default: ALUControl=3'bxxx;
endcase
end

endmodule