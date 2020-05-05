module alu(
    input wire [1:0] func_alu,
    input wire [15:0] in1,
    input wire [15:0] in2,
    output wire [15:0] out,
    output wire eq
);

wire [15:0] added;
wire [15:0] nanded;
reg [15:0] _out;
reg _eq;

always @(*) begin
    case(func_alu)
        2'b00: begin
                _out = added;
                _eq = 1'b0;
            end
        2'b01: begin
                _out = nanded;
                _eq = 1'b0;
            end
        2'b10: begin
                _out = in1;
                _eq = 1'b0;
            end
        2'b11: begin
                _out = in1;
                _eq = (in1 == in2);
            end
    endcase
end

assign added = in1 + in2;
assign nanded = ~(in1 & in2);
assign out = _out;
assign eq = _eq;

endmodule
