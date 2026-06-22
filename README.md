Verilog Practice

A collection of small Verilog/SystemVerilog projects focused on learning RTL design fundamentals, simulation, testbench development, and waveform-based debugging.

The goal of this repository is to build fluency with:

* Combinational logic
* Sequential logic
* Counters
* Finite state machines
* Module instantiation
* Self-checking testbenches
* GTKWave waveform inspection
* Clean RTL project organization

Tools Used

* SystemVerilog / Verilog
* Icarus Verilog
* GTKWave
* VS Code
* Git / GitHub

Repository Structure

Verilog Practice/
├── project 1/
├── project 2/
├── project 3/
├── project 4/
├── project 5/
├── project 6/
└── .gitignore

⸻

Project 1: Basic Verilog Practice

Introductory Verilog practice covering module syntax, ports, simple combinational logic, and basic testbench structure.

Key concepts:

* module / endmodule
* input, output
* wire and reg
* Continuous assignment using assign
* Basic simulation flow using Icarus Verilog and GTKWave

⸻

Project 2: LED Counter

A parameterized LED counter that increments an LED output using an internal counter.

Key concepts:

* Parameterized modules
* Vector signals
* Sequential logic
* Clocked always blocks
* Reset behavior
* Nonblocking assignments
* Testbench clock generation

Main behavior:

reset = 1  -> counter and LEDs clear
enable = 1 -> counter runs
tick       -> LED output increments

⸻

Project 3: LED Up/Down Counter

An extension of the LED counter that supports both incrementing and decrementing the LED output based on a direction input.

Key concepts:

* Direction-controlled logic
* Internal tick generation
* Enable-controlled sequential behavior
* Holding state when disabled
* Testbench-driven input changes

Main behavior:

direction = 0 -> count up
direction = 1 -> count down
enable = 0    -> hold output / pause behavior

⸻

Project 4: Parking Gate FSM

A finite state machine modeling a simple parking garage gate controller.

States:

IDLE
CHECK_TICKET
OPEN_GATE
WAIT_FOR_CAR
CLOSE_GATE

Inputs:

car_detected
ticket_valid
car_passed

Outputs:

gate_open
gate_closed

Key concepts:

* FSM state encoding with localparam
* Current state and next state registers
* Two-block FSM structure
* Combinational next-state logic
* Output logic based on state
* Waveform debugging of state transitions

Expected state flow:

IDLE -> CHECK_TICKET -> OPEN_GATE -> WAIT_FOR_CAR -> CLOSE_GATE -> IDLE

⸻

Project 5: Vending Machine FSM

A Moore-style finite state machine modeling a vending machine that sells one item for 25 cents.

Accepted coins:

nickel  = 5 cents
dime    = 10 cents
quarter = 25 cents

States:

S0
S5
S10
S15
S20
DISPENSE
DISPENSE_CHANGE

Outputs:

dispense
return_change

Key concepts:

* Moore FSM design
* Three-block FSM structure
* State-based output logic
* Handling exact payment and overpayment
* Self-checking testbench ideas
* Coin input pulse modeling

Example behavior:

quarter              -> dispense
nickel + quarter     -> dispense + return_change
dime + dime + nickel -> dispense
dime + quarter       -> dispense + return_change

⸻

Project 6: BCD Counter + Seven-Segment Decoder

A modular design that combines a BCD counter with a seven-segment display decoder.

Directory structure:

project 6/
├── bcd_counter/
│   ├── bcd_counter.sv
│   └── bcd_counter_tb.sv
├── seven_seg_decoder/
│   ├── seven_seg_decoder.sv
│   └── seven_seg_decoder_tb.sv
└── bcd_7seg_top/
    ├── bcd_7seg_top.sv
    └── bcd_7seg_top_tb.sv

BCD Counter

Counts from decimal 0 to 9 and wraps back to 0.

Behavior:

reset = 1  -> count = 0
enable = 0 -> count holds
enable = 1 -> count increments
count = 9  -> next count = 0

Key concepts:

* BCD representation
* Mod-10 counting
* Sequential logic
* Self-checking testbench
* Expected-value tracking

Seven-Segment Decoder

Maps a 4-bit BCD digit to a 7-bit active-high seven-segment pattern.

Assumed segment convention:

seg[6:0] = a b c d e f g
1 = segment ON
0 = segment OFF

Example mappings:

0 -> 1111110
1 -> 0110000
2 -> 1101101

Key concepts:

* Combinational logic
* always_comb
* case statements
* Default case for invalid BCD values
* Self-checking testbench using tasks

Integrated Top Module

Connects the BCD counter to the seven-segment decoder.

Data path:

bcd_counter -> count[3:0] -> seven_seg_decoder -> seg[6:0]

Key concepts:

* Module instantiation
* Internal signals
* Top-level integration
* Integrated testbench
* Verifying connected modules together

⸻

Running Simulations

Use Icarus Verilog with SystemVerilog support:

iverilog -g2012 -o <output_name> <source_files>
vvp <output_name>

