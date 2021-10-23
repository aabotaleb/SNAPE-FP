`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/26/2020 12:31:18 AM
// Design Name: 
// Module Name: max_pool_single_tb
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


module max_pool_single_tb;

parameter DATAWIDTH = 32;
parameter MAT_DIMENSION = 5;

parameter WINDOW_DIMENSION = 3;
parameter STRIDE = 2;
parameter OUTPUT_DIMENSION = (MAT_DIMENSION - WINDOW_DIMENSION)/STRIDE + 1;



reg clk, rst;
reg [DATAWIDTH-1:0] mat_in[MAT_DIMENSION][MAT_DIMENSION];
wire finished;
reg [DATAWIDTH-1:0] mat_out[OUTPUT_DIMENSION][OUTPUT_DIMENSION];

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
    mat_in[0][0] = 32'h00000000;
    mat_in[0][1] = 32'h3f800000;
    mat_in[0][2] = 32'h40000000;
    mat_in[0][3] = 32'h40400000;
    mat_in[0][4] = 32'h40800000;
    mat_in[1][0] = 32'h3f800000;
    mat_in[1][1] = 32'h40000000;
    mat_in[1][2] = 32'h40400000;
    mat_in[1][3] = 32'h40800000;
    mat_in[1][4] = 32'h40a00000;
    mat_in[2][0] = 32'h40000000;
    mat_in[2][1] = 32'h40400000;
    mat_in[2][2] = 32'h40800000;
    mat_in[2][3] = 32'h40a00000;
    mat_in[2][4] = 32'h40c00000;
    mat_in[3][0] = 32'h40400000;
    mat_in[3][1] = 32'h40800000;
    mat_in[3][2] = 32'h40a00000;
    mat_in[3][3] = 32'h40c00000;
    mat_in[3][4] = 32'h40e00000;
    mat_in[4][0] = 32'h40800000;
    mat_in[4][1] = 32'h40a00000;
    mat_in[4][2] = 32'h40c00000;
    mat_in[4][3] = 32'h40e00000;
    mat_in[4][4] = 32'h41000000;
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
//replace all \mat_out lines with .mat_out(mat_out) to allow only behavioural simulation
max_pool_single #(.DATAWIDTH(DATAWIDTH), .MAT_DIMENSION(MAT_DIMENSION), .WINDOW_DIMENSION(WINDOW_DIMENSION), .STRIDE(STRIDE)) pool1(
    .clk(clk),
    .rst(rst),
    //.mat_in(mat_in),
    . \mat_in[0][0] (mat_in[0][0]),
    . \mat_in[0][1] (mat_in[0][1]),
    . \mat_in[0][2] (mat_in[0][2]),
    . \mat_in[0][3] (mat_in[0][3]),
    . \mat_in[0][4] (mat_in[0][4]),
    . \mat_in[1][0] (mat_in[1][0]),
    . \mat_in[1][1] (mat_in[1][1]),
    . \mat_in[1][2] (mat_in[1][2]),
    . \mat_in[1][3] (mat_in[1][3]),
    . \mat_in[1][4] (mat_in[1][4]),
    . \mat_in[2][0] (mat_in[2][0]),
    . \mat_in[2][1] (mat_in[2][1]),
    . \mat_in[2][2] (mat_in[2][2]),
    . \mat_in[2][3] (mat_in[2][3]),
    . \mat_in[2][4] (mat_in[2][4]),
    . \mat_in[3][0] (mat_in[3][0]),
    . \mat_in[3][1] (mat_in[3][1]),
    . \mat_in[3][2] (mat_in[3][2]),
    . \mat_in[3][3] (mat_in[3][3]),
    . \mat_in[3][4] (mat_in[3][4]),
    . \mat_in[4][0] (mat_in[4][0]),
    . \mat_in[4][1] (mat_in[4][1]),
    . \mat_in[4][2] (mat_in[4][2]),
    . \mat_in[4][3] (mat_in[4][3]),
    . \mat_in[4][4] (mat_in[4][4]),
    .finished(finished),
    //.mat_out(mat_out)
    . \mat_out[0][0] (mat_out[0][0]),
    . \mat_out[0][1] (mat_out[0][1]),
    . \mat_out[1][0] (mat_out[1][0]),
    . \mat_out[1][1] (mat_out[1][1])
);
endmodule
