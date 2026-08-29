# RISC-V Single-Cycle Processor

### 32-bit RISC-V Processor | Verilog HDL | RTL Design | Functional Verification

A modular RTL implementation of a 32-bit RISC-V single-cycle processor developed in Verilog HDL.

This project focuses on designing and integrating the fundamental hardware blocks required to execute instructions through a complete single-cycle datapath.

The processor is built using a hierarchical RTL architecture consisting of the Program Counter, Instruction Memory, Register Set, Immediate Generator, ALU, Data Memory, multiplexers, and dedicated control logic.

The design emphasizes modular hardware construction, clear datapath organization, control-path separation, and RTL-level functional verification.

---

## Project Overview

The processor follows the fundamental single-cycle instruction execution flow:

**Instruction Fetch → Instruction Decode → Execute → Memory Access → Write Back**

Each instruction is processed within a single clock cycle.

The processor is organized into three major functional sections:

- **Instruction Fetch Path**
- **Core Datapath**
- **Control Unit**

The modular organization makes the internal operation of the processor observable during RTL simulation and simplifies debugging and functional verification.

---

## Processor Architecture

The top-level processor integrates the instruction-fetch logic, core datapath, control unit, instruction memory, and data memory.

### Top-Level Architecture

![RISC-V Single-Cycle Processor](docs/images/single_cycle_top.png)

The top-level design provides the clock and reset interface and connects the processor core with instruction and data memories.

Important processor-level signals include:

- ALU Output
- Memory Write
- Program Counter
- Write Data
- Instruction
- Clock
- Reset

---

## Core Datapath

The core datapath is responsible for transferring and processing instruction and operand data through the processor.

![Core Datapath](docs/images/core_datapath.png)

The datapath contains the following major hardware blocks:

- Program Counter (PC)
- PC + 4 Logic
- PC Target Generation
- PC Multiplexer
- Register Set
- Immediate Generator
- Source-A Multiplexer
- ALU Multiplexer
- ALU
- Data Memory Interface
- Write-Back Multiplexer

### Datapath Operation

The current Program Counter provides the address used to access instruction memory.

The fetched instruction is decoded to determine the source registers, destination register, immediate value, and required control signals.

The Register Set provides the source operands to the execution stage.

Depending on the instruction, the ALU receives its second operand either from the register set or from the generated immediate value.

The ALU performs the required arithmetic or logical operation.

For memory-access instructions, the ALU result is used as the data-memory address.

Finally, the Write-Back Multiplexer selects the appropriate result that is written back to the destination register.

---

## Instruction Fetch Path

The instruction-fetch section is responsible for generating and updating the Program Counter.

The main components are:

- Program Counter
- PC + 4 Logic
- PC Target Generation
- PC Selection Multiplexer
- Instruction Memory

For normal sequential execution:

**Next PC = PC + 4**

For control-flow instructions, the PC Target logic generates an alternative target address.

The PC selection logic determines which address becomes the next Program Counter value.

This provides the required mechanism for sequential instruction execution as well as branch and jump operations.

---

## Control Unit

The Control Unit decodes the current instruction and generates the control signals required to configure the datapath.

![Control Unit](docs/images/control_unit.png)

The control path is implemented using dedicated RTL blocks including:

- Main Decoder
- ALU Decoder
- Instruction Decoder

The control logic determines operations such as:

- Register Write Enable
- Memory Write Enable
- ALU Source Selection
- ALU Operation
- Result Source Selection
- Branch Control
- Jump Control
- Immediate Source Selection

Separating the control logic from the datapath keeps the processor architecture modular and makes individual control decisions easier to analyze during simulation.

---

## Processor Core

The integrated processor core combines the datapath and control logic into a complete single-cycle execution unit.

![Single-Cycle Core](docs/images/single_cycle_core.png)

The hierarchical implementation allows the major processor components to be individually inspected while also providing a complete processor-level structure.

The processor core coordinates:

**Instruction → Decode → Operand Selection → ALU Operation → Memory Access → Write Back**

---

## RTL Design Philosophy

The processor was developed using a **bottom-up RTL design methodology**.

Instead of treating the processor as a single large hardware block, the design is decomposed into smaller functional modules.

Each module has a specific hardware responsibility.

### Modular Hardware Design

Each processor function is implemented as a separate RTL block.

This improves:

- Readability
- Debugging
- Reusability
- Functional Verification
- Hierarchical Integration

