module alu #(parameter N = 32) (
    input  logic [(N-1):0] read_data_1, read_data_2,       //input operands
    input  logic [3:0]  OpCode,     //Operation Code or Control Code
    output logic [(N-1):0] write_data,          //output of ALU
    output logic        zero_f      //zero flag, active when the output is 0
    // i plan on adding more flags to the alu, like overflow, carry and negative
);

    always_comb begin
        case (OpCode)
            4'b0001: write_data = read_data_1 & read_data_2;                   // AND
            4'b0010: write_data = read_data_1 | read_data_2;                   // OR
            4'b0100: write_data = read_data_1 + read_data_2;                   // ADD
            4'b1001: write_data = read_data_1 - read_data_2;                   // SUB
            4'b1100: write_data = (read_data_1 < read_data_2) ? 32'd1 : 32'd0; // SLT
            4'b0011: write_data = read_data_1 << read_data_2;                  // SLL
            4'b1010: write_data = read_data_1 >> read_data_2;                  // SRL
            4'b1110: write_data = read_data_1 * read_data_2;                   // MUL
            4'b0111: write_data = read_data_1 ^ read_data_2;                   // XOR
            default: write_data = 32'd0;
        endcase

        zero_f = (write_data == 32'd0);         // setting up the value of zero flag
    end

endmodule
