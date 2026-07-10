module IF_ID_reg(
    input clk,reset,
    input StallD,
    input FlushD,
    input [31:0] instrF,
    input [31:0] PCF,
    input [31:0] PCPlus4F,
    output reg [31:0] instrD,
    output reg [31:0] PCD,
    output reg [31:0] PCPlus4D
);

always@(posedge clk) begin

    if(reset||FlushD) begin
        instrD<=32'b0;
        PCD<=32'b0;
        PCPlus4D<=32'b0;
    end
    
    else if(!StallD) begin
            instrD<=instrF;
            PCD<=PCF;
            PCPlus4D<=PCPlus4F;
    end

end

endmodule

    