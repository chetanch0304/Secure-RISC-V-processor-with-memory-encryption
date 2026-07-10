module Data_Path(
    input clk, reset,

    //Control signals from Control Unit
    input Jump,RegWrite,ALUSrc,
    input MemWrite, 
    input [1:0] ResultSrc,
    input [1:0] ImmSrc,
    input [2:0] ALUControl,
    input Branch,
    
    //Outputs to Control Unit
    output [6:0] opcode,
    output [2:0] funct3,
    output [6:0] funct7
);

// Fetch Stage
    wire [31:0] PCF;
    wire [31:0] PCNextF;
    wire [31:0] PCPlus4F;
    wire [31:0] PCTargetE;// Branch target computed in EX stage
    wire [31:0] InstrF;

// Decode Stage
    wire [31:0] PCD;
    wire [31:0] PCPlus4D;
    wire [31:0] InstrD;
    wire [31:0] RD1D;
    wire [31:0] RD2D;
    wire [31:0] ImmExtD;

// Execute Stage
    wire [31:0] PCE;
    wire [31:0] PCPlus4E;
    wire [31:0] RD1E;
    wire [31:0] RD2E;
    wire [31:0] ImmExtE;
    wire [31:0] SrcAE;
    wire [31:0] SrcBE;
    wire [31:0] ALUResultE;
    wire ZeroE;
    wire [4:0] Rs1E;
    wire [4:0] Rs2E;
    wire [4:0] RdE;


// Memory Stage
    wire [31:0] ALUResultM;
    wire [31:0] WriteDataM;
    wire [31:0] ReadDataM;
    wire [31:0] PCPlus4M;
    wire [4:0] RdM;

// Decode Stage Control
    wire RegWriteD;
    wire MemWriteD;
    wire BranchD;
    wire JumpD;
    wire [1:0] ImmSrcD;
    wire ALUSrcD;
    wire [1:0] ResultSrcD;
    wire [2:0] ALUControlD;

// Execute Stage Control
    wire RegWriteE;
    wire MemWriteE;
    wire BranchE;
    wire JumpE;
    wire ALUSrcE;
    wire [1:0] ResultSrcE;
    wire [2:0] ALUControlE;

// Memory Stage Control
    wire RegWriteM;
    wire MemWriteM;
    wire [1:0] ResultSrcM;

// Write Back Stage Control
    wire RegWriteW;
    wire [1:0] ResultSrcW;
    wire [31:0] ResultW;
    wire [31:0] ReadDataW;
    wire [31:0] ALUResultW;
    wire [31:0] PCPlus4W;
    wire [4:0] RdW;
    
wire [31:0]  WriteDataE;
wire [31:0]  WriteDataM;
    
//Forwarding select signals
wire [1:0] ForwardAE;
wire [1:0] ForwardBE;    

//Stall and FLush signals
wire StallF;
wire StallD;
wire FlushD;
wire FlushE;


// PC Logic flow
prog_counter pc(.clk(clk), .reset(reset),.StallF(StallF),.pc_in(PCNextF),.pc_out(PCF));

instruction_mem im(.A(PCF),.RD(InstrF));

Pcplus4_adder a1(.pc_out(PCF),.PCPlus4(PCPlus4F));

IF_ID_reg if_id(.clk(clk),.reset(reset),.StallD(StallD),.FlushD(FlushD),.instrF(InstrF),.PCF(PCF), 
                .PCPlus4F(PCPlus4F), .instrD(InstrD), .PCD(PCD), .PCPlus4D(PCPlus4D));

    assign opcode = InstrD[6:0];
    assign funct3 = InstrD[14:12];
    assign funct7 = InstrD[31:25];


imm_extend e(.instruction(InstrD[31:7]), .ImmSrc(ImmSrcD), .ImmExt(ImmExtD));

register_file rf(.clk(clk), .A1(InstrD[19:15]), .A2(InstrD[24:20]), .A3(RdW), .WE3(RegWriteW), 
                 .WD3(ResultW), .RD1(RD1D), .RD2(RD2D));

//Outputs from the control unit being assigned to the internal control signals of datapath.
assign RegWriteD = RegWrite;
assign MemWriteD = MemWrite;
assign BranchD = Branch;
assign JumpD = Jump;
assign ImmSrcD=ImmSrc;
assign ALUSrcD = ALUSrc;
assign ResultSrcD = ResultSrc;
assign ALUControlD = ALUControl;

wire [4:0] Rs1D;
wire [4:0] Rs2D;
wire [4:0] RdD;

assign Rs1D=InstrD[19:15];
assign Rs2D=InstrD[24:20];
assign RdD=InstrD[11:7];

ID_EX_reg id_ex(
    .clk(clk), .reset(reset), .FlushE(FlushE),

    // Data
    .RD1D(RD1D),
    .RD2D(RD2D),
    .PCD(PCD),
    .PCPlus4D(PCPlus4D),
    .ImmExtD(ImmExtD),
    .Rs1D(Rs1D),
    .Rs2D(Rs2D),
    .RdD(RdD),
    .funct3D(funct3),

    // Control
    .RegWriteD(RegWriteD),
    .ResultSrcD(ResultSrcD),
    .MemWriteD(MemWriteD),
    .JumpD(JumpD),
    .BranchD(BranchD),
    .ALUSrcD(ALUSrcD),
    .ALUControlD(ALUControlD),

    // Outputs
    .RD1E(RD1E),
    .RD2E(RD2E),
    .PCE(PCE),
    .PCPlus4E(PCPlus4E),
    .ImmExtE(ImmExtE),
    .Rs1E(Rs1E),
    .Rs2E(Rs2E),
    .RdE(RdE),
    .RegWriteE(RegWriteE),
    .ResultSrcE(ResultSrcE),
    .MemWriteE(MemWriteE),
    .JumpE(JumpE),
    .BranchE(BranchE),
    .ALUSrcE(ALUSrcE),
    .ALUControlE(ALUControlE)
);

