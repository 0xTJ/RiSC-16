`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 100 ns / 10 ns

module cpu_tb();

//-- Simulation time
parameter DURATION = 100000;

//-- Clock signal
reg clk = 0;
always #0.5 clk = ~clk;

// Signals
reg reset = 1;
reg [15:0] instr = 0;
wire [15:0] instr_addr;
wire we_dmem;
wire [15:0] data_addr;
wire [15:0] data_in;
reg [15:0] data_out = 0;

//-- Instantiate the unit to test
cpu UUT (
    .clk(clk),
    .reset(reset),
    .instr(instr),
    .instr_addr(instr_addr),
    .we_dmem(we_dmem),
    .data_addr(data_addr),
    .data_in(data_in),
    .data_out(data_out)
);

// reg [15:0] data_mem [511:0];
// reg [15:0] instr_mem [2000:0];
reg [15:0] mem [2000:0];

always @(*) begin
    instr = mem[instr_addr];
    if (!we_dmem) begin
        // data_out = data_mem[data_addr];
        data_out = mem[data_addr];
    end
end

always @(posedge clk) begin
    if (we_dmem) begin
        // data_mem[data_addr] = data_in;
        mem[data_addr] = data_in;
    end
end

initial begin
    //-- File were to store the simulation results
    $dumpfile(`DUMPSTR(`VCD_OUTPUT));
    $dumpvars(0, cpu_tb);

    $readmemh("rom.txt", mem);

    #1 reset = 0;

    #(DURATION-1);
    $writememh("./ram.txt", mem);
    $display("End of simulation");
    $finish;
end

endmodule
