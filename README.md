# SNAPE-FP
SNAPE-FP: SqueezeNet CNN with Accelerated Pooling Layers Extension based on IEEE-754 Floating Point Implementation through SW/HW Partitioning On ZYNQ SoC.</br>
This is the coding work of the published paper at IEEE NILES 2021 Conference, you can refer to the paper for more details about the background and the proposed architecture to accelerate the squeezenet convolutional neural network.</br>
First section of this readme contains the paper info, then general illustration of the project files along with short description, followed by guide to replicate the experiement using Xilinx Vivado 2019.1 IDE along with the use of PYNQ-Z2 Kit, then finally tabulating the results.

## Paper Info
Abdelrhman M. Abotaleb, Mohab H. Ahmed, and Mazen A. Fathi, "SNAP-FP: SqueezeNet CNN with Accelerated
Pooling Layers based on IEEE-754 Floating Point Implementation through SW/HW Partitioning On ZYNQ SoC",
2021 IEEE 3rd Novel Intelligent and Leading Emerging Sciences Conference (NILES),Manuscript accepted for
presentation by October 23rd and publication at IEEE Xplore.

## Motivation
FPGA Acceleration can overcome the cache latency needed to commuicate with data in processing system, no off-chip memory bottleneck and most importantly parellelism with higher orders can be achieved. 

## Project Description 
The project consists of the following parts
- The floating point unit.
- The average pool FPGA implementation
    There are three versions developed:
    - No parallelism 
    - Three channels are implemented in parallel.
- The maxpool FPGA implementation
- The AXI interfacing to integrate the average pool with C application driver.
- The AXI interfacing to integrate the max pool with C application driver.


## Software and Hardware Environment

### Software Tools:

1. Xilinx Vivado 2019.1 IDE
2. Xilinx SDK

### Hardware Tools:

PYNQ-Z2 from TUL.

## Results
1. Running Time


2. Utilization


3. Power consumtion



