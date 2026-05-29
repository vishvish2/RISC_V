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

