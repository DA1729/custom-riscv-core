# Control Unit Module

This module is a basic **Control Unit** for decoding R-type instructions in a simplified RISC-V processor.
It generates the appropriate **ALU** `OpCode` and **write enable signal** based on the instruction fields: `funct3`, `funct7`, and the main `opcode` from the instruction word.

## Module Parameters

- `N` (default = 32): Width of data operands (currently unused but can be used for future scaling and consistency). 

## 🛠️ Inputs 

| **Signal Name** | **Width** | **Description** |
|:----------------|:----------|:----------------|
| `funct7`         | 7 bits     | Instruction-specific field used to differentiate opcodes (e.g., ADD vs SUB). |
| `funct3`         | 3 bits     | Encodes the basic operation type within the R-type format. |
| `non_alu_opcode` | 7 bits     | Full instruction opcode from the instruction word. Only R-type (`0110011`) is currently supported. |

---

## 🛠️ Outputs 

| **Signal Name** | **Width** | **Description** |
|:----------------|:----------|:----------------|
| `OpCode`         | 4 bits     | ALU operation code, passed to the ALU. **Do not confuse with** `non_alu_opcode`. |
| `write_en`       | 1 bit      | Set to 1 when the operation writes to a destination register. |


## ⚙️ Supported Instructions (R-Type)

This control unit currently supports only **R-type** instructions (`non_alu_opcode = 0110011`):

| `funct3` | `funct7`  | **Instruction** | **ALU `OpCode`** | **Operation**            |
|:--------:|:---------:|:----------------|:----------------:|:--------------------------|
| `000`    | `0000000` | ADD              | `0010`            | Addition                  |
| `000`    | `0100000` | SUB              | `0100`            | Subtraction               |
| `110`    | `xxxxxxx` | OR               | `0001`            | Bitwise OR                |
| `111`    | `xxxxxxx` | AND              | `0000`            | Bitwise AND               |
| `001`    | `xxxxxxx` | SLL              | `0011`            | Logical Shift Left        |
| `101`    | `xxxxxxx` | SRL              | `0101`            | Logical Shift Right       |
| `010`    | `xxxxxxx` | MUL              | `0110`            | Multiplication            |
| `100`    | `xxxxxxx` | XOR              | `0111`            | Bitwise XOR               |

> **Note:**  
> For instructions with unspecified `funct7`, the current implementation does not validate it.  
> Only ADD and SUB require a `funct7` check.


## 🪐 Future Developments

- ⬜ **Support for I-type, B-type, S-type instructions**  
  Add decoding logic for load/store/branch operations.

- ⬜ **Hazard Detection Unit**  
  Integrate control logic to detect and manage hazards in pipelined implementations.

- ⬜ **ALU Function Abstraction**  
  Move OpCode generation to a dedicated function for clarity and modularity.

- ⬜ **Illegal Instruction Detection**  
  Add signaling for unsupported or invalid `funct3` / `funct7` combinations.

- ⬜ **Parameterize Instruction Formats**  
  Use parameter definitions for all opcodes and function codes to improve readability and configurability.
