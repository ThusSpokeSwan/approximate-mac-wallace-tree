`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.03.2026 11:27:37
// Design Name: 
// Module Name: accumulator
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
