module control(
    input wire [2:0] opcode,
    input wire eq,
    output wire [1:0] func_alu,
    output wire mux_alu1, mux_alu2, mux_rf,
    output wire [1:0] mux_pc, mux_tgt,
    output wire we_rf, we_dmem
);

reg [1:0] _func_alu;
reg _mux_alu1, _mux_alu2, _mux_rf;
reg [1:0] _mux_pc, _mux_tgt;
reg _we_rf, _we_dmem;

always @(*) begin
    case (opcode)
        3'b000: _func_alu = 2'b00;
        3'b001: _func_alu = 2'b00;
        3'b010: _func_alu = 2'b01;
        3'b011: _func_alu = 2'b10;
        3'b100: _func_alu = 2'b00;
        3'b101: _func_alu = 2'b00;
        3'b110: _func_alu = 2'b11;
        3'b111: _func_alu = 2'b10;
    endcase
end

always @(*) begin
    case (opcode)
        3'b000: _mux_alu1 = 1'b0;
        3'b001: _mux_alu1 = 1'b0;
        3'b010: _mux_alu1 = 1'b0;
        3'b011: _mux_alu1 = 1'b1;
        3'b100: _mux_alu1 = 1'b0;
        3'b101: _mux_alu1 = 1'b0;
        3'b110: _mux_alu1 = 1'b0;
        3'b111: _mux_alu1 = 1'b0;
    endcase
end

always @(*) begin
    case (opcode)
        3'b000: _mux_alu2 = 1'b0;
        3'b001: _mux_alu2 = 1'b1;
        3'b010: _mux_alu2 = 1'b0;
        3'b011: _mux_alu2 = 1'b0;
        3'b100: _mux_alu2 = 1'b1;
        3'b101: _mux_alu2 = 1'b1;
        3'b110: _mux_alu2 = 1'b0;
        3'b111: _mux_alu2 = 1'b0;
    endcase
end

always @(*) begin
    case (opcode)
        3'b000: _mux_pc = 2'b01;
        3'b001: _mux_pc = 2'b01;
        3'b010: _mux_pc = 2'b01;
        3'b011: _mux_pc = 2'b01;
        3'b100: _mux_pc = 2'b01;
        3'b101: _mux_pc = 2'b01;
        3'b110: if (eq) begin
                    _mux_pc = 2'b10;
                end else begin
                    _mux_pc = 2'b01;
                end
        3'b111: _mux_pc = 2'b00;
    endcase
end

always @(*) begin
    case (opcode)
        3'b000: _mux_rf = 1'b1;
        3'b001: _mux_rf = 1'b0;
        3'b010: _mux_rf = 1'b1;
        3'b011: _mux_rf = 1'b0;
        3'b100: _mux_rf = 1'b0;
        3'b101: _mux_rf = 1'b0;
        3'b110: _mux_rf = 1'b0;
        3'b111: _mux_rf = 1'b0;
    endcase
end

always @(*) begin
    case (opcode)
        3'b000: _mux_tgt = 2'b00;
        3'b001: _mux_tgt = 2'b00;
        3'b010: _mux_tgt = 2'b00;
        3'b011: _mux_tgt = 2'b00;
        3'b100: _mux_tgt = 2'b00;
        3'b101: _mux_tgt = 2'b01;
        3'b110: _mux_tgt = 2'b00;
        3'b111: _mux_tgt = 2'b10;
    endcase
end

always @(*) begin
    case (opcode)
        3'b000: _we_rf = 1'b1;
        3'b001: _we_rf = 1'b1;
        3'b010: _we_rf = 1'b1;
        3'b011: _we_rf = 1'b1;
        3'b100: _we_rf = 1'b0;
        3'b101: _we_rf = 1'b1;
        3'b110: _we_rf = 1'b0;
        3'b111: _we_rf = 1'b1;
    endcase
end

always @(*) begin
    case (opcode)
        3'b000: _we_dmem = 1'b0;
        3'b001: _we_dmem = 1'b0;
        3'b010: _we_dmem = 1'b0;
        3'b011: _we_dmem = 1'b0;
        3'b100: _we_dmem = 1'b1;
        3'b101: _we_dmem = 1'b0;
        3'b110: _we_dmem = 1'b0;
        3'b111: _we_dmem = 1'b0;
    endcase
end

assign func_alu = _func_alu;
assign mux_alu1 = _mux_alu1;
assign mux_alu2 = _mux_alu2;
assign mux_rf = _mux_rf;
assign mux_pc = _mux_pc;
assign mux_tgt = _mux_tgt;
assign we_rf = _we_rf;
assign we_dmem = _we_dmem;

endmodule
