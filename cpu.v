module cpu(
    input wire clk_fetch,
    input wire clk_execute,
    input wire reset,
    input wire [15:0] instr,
    output wire [15:0] instr_addr,
    output wire we_dmem,
    output wire [15:0] data_addr,
    output wire [15:0] data_in,
    input wire [15:0] data_out,
    output wire halt
);

wire [1:0] func_alu;
wire mux_alu1, mux_alu2, mux_rf;
wire [1:0] mux_pc, mux_tgt;
wire we_rf;

reg _halt;

wire [2:0] tgt, src1;
reg [2:0] src2;

reg [15:0] tgt_val;
wire [15:0] src1_val;
wire [15:0] src2_val;

wire [2:0] opcode, reg_a, reg_b, reg_c;
wire signed [6:0] s_imm;
wire [9:0] imm;

wire signed [15:0] sign_ext_s_imm;
wire [15:0] shifted_imm;

reg [15:0] alu_in1, alu_in2;
wire [15:0] alu_out;
wire eq;

reg [15:0] pc = 16'hFFFF;
wire [15:0] pc_inc, pc_inc_offset;

control control (
    .opcode(opcode),
    .eq(eq),
    .func_alu(func_alu),
    .mux_alu1(mux_alu1),
    .mux_alu2(mux_alu2),
    .mux_pc(mux_pc),
    .mux_rf(mux_rf),
    .mux_tgt(mux_tgt),
    .we_rf(we_rf),
    .we_dmem(we_dmem)
);

op_decode op_decode (
    .instr(instr),
    .opcode(opcode),
    .reg_a(reg_a),
    .reg_b(reg_b),
    .reg_c(reg_c),
    .s_imm(s_imm),
    .imm(imm)
);

registers registers (
    .clk(clk_execute),
    .we_rf(we_rf),
    .tgt(tgt),
    .src1(src1),
    .src2(src2),
    .tgt_val(tgt_val),
    .src1_val(src1_val),
    .src2_val(src2_val)
);

alu alu (
    .func_alu(func_alu),
    .in1(alu_in1),
    .in2(alu_in2),
    .out(alu_out),
    .eq(eq)
);

always @(*) begin
    case(mux_tgt)
        2'b00: tgt_val = alu_out;
        2'b01: tgt_val = data_out;
        2'b10: tgt_val = pc_inc;
        default: tgt_val = alu_out;
    endcase
end

assign tgt = reg_a;
assign src1 = reg_b;
always @(*) begin
    case(mux_rf)
        1'b0: src2 = reg_a;
        1'b1: src2 = reg_c;
    endcase
end

assign sign_ext_s_imm[6:0] = s_imm;
assign sign_ext_s_imm[15:7] = {9{s_imm[6]}};
assign shifted_imm[15:6] = imm;
assign shifted_imm[5:0] = 6'b000000;

always @(*) begin
    case(mux_alu1)
        1'b0: alu_in1 = src1_val;
        1'b1: alu_in1 = shifted_imm;
    endcase
end
always @(*) begin
    case(mux_alu2)
        1'b0: alu_in2 = src2_val;
        1'b1: alu_in2 = sign_ext_s_imm;
    endcase
end

assign pc_inc = pc + 16'b1;
assign pc_inc_offset = pc_inc + sign_ext_s_imm;
always @(negedge clk_execute) begin
    if (~reset) begin
        case(mux_pc)
            2'b00: pc = alu_out;
            2'b01: pc = pc_inc;
            2'b10: pc = pc_inc_offset;
            default: pc = pc_inc;
        endcase
    end
    else pc = 16'b0;
end

assign data_in = src2_val;
assign data_addr = alu_out;

assign halt = _halt;
always @(*) begin
    _halt = (instr == 16'b110_000_000_1111111);
end

assign instr_addr = pc;

endmodule
