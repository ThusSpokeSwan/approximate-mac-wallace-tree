`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.03.2026 23:52:38
// Design Name: 
// Module Name: exact_HA
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


module exact_HA(
    input wire A,
    input wire B,
    output wire S,
    output wire Cout
    );
    
    assign S = A ^ B;
    assign Cout = A & B;
    
endmodule
