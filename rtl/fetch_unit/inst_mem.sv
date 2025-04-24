// the instruction memory

module inst_mem #(
    N = 32
) (
    input logic [(N-1):0] PC,        // the program counter 
    input logic reset,                // initializes the program (sets the instruction memory)
    output logic [(N-1):0] inst_code

);

reg [7:0] mem_block [31:0];          // the instruction memory block 

assign inst_code = {mem_block[PC + 3], mem_block[PC + 2], mem_block[PC + 1], mem_block[PC]};

always @(reset) begin
    if (reset == 1) begin
        $readmemh("program.hex", mem_block);        // initializing the memory block with the program written in the hex file
    end
end

    
endmodule
