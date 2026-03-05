`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.03.2026 23:50:52
// Design Name: 
// Module Name: exact_FA
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
