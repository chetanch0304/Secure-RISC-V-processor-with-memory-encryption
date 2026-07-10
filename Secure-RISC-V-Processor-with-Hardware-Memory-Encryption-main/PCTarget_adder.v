module PCTarget_adder(
    input [31:0] pc_out,
    input [31:0] ImmExt,
    output [31:0] PCTarget
);

assign PCTarget= pc_out+ImmExt;

endmodule