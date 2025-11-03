# Project 1 – toUpper() Function Using Primitive Digital Gates

**Author:** Nadim Siddique  
**Course:** CSC 211  
**Tools Used:** Icarus Verilog (iverilog + vvp), GTKWave  


## Project Overview

This project implements the `toUpper()` function commonly found in programming languages like Python, C++, and Java **using only primitive digital logic gates**.  
The circuit converts lowercase ASCII letters (`a–z`) to uppercase (`A–Z`) by flipping **bit A5** when the input value lies within the binary range for lowercase letters (`01100001`–`01111010`).

Every other character, number, or symbol passes through unchanged.

---

## Implementation Details

### Gate-Level Design Rules
Each gate is modeled with the following **propagation delays** (in nanoseconds):

| Gate Type | Symbol | Propagation Delay|
|-----------|--------|------------------|
| NOT       | `not`  |         #5 ns    |
| AND, OR   | `and`, `or` |    #10 ns   |
| NAND, NOR | `nand`, `nor` |  #12 ns   |
| XOR, XNOR | `xor`, `xnor` |  #15 ns   |
| Buffer    | `buf`  |         #4 ns    |

---

## Logic Summary

The circuit detects lowercase letters (`a–z`) using the top bits pattern  
`A7 A6 A5 = 0 1 1` and range checks on bits `A4–A0`.  
If true, the circuit flips bit 5 (`A5`) to convert to uppercase.

**Boolean Concept:**  
`A5_out = A5 ⊕ isLower`  
where `isLower` is high only when input ∈ [0x61, 0x7A].

---

##  Simulation Procedure

1. **Compile both files:**
   ```bash
   iverilog -Wall -g2012 -o sim.out to_upper_gate.v tb_to_upper.v
