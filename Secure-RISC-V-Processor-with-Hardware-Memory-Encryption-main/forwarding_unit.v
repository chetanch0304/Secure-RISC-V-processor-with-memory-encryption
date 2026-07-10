module forwarding_unit (
    // Source registers in EX stage (of dependent instruction)
    input  wire [4:0]  Rs1E,
    input  wire [4:0]  Rs2E,

    input  wire [4:0]  RdM, // Destination register from MEM stage
    input  wire RegWriteM,

    input  wire [4:0]  RdW, // Destination register from WB stage
    input  wire RegWriteW,

    // Forwarding mux selects
    output reg  [1:0]  ForwardAE,
    output reg  [1:0]  ForwardBE
);

    always @(*) begin

    //default: no forwarding
        ForwardAE=2'b00;
        ForwardBE=2'b00;

        // ForwardAE (for rs1) 
        if (RegWriteM && (RdM != 5'b0) && (RdM == Rs1E))
            ForwardAE = 2'b10;   // forward from MEM stage
        else if (RegWriteW && (RdW != 5'b0) && (RdW == Rs1E))
            ForwardAE= 2'b01;   // forward from WB stage
        else
            ForwardAE= 2'b00;   // no forwarding

        // ForwardBE (for rs2) 
        if (RegWriteM && (RdM != 5'b0) && (RdM == Rs2E))
            ForwardBE = 2'b10;
        else if (RegWriteW && (RdW != 5'b0) && (RdW == Rs2E))
            ForwardBE = 2'b01;
    end

endmodule
