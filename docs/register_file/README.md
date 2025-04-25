# Register File Module

The `reg_file` module implements a simple 32-register block for a CPU. It supports two simultaneous reads and one write per clock cycle. It also provides a **reset** capability to clear all register contents.


## Inputs

| Signal Name | Width | Description |
|:------------|:------|:------------|
| `clk` | 1 bit | Clock signal for synchronous operations. |
| `read_add1` | 5 bits | Address of the first register to read data from. |
| `read_add2` | 5 bits | Address of the second register to read data from. |
| `write_en` | 1 bit | Write enable signal. If high, data will be written to the register at `write_add`. |
| `write_add` | 5 bits | Address of the register to write `write_data` into. |
| `write_data` | 32 bits (parameterized by `N`) | Data to write into the register file. |
| `reset` | 1 bit | Resets all registers to zero when asserted. |

---

## Outputs

| Signal Name | Width | Description |
|:------------|:------|:------------|
| `read_data_1` | 32 bits (parameterized by `N`) | Data read from the register at address `read_add1`. |
| `read_data_2` | 32 bits (parameterized by `N`) | Data read from the register at address `read_add2`. |

## Internal Behavior

- **Reset**:
  - On `posedge reset`, all 32 registers are cleared to `32'b0`.
  - `read_data_1` and `read_data_2` are set to zero.

- **Normal Operation**:
  - On the rising edge of `clk`:
    - `read_data_1` and `read_data_2` fetch values from the registers at addresses `read_add1` and `read_add2`.
    - If `write_en` is active, `write_data` is written to the register specified by `write_add`.

---

## Important Notes

- **Parameterization**: The register size (`N`) is parameterized, but the module currently hardcodes `reg_block` to **32-bit** wide and **32** entries.

- **Incorrect Usage**:
  - `assign` statements should not be inside an `always_ff` block (this will cause synthesis/simulation errors).
  - Instead of `assign`, direct non-blocking (`<=`) or blocking (`=`) assignments should be used for outputs.

- **Write Priority**: Write happens after reads in the same clock cycle.
