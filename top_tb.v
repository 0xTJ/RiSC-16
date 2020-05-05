`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 100 ns / 10 ns

module top_tb();

//-- Simulation time
parameter DURATION = 1000;

//-- Clock signal
reg clk = 0;
always #0.5 clk = ~clk;

// Signals
wire led_red, led_green, led_blue;

//-- Instantiate the unit to test
top UUT (
    .clk_raw(clk),
    .led_red(led_red),
    .led_green(led_green),
    .led_blue(led_blue)
);

initial begin
    //-- File were to store the simulation results
    $dumpfile(`DUMPSTR(`VCD_OUTPUT));
    $dumpvars(0, top_tb);

    #(DURATION-1);

    $display("End of simulation");
    $finish;
end

endmodule
