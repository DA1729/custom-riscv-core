`include "inst_mem.sv"              // including the programmable instruction memory module


module ifs #(
    N = 32
) (
    input logic clk, init,
    output logic [N-1:0] inst_code
);

reg [N-1:0] PC = 32'b0;


inst_mem inst_mem_call (.PC(PC), .init(init), .inst_code(inst_code));

always @(posedge clk, posedge init)

begin
    if (init == 1)
    PC <= 0;
    else
    PC <= PC + 4;
end
    
endmodule
