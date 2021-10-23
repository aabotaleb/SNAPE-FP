# SNAPE-FP
SNAPE-FP: SqueezeNet CNN with Accelerated Pooling Layers Extension based on IEEE-754 Floating Point Implementation through SW/HW Partitioning On ZYNQ SoC.</br>
This is the coding work of the published paper at IEEE NILES 2021 Conference, you can refer to the paper for more details about the background and the proposed architecture to accelerate the squeezenet convolutional neural network.</br>
First section of this readme contains the paper info, then general illustration of the project files along with short description, followed by guide to replicate the experiement using Xilinx Vivado 2019.1 IDE along with the use of PYNQ-Z2 Kit, then finally tabulating the results.

## Paper Info
Abdelrhman M. Abotaleb, Mohab H. Ahmed, and Mazen A. Fathi, "SNAP-FP: SqueezeNet CNN with Accelerated
Pooling Layers based on IEEE-754 Floating Point Implementation through SW/HW Partitioning On ZYNQ SoC",
2021 IEEE 3rd Novel Intelligent and Leading Emerging Sciences Conference (NILES),Manuscript accepted for
presentation by October 23rd and publication at IEEE Xplore.

## Licensing
You can use the current project files to extended this work in any useful ways but you must cite us, the original authours, properly and leave our copyrights on it.
This work is licensed under Berkeley-style open source license.

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
</br>
1. Running Time
</br>
Table 1. Average run time for each layer’s software and FPGA implementation over 1000 test runs, SP means single precision and HP means half precision.

|Type of Run | Layer/Precision |Time for 1 Channel (us) | Time for MultiChannels (us)|
| --------------- | ---------- | ----------------------- | -------------------------- |
|1000 Runs AXI | Avg Pool/SP | 1.78461 | 1.79076|
|1000 Runs AXI | Avg Pool/HP | 1.79076 | 1.78769|
|1000 Runs AXI | Max Pool/SP | 17.00923 | N/A|
|1000 Runs AXI | Max Pool/HP | 17.02153 | N/A|
|1000 Runs Arm | Avg Pool/SP | 8.37538 |24.87076 |
|1000 Runs Arm | Max Pool/SP | 108.35384 | N/A |

2. Utilization
</br>
Table 2. Hardware utilization for each accelerated layer.

|Resource | Layer/ Precision | Utilization 1 Channel | Utilization MultiChannels|
| ---------- | ---------- | ------------ | ------------- |
|Slice LUTs | Avg Pool/SP | 4912 (9.23%) | 9378 (17.63%) |
| .. | Avg Pool/HP | 3801 (7.14%) | 6075 (11.42%) |
| .. | Max Pool/SP | 16087 (30.24%) | 19596 (36.8%) |
| .. | Max Pool/HP | 10673 (20.06%) | 17452 (32.8%) |
| LUT as Logic | Avg Pool/SP | 4852 (9.12%) | 9318 (17.52%)|
| .. | Avg Pool/HP | 3741 (7.03%) | 6015 (11.31%)|
| .. | Max Pool/SP | 16027 (30.13%) | 19534 (36.7%)|
| .. | Max Pool/HP | 10613 (19.95%) | 17390 (32.7%)|
| LUT as Memory | Avg Pool/SP | 60 (0.34%) | 60 (0.34%) |
| .. | Avg Pool/HP | 60 (0.34%) | 60 (0.34%) | 
| .. | Max Pool/All |  60 (0.34%) | 62 (0.36%)|
| Slice Reg as Flip Flops | Avg Pool/SP | 6085 (5.72%) |  22533 (21.1%)|
| .. | Avg Pool/HP | 6077 (5.71%) | 14354 (13.5%)|
| .. | Max Pool/SP | 40471 (38.04%) | 45965(43.2%)|
| .. | Max Pool/HP | 26069 (24.50%) | 40587(38.2%)|
| DSP48E1 | Avg Pool/SP | 2 (0.91%) | 6 (2.73%)|
| .. | Avg Pool/HP | 1 (0.45%) | 3 (1.36%)|
| .. | Max Pool/All | 0 (0%) | 0 (0%)|




</br>
3. Power consumption
</br>
Table 3. Power consumption for each accelerated layer.

|Type of Power | Layer/Precision | Consumption 1 Channel (W) | Consumption MultiChannels (W) |
| ------------- | --------------- | ------------------------- | ----------------------------- |
| Dynamic (91%) | Avg Pool/SP | 1.303 | 1.36 |
| .. | Avg Pool/HP | 1.294 | 1.326|
| .. | MaxPool/SP | 1.413| 1.399|
| .. | MaxPool/HP | 1.351| 1.389|
|Device Static (9%) | Avg Pool/SP| 0.132 | 0.135|
| .. | Avg Pool/HP | 0.133 | 0.134|
| .. | Max Pool/SP | 0.136 | 0.136|
| .. | Max ool/HP | 0.135 | 0.136|

