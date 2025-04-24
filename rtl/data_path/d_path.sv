// this module transfers the data between the CPU's functional units

`include "alu.sv"
`include "reg_file.sv"



module d_path #(
    N = 32
)(
    input logic [4:0] read_add1,
    input logic [4:0] read_add2, 
    input logic [4:0] write_add,
    input logic [3:0] OpCode
    input logic write_en,
    input logic clk,
    input logic reset,
    output logic zero_f 

);


logic [(N-1):0] read_data_1;
logic [(N-1):0] read_data_2;
logic [(N-1):0] write_data;


reg_file reg_file_call (.clk(clk), .read_add1(read_add1), .read_add2(read_add2), .write_en(write_en), .write_add(write_add), 
                            .write_data(write_data), .reset(reset), .read_data_1(read_data_1), .read_data_2(read_data_2));


alu alu_call (.read_data_1(read_data_1), .read_data_2(read_data_2), .OpCode(OpCode), .write_data(write_data), .zero_f(zero_f))


    
endmodule