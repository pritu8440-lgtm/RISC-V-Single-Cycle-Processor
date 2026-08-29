# RISC-V Single-Cycle Processor

A 32-bit RISC-V Single-Cycle Processor designed and implemented using Verilog HDL.

## Overview

This project implements a basic RISC-V processor where each instruction is completed in a single clock cycle.

The processor follows the standard instruction flow:

Instruction Fetch → Instruction Decode → Execute → Memory Access → Write Back

## Processor Architecture

The main datapath consists of:

- Program Counter (PC)
- Instruction Memory
- Register File
- Immediate Generator
- ALU
- ALU Control
- Data Memory
- Multiplexers
- Main Control Unit
- PC Target / Next-PC Logic

## Supported Operations

The processor demonstrates operations including:

- Arithmetic operations
- Logical operations
- Load and Store
- Branch instructions
- Jump instructions
- Register-to-register operations
- Immediate operations

## Project Structure

```text
RISC-V-Single-Cycle-Processor/
│
├── RTL/
│   ├── alu.v
│   ├── alu_decoder.v
│   ├── alu_mux.v
│   ├── data_memory.v
│   ├── imm_gen.v
│   ├── instruction_decoder.v
│   ├── register_set.v
│   ├── src_a_mux.v
│   └── writeback_mux.v
│
├── testbench/
│   └── CPU_top_tb.v
│
├── cpu.v
├── cpu_wave.vcd
├── .gitignore
└── README.md