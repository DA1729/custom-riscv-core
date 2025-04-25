# Processor Module

The `processor` module integrates all major components needed to form a simple R-Type instruction CPU. It connects the instruction fetch unit, control unit, data path, ALU, and register file into a working processor. It supports basic R-type operations and outputs a **zero flag** based on ALU operations.

---

## Inputs

| Signal Name | Width | Description |
|:------------|:------|:------------|
| `clk` | 1 bit | Clock signal for synchronous operations. |
| `reset` | 1 bit | Resets the processor components when asserted. |

---

## Outputs

| Signal Name | Width | Description |
|:------------|:------|:------------|
| `zero_f` | 1 bit | Flag indicating whether the ALU output is zero (used for conditional operations). |

---

## Internal Behavior

- **Instruction Fetch**:
  - The `ifu` (Instruction Fetch Unit) fetches the next instruction and outputs it through `inst_code`.

- **Instruction Decomposition**:
  - Fetched instruction (`inst_code`) fields:
    - `funct7` (`inst_code[31:25]`): Specifies detailed ALU operation.
    - `rs2` (`inst_code[24:20]`): Source register 2 address.
    - `rs1` (`inst_code[19:15]`): Source register 1 address.
    - `funct3` (`inst_code[14:12]`): Mode selector for the ALU (e.g., arithmetic or logic).
    - `rd` (`inst_code[11:7]`): Destination register address.
    - `opcode` (`inst_code[6:0]`): Operation type (currently only R-Type instructions supported).

- **Control Unit**:
  - The `control_unit` decodes parts of the instruction (`funct7`, `funct3`, `opcode`) to generate:
    - `OpCode`: Operation code for the ALU.
    - `write_en`: Write enable signal for the register file.

- **Data Path**:
  - The `data_path` module uses:
    - Read addresses (`rs1`, `rs2`) and write address (`rd`) from the instruction.
    - `OpCode` and `write_en` from the control unit.
    - Performs ALU operations and manages register reads/writes.
    - Outputs `zero_f` to indicate ALU result is zero.

- **ALU and Register File**:
  - The `ALU` operates based on inputs from the `data_path` and `control_unit`.
  - The `reg_file` is embedded within the `data_path` and handles register operations.

---

## Important Notes

- **Module Integration**:
  - This module integrates five submodules:
    - `ifu` (Instruction Fetch Unit)
    - `control_unit`
    - `data_path`
    - `ALU` (implicitly through `data_path`)
    - `reg_file` (implicitly through `data_path`)

- **Instruction Set Limitation**:
  - Only a subset of R-type instructions are currently supported.
  - Future extensions can include other instruction types (I-Type, S-Type, etc.).

- **Zero Flag**:
  - The `zero_f` output can be used for branch decisions or comparisons in future designs.
