module prog_counter(
    input clk,reset,
    input StallF,
    input [31:0] pc_in,
    output reg [31:0] pc_out
);

always@(posedge clk) begin

    if(reset) 
        pc_out<=32'b0;
    else if(!StallF)
        pc_out<=pc_in;
        
end

endmodule