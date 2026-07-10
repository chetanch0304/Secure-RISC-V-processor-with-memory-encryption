module Pcplus4_adder(
    input [31:0] pc_out,
    output [31:0] PCPlus4
);

assign PCPlus4= pc_out+4;

endmodule