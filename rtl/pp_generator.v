`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Project Name: Approximate MAC using Wallace Tree Multiplier
// Author: Hans Raj
// Create Date: 03.03.2026 23:54:55
// Module Name: pp_generator
// Tools: Xilinx Vivado 
// Description: Partial product generator used by Wallace tree multiplier.
// pp[i][j] = A[j] & B[i];
// 
//////////////////////////////////////////////////////////////////////////////////

module pp_generator(
    input wire [7:0] A,
    input wire [7:0] B,
    output wire [7:0] pp [7:0]
    );
    
    genvar i, j;
    
    generate
        for (i = 0; i < 8; i = i + 1) begin : row
            for (j = 0; j < 8; j = j + 1) begin : col
               assign pp[i][j] = A[j] & B[i];
           end
       end
   endgenerate
   
endmodule
