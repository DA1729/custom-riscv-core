module alu #(parameter N = 32) (
    input  logic [(N-1):0] read_data_1, read_data_2,       //input operands
    input  logic [3:0]  OpCode,     //Operation Code or Control Code
    output logic [(N-1):0] write_data,          //output of ALU
    output logic        zero_f      //zero flag, active when the output is 0
    // i plan on adding more flags to the alu, like overflow, carry and negative
);

    always_comb begin
        case (OpCode)
            4'b0001: y = a & b;                   // AND
            4'b0010: y = a | b;                   // OR
            4'b0100: y = a + b;                   // ADD
            4'b1001: y = a - b;                   // SUB
            4'b1100: y = (a < b) ? 32'd1 : 32'd0; // SLT
            4'b0011: y = a << b;                  // SLL
            4'b1010: y = a >> b;                  // SRL
            4'b1110: y = a * b;                   // MUL
            4'b0111: y = a ^ b;                   // XOR
            default: y = 32'd0;
        endcase

        zero_f = (y == 32'd0);         // setting up the value of zero flag
    end

endmodule
