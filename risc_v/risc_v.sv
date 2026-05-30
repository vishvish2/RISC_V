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

endmodule