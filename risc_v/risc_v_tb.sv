`timescale 1ns/1ps
`include "risc_v/risc_v.sv"

module risc_v_tb;

logic [31:0] cpuout, cpuin;
logic clk, reset;
risc_v dut (cpuout, cpuin, clk, reset);


initial begin
    $dumpfile("risc_v/risc_v_tb.vcd");
    $dumpvars(0, risc_v_tb);
    reset = 1'b1; cpuin = 32'd20; #10;
    reset = 1'b0; #60;
    reset = 1'b1; cpuin = 32'd15; #10;
    reset = 1'b0; #60;

    $finish;
end

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    $monitor("t = %3d, cpuout = %d, cpuin = %d, clk = %b, reset = %b \n",
    $time, cpuout, cpuin, clk, reset);
end

endmodule