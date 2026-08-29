# RISC-V Single-Cycle Processor

### 32-bit RISC-V Processor | Verilog HDL | RTL Design | Functional Verification

A modular RTL implementation of a 32-bit RISC-V single-cycle processor developed in Verilog HDL.

The project focuses on implementing a complete instruction-execution datapath by integrating fundamental processor building blocks such as the Program Counter, Instruction Memory, Register Set, Immediate Generator, ALU, Data Memory, multiplexers, and control logic.

The design follows a modular RTL architecture in which the datapath and control path are implemented as separate functional blocks and integrated hierarchically at the processor level.

---

## Project Overview

The processor follows the fundamental single-cycle instruction execution flow:

**Instruction Fetch → Instruction Decode → Execute → Memory Access → Write Back**

Each instruction is processed within a single clock cycle.

The processor is organized into two major functional sections:

- **Instruction Fetch Path**
- **Core Datapath**
- **Control Unit**

The modular structure makes the internal operation of the processor observable during RTL simulation and simplifies functional verification and debugging.

---

## Processor Architecture

The top-level processor integrates the instruction-fetch logic, core datapath, control unit, instruction memory, and data memory.

### Top-Level Architecture

![RISC-V Single-Cycle Processor](docs/images/single_cycle_top.png)

The top-level design provides the clock and reset interface and connects the processor core with instruction and data memories.

The processor exposes important execution signals such as:

- ALU output
- Memory write control
- Program Counter
- Write data
- Reset
- Clock

---

## Core Data Path

The core datapath is responsible for transferring and processing instruction and operand data.

![Core Datapath](docs/images/core_datapath.png)

The datapath contains the following major hardware blocks:

- Program Counter (PC)
- PC + 4 logic
- PC Target Generation
- PC Multiplexer
- Instruction Memory interface
- Register Set
- Immediate Generator
- Source-A Multiplexer
- ALU Multiplexer
- ALU
- Write-Back Multiplexer

### Datapath Operation

The current Program Counter is used to access the instruction memory.

The fetched instruction is decoded to determine the source registers, destination register, immediate value, and required control signals.

The Register Set provides the source operands.

Depending on the instruction, the ALU receives its second operand either from the register file or from the generated immediate value.

The ALU performs the required arithmetic or logical operation.

For memory-access instructions, the ALU result is used as the data-memory address.

Finally, the Write-Back Multiplexer selects the appropriate result to be written into the destination register.

---

## Instruction Fetch Path

The instruction-fetch section generates and updates the Program Counter.

The main components are:

- Program Counter
- PC + 4
- PC Target Generation
- PC Selection Multiplexer
- Instruction Memory

For normal sequential execution:

**Next PC = PC + 4**

For control-flow instructions, the PC target logic provides the alternative target address.

The PC selection logic determines which address becomes the next Program Counter value.

---

## Control Unit

The control unit decodes the current instruction and generates the control signals required to configure the datapath.

![Control Unit](docs/images/control_unit.png)

The control path is implemented using dedicated RTL blocks including:

- Main Decoder
- ALU Decoder
- Instruction Decoder

The generated control signals determine the behavior of the datapath.

Important control signals include:

- Register Write
- Memory Write
- ALU Source Selection
- ALU Operation
- Result Source Selection
- Branch Control
- Jump Control
- Immediate Source Selection

Separating the control logic from the datapath keeps the processor architecture modular and makes individual control decisions easier to analyze during simulation.

---

## RTL Design Philosophy

The processor was developed using a **bottom-up RTL design methodology**.

Instead of treating the processor as a single large hardware block, the design is decomposed into smaller functional modules.

Each module has a specific hardware responsibility.

The major design principles are:

### Modular Hardware Design

Each processor function is implemented as a separate RTL block.

This improves:

- Readability
- Debugging
- Reusability
- Functional verification
- Hierarchical integration

### Datapath and Control Separation

The datapath is responsible for data movement and computation, while the control unit generates the signals that configure the datapath.

This separation makes the instruction execution process easier to understand at RTL level.

### Hierarchical Integration

Individual modules are connected hierarchically to construct the complete processor.

This allows internal processor behavior to be observed through simulation.

---

## Instruction Execution Flow

The processor executes an instruction through the following logical sequence:

### 1. Instruction Fetch

The Program Counter provides the instruction address.

The instruction memory returns the corresponding 32-bit instruction.

The sequential PC value is generated using:

**PC + 4**

### 2. Instruction Decode

The instruction is decoded to determine:

- Source registers
- Destination register
- Immediate field
- Instruction type
- Required control signals

### 3. Operand Selection

The Register Set provides the required source operands.

The immediate generator produces the instruction-specific immediate value.

Multiplexers select the appropriate operands for the ALU.

### 4. Execute

The ALU performs the selected arithmetic or logical operation.

The ALU operation is determined by the control signals generated by the control unit.

### 5. Memory Access

For memory-related operations, the ALU output is used as the memory address.

The data memory performs the required read or write operation according to the memory control signal.

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
- Register source addresses
- Register read data
- Register write enable
- Write-back data
- ALU control
- ALU operands
- ALU result
- Zero flag
- Memory address
- Memory write control
- Memory read data

---

## GTKWave Simulation

The RTL simulation waveform was inspected using GTKWave to verify the behavior of the processor across clock cycles.

![GTKWave Verification Waveform](docs/images/waveform.png)

The waveform provides visibility into the relationship between:

- Clock cycles
- Instruction addresses
- Program Counter updates
- Instruction values
- Register operations
- ALU operations
- Memory operations
- Control signals
- Write-back behavior

This signal-level observation is useful for validating the interaction between individual RTL modules and the complete processor datapath.

---

## Processor Core

The integrated processor core combines the datapath and control logic into a complete single-cycle execution unit.

![Single-Cycle Core](docs/images/single_cycle_core.png)

The hierarchical implementation allows the major processor components to be individually inspected while also providing a complete top-level processor structure.

---

## Design Verification Approach

Verification was performed progressively during development.

The general verification methodology was:

1. Implement individual RTL modules.
2. Verify module-level behavior.
3. Integrate the modules into the datapath.
4. Integrate the control unit with the datapath.
5. Connect instruction and data memory.
6. Run the complete processor testbench.
7. Inspect internal signals using GTKWave.
8. Verify Program Counter progression, ALU operations, register activity, memory behavior, and write-back behavior.

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
│       └── waveform.png
│
├── README.md
├── .gitignore
│
├── Verilog RTL source files
├── CPU testbench
└── Simulation files