`include "program_counter/program_counter.sv"
`include "instruction_memory/instruction_memory.sv"
`include "control_unit/control_unit.sv"
`include "reg_file/reg_file.sv"
`include "extend/extend.sv"
`include "alu/alu.sv"
`include "data_memory_and_io/data_memory_and_io.sv"

module risc_v (output logic [31:0] CPUOut,
                input logic [31:0] CPUIn,
                input logic CLK, Reset);

logic [31:0] PC, PCNext, Instr, RD1, RD2, WD3, WE3, ImmExt, SrcA, SrcB, ALUResult, RD, Result, PCTarget, PCPlus4;
logic MemWrite, ALUSrc, RegWrite, Zero, Negative;
logic [4:0] ALUControl;
logic [2:0] ImmSrc;
logic [1:0] PCSrc, ResultSrc;

assign A1 = Instr[19:15];
assign A2 = Instr[24:20];
assign A3 = Instr[11:7];
assign WE3 = RegWrite;
assign SrcA = RD1;
assign SrcB = (ALUSrc) ? ImmExt : RD2;
assign PCPlus4 = PC + 32'd4;
assign PCTarget = PC + ImmExt;

always_comb begin
        case (PCSrc)
            2'b00: PCNext = PCPlus4;
            2'b01: PCNext = PCTarget;
            2'b10: PCNext = ALUResult;
            default: PCNext = 32'bx;
        endcase
    end

always_comb begin
        case (ResultSrc)
            2'b00: Result = ALUResult;
            2'b01: Result = RD;
            2'b10: Result = PCPlus4;
            2'b11: Result = Immext;
            default: PCNext = 32'bx;
        endcase
    end

program_counter prog_count (PC, PCNext, CLK, Reset);

instruction_memory instr_mem (Instr, PC);

control_unit cu (MemWrite, ALUSrc, RegWrite, ALUControl, ImmSrc, PCSrc,
    ResultSrc, Instr, Zero, Negative);

reg_file register (RD1, RD2, WD3, A1, A2, A3, WE3, CLK);

extend ext (ImmExt, ImmSrc, Instr);

alu arith_logic (ALUResult, Zero, Negative, SrcA, SrcB, ALUControl);

data_memory_and_io data_mem (RD, CPUOut, ALUResult, RD2, CPUIn, MemWrite, CLK)

endmodule