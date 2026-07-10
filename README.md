# Secure 5-Stage Pipelined RISC-V Processor with Transparent Memory Encryption

A **32-bit 5-stage pipelined RISC-V processor** designed in Verilog HDL featuring **transparent hardware-based memory encryption**. The processor automatically encrypts all data during store operations and decrypts it during load operations without requiring any modifications to the RISC-V ISA or software.

The project is based on the architecture presented in **Digital Design and Computer Architecture: RISC-V Edition** by Sarah Harris and David Harris and extends it by integrating a secure memory subsystem for hardware-level data protection.

---

## Key Features

### Processor Architecture

- 32-bit RV32I-compatible pipelined processor
- Five-stage pipeline
  - Instruction Fetch (IF)
  - Instruction Decode (ID)
  - Execute (EX)
  - Memory Access (MEM)
  - Write Back (WB)
- Modular RTL implementation
- 32 × 32-bit Register File
- Separate Instruction and Data Memory
- Immediate Extension Unit
- Branch and Jump Support
- Hazard Detection Unit
- Data Forwarding Unit
- Pipeline Flushing and Stalling
- Verified using Xilinx Vivado

---

## Security Features

Unlike conventional processors that store plaintext directly into memory, this processor integrates a **Transparent Memory Encryption Engine** inside the Memory stage.

### Automatic Encryption

Every Store (`sw`) instruction performs:

```
Plaintext
        │
        ▼
Encryption Engine
        │
        ▼
Ciphertext
        │
        ▼
Data Memory
```

Only encrypted data is stored in memory.

---

### Automatic Decryption

Every Load (`lw`) instruction performs:

```
Encrypted Data
        │
        ▼
Decryption Engine
        │
        ▼
Plaintext
        │
        ▼
Register File
```

Software remains completely unaware of the encryption process.

---

## Secure Memory Architecture

```
                     EX/MEM Pipeline Register
                               │
                               ▼
                    Secure Memory Controller
                    ┌─────────────────────┐
                    │                     │
                    ▼                     ▼
             Secure Key Storage     Encryption Unit
                    │                     │
                    └─────────┬───────────┘
                              │
                         Data Memory
                              │
                       Decryption Unit
                              │
                              ▼
                    MEM/WB Pipeline Register
```

---

## Secure Key Management

The processor includes a dedicated **Secure Key Storage** module.

### Features

- Owner-programmable encryption key
- Write-only key register
- Automatic key locking after initialization
- Key validity detection
- Read protection against secret key access

The owner initializes the processor by writing a secret key to a dedicated key register. Once programmed, the key is locked and cannot be modified during execution.

---

## Supported Instructions

### R-Type

- ADD
- SUB
- AND
- OR
- SLT

### I-Type

- ADDI
- LW

### S-Type

- SW

### B-Type

- BEQ

### J-Type

- JAL

---

## Hazard Handling

### Data Hazards

Resolved using a dedicated Forwarding Unit supporting forwarding from:

- EX/MEM Stage
- MEM/WB Stage

### Load-Use Hazards

Handled using a Hazard Detection Unit which inserts pipeline stalls whenever forwarding cannot resolve dependencies.

### Control Hazards

Branches and jumps are resolved in the Execute stage using pipeline flushing.

---

## Security Verification

The secure processor was verified using multiple assembly programs demonstrating:

- Secret key initialization
- Automatic key locking
- Transparent encryption during Store instructions
- Transparent decryption during Load instructions
- Protection against reading the secret key
- Correct ALU execution after decrypted memory reads
- Correct forwarding and hazard handling with encrypted memory operations

Simulation confirmed that:

- Register File stores and operates on plaintext values
- Data Memory stores only encrypted ciphertext
- Processor functionality remains unchanged despite memory encryption

---

## Project Structure

```
├── Program Counter
├── Instruction Memory
├── Data Memory
├── Register File
├── ALU
├── Immediate Generator
├── Control Unit
├── Main Decoder
├── ALU Decoder
├── Hazard Detection Unit
├── Forwarding Unit
├── IF_ID Register
├── ID_EX Register
├── EX_MEM Register
├── MEM_WB Register
├── Secure Memory Controller
├── Secure Key Storage
├── Encrypt Unit
├── Decrypt Unit
├── Datapath
├── Top Processor
└── Testbench
```

---

## Tools Used

- Verilog HDL
- Xilinx Vivado
- Visual Studio Code
- Git
- GitHub

---

## Future Improvements

- Replace XOR encryption with Simplified AES
- Support full AES-128 encryption
- Hardware Random Number Generator (TRNG)
- Secure Boot Mechanism
- Instruction Memory Encryption
- Secure DMA Engine
- Memory Protection Unit (MPU)
- Hardware Access Control
- Cache Encryption
- Secure SoC Integration

---

## References

- David Harris & Sarah Harris, *Digital Design and Computer Architecture: RISC-V Edition*
- RISC-V Unprivileged ISA Specification

---

## Author

**Chetan Chaudhary**

B.Tech Electronics and Communication Engineering

National Institute of Technology Silchar

---

## Project Highlights

- ✔ 5-Stage Pipelined RISC-V Processor
- ✔ Hazard Detection and Data Forwarding
- ✔ Transparent Hardware Memory Encryption
- ✔ Secure Key Storage
- ✔ Automatic Encryption/Decryption
- ✔ Write-Only Secret Key Register
- ✔ Pipeline Verification in Xilinx Vivado
