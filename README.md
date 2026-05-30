# Command to compile testbench code
`iverilog -g 2012 -o <module name/testbench module name>.vvp <module name/testbench module name>.sv`

e.g.
`iverilog -g 2012 -o program_counter/program_counter_tb.vvp program_counter/program_counter_tb.sv`

This will create a .vvp file for the module

# Command for viewing output of testbench compilation
`vvp <module name/testbench module name>.vvp`

e.g.
`vvp program_counter/program_counter_tb.vvp`

This will create a .vcd file for the module

# Command for viewing waveforms of variables from testbench
`gtkwave <module name/testbench module name>.vcd`

e.g.
`gtkwave program_counter/program_counter_tb.vcd`

Select variables to view the waveforms of in the GTKWave GUI

# Machine Code to Assembly language
The machine code in `program.txt` translates to the following assembly
```nasm
addi x1, x0, 50     # Stores the value 50 in x1
lui x10, 0x80000    # Store 0x80000000 in x10
lw x2, -4(x10)      # 0x80000000 - 4 = 0x7FFFFFFC, CPUIn gets written to x2
sub x3, x1, x2      # x3 = x1 – x2 = 50 - CPUIn
sw x3, -4(x10)      # 0x80000000 - 4 = 0x7FFFFFFC, CPUOut = x3
beq x0, x0, 0       # end
```
It performs the operation `CPUOut = 50 - CPUIn` where `CPUOut` and `CPUIn` are an external output and input to and from the microarchitecture.

