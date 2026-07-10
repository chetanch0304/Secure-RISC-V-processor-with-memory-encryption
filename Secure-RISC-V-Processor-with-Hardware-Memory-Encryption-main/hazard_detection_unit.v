module hazard_detection_unit(

    // Decode stage
    input  [4:0] Rs1D,
    input  [4:0] Rs2D,

    // Execute stage
    input  [4:0] RdE,
    input  [1:0] ResultSrcE,

    input PCSrcE,

    // Outputs
    output StallF,
    output StallD,
    output FlushD,
    output FlushE

);

wire lwStall;

// Load-use hazard detection
assign lwStall =(ResultSrcE == 2'b01) && (RdE!=5'd0) && ((Rs1D == RdE) || (Rs2D == RdE));

// Pipeline control
assign StallF = lwStall;

assign StallD = lwStall;

assign FlushD = PCSrcE;

assign FlushE = lwStall | PCSrcE;

endmodule