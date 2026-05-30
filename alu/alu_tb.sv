`timescale 1ns/1ps
`include "alu/alu.sv"

module alu_tb;

logic signed [31:0] aluresult, a, b;
logic [4:0] alucontrol;
logic zero, negative;
alu dut (aluresult, zero, negative, a, b, alucontrol);

initial begin
    $dumpfile("alu/alu_tb.vcd");
    $dumpvars(0, alu_tb);
    a = 32'd100; b = 32'd520;
    alucontrol = 5'b10010; #10;             // add
    alucontrol = 5'b10110; #10;             // add (X bits varied)
    alucontrol = 5'b01010; #10;             // subtract, negative (true)
    a = 32'd600; #10;                       // subtract, negative (false)
    a = 32'd520; #10;                       // subtract, zero (true)
    a = 32'd700; #10;                       // subtract, negative (false)
    alucontrol = 5'b10111; #10;             // bitwise OR
    alucontrol = 5'b01111; #10;             // bitwise OR (X bits varied)
    alucontrol = 5'b01011; #10;             // bitwise AND
    b = 32'd3; alucontrol = 5'b01000; #10;  // shift left logical
    alucontrol = 5'b10100; #10;             // shift right logical
    alucontrol = 5'b01101; #10;             // set less than (false)
    b = 32'd1000; #10;                      // set less than (true)

    $finish;
end

initial begin
    $monitor("t = %3d, aluresult = %b (%4d), zero = %b, negative = %b, \
    a = %b (%3d), b = %b (%4d), alucontrol = %b \n",
    $time, aluresult, aluresult, zero, negative, a, a, b, b, alucontrol);
end

endmodule