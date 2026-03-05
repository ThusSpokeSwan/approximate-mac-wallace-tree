`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// 
// Project Name: Approximate MAC using Wallace Tree Multiplier
// Author: Hans Raj
// Create Date: 03.03.2026 23:48:46
// Module Name: approx_FA
// Tools: Xilinx Vivado 
// Description: Approximate full adder used in the Wallace tree reduction stage.
// S = A | B | C
// Cout = A & B
// Used in LSB columns to reduce hardware complexity.
// 
//////////////////////////////////////////////////////////////////////////////////

module approx_FA(
    input wire A,
    input wire B,
    input wire C,
    output wire S,
    output wire Cout
    );
    
    assign S = A | B | C;
    assign Cout = A & B;
endmodule
