`timescale 1ns/1ps
`include "control_unit/control_unit.sv"

module control_unit_tb;

logic memwrite, alusrc, regwrite, zero, negative;
logic [4:0] alucontrol;
logic [2:0] immsrc;
logic [1:0] pcsrc, resultsrc;
logic [31:0] instr;

control_unit dut (memwrite, alusrc, regwrite, alucontrol, immsrc, pcsrc,
    resultsrc, instr, zero, negative);


initial begin
    $dumpfile("control_unit/control_unit_tb.vcd");
    $dumpvars(0, control_unit_tb);

    zero = 1'bx; negative = 1'bx;
    instr = 32'b0000000xxxxxxxxxx000xxxxx0110011; #10;  // add
    instr = 32'b0100000xxxxxxxxxx000xxxxx0110011; #10;  // sub
    instr = 32'b0000000xxxxxxxxxx110xxxxx0110011; #10;  // or
    instr = 32'b0000000xxxxxxxxxx111xxxxx0110011; #10;  // and
    instr = 32'b0000000xxxxxxxxxx001xxxxx0110011; #10;  // sll
    instr = 32'b0000000xxxxxxxxxx101xxxxx0110011; #10;  // srl
    instr = 32'b0000000xxxxxxxxxx010xxxxx0110011; #10;  // slt

    instr = 32'bxxxxxxxxxxxxxxxxx000xxxxx0010011; #10;  // addi
    instr = 32'bxxxxxxxxxxxxxxxxx110xxxxx0010011; #10;  // ori
    instr = 32'bxxxxxxxxxxxxxxxxx111xxxxx0010011; #10;  // andi
    instr = 32'bxxxxxxxxxxxxxxxxx001xxxxx0010011; #10;  // slli
    instr = 32'bxxxxxxxxxxxxxxxxx101xxxxx0010011; #10;  // srli
    instr = 32'bxxxxxxxxxxxxxxxxx010xxxxx0010011; #10;  // slti

    instr = 32'bxxxxxxxxxxxxxxxxx010xxxxx0000011; #10;  // lw
    instr = 32'bxxxxxxxxxxxxxxxxx010xxxxx0100011; #10;  // sw
    
    instr = 32'bxxxxxxxxxxxxxxxxx000xxxxx1100011;       // beq, zero = 0 
    zero = 1'b0; #10;
    instr = 32'bxxxxxxxxxxxxxxxxx000xxxxx1100011;       // beq, zero = 1
    zero = 1'b1; #10;
    
    instr = 32'bxxxxxxxxxxxxxxxxx001xxxxx1100011;       // bne, zero = 0
    zero = 1'b0; #10;
    instr = 32'bxxxxxxxxxxxxxxxxx001xxxxx1100011;       // bne, zero = 1
    zero = 1'b1; #10;

    instr = 32'bxxxxxxxxxxxxxxxxx100xxxxx1100011;       // blt, negative = 0
    negative = 1'b0; #10;
    instr = 32'bxxxxxxxxxxxxxxxxx100xxxxx1100011;       // blt, negative = 1
    negative = 1'b1; #10;

    instr = 32'bxxxxxxxxxxxxxxxxx101xxxxx1100011;       // bge, negative = 0
    negative = 1'b0; #10;
    instr = 32'bxxxxxxxxxxxxxxxxx101xxxxx1100011;       // bge, negative = 1
    negative = 1'b1; #10;

    instr = 32'b0000000xxxxxxxxxx000xxxxx1101111; #10;  // jal
    instr = 32'b0100000xxxxxxxxxx000xxxxx1100111; #10;  // jalr
    instr = 32'b0000000xxxxxxxxxx110xxxxx0110111; #10;  // lui

    $finish;
end

initial begin
    $monitor("t = %3d, instr = %b, zero = %b, negative = %b, regwrite = %b, \
    immsrc = %b, alusrc = %b, alucontrol = %b, memwrite = %b, resultsrc = %b \
    pcsrc = %b, \n",
    $time, instr, zero, negative, regwrite, immsrc, alusrc, alucontrol, memwrite, 
        resultsrc, pcsrc);
end

endmodule