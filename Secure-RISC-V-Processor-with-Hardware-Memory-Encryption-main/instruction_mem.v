module instruction_mem(
    input [31:0] A,
    output reg [31:0] RD
);

//Instruction memory array(ROM)
reg [31:0] mem[0:63];

integer i;

//Initialize the memory with program instructions(Hex form)
initial begin

//    mem[0] = 32'h01900093;   // addi x1,x0,25
//    mem[1] = 32'h00102023;   // sw x1,0(x0)
//    mem[2] = 32'h00002103;   // lw x2,0(x0)
//    mem[3] = 32'h00510193;   // addi x3,x2,5
//    mem[4] = 32'h00302223;   // sw x3,4(x0)
//    mem[5] = 32'h00402203;   // lw x4,4(x0)
//    mem[6] = 32'h004102B3;   // add x5,x2,x4

      mem[0] = 32'h00F00093;   // addi x1,x0,15
      mem[1] = 32'h02102023;   // sw x1,32(x0)
      mem[2] = 32'h01900113;   // addi x2,x0,25
      mem[3] = 32'h00202023;   // sw x2,0(x0)
      mem[4] = 32'h00002183;   // lw x3,0(x0)
      mem[5] = 32'h00A18213;   // addi x4,x3,10
      mem[6] = 32'h00402223;   // sw x4,4(x0)
      mem[7] = 32'h00402283;   // lw x5,4(x0)
      mem[8] = 32'h00518333;   // add x6,x3,x5
      mem[9] = 32'h02002383;   // lw x7,32(x0)
      mem[10] = 32'h03700093;   // addi x1,x0,55
      mem[11] = 32'h02102023;   // sw x1,32(x0)
    
    for(i=12;i<64;i=i+1)
        mem[i] = 32'h00000013;   // NOP
end

//initial begin
//    
//    for(i=0;i<64;i=i+1)
//        mem[i] = 32'h00000013;   // addi x0,x0,0 (NOP)
//        
//    $readmemh("program.hex",mem);
//end

//Reads the instruction corresponding to given address
always@(*) begin
    RD= mem[A[31:2]]; //Addresses being multiple of 4 contains 0 in last 2 bits(so we avoid them)
end

endmodule
