module register_file(
    input clk,
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input WE3,
    input [31:0] WD3,
    output [31:0] RD1,
    output [31:0] RD2
);

reg [31:0] reg_file [31:0];//register file array containing 32 registers each of 32-bits

//Synchronous Write
always@(posedge clk) begin

    if(WE3 && (A3!=0))
    reg_file[A3]<=WD3;
end    

//Asynchronous Read
assign RD1= (A1==0) ? 32'b0:reg_file[A1];
assign RD2= (A2==0) ? 32'b0:reg_file[A2];

endmodule