forwarding_unit fu(.Rs1E(Rs1E),.Rs2E(Rs2E),.RdM(RdM),.RegWriteM(RegWriteM),.RdW(RdW),
                    .RegWriteW(RegWriteW),.ForwardAE(ForwardAE),.ForwardBE(ForwardBE));

forward_mux muxA(.RD(RD1E),.ALUResultM(ALUResultM),.ResultW(ResultW),.Forward(ForwardAE),.Out(SrcAE));
forward_mux muxB(.RD(RD2E),.ALUResultM(ALUResultM),.ResultW(ResultW),.Forward(ForwardBE),.Out(WriteDataE));

// ALU Logic
ALUSrc_mux m2(.RD2(WriteDataE), .ImmExt(ImmExtE), .ALUSrc(ALUSrcE), .SrcB(SrcBE));

alu alu_stage(.SrcA(SrcAE), .SrcB(SrcBE),.ALUControl(ALUControlE),.ALUResult(ALUResultE),.Zero(ZeroE));

PCTarget_adder branch_adder(.pc_out(PCE), .ImmExt(ImmExtE), .PCTarget(PCTargetE));

wire PCSrcE;
assign PCSrcE= (ZeroE & BranchE)|JumpE;

PCSrc_mux m1(.PCSrc(PCSrcE), .PCPlus4(PCPlus4F),.PCTarget(PCTargetE),.PCNext(PCNextF));

EX_MEM_reg ex_mem(
    .clk(clk),
    .reset(reset),
    .ALUResultE(ALUResultE),
    .WriteDataE(WriteDataE),
    .PCPlus4E(PCPlus4E),
    .RdE(RdE),
    .RegWriteE(RegWriteE),
    .ResultSrcE(ResultSrcE),
    .MemWriteE(MemWriteE),
    .ALUResultM(ALUResultM),
    .WriteDataM(WriteDataM),
    .PCPlus4M(PCPlus4M),
    .RdM(RdM),
    .RegWriteM(RegWriteM),
    .ResultSrcM(ResultSrcM),
    .MemWriteM(MemWriteM)
);

hazard_detection_unit hazard(
    .Rs1D(Rs1D),
    .Rs2D(Rs2D),
    .RdE(RdE),
    .ResultSrcE(ResultSrcE),
    .PCSrcE(PCSrcE),
    .StallF(StallF),
    .StallD(StallD),
    .FlushD(FlushD),
    .FlushE(FlushE)
);

//------ Secure Memory Stage -------//
wire MemWriteRAM; wire KeyWriteEnable;

wire [31:0] SecretKey;

wire KeyLocked;
wire KeyValid;

wire [31:0] EncryptedWriteData;
wire [31:0] EncryptedReadData;

secure_memory_controller smc(.MemWriteM(MemWriteM),.Address(ALUResultM),.MemWriteRAM(MemWriteRAM),.KeyWriteEnable(KeyWriteEnable));

secure_key_storage key_storage(.clk(clk),.reset(reset),.key_write_enable(KeyWriteEnable),.key_in(WriteDataM),.secret_key(SecretKey),
.key_locked(KeyLocked),.key_valid(KeyValid));

encrypt_unit enc(.secret_key(SecretKey), .plaintext(WriteDataM),.ciphertext(EncryptedWriteData)); //encryption

Data_Memory data_mem(.clk(clk), .WE(MemWriteRAM), .A(ALUResultM), .WD(EncryptedWriteData), .RD(EncryptedReadData));

wire [31:0] DecryptedReadData;

decrypt_unit dec(.secret_key(SecretKey),.plaintext(DecryptedReadData),.ciphertext(EncryptedReadData));   //decryption

wire ReadKeyAddress;
assign ReadKeyAddress= (ALUResultM == 32'h00000020);

assign ReadDataM= ReadKeyAddress? 32'h00000000 : DecryptedReadData;

//---------------------------------//

MEM_WB mem_wb(
    .clk(clk),
    .reset(reset),
    .ReadDataM(ReadDataM),
    .ALUResultM(ALUResultM),
    .PCPlus4M(PCPlus4M),
    .RdM(RdM),
    .RegWriteM(RegWriteM),
    .ResultSrcM(ResultSrcM),
    .ReadDataW(ReadDataW),
    .ALUResultW(ALUResultW),
    .PCPlus4W(PCPlus4W),
    .RdW(RdW),
    .RegWriteW(RegWriteW),
    .ResultSrcW(ResultSrcW)
);    

ResultSrc_mux wb_mux(.ALUResult(ALUResultW), .RD(ReadDataW), .PCPlus4(PCPlus4W), .ResultSrc(ResultSrcW), .Result(ResultW));
    
endmodule