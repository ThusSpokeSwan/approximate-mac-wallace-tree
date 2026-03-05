`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.03.2026 14:54:37
// Design Name: 
// Module Name: tb_dump_results
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


module tb_dump_results;

reg [7:0] A;
reg [7:0] B;

wire [15:0] approx_product;

integer i,j;
integer file;

wallace_tree uut(
    .A(A),
    .B(B),
    .product(approx_product)
);

initial begin

file = $fopen("results.txt","w");

for(i=0;i<256;i=i+1) begin
    for(j=0;j<256;j=j+1) begin

        A = i;
        B = j;

        #1; // allow combinational logic to settle

        $fwrite(file,"%d %d %d\n",A,B,approx_product);

    end
end

$fclose(file);

$display("Finished writing results");

$finish;

end

endmodule
