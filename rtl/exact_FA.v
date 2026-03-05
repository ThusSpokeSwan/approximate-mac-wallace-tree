`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Project: Approximate MAC using Wallace Tree Multiplier
// Author: Hans Raj
// Create Date: 03.03.2026 23:50:52
// Module Name: exact_FA
// Description: Exact full adder used in Wallace tree reduction stage
//  S = A ^ B ^ C;
// Cout = (A & B) | (B & C) | (A & C);
// Use in MSB columns for accuracy.
// Tools: Xilinx Vivado
//
//////////////////////////////////////////////////////////////////////////////////


module exact_FA(
input wire A,
    input wire B,
    input wire C,
    output wire S,
    output wire Cout
    );
    
    assign S = A ^ B ^ C;
    assign Cout = (A & B) | (B & C) | (A & C);
    
endmodule
