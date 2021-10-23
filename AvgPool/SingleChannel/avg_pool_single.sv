`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/15/2020 12:20:48 AM
// Design Name: 
// Module Name: avg_pool_single
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


module avg_pool_single(
        mat_in_y, avg_out, sum_out, clk, rst, finished
    );
parameter DATAWIDTH = 32;
parameter MAT_DIMENSION = 2;
parameter DIVISOR = 32'h3bc1e4bc; //1/169
input wire [DATAWIDTH-1:0] mat_in_y[MAT_DIMENSION][MAT_DIMENSION];
input wire clk, rst;
output wire [DATAWIDTH-1:0] avg_out, sum_out;
output reg finished;

wire accum_enable;

reg [DATAWIDTH-1:0] accum_in;

parameter INDEX_WIDTH = $clog2(MAT_DIMENSION) + 1;//+1 for detecting when finished
reg [INDEX_WIDTH-1:0] row, col;

always @(posedge clk)
begin
    if(rst == 1'b1)
    begin
        row = {INDEX_WIDTH{1'b0}};
        col = {INDEX_WIDTH{1'b0}};
        finished = 1'b0;
    end
    else
    begin
        if(finished == 1'b0)
        begin
            col = col + 1;
            if(col == MAT_DIMENSION)
            begin
                col = {INDEX_WIDTH{1'b0}};
                if(row == MAT_DIMENSION - 1 )
                begin
                    finished = 1'b1;
                    row = {INDEX_WIDTH{1'b0}};
                    col = {INDEX_WIDTH{1'b0}};
                end
                else
                begin
                    row = row + 1;
                end
            end
        end
    end
end

fp_accumulate #(.DATAWIDTH(DATAWIDTH)) accum1(
    .clk(clk),
    .rst(rst),
    .en(accum_enable),
    .fp_in(mat_in_y[row][col]),
    .fp_sum(sum_out)
);

mul_fp mult1(
    .flp_a(DIVISOR),
    .flp_b(sum_out),
    .flp_res(avg_out)
);

assign accum_enable = ~finished;
endmodule