Example for Project 6 integrated test:

cd "project 6"
mkdir -p build
iverilog -g2012 -o build/bcd_7seg_top_tb \
  bcd_counter/bcd_counter.sv \
  seven_seg_decoder/seven_seg_decoder.sv \
  bcd_7seg_top/bcd_7seg_top.sv \
  bcd_7seg_top/bcd_7seg_top_tb.sv
vvp build/bcd_7seg_top_tb

Open the waveform if needed:

gtkwave bcd_7seg_top_tb.vcd

⸻

Git Ignore Policy

Generated simulation artifacts should not be committed.

Ignored files include:

*.vcd
*.out
*.vvp
*_tb
build/
.DS_Store

Source files and testbenches should be committed:

*.v
*.sv
*.svh
README.md
.gitignore

⸻

Learning Goals

This repository is intended to build practical RTL design habits:

* Write small, focused modules
* Write a testbench for every module
* Use self-checking tests when possible
* Inspect waveforms in GTKWave
* Keep generated files out of Git
* Organize projects clearly
* Prefer one clock and enable signals over generated clocks
* Build toward larger FPGA-style systems gradually

# Verilog Practice

A collection of small Verilog/SystemVerilog projects focused on RTL fundamentals, simulation, waveform debugging, and self-checking testbenches.

This repository tracks my progression through core digital design concepts, including combinational logic, sequential logic, counters, finite state machines, module integration, and verification with Icarus Verilog and GTKWave.

## Tools

- Verilog / SystemVerilog
- Icarus Verilog
- GTKWave
- VS Code
- Git / GitHub

## Projects

| Project | Description | Key Concepts |
|---|---|---|
| Project 1 | Basic Verilog practice | Modules, ports, `assign`, simple testbenches |
| Project 2 | LED counter | Sequential logic, counters, reset, enable |
| Project 3 | LED up/down counter | Direction control, tick logic, holding state |
| Project 4 | Parking gate FSM | FSM design, state transitions, output logic |
| Project 5 | Vending machine FSM | Moore FSM, coin input modeling, change return |
| Project 6 | BCD counter + seven-segment decoder | BCD counting, decoder logic, module integration, self-checking tests |

## Project 6: BCD Counter + Seven-Segment Decoder

This is the most complete project so far. It connects a BCD counter to a seven-segment decoder and verifies the full integrated design.

```text
project 6/
├── bcd_counter/
│   ├── bcd_counter.sv
│   └── bcd_counter_tb.sv
├── seven_seg_decoder/
│   ├── seven_seg_decoder.sv
│   └── seven_seg_decoder_tb.sv
└── bcd_7seg_top/
    ├── bcd_7seg_top.sv
    └── bcd_7seg_top_tb.sv
```

### BCD Counter

Counts from decimal `0` to `9`, then wraps back to `0`.

```text
reset = 1  -> count = 0
enable = 0 -> count holds
enable = 1 -> count increments
count = 9  -> next count = 0
```

### Seven-Segment Decoder

Maps a 4-bit BCD digit to a 7-bit active-high seven-segment pattern.

Assumed segment convention:

```text
seg[6:0] = a b c d e f g
1 = segment ON
0 = segment OFF
```

Example mappings:

```text
0 -> 1111110
1 -> 0110000
2 -> 1101101
```

### Integrated Top Module

The top module connects the BCD counter output to the seven-segment decoder input.

```text
bcd_counter -> count[3:0] -> seven_seg_decoder -> seg[6:0]
```

The integrated testbench verifies that the segment output follows the expected digit sequence as the BCD counter increments.

## Running Simulations

Use Icarus Verilog with SystemVerilog support:

```bash
iverilog -g2012 -o <output_name> <source_files>
vvp <output_name>
```

Example: run the Project 6 integrated test.

```bash
cd "project 6"
mkdir -p build

iverilog -g2012 -o build/bcd_7seg_top_tb \
  bcd_counter/bcd_counter.sv \
  seven_seg_decoder/seven_seg_decoder.sv \
  bcd_7seg_top/bcd_7seg_top.sv \
  bcd_7seg_top/bcd_7seg_top_tb.sv

vvp build/bcd_7seg_top_tb
```

Open the waveform:

```bash
gtkwave bcd_7seg_top_tb.vcd
```

## Verification Approach

Each completed module has its own testbench. Later projects use self-checking testbenches that compare actual outputs against expected values and print pass/fail results.

Current verification practices include:

- Clock generation in testbenches
- Reset and enable testing
- Expected-value tracking
- Invalid-input checking
- Waveform inspection with GTKWave
- Integrated top-level testing

## Git Ignore Policy

Generated simulation files are not meant to be committed.

Ignored files include:

```text
*.vcd
*.out
*.vvp
*_tb
build/
.DS_Store
```

## Future Projects

Planned next steps:

- Tick / enable generator
- Shift register
- UART transmitter
- Multi-digit BCD counter
- Simple ALU
- VGA timing generator
- FIFO
- Valid/ready handshake modules