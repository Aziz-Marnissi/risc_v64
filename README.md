64-bit RISC Pipelined CPU (VHDL)
This repository contains the VHDL implementation of a 64-bit RISC Processor. The design focuses on a modular, pipelined architecture, featuring a customizable ALU, a dedicated Control Unit, and a multi-stage instruction flow.

🏗️ Architecture Overview
The processor follows a classic RISC structure, optimized for high-throughput execution. Key components include:

Instruction Fetch (IF): Program Counter (PC) and ROM-based instruction storage.

Instruction Decode (ID): IF/ID pipeline registers and a Control Unit for signal dispatching.

Execution (EX): A 64-bit ALU with comprehensive flag generation (Carry, Zero, Overflow, Negative).

Register File: A bank of 64 general-purpose registers (N=64).

🛠️ Key Features
1. Parametric ALU
The ALU is designed with a generic width, allowing it to scale from 8-bit to 64-bit architectures easily. It supports:

Arithmetic: ADD, SUB (with signed overflow detection).

Logic: AND, OR, XOR.

Status Flags: Real-time feedback for conditional branching.

2. Pipelined Design
The inclusion of an ifidreg (Instruction Fetch/Instruction Decode Register) allows the CPU to overlap the fetching of a new instruction while decoding the previous one, increasing the Clock Cycles Per Instruction (CPI) efficiency.

3. Smart Immediate Extension
The CPU top-level entity implements a robust immediate value handler using the resize function, safely transitioning 40-bit instruction constants into the 64-bit data path.

📂 File Structure
File	Description
ALU.vhd	The core arithmetic and logic unit with flag logic.
CPU.vhd	Top-level entity interconnecting all sub-modules.
cunit.vhd	The Control Unit responsible for instruction decoding.
registre.vhd	The 64x64-bit Register File implementation.
pc.vhd / rom.vhd	Program counter and instruction memory modules.
🚀 Getting Started
Prerequisites
A VHDL Simulator (e.g., ModelSim, GHDL, or Vivado).

IEEE Standard Libraries (ieee.std_logic_1164, ieee.numeric_std).

Compilation & Simulation
Compile the low-level components first: ALU.vhd, PC.vhd, rom.vhd, registre.vhd.

Compile the intermediate registers: ifidreg.vhd.

Compile the Top-Level: CPU.vhd.

Load the testbench and run the simulation to observe the res and pc_out signals.

📈 Future Enhancements
[ ] Data Forwarding: Implement forwarding paths to resolve Data Hazards.

[ ] Memory Stage: Add RAM integration for Load/Store operations.

[ ] Branch Prediction: Enhance the PC logic for conditional jumps.
