`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Project Name: Approximate MAC using Wallace Tree Multiplier
// Author: Hans Raj
// Create Date: 05.03.2026 11:27:37
// Module Name: accumulator
// Tools: Xilinx Vivado 
// Description: 16-bit accumulator register used in the MAC unit. 
// ACC = ACC + Product
// Dependencies: wallace_tree multiplier
// 
//////////////////////////////////////////////////////////////////////////////////


module accumulator(
    input wire clk,
    input wire reset,
    input wire enable,
    input wire [15:0] product,
    output reg [31:0] acc
    );
    
always @(posedge clk or posedge reset) begin
    if(reset)
        acc <= 32'b0;
    else if (enable)
        acc <= acc + product;
end

endmodule