### Datapath and Control Separation

The datapath is responsible for data movement and computation, while the Control Unit generates the signals that configure the datapath.

This separation makes the instruction execution process easier to understand and verify at RTL level.

### Hierarchical Integration

Individual RTL modules are connected hierarchically to construct the complete processor.

This allows internal processor behavior to be observed during simulation and makes debugging more systematic.

---

## Instruction Execution Flow

The processor executes an instruction through the following logical sequence.

### 1. Instruction Fetch

The Program Counter provides the instruction address.

The Instruction Memory returns the corresponding 32-bit instruction.

The sequential PC value is generated using:

**PC + 4**

### 2. Instruction Decode

The instruction is decoded to determine:

- Source Registers
- Destination Register
- Immediate Field
- Instruction Type
- Required Control Signals

### 3. Operand Selection

The Register Set provides the required source operands.

The Immediate Generator produces the instruction-specific immediate value.

Multiplexers select the appropriate operands for the ALU.

### 4. Execute

The ALU performs the selected arithmetic or logical operation.

The ALU operation is determined by the control signals generated by the Control Unit.

### 5. Memory Access

For memory-related instructions, the ALU output is used as the memory address.

The Data Memory performs the required read or write operation according to the memory control signal.

### 6. Write Back

The Write-Back Multiplexer selects the value that should be written to the destination register.

The selected result is written into the Register Set when register write is enabled.

---

## Verification

The processor was functionally verified using a Verilog testbench.

Simulation was performed using **Icarus Verilog**, and the generated waveform was analyzed using **GTKWave**.

The verification process focuses on observing the interaction between datapath signals and control signals across multiple clock cycles.

The following internal signals were observed during simulation:

- Clock
- Reset
- Program Counter
- Next PC
- PC + 4
- PC Target
- Instruction
- Immediate
- Register Source Addresses
- Register Read Data
- Register Write Enable
- Write-Back Data
- ALU Control
- ALU Operands
- ALU Result
- Zero Flag
- Memory Address
- Memory Write Control
- Memory Read Data

---

## GTKWave Simulation

The RTL simulation waveform was inspected using GTKWave to verify processor behavior across multiple clock cycles.

![GTKWave Verification Waveform](docs/images/waveform.png)

The waveform provides visibility into the relationship between:

- Clock Cycles
- Instruction Addresses
- Program Counter Updates
- Instruction Values
- Register Operations
- ALU Operations
- Memory Operations
- Control Signals
- Write-Back Behavior

Signal-level observation helps verify the interaction between individual RTL modules and the complete processor datapath.

---

## Hardware Demonstration

The processor design is also documented with a hardware setup using the **Digilent Basys 3 FPGA development board**.

![Basys 3 Hardware Demonstration](docs/images/basys3-hardware.png)

The hardware image documents the FPGA development environment used alongside the RTL design and simulation workflow.

The project workflow therefore covers both:

**RTL Design → Simulation → Waveform Verification → FPGA Hardware Environment**

---

## Design Verification Approach

Verification was performed progressively during development.

The general verification methodology was:

1. Implement individual RTL modules.
2. Verify module-level behavior.
3. Integrate the modules into the datapath.
4. Integrate the Control Unit with the datapath.
5. Connect instruction and data memory.
6. Run the complete processor testbench.
7. Inspect internal signals using GTKWave.
8. Verify Program Counter progression.
9. Verify ALU operations.
10. Verify register activity.
11. Verify memory behavior.
12. Verify write-back behavior.

This bottom-up verification approach helps isolate functional issues before complete processor integration.

---

## Project Structure

```text
RISC-V-Single-Cycle-Processor/
│
├── docs/
│   └── images/
│       ├── single_cycle_top.png
│       ├── core_datapath.png
│       ├── control_unit.png
│       ├── single_cycle_core.png
│       ├── waveform.png
│       └── basys3-hardware.png
│
├── README.md
├── .gitignore
│
├── Verilog RTL source files
├── CPU testbench
└── Simulation files
---

## 👋 Author

**Ritu Priya** — [RISC-V Single-Cycle Processor](https://github.com/pritu8440-lgtm/RISC-V-Single-Cycle-Processor)

Designed and developed by **Ritu Priya** as a hands-on RTL implementation of a 32-bit RISC-V single-cycle processor using Verilog HDL, with functional simulation and signal-level verification using GTKWave.