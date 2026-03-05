`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.03.2026 11:30:43
// Design Name: 
// Module Name: approx_mac
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


module approx_mac(
    input wire clk,
    input wire reset,
    input wire enable,
    input wire [7:0] A,
    input wire [7:0] B,
    output wire [31:0] mac_out
    );
    
    wire [15:0] product;
    
    wallace_tree mult(
        .A(A),
        .B(B),
        .product(product)
    );
    
    accumulator acc_unit(
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .product(product),
        .acc(mac_out)
    );
endmodule
