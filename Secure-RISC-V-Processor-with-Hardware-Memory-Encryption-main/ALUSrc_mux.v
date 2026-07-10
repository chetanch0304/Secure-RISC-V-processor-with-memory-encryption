module ALUSrc_mux(
input [31:0] RD2, 
input [31:0] ImmExt, 
input ALUSrc,
output [31:0] SrcB
);
    
assign SrcB = ALUSrc?ImmExt:RD2; // ALUSrc is the select line which will select the output for SrcB. 
                                 //   One indicates for ImmExt and zero indicates for RD2.
                                 
endmodule