`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/15/2020 12:46:19 AM
// Design Name: 
// Module Name: avg_pool_single_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module avg_pool_single_tb;

parameter DATAWIDTH = 32;
parameter MAT_DIMENSION = 13;
parameter DIVISOR = 32'h3bc1e4bc; //1/169

reg [DATAWIDTH-1:0] mat_in_x[MAT_DIMENSION][MAT_DIMENSION];

reg clk, rst;
reg [DATAWIDTH-1:0] avg_out, sum_out;
wire finished;

always
begin
    clk = 1;
    #60;
    clk = 0;
    #60;
end
integer i, j;

initial
begin
    $stop;
    for(i = 0; i < MAT_DIMENSION; i = i+ 1)
    begin
        for(j = 0; j < MAT_DIMENSION; j = j+ 1)
        begin
            mat_in_x[i][j] = 32'h3f800000;
        end
    end
        
    rst = 1'b1;
    #120;
    rst = 1'b0;
    
    while(finished == 1'b0)
    begin
        #120;
    end
    $stop;
end
//ONLY USE FOR POST SYNTH/IMPL SIMULATIONS
//replace all \mat_in_y lines with .mat_in_y(mat_in_x) to allow only behavioural simulation
avg_pool_single #(.DATAWIDTH(DATAWIDTH), .MAT_DIMENSION(MAT_DIMENSION), .DIVISOR(DIVISOR)) avg_pool_s1(
    .clk(clk),
    .rst(rst),
    .avg_out(avg_out),
    .sum_out(sum_out),
    .finished(finished),
    //. \mat_in_y[0][0] (mat_in_x[0][0]),
    
    //. \mat_in_y[0][1] (mat_in_x[0][1]),
    
    //. \mat_in_y[1][0] (mat_in_x[1][0]),
    //. \mat_in_y[1][1] (mat_in_x[1][1])
    .mat_in_y(mat_in_x)
);
endmodule
