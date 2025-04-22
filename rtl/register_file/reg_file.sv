module reg_file #(
    N = 32
) (
    input logic clk,  // clock input
    input logic [4:0] read_add1,    // address for the register to get our first data
    input logic [4:0] read_add2,    // address for the register to get our second deta
    input logic write_en,           // enable input for writing the data
    input logic write_add,          // address for writing the data
    input logic [N-1:0] write_data, // data to write in the given address

    input logic reset,              // the reset switch (you know what it does)

    output logic [N-1:0] read_data_1, // read data from address 1
    output logic [N-1:0] read_data_2  // read data from address 2

    
    );
    reg [31:0] reg_block [31:0];       // the register block 

    always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        for (int i = 0; i < 32; i++) begin
        reg_block[i] <= 32'b0;          // resets all the memory registers to 0 at the positive edge of reset
        assign read_data_1 = 32'b0;
        assign read_data_2 = 32'b0;
        end
    end else begin
        assign read_data_1 = reg_block[read_add1];
        assign read_data_2 = reg_block[read_add2];

        if (write_en) begin
            reg_block[write_add] = write_data;
        end
    end
    end
 
endmodule