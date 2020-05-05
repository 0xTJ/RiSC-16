`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 100 ns / 10 ns

module control_tb();

//-- Simulation time: 1us (10 * 100ns)
parameter DURATION = 100;

//-- Clock signal
reg clk = 0;
always #0.5 clk = ~clk;

//-- Signals
reg [2:0] opcode;
reg eq;
wire [1:0] func_alu;
wire mux_alu1, mux_alu2, mux_rf;
wire [1:0] mux_pc, mux_tgt;
wire we_rf, we_dmem;

//-- Instantiate the unit to test
control UUT (
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

initial begin
    //-- File were to store the simulation results
    $dumpfile(`DUMPSTR(`VCD_OUTPUT));
    $dumpvars(0, control_tb);

    #(DURATION) $display("End of simulation");
    $finish;
end

endmodule
