`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Project: Approximate MAC using Wallace Tree Multiplier
// Author: Hans Raj
// Create Date: 03.03.2026 23:52:38
// Module Name: exact_HA
// Description: Exact half adder used in Wallace tree reduction stage
//  S = A ^ B ;
// Cout = A & B;
// Tools: Xilinx Vivado
//////////////////////////////////////////////////////////////////////////////////

module exact_HA(
    input wire A,
    input wire B,
    output wire S,
    output wire Cout
    );
    
    assign S = A ^ B;
    assign Cout = A & B;
    
endmodule
