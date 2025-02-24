# MIPS16 Processor Implementation

## Overview
The **MIPS16 Processor** is a hardware-based project implemented using **VHDL** and designed to execute a sequence of instructions on an **FPGA (Basys3 Artix-7 Board)**. The processor is capable of computing the **factorial of 5**, and its execution flow is managed through button inputs. The system utilizes a **16-bit instruction set** and displays results in **hexadecimal format** on a **seven-segment display (SSD)**.

## Features
- **Instruction Execution Control**:
  - **Upper Button**: Resets the program counter.
  - **Middle Button**: Enables the execution of the next instruction.
- **Selectable SSD Output**:
  - The **rightmost three switches** determine which value is displayed.
  - Values include **Instruction output, PC output, register contents, ALU results, and memory data**.
- **Hexadecimal Output**:
  - All results are displayed in hexadecimal format on the Basys3 board.

## Technologies Used
- **Hardware Description Language**: VHDL
- **FPGA Board**: Basys3 (Artix-7 FPGA)
- **Development Tools**: Vivado Design Suite
- **Processor Type**: 16-bit MIPS processor
- **Testing Environment**: FPGA simulation and on-board testing

## Architecture
The **MIPS16 processor** consists of the following components:

### Main Modules:
- **Instruction Fetch (IF)**: Fetches instructions from memory.
- **Instruction Decode (ID)**: Decodes the instruction and prepares operands.
- **Main Control Unit (MC)**: Generates control signals for execution.
- **Execution Unit (EX)**: Executes arithmetic and logic operations.
- **Memory Unit (MEM)**: Handles data memory read/write operations.
- **SSD Display Controller (SSD)**: Manages the display output.
- **Multi-Purpose Generator (MPG)**: Controls button inputs for step execution.

## Instruction Set
The implemented instructions allow the processor to compute **factorial of 5** step by step. The instruction set is as follows:

| Address | Instruction | Hex Code | Description |
|---------|------------|----------|-------------|
| 0 | XOR $1, $1, $1 | `x0496` | Initialize counter |
| 1 | ADDI $1, $0, 0 | `x8080` | Set counter to 0 |
| 2 | XOR $4, $4, $4 | `x1246` | Initialize result |
| 3 | ADDI $4, $0, 1 | `x8201` | Set result to 1 |
| 4 | BEQ $1, $4, 5 | `x0105` | Check loop condition |
| 5 | SW $1, 1($4) | `xE201` | Store result if condition met |
| 6 | ADDI $1, $1, 1 | `x8410` | Increment counter |
| 7 | J 4 | `x0013` | Jump back to loop condition |

## Usage Instructions
1. **Load the Bitstream**:
   - Program the FPGA board using the **generated bitstream**.
2. **Reset and Execute Instructions**:
   - Press the **upper button** to reset the program counter.
   - Press the **middle button** to step through each instruction.
3. **View Output on SSD**:
   - Use the **first three rightmost switches** to select which value to display.
     - `000`: Instruction Output
     - `001`: PC Output
     - `010`: Register 1 Value
     - `011`: Register 2 Value
     - `100`: Extended Immediate Value
     - `101`: ALU Result
     - `110`: Memory Data
     - `111`: Write Data

## Future Enhancements
- **Extended ALU Operations**: Implement additional arithmetic and logic functions.
- **Pipeline Processing**: Optimize instruction execution using pipelining.
- **Memory Expansion**: Increase data memory capacity.
- **Interrupt Handling**: Introduce external interrupt support.
- **User Input Support**: Implement data input via buttons or UART.


---
This project showcases expertise in **processor design, VHDL implementation, and FPGA programming**, making it an excellent addition to a portfolio for **hardware engineering and embedded systems development**.

