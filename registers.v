module registers(
    input wire clk, // latch at negedge
    input wire we_rf,
    input wire [2:0] tgt,
    input wire [2:0] src1,
    input wire [2:0] src2,
    input wire [15:0] tgt_val,
    output wire [15:0] src1_val,
    output wire [15:0] src2_val
);

reg [15:0] regs [7:0];
reg [15:0] _src1_val;
reg [15:0] _src2_val;

always @(negedge clk) begin
    if (we_rf) begin
        case(tgt)
            3'b0: ;
            default: regs[tgt] = tgt_val;
        endcase
    end
end

always @(*) begin
    case(src1)
        3'b0: _src1_val = 16'b0;
        default: _src1_val = regs[src1];
    endcase
    case(src2)
        3'b0: _src2_val = 16'b0;
        default: _src2_val = regs[src2];
    endcase
end

assign src1_val = _src1_val;
assign src2_val = _src2_val;

endmodule
