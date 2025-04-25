# ALU Module
This is a parameterized Verilog HDL implementation of an **Arithmetic Logic Unit (ALU)**. It performs a variety of arithmetic and logical operations based on a 4-bit opcode. The design is written in SystemVerilog using synthesizable constructs, making it suitable for FPGA and ASIC designs.



## Module Prameters
- `N` (default = 32): Specifies the width of the input and output data buses. Can be configured to support different operand sizes.


## Inputs 

| **Signal Name** | **Width** | **Description** |
|-----------------|-----------|-----------------|
| `read_data_1`   | N bits    | First operand for ALU operations. |
| `read_data_2`   | N bits    | Second operand for ALU operations. |
| `OpCode`        | 4 bits    | Operation code that selects the ALU operation. |

## Outputs

| **Signal Name** | **Width** | **Description** |
|-----------------|-----------|-----------------|
| `write_data`    | N bits    | Result of the selected ALU operation. |
| `zero_f`        | 1 bit     | Set to 1 if `write_data` is zero; otherwise 0. |


## Supported Operations

| OpCode (bin) | Mnemonic | Operation                        |
|--------------|----------|----------------------------------|
| 0001         | AND      | Bitwise AND                      |
| 0010         | OR       | Bitwise OR                       |
| 0100         | ADD      | Addition                         |
| 1001         | SUB      | Subtraction                      |
| 1100         | SLT      | Set if less than (signed)        |
| 0011         | SLL      | Shift left logical               |
| 1010         | SRL      | Shift right logical              |
| 1110         | MUL      | Multiplication                   |
| 0111         | XOR      | Bitwise XOR                      |
| Default      | -        | Outputs zero                     |


## Future Developments

Planned additions to make the ALU more robust:

- **Overflow Flag (overflow_f):**  
  Will detect arithmetic overflow conditions for signed operations (e.g., ADD, SUB).

- **Carry Flag (carry_f):**  
  Will detect unsigned overflow (carry-out from MSB).

- **Negative Flag (neg_f):**  
  Will indicate whether the result is negative (sign bit = 1).

- **Signed vs. Unsigned comparison:**  
  Introduce separate signed and unsigned comparison operations (e.g., SLTU).

- **Branch support:**  
  Flags can be used for conditional branching (e.g., BEQ, BNE).

- **Pipeline optimization:**  
  Explore splitting operations into pipeline stages for better performance.
