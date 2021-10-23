`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/25/2020 10:53:33 PM
// Design Name: 
// Module Name: max_pool_single
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


module max_pool_single(mat_in, clk, rst, mat_out, finished);

parameter DATAWIDTH = 32;
parameter MAT_DIMENSION = 27;

parameter WINDOW_DIMENSION = 3;
parameter STRIDE = 2;
parameter OUTPUT_DIMENSION = (MAT_DIMENSION - WINDOW_DIMENSION)/STRIDE + 1;



input wire clk, rst;
input wire [DATAWIDTH-1:0] mat_in[MAT_DIMENSION][MAT_DIMENSION];
output reg finished;
output wire [DATAWIDTH-1:0] mat_out[OUTPUT_DIMENSION][OUTPUT_DIMENSION];

wire [DATAWIDTH-1:0] greatest_fp;
wire [DATAWIDTH-1:0] A_FP;
wire [DATAWIDTH-1:0] B_FP;
wire AIsGreater;



parameter INDEX_WIDTH = $clog2(OUTPUT_DIMENSION) + 1;//+1 for detecting when finished
reg [INDEX_WIDTH-1:0] row, col;

reg [WINDOW_DIMENSION-1:0] window_row;
reg [WINDOW_DIMENSION-1:0] window_col;
reg window_finished;

always @(posedge clk)
begin
    if(rst == 1'b1)
    begin
        row = {INDEX_WIDTH{1'b0}};
        col = {INDEX_WIDTH{1'b0}};
        finished = 0;
        window_finished = 0;
        window_row = 0;
        window_col = 0;
    end
    else
    begin
        if(finished == 1'b0 && window_finished == 1'b1)
        begin
            window_finished = 1'b0;
            col = col + 1;
            if(col == OUTPUT_DIMENSION)
            begin
                col = {INDEX_WIDTH{1'b0}};
                if(row == OUTPUT_DIMENSION - 1 )
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
        else if(finished == 1'b0 && window_finished == 1'b0)
        begin
            window_col = window_col + 1;
            if(window_col == WINDOW_DIMENSION)
            begin
                window_col = 0;
                if(window_row == WINDOW_DIMENSION - 1 )
                begin
                    window_finished = 1'b1;
                    window_row = 0;
                    window_col = 0;
                end
                else
                begin
                    window_row = window_row + 1;
                end
            end
        end
    end
end
genvar i, j;

generate
    for(i = 0; i < OUTPUT_DIMENSION; i = i + 1)
    begin
        for(j = 0; j < OUTPUT_DIMENSION; j = j + 1)
        begin
            fp_reg reg0(
                .d(greatest_fp),
                .clk(clk),
                .rst(rst),
                .en(row == i && col == j),
                .q(mat_out[i][j])
            );
        end
    end
endgenerate

fp_comp comp1(
    .A_FP(A_FP),
    .B_FP(B_FP),
    .AIsGreater(AIsGreater)
);

assign greatest_fp = AIsGreater == 1'b1 ? A_FP : B_FP;

assign A_FP = mat_out[row][col];
assign B_FP = mat_in[row*STRIDE + window_row][col * STRIDE + window_col];
endmodule
