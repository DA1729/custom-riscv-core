# Custom RISC-V Based CPU (SystemVerilog) (vOld32-RISC-V)

Welcome to the repository for a simple **RISC-V based CPU** designed and implemented in SystemVerilog. I am obviously calling it vOld32 RISC-V Edition.
This project is a modular build of a basic 32-bit processor, featuring core components such as an **ALU, Control Unit, Register File, Instruction Memory, and Data Path** — integrated through a clean and understandable structure.

The processor currently supports **R-Type** instructions of the RISC-V ISA, with extensions planned for more instruction types and flags (like overflow, carry, and negative flags in ALU).


## Repo Structure

`
    docs/                # Documentation for each major module
    ALU/README.md
    control_unit/README.md
    data_path/README.md
    ifs/README.md
    processor/README.md
    register_file/README.md

rtl/                 # RTL (Register-Transfer Level) design files
    ALU/alu.sv
    control_unit/control_unit.sv
    data_path/d_path.sv
    fetch_unit/ifu.sv
    fetch_unit/inst_mem.sv
    fetch_unit/program.hex   # Instruction memory initialization
    processor/processor.sv
    register_file/reg_file.sv

LICENSE              # License file
README.md            # Top-level README (this file)

`


## Major Modules Overview

- **ALU (`rtl/ALU/alu.sv`)**: Performs arithmetic and logic operations based on the ALU `OpCode`.

- **Control Unit (`rtl/control_unit/control_unit.sv`)**: Decodes the instruction and generates control signals for the ALU and register file.

- **Register File (`rtl/register_file/reg_file.sv`)**: Stores and provides operand data, supports read and write operations.

- **Data Path (`rtl/data_path/d_path.sv`)**: Connects the ALU, Register File, and manages the flow of data during execution.

- **Fetch Unit (`rtl/fetch_unit/ifu.sv, rtl/fetch_unit/inst_mem.sv`)**: Handles instruction fetching and program counter incrementation. Instruction memory is preloaded from `program.hex`.

- **Processor (`rtl/processor/processor.sv`)**: Top-level module integrating all components into a working CPU.


## How it Works

- **Instruction Fetch**: The **Fetch Unit** (`ifu.sv`) increments the Program Counter (PC) and fetches the instruction from Instruction Memory (`inst_mem.sv`).

- **Instruction Decode**: The **Control Unit** decodes the instruction into ALU control signals and write-enable signals for the **Register File**.

- **Execution**: The **ALU** performs operations on the operands fetched from the **Register File**.

- **Write Back**: The result from the ALU is written back into the **Register File** if write-enable is asserted.


## Documentation 

Each module has a dedicated `README` under the `docs/` folder with:

- Detailed explanation of the module’s functionality.
- Inputs/Outputs and their description. 
- Sample waveforms / truth tables (if applicable). 



## Features

- Modular and scalable SystemVerilog design.

- Simple RISC-V instruction set focusing on R-Type instructions.

- Extensible ALU supporting multiple operations like ADD, SUB, AND, OR, SLL, SRL, XOR, MUL, and SLT.

- Easy-to-understand data flow.

- Instruction memory initialization through external `.hex` file.

- Clean and documented codebase for easy extension and learning.



## License

This project is licensed under the [MIT License](LICENSE).  
You are free to use, modify, and distribute this software, provided that the original copyright and 
permission notice are included in all copies or substantial portions of the software.




## Future Work

- Writing the testbenches for all the modules. 
- Expansion to other RISC-V instructions: I-type, S-type, etc. 
- Pipelining the processor.
- Adding support for memory access. 


If you want to get on this to make this processor super complex and super cool, reach me out at: dakshpandey177@gmail.com, or daksh_p@ph.iitr.ac.in

