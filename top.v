module top(
    // input wire clk_raw,
    // input wire reset,
    output wire led_red,
    output wire led_green,
    output wire led_blue
);

wire clk_raw;
reg [15:0] counter = 0;
reg clk = 1'b0;
reg clk_state = 1'b0;
wire clk_fetch;
wire clk_execute;

reg reset = 0;
reg [15:0] instr;
wire [15:0] instr_addr;
wire we_dmem;
wire [15:0] data_addr;
wire [15:0] data_in;
reg [15:0] data_out;
wire halt;

reg _led_red;
reg _led_green;
reg _led_blue;

SB_LFOSC OSCInst0 (
    .CLKLFEN(1'b1),
    .CLKLFPU(1'b1),
    .CLKLF(clk_raw)
) /* synthesis ROUTE_THROUGH_FABRIC= 0 */;
// defparam OSCInst0.CLKHF_DIV = 2'b00;

always @(negedge clk_raw) begin
    counter = counter + 1;
    clk = counter[0];
end

always @(negedge clk) begin
    clk_state = clk_state + 1'b1;
end

assign clk_fetch = (~clk_state) & clk;
assign clk_execute = clk_state & clk;

cpu cpu (
    .clk_fetch(clk_fetch),
    .clk_execute(clk_execute),
    .reset(reset),
    .instr(instr),
    .instr_addr(instr_addr),
    .we_dmem(we_dmem),
    .data_addr(data_addr),
    .data_in(data_in),
    .data_out(data_out),
    .halt(halt)
);

// reg [15:0] data_mem [400:0];
// reg [15:0] instr_mem [31:0];
reg [15:0] mem [512:0];

initial begin
    $readmemh("rom.txt", mem);
end

/* verilator lint_off WIDTH */
always @(posedge clk_fetch) begin
    instr = mem[instr_addr];
end

always @(negedge clk_execute) begin
    if (we_dmem) begin
        mem[data_addr] = data_in;
    end
end

always @(posedge clk_execute) begin
    data_out = mem[data_addr];
end
/* verilator lint_on WIDTH */

always @(*) begin
    _led_red = halt;
    _led_green = clk_fetch;
    _led_blue = clk_execute;
end

assign led_red = !_led_red;
assign led_green = !_led_green;
assign led_blue = !_led_blue;

endmodule
