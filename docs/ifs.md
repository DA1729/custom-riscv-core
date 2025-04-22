# Instruction Fetch Unit


## Overview

The **Instruction Fetch Unit** is a key component of a CPU's instruction pipeline that fetches instructions from memory based on the Program Counter (PC). It consists of two main modules:

- **Instruction Memory Module (`inst_mem`)**: Loads instructions from a `.hex` file into memory and provides the instruction code based on the current value of the PC.

- **Instruction Fetch Module (`ifs`)**: Manages the program counter (PC) and fetches the instruction code from the memory at each clock cycle.

The modules are designed to be highly flexible and can be customized to suit different instruction sets and memory sizes.

## Module 1: `inst_mem`

### Description

The **Instruction Memory Module** is responsible for storing and retrieving instructions from memory. When the `init` signal is asserted, it loads instructions from a `.hex` file into a memory block. The `inst_code` output provides the 32-bit instruction at the memory location specified by the Program Counter (PC).


### Parameters

- `N`: The bit-width of the instruction (default value: 32 bits).

- This allows the instruction memory to support different architectures (e.g., 32-bit, 64-bit).

### Inputs

- `PC`: The **Program Counter** (of width `N` bits) which determines the memory address from which to fetch the instruction.

- `init`: A **reset signal** (1-bit) that initializes the memory by reading from the `.hex` file.

### Outputs

- `inst_code`: The **32-bit instruction code** fetched from the memory based on the value of `PC`.

### Internal Signals

- `mem_block`:  A memory array (`32` entries, each 8 bits wide) that stores the instructions loaded from the `.hex` file.



## Module 2: `ifs`

### Description

The **Instruction Fetch Module** (`ifs`) is responsible for managing the Program Counter (PC) and fetching instructions at each clock cycle. The PC increments by 4 on each clock cycle (assuming a 32-bit architecture). The module outputs the current instruction from the memory based on the updated PC.

### Parameters

- `N`: The bit-width of the instruction (default value: 32 bits).

### Inputs

- `clk`: The **clock signal** to synchronize the program counter and instruction fetch operations.

- `init`: The **reset signal** (1-bit), which initializes the PC to 0 and loads instructions into the instruction memory.


### Outputs

- `inst_code`: The **32-bit instruction code** fetched from the instruction memory.

### Internal Signals

- `PC`: The **Program Counter** that keeps the track of the current instruction's address in memory. It is updated on each clock cycle. 


## Operation

- **Instruction Memory Initialization**:

    - When the `init` signal is asserted (set to `1`), the `inst_mem` module loads the instructions from the `program.hex` file into the memory (`mem_block`).

    - The instructions in the `.hex` file are stored in memory as 32-bit words (4 bytes each).

- **Instruction Fetching**: 
    
    - When `init` is `0` and the clock (`clk`) signal is active, the `ifs` module increments the Program Counter (PC) by 4 on each clock cycle, and the corresponding instruction is fetched from memory.

    - The `PC` is used as an address to retrieve the correct instruction from memory. The instruction is then assigned to `inst_code`.

- **Program Counter (PC) Management**:

    - On reset (`init == 1`), the PC is reset to `0`.

    - Otherwise, the PC is incremented by 4 on each clock cycle to fetch the next instruction.


## Example Workflow

- **Initialization**:
    
    - The system is initialized by asserting the `init` signal, which loads instructions from a `.hex` file into the instruction memory.

- **Fetching Instructions**:

    - After initialization, the `init` signal is deasserted (`init == 0`), and the clock signal (`clk`) begins to drive the instruction fetch process.

    - On each clock cycle, the `ifs` module increments the PC and fetches the instruction corresponding to the updated PC value.


## File Format for .hex

The .hex file should contain the instructions in hexadecimal format. Each line corresponds to a 32-bit instruction, represented by four 8-bit values (one per byte). An example of the .hex file format:

`
00 94 03 33  // add t1, s0, s1
41 39 03 B3  // sub t2, s2, s3
03 5A 02 B3  // mul t0, s4, s5
01 7B 4E 33  // xor t3, s6, s7
`


Each 8-bit chunk is loaded into the `mem_block` array in the `inst_mem` module.



## Notes

- **PC Incrementation**: The current design assumes a simple 32-bit architecture where each instruction is 4 bytes (32 bits), so the Program Counter increments by 4 on each cycle.

- **Memory Size**: The instruction memory size is set to 32 bytes (8 instructions). To change the size, you can modify the `mem_block` array size and adjust the `.hex` file accordingly
