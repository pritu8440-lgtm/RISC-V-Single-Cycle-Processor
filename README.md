# RISC-V Single-Cycle Processor

### 32-bit RISC-V Processor | Verilog HDL | RTL Design | Functional Verification

A modular RTL implementation of a 32-bit RISC-V single-cycle processor
designed using Verilog HDL.

This project focuses on building a complete processor from fundamental
RTL hardware blocks and integrating them into a functional instruction
execution datapath. The design separates instruction-fetch logic,
datapath operations, and control logic to provide clear visibility into
instruction flow, data movement, and control-signal generation.

---

## Project Overview

The processor implements the fundamental instruction-execution flow:

**Instruction Fetch → Instruction Decode → Execute → Memory Access → Write Back**

The processor is designed as a single-cycle architecture, where an
instruction passes through the required combinational logic and its
corresponding architectural state is updated within one clock cycle.

The implementation is divided into modular RTL components rather than
using a single monolithic processor module.

Major hardware blocks include:

- Program Counter (PC)
- PC + 4 logic
- PC target generation
- Instruction Memory
- Instruction Decoder
- Main Decoder
- ALU Decoder
- Register Set
- Immediate Generator
- Source-A Multiplexer
- ALU Multiplexer
- Arithmetic Logic Unit (ALU)
- Data Memory
- Write-back Multiplexer

These modules are connected hierarchically to form the complete
single-cycle processor.

---

## Architecture

The processor is organized into three major functional paths:

1. Instruction Fetch Path
2. Datapath
3. Control Path

Together, these paths implement the complete instruction execution
cycle.

### 1. Instruction Fetch Path

The instruction fetch path determines which instruction is executed
next.

The path includes:

- Program Counter (PC)
- PC + 4 logic
- PC target generation
- PC selection logic
- Instruction Memory

During normal sequential execution, the program counter advances to the
next instruction address using the PC + 4 path.

For control-flow instructions, a target address is generated and the
next PC is selected according to the corresponding control signal.

The instruction memory uses the current PC/address value to provide the
instruction to the decoding and control logic.

### 2. Datapath

The datapath is responsible for moving and processing instruction
operands.

The main datapath components are:

- Register Set
- Immediate Generator
- Source-A Multiplexer
- ALU Multiplexer
- ALU
- Data Memory
- Write-back Multiplexer

The Register Set provides the source operands required by the current
instruction.

The Immediate Generator extracts and formats the immediate field from
the instruction according to the instruction type.

The Source-A and ALU multiplexing logic selects the appropriate operand
sources before the ALU operation.

The ALU performs the selected arithmetic or logical operation.

For memory instructions, the ALU result is also used as the effective
address for Data Memory.

For load operations, the value returned from Data Memory is routed
through the write-back selection logic before being written into the
destination register.

### 3. Control Path

The control path interprets the current instruction and generates the
control signals required by the datapath.

The control logic contains:

- Instruction Decoder
- Main Decoder
- ALU Decoder

The control path determines signals such as:

- Register write enable
- Memory write enable
- ALU source selection
- ALU operation
- Write-back source selection
- Branch control
- Jump control
- Immediate format selection

The separation of control logic from the datapath makes the processor
easier to analyze, debug, verify, and extend.

---

## RTL Design Philosophy

The processor follows a modular and hierarchical RTL design approach.

Instead of implementing the complete CPU as one large block, the design
is decomposed into smaller hardware modules with well-defined
interfaces.

Each module is responsible for a specific hardware function.

This approach provides several advantages:

- Clear separation of functionality
- Easier module-level verification
- Simplified debugging
- Better signal visibility during simulation
- Easier integration and maintenance
- Straightforward extension of processor functionality

The design emphasizes explicit hardware connectivity and observable
control/data paths at the RTL level.

---

## Processor Data Flow

The overall data flow can be summarized as:

**PC → Instruction Memory → Instruction Decode / Control → Register Set /
Immediate Generator → Operand Selection → ALU → Data Memory / Write Back
→ Register Set**

