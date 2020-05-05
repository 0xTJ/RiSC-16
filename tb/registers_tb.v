`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 100 ns / 10 ns

module registers_tb();

//-- Simulation time: 1us (10 * 100ns)
parameter DURATION = 100;

//-- Clock signal
reg clk = 0;
always #0.5 clk = ~clk;

//-- Signals
reg we_rf;
reg [2:0] tgt, src1, src2;
reg [15:0] tgt_val;
wire [15:0] src1_val, src2_val;

//-- Instantiate the unit to test
registers UUT (
    .clk(clk),
    .we_rf(we_rf),
    .tgt(tgt),
    .src1(src1),
    .src2(src2),
    .tgt_val(tgt_val),
    .src1_val(src1_val),
    .src2_val(src2_val)
);

initial begin
    //-- File were to store the simulation results
    $dumpfile(`DUMPSTR(`VCD_OUTPUT));
    $dumpvars(0, registers_tb);

    we_rf = 0;
    tgt = 0; src1 = 0; src2 = 0;
    tgt_val = 0; #1;
    tgt = 3; tgt_val = 5; src1 = 3; #2;
    we_rf = 1; #1;
    we_rf = 0; #2;
    tgt = 4; tgt_val = 53; src1 = 4; #2;
    we_rf = 1; #1;
    tgt = 3; tgt_val = 5; src1 = 3; #2;

    #(DURATION) $display("End of simulation");
    $finish;
end

endmodule
