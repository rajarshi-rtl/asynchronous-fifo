# Asynchronous FIFO Design in Verilog

## Overview

Implemented a parameterized Asynchronous FIFO (First-In First-Out) buffer in Verilog for reliable data transfer between independent clock domains.

The design uses Gray-code pointers and dual-flop synchronizers to mitigate metastability issues associated with Clock Domain Crossing (CDC).

## Features

* Parameterized FIFO depth and data width
* Independent write and read clock domains
* Gray-code pointer generation
* Dual-flop synchronizers for CDC
* Full and Empty flag generation
* Dual-port memory architecture
* Verilog RTL implementation and simulation

## Architecture

The FIFO consists of the following modules:

* `asynchronous_fifo.v` – Top-level FIFO module
* `wr_ptr_handler.v` – Write pointer Handler and full flag generation logic
* `rd_ptr_handler.v` – Read pointer Handler and empty flag generation logic
* `dual_flop_synchronizer.v` – Dual Flop Synchronizer
* `binary_to_gray.v` – Binary to Gray code converter
* `gray_to_binary.v` – Gray to Binary code converter
* `fifo_mem.v` – Dual-port memory

## Verification

The design was verified using Icarus Verilog and GTKWave.

### Test Cases Performed

1. Reset functionality
2. FIFO write operation
3. FIFO read operation
4. Full flag assertion
5. Empty flag assertion
6. Overflow protection
7. Underflow protection
8. Different write/read clock frequencies
9. Simultaneous read and write operations

## Tools Used

* Verilog HDL
* Icarus Verilog
* GTKWave

## Author

Rajarshi Ray
B.Tech Electronics and Telecommunication Engineering
IIEST Shibpur