In parallel, the PC logic generates the next instruction address using
the sequential PC + 4 path or a control-flow target.

The control path configures the datapath according to the instruction
being executed.

---

## Instruction Execution

The processor follows a single-cycle execution model.

### Instruction Fetch

The Program Counter provides the address of the current instruction.

The Instruction Memory returns the corresponding 32-bit instruction.

### Instruction Decode

The instruction fields are decoded to determine:

- Source registers
- Destination register
- Immediate information
- Instruction type
- Required control signals

### Execute

The required operands are selected and supplied to the ALU.

The ALU performs the operation specified by the decoded control signals.

### Memory Access

For memory instructions, the ALU generates the effective memory address.

Data Memory performs the required read or write operation.

### Write Back

The Write-back Multiplexer selects the appropriate result source.

The selected value is written to the destination register when register
write is enabled.

---

## RTL Module Organization

The processor uses a hierarchical module organization.

The top-level testbench instantiates the processor and exposes internal
signals for functional verification.

The major RTL hierarchy includes functional blocks corresponding to:

- Datapath
- Instruction Fetch
- Main Control
- PC / Immediate Generation
- ALU
- Register Set
- Instruction Memory
- Data Memory
- Multiplexing logic
- Instruction and ALU decoding

This organization keeps individual hardware functions isolated while
allowing them to operate together as a complete processor.

---

## Design Approach

The processor was developed using a bottom-up RTL design methodology.

Individual hardware blocks were implemented first and then integrated
into the complete processor.

The development flow follows:

**Hardware Module → Module Verification → Integration → Processor
Verification**

During simulation, internal signals are observed to verify the
interaction between individual modules.

Important signals analyzed during verification include:

- Program Counter
- Next PC
- PC + 4
- PC target
- Instruction
- Immediate
- Register addresses
- Register read data
- Register write data
- Register write enable
- ALU control
- ALU operands
- ALU result
- Zero flag
- Memory address
- Memory read data
- Memory write data
- Memory write enable
- Write-back selection

---

## Verification

The processor is functionally verified using a Verilog testbench.

Simulation is performed using **Icarus Verilog**, and generated waveform
data is inspected using **GTKWave**.

The verification process focuses on observing the processor behavior
across multiple clock cycles.

### Verification Areas

The simulation checks the behavior of:

- Instruction fetch
- Program-counter progression
- Instruction decoding
- Register read operations
- Register write operations
- Immediate generation
- ALU control generation
- ALU arithmetic and logical operations
- Zero detection
- Memory addressing
- Memory read/write behavior
- Write-back selection
- Branch and jump target generation

Internal RTL signals are exposed in GTKWave so that data movement and
control decisions can be correlated with the executed instruction.

### Waveform Analysis

GTKWave is used to inspect the generated `cpu_wave.vcd` waveform.

The waveform analysis provides visibility into:

- Clock transitions
- PC updates
- Instruction addresses
- Instruction values
- Immediate values
- Register operands
- ALU control signals
- ALU inputs and results
- Memory signals
- Write-back data
- Branch/jump selection

This provides functional evidence that the datapath and control logic
operate together correctly across clock cycles.

---

## Simulation Flow

The project can be simulated using an RTL simulator such as
Icarus Verilog.

A typical verification flow is:

1. Compile the Verilog RTL and testbench.
2. Execute the generated simulation.
3. Generate the VCD waveform file.
4. Open the waveform using GTKWave.
5. Inspect internal processor signals.
6. Correlate signal transitions with instruction execution.

The generated simulation artifacts are kept separate from the main RTL
source files.

---

## Tools & Technologies

- Verilog HDL
- RTL Design
- Icarus Verilog
- GTKWave
- Visual Studio Code
- Git
- GitHub

---

## Repository Structure

The repository is organized to keep RTL source files, verification
files, and project documentation clearly separated.

```text
RISC-V-Single-Cycle-Processor/
│
├── RTL / Verilog source files
│
├── CPU_top_tb.v
│
├── README.md
│
├── .gitignore
│
└── simulation files