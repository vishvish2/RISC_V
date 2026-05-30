`timescale 1ns/1ps
`include "extend/extend.sv"

module extend_tb;

logic [31:0] immext, instr;
logic [2:0] immsrc;
extend dut (immext, immsrc, instr);

initial begin
    $dumpfile("extend/extend_tb.vcd");
    $dumpvars(0, extend_tb);
    immsrc = 3'b000; instr = 32'hB4B5CAD7; #10  // I-Type
    immsrc = 3'b001; instr = 32'h6B95BCA9; #10  // S-Type
    immsrc = 3'b010; instr = 32'hCCD672B6; #10  // B-Type
    immsrc = 3'b011; instr = 32'h3D2DE34A; #10  // U-Type
    immsrc = 3'b100; instr = 32'hE3A6B935; #10  // J-Type
    
    $finish;
end

initial begin
    $monitor("t = %3d, immsrc = %b, instr = %b, immext = %b \n",
    $time, immsrc, instr, immext);
end

endmodule