`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.03.2026 11:40:46
// Design Name: 
// Module Name: tb_approx_mac
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


module tb_approx_mac;

    reg clk;
    reg reset;
    reg enable;
    reg [7:0] A;
    reg [7:0] B;

    wire [31:0] mac_out;

    // Instantiate the MAC
    approx_mac uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .A(A),
        .B(B),
        .mac_out(mac_out)
    );

    // Clock generation (10 ns period)
    always #5 clk = ~clk;

    initial begin
    
        // Initialize
        clk = 0;
        reset = 1;
        enable = 0;
        A = 0;
        B = 0;

        // Hold reset for a bit
        #20;
        reset = 0;
        enable = 1;

        // Test sequence
        // Cycle 1
        A = 8'd2; B = 8'd3;   // product = 6
        #10;

        // Cycle 2
        A = 8'd4; B = 8'd5;   // product = 20
        #10;

        // Cycle 3
        A = 8'd6; B = 8'd7;   // product = 42
        #10;

        // Cycle 4
        A = 8'd10; B = 8'd3;  // product = 30
        #10;

        // Cycle 5
        A = 8'd8; B = 8'd9;   // product = 72
        #10;

        // Stop simulation
        enable = 0;
        #20;

        $finish;
    end

endmodule
