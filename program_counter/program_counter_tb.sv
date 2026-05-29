`timescale 1ns/1ps                                      // Define time units
`include "program_counter/program_counter.sv"           // Include pc module

module program_counter_tb;

logic [31:0] pc, pcnext;
logic clk, reset;                                       // Variable declaration
program_counter dut (pc, pcnext, clk, reset);           // Instantiate the module under test

initial begin
    $dumpfile("program_counter/program_counter_tb.vcd");// Dump variable changes in the vcd file
    $dumpvars(0, program_counter_tb);                   // Specifies which variables to dump in the vcd file
    // Initialise signals
    reset = 1;
    pcnext = 32'h00000000;
    #10; reset = 0;
    #5; pcnext = 32'h00000004;
    #10; pcnext = 32'h00000006;
    #10; pcnext = 32'h0000000C;
    #10; pcnext = 32'h00000010;
    #10; reset = 1; pcnext = 32'h00000018;              // Test reset again 
    #10; reset = 0; pcnext = 32'h0000001E;
    #20;

    $finish;
end

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin                       
    $monitor("t = %3d, pc = %h, pcnext = %h, clk = %b, reset = %b \n", $time, pc, pcnext, clk, reset);
end                                 // Print variable values on screen
endmodule