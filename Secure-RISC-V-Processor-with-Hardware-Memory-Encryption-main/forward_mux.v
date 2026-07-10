module forward_mux(
    input [31:0] RD,
    input [31:0] ALUResultM,
    input [31:0] ResultW,
    input [1:0] Forward,
    output reg [31:0] Out
);

always @(*) begin

    case(Forward)

        2'b00: Out = RD;

        2'b01: Out = ResultW;

        2'b10: Out = ALUResultM;

        default: Out = RD;

    endcase

end

endmodule