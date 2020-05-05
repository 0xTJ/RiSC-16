module op_decode(
    input wire [15:0] instr,
    output wire [2:0] opcode,
    output wire [2:0] reg_a,
    output wire [2:0] reg_b,
    output wire [2:0] reg_c,
    output wire signed [6:0] s_imm,
    output wire [9:0] imm
);

assign opcode = instr[15:13];
assign reg_a = instr[12:10];
assign reg_b = instr[9:7];
assign reg_c = instr[2:0];
assign s_imm = instr[6:0];
assign imm = instr[9:0];

endmodule
