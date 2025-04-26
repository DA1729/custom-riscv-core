// this module integrates all the modules to complete the processor

`include "./../ALU/alu.sv"                      // ALU module (we won't be calling it explicitly tho)
`include "./../control_unit/control_unit.sv"    // control unit (explicitly called)
`include "./../data_path/d_path.sv"             // data path module (explicitly called)
`include "./../register_file/reg_file.sv"       // register file module (not explicitly called)
`include "./../fetch_unit/ifu.sv"


module processor #(
    N = 32
) (
    input logic clk, 
    input logic reset, 

    output logic zero_f
);


logic [(N-1):0] inst_code;                      // intermediate value coming up from the IFU 
logic [3:0] OpCode;                             // ALU's Operation Code (input to the ALU)
logic write_en;                                 // output from the control unit


ifu ifu_call (.clk(clk), .reset(reset), .inst_code(inst_code));      // from here, we get the instruction code

// the R-Type instruction code has the following decomposition:
// inst_code[31:25] = funct7, controls which arithmetic operation to perform 
// inst_code[24:20] = rs2, which is the pointer to the 2nd source register (or the value for read_add_2)
// inst_code[19:15] = rs1, which is the pointer to the 1st soruce register (or the value for read_add_1)
// inst_code[14:12] = funct3, controls which mode of operation for the ALU (arithmetic or logic)
// inst_code[11:7] = rd, the pointer to the register where we want to write the ALU output (or the value for write_add)
// inst_code[6:0] = opcode, here the variable's name is non_alu_opcode, tells the type of operation of ISA, for now the processor only support R-type operations, that too not all of them

ifu instruction_fetch (.clk(clk), .reset(reset), .inst_code(inst_code));        // fetching the instruction code

data_path data_path_call (.read_add1(inst_code[19:15]), .read_add2(inst_code[24:20]), .write_add(inst_code[11:7]), 
                                                  .OpCode(OpCode), .write_en(write_en), .clk(clk), .reset(reset),
                                                                                                 .zero_f(zero_f));


control_unit control_call (.funct7(inst_code[31:25]), .funct3(inst_code[14:12]), .non_alu_opcode(inst_code[6:0]),
                                                                           .OpCode(OpCode), .write_en(write_en));

    
endmodule
