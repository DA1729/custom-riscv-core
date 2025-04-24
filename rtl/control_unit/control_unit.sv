module control_unit #(
    N = 32
) (
    input logic [6:0] funct7, 
    input logic [2:0] funct3, 
    input logic [6:0] non_alu_opcode,  // this is the OpCode for the bigger system, which tells the type of ISA Operation, for now the core is executes only R-type 
    output logic [3:0] OpCode, // be very very very careful, this is the OpCode for the ALU not of the bigger system
    output logic write_en
);



always_comb begin
    // default outputs
    OpCode = 4'b0;
    write_en = 0;
    

    if (non_alu_opcode == 7'b0110011) begin // this opcode is for the R-Type Operation
        write_en = 1;


        case (funct3) // funct3 specifies the mode of operation of the ALU
            3'b000: begin
                if (funct7  == 7'b0)
                    OpCode = 4'b0010; // ADD operation
                    OpCode = 4'b0100; // SUD operation
            end
                    3'b110: OpCode = 4'b0001; // OR
                    3'b111: OpCode = 4'b0000; // AND
                    3'b001: OpCode = 4'b0011; // SLL
                    3'b101: OpCode = 4'b0101; // SRL
                    3'b010: OpCode = 4'b0110; // MUL
                    3'b100: OpCode = 4'b0111; // XOR
                    default: OpCode = 4'b0000;
        endcase


            end
    end


    
endmodule