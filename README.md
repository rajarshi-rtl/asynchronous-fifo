# Asynchronous FIFO Design in Verilog

## Overview

Implemented a parameterized Asynchronous FIFO (First-In First-Out) buffer in Verilog for reliable data transfer between independent clock domains.

## Features

* Parameterized FIFO depth and data width
* Independent write and read clock domains
* Binry/Gray-code pointer generation
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

### Test Cases Performed in the testbench

1. Reset functionality
2. FIFO write/read operation
3. Full/Empty flag generation
4. Different write/read clock domains
5. Simultaneous read and write operations

## Tools Used

* Verilog HDL
* Icarus Verilog
* GTKWave

## Author

Rajarshi Ray  
B.Tech Electronics and Telecommunication Engineering  
IIEST Shibpur
