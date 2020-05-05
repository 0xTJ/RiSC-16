`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 100 ns / 10 ns

module alu_tb();

//-- Simulation time: 1us (10 * 100ns)
parameter DURATION = 100;

//-- Clock signal
reg clk = 0;
always #0.5 clk = ~clk;

//-- Signals
reg [1:0] func_alu;
reg [15:0] in1, in2;
wire [15:0] out;

//-- Instantiate the unit to test
alu UUT (
    .func_alu(func_alu),
    .in1(in1),
    .in2(in2),
    .out(out)
);

initial begin
    //-- File were to store the simulation results
    $dumpfile(`DUMPSTR(`VCD_OUTPUT));
    $dumpvars(0, alu_tb);

    in1 = 16'b10101001_01111010;
    in2 = 16'b00111001_10101000;
    func_alu = 0; #1
    func_alu = 1; #1
    func_alu = 2; #1
    func_alu = 3; #1
    in1 = 16'b10110110_00000111;
    in2 = 16'b00011001_11010010;
    func_alu = 0; #1
    func_alu = 1; #1
    func_alu = 2; #1
    func_alu = 3; #1

    #(DURATION) $display("End of simulation");
    $finish;
end

endmodule
