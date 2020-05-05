`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 100 ns / 10 ns

module op_decode_tb();

//-- Simulation time: 1us (10 * 100ns)
parameter DURATION = 100;

//-- Clock signal
reg clk = 0;
always #0.5 clk = ~clk;

//-- Signals
reg [15:0] instr;
wire [2:0] opcode, reg_a, reg_b, reg_c;
wire signed [6:0] s_imm;
wire [9:0] imm;

//-- Instantiate the unit to test
op_decode UUT (
    .instr(instr),
    .opcode(opcode),
    .reg_a(reg_a),
    .reg_b(reg_b),
    .reg_c(reg_c),
    .s_imm(s_imm),
    .imm(imm)
);

initial begin
    //-- File were to store the simulation results
    $dumpfile(`DUMPSTR(`VCD_OUTPUT));
    $dumpvars(0, op_decode_tb);

    instr = 16'b0; #1
    instr = 16'b1011100111001101; #1

    #(DURATION) $display("End of simulation");
    $finish;
end

endmodule
