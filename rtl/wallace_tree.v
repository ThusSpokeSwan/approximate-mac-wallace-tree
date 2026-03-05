`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Project: Approximate MAC using Wallace Tree Multiplier
// Author: Hans Raj
// Create Date: 04.03.2026 00:23:21
// Module: wallace_tree
// Description:
// 8x8 Wallace tree multiplier implementing hybrid partial product reduction.
// Columns 0–7 use approximate full adders, while higher columns use exact
// adders to limit numerical error.
//
//////////////////////////////////////////////////////////////////////////////////

module wallace_tree(
    input wire [7:0] A,
    input wire [7:0] B,
    output wire [15:0] product
    );
    
    wire [7:0] pp [7:0];
    wire [15:0] rowA;
    wire [15:0] rowB;
    
    genvar i, j;
    
    generate
        for (i = 0; i < 8; i = i + 1) begin : row
            for (j = 0; j < 8; j = j + 1) begin : col
               assign pp[i][j] = A[j] & B[i];
           end
       end
   endgenerate
   
   // Column 0
   assign product[0] = pp[0][0];
   
   // Column 1
   exact_HA HA_L1_C1 (
    .A(pp[0][1]),
    .B(pp[1][0]),
    .S(s1_1_0),
    .Cout(c1_2_0)
   );
   
   // Column 2
   approx_FA FA_L1_C2 (
    .A(pp[0][2]),
    .B(pp[1][1]),
    .C(pp[2][0]),
    .S(s1_2_0),
    .Cout(c1_3_0)
   );
   
   // Column 3
   approx_FA FA_L1_C3_0 (
    .A(pp[0][3]),
    .B(pp[1][2]),
    .C(pp[2][1]),
    .S(s1_3_0),
    .Cout(c1_4_0)
   );
   
   approx_FA FA_L1_C3_1 (
    .A(pp[3][0]),
    .B(c1_2_0),
    .C(c1_3_0),
    .S(s1_3_1),
    .Cout(c1_4_1)
   );
   
   // Column 4
   approx_FA FA_L1_C4_0 (
    .A(pp[0][4]),
    .B(pp[1][3]),
    .C(pp[2][2]),
    .S(s1_4_0),
    .Cout(c1_5_0)
   );
   
   approx_FA FA_L1_C4_1 (
    .A(pp[3][1]),
    .B(pp[4][0]),
    .C(c1_4_0),
    .S(s1_4_1),
    .Cout(c1_5_1)
   );
   
   approx_FA FA_L2_C4_0 (
    .A(s1_4_0),
    .B(s1_4_1),
    .C(c1_4_1),
    .S(s2_4_0),
    .Cout(c2_5_0)
   );
   
   // Column 5
   approx_FA FA_L1_C5_0 (
    .A(pp[0][5]),
    .B(pp[1][4]),
    .C(pp[2][3]),
    .S(s1_5_0),
    .Cout(c1_6_0)
   );
   
   approx_FA FA_L1_C5_1 (
    .A(pp[3][2]),
    .B(pp[4][1]),
    .C(pp[5][0]),
    .S(s1_5_1),
    .Cout(c1_6_1)
   );
   
   approx_FA FA_L1_C5_2 (
    .A(c1_5_0),
    .B(c1_5_1),
    .C(c2_5_0),
    .S(s1_5_2),
    .Cout(c1_6_2)
   );
   
   approx_FA FA_L2_C5_0 (
    .A(s1_5_0),
    .B(s1_5_1),
    .C(s1_5_2),
    .S(s2_5_0),
    .Cout(c2_6_0)
   );
   
   // Column 6
   approx_FA FA_L1_C6_0 (
    .A(pp[0][6]),
    .B(pp[1][5]),
    .C(pp[2][4]),
    .S(s1_6_0),
    .Cout(c1_7_0)
   );
   
   approx_FA FA_L1_C6_1 (
    .A(pp[3][3]),
    .B(pp[4][2]),
    .C(pp[5][1]),
    .S(s1_6_1),
    .Cout(c1_7_1)
   );
   
   approx_FA FA_L1_C6_2 (
    .A(pp[6][0]),
    .B(c1_6_0),
    .C(c1_6_1),
    .S(s1_6_2),
    .Cout(c1_7_2)
   );
   
   exact_HA HA_L1_C6_0 (
    .A(c1_6_2),
    .B(c2_6_0),
    .S(s1_6_3),
    .Cout(c1_7_3)
   );
   
   exact_HA HA_L2_C6_0 (
    .A(s1_6_0),
    .B(s1_6_1),
    .S(s2_6_0),
    .Cout(c2_7_0)
   );
   
   exact_HA HA_L2_C6_1 (
    .A(s1_6_2),
    .B(s1_6_3),
    .S(s2_6_1),
    .Cout(c2_7_1)
   );
   
   // Column 7
   approx_FA FA_L1_C7_0 (
    .A(pp[0][7]),
    .B(pp[1][6]),
    .C(pp[2][5]),
    .S(s1_7_0),
    .Cout(c1_8_0)
   );
   
   approx_FA FA_L1_C7_1 (
    .A(pp[3][4]),
    .B(pp[4][3]),
    .C(pp[5][2]),
    .S(s1_7_1),
    .Cout(c1_8_1)
   );
   
   approx_FA FA_L1_C7_2 (
    .A(pp[6][1]),
    .B(pp[7][0]),
    .C(c1_7_0),
    .S(s1_7_2),
    .Cout(c1_8_2)
   );
   
   approx_FA FA_L1_C7_3 (
    .A(c1_7_1),
    .B(c1_7_2),
    .C(c1_7_3),
    .S(s1_7_3),
    .Cout(c1_8_3)
   );
   
   exact_HA HA_L1_C7_4 (
    .A(c2_7_0),
    .B(c2_7_1),
    .S(s1_7_4),
    .Cout(c1_8_4)
   );
   
   approx_FA FA_L2_C7_0 (
    .A(s1_7_0),
    .B(s1_7_1),
    .C(s1_7_2),
    .S(s2_7_0),
    .Cout(c2_8_0)
   );
   
   exact_HA HA_L2_C7_1 (
    .A(s1_7_3),
    .B(s1_7_4),
    .S(s2_7_1),
    .Cout(c2_8_1)
   );
   
   // Column 8
   exact_FA FA_L1_C8_0 (
   .A(pp[1][7]),
   .B(pp[2][6]),
   .C(pp[3][5]),
   .S(s1_8_0),
   .Cout(c1_9_0)
   );
   
   exact_FA FA_L1_C8_1 (
   .A(pp[4][4]),
   .B(pp[5][3]),
   .C(pp[6][2]),
   .S(s1_8_1),
   .Cout(c1_9_1)
   );
   
   exact_FA FA_L1_C8_2 (
   .A(pp[7][1]),
   .B(c1_8_0),
   .C(c1_8_1),
   .S(s1_8_2),
   .Cout(c1_9_2)
   );
   
   exact_FA FA_L1_C8_3 (
   .A(c1_8_2),
   .B(c1_8_3),
   .C(c1_8_4),
   .S(s1_8_3),
   .Cout(c1_9_3)
   );
   
   exact_HA HA_L1_C8_0 (
    .A(c2_8_0),
    .B(c2_8_1),
    .S(s1_8_4),
    .Cout(c1_9_4)
   );
   
   exact_FA FA_L2_C8_0 (
   .A(s1_8_0),
   .B(s1_8_1),
   .C(s1_8_2),
   .S(s2_8_0),
   .Cout(c2_9_0)
   );
   
   exact_HA HA_L2_C8_0 (
    .A(s1_8_3),
    .B(s1_8_4),
    .S(s2_8_1),
    .Cout(c2_9_1)
   );
   
   // Column 9
   exact_FA FA_L1_C9_0 (
   .A(pp[2][7]),
   .B(pp[3][6]),
   .C(pp[4][5]),
   .S(s1_9_0),
   .Cout(c1_10_0)
   );
   
   exact_FA FA_L1_C9_1 (
   .A(pp[5][4]),
   .B(pp[6][3]),
   .C(pp[7][2]),
   .S(s1_9_1),
   .Cout(c1_10_1)
   );
   
   exact_FA FA_L1_C9_2 (
   .A(c1_9_0),
   .B(c1_9_1),
   .C(c1_9_2),
   .S(s1_9_2),
   .Cout(c1_10_2)
   );
   
   exact_FA FA_L1_C9_3 (
   .A(c1_9_3),
   .B(c1_9_4),
   .C(c2_9_0),
   .S(s1_9_3),
   .Cout(c1_10_3)
   );
   
   exact_FA FA_L2_C9_0 (
   .A(s1_9_0),
   .B(s1_9_1),
   .C(s1_9_2),
   .S(s2_9_0),
   .Cout(c2_10_0)
   );
   
   exact_HA HA_L2_C9_0 (
    .A(s1_9_3),
    .B(c2_9_1),
    .S(s2_9_1),
    .Cout(c2_10_1)
   );
   
   // Column 10
   exact_FA FA_L1_C10_0 (
   .A(pp[3][7]),
   .B(pp[4][6]),
   .C(pp[5][5]),
   .S(s1_10_0),
   .Cout(c1_11_0)
   );
   
   exact_FA FA_L1_C10_1 (
   .A(pp[6][4]),
   .B(pp[7][3]),
   .C(c1_10_0),
   .S(s1_10_1),
   .Cout(c1_11_1)
   );
   
   exact_FA FA_L1_C10_2 (
   .A(c1_10_1),
   .B(c1_10_2),
   .C(c1_10_3),
   .S(s1_10_2),
   .Cout(c1_11_2)
   );
   
   exact_HA HA_L1_C10_0 (
    .A(c2_10_0),
    .B(c2_10_1),
    .S(s1_10_3),
    .Cout(c1_11_3)
   );
   
   exact_HA HA_L2_C10_0 (
    .A(s1_10_0),
    .B(s1_10_1),
    .S(s2_10_0),
    .Cout(c2_11_0)
   );
   
   exact_HA HA_L2_C10_1 (
    .A(s1_10_2),
    .B(s1_10_3),
    .S(s2_10_1),
    .Cout(c2_11_1)
   );
   
   // Column 11
   exact_FA FA_L1_C11_0 (
   .A(pp[4][7]),
   .B(pp[5][6]),
   .C(pp[6][5]),
   .S(s1_11_0),
   .Cout(c1_12_0)
   );
   
   exact_FA FA_L1_C11_1 (
   .A(pp[7][4]),
   .B(c1_11_0),
   .C(c1_11_1),
   .S(s1_11_1),
   .Cout(c1_12_1)
   );
   
   exact_FA FA_L1_C11_2 (
   .A(c1_11_2),
   .B(c1_11_3),
   .C(c2_11_0),
   .S(s1_11_2),
   .Cout(c1_12_2)
   );
   
   exact_HA HA_L2_C11_0 (
    .A(c2_11_1),
    .B(s1_11_0),
    .S(s2_11_0),
    .Cout(c2_12_0)
   );
   
   exact_HA HA_L2_C11_1 (
    .A(s1_11_1),
    .B(s1_11_2),
    .S(s2_11_1),
    .Cout(c2_12_1)
   );
   
   // Column 12
   exact_FA FA_L1_C12_0 (
   .A(pp[5][7]),
   .B(pp[6][6]),
   .C(pp[7][5]),
   .S(s1_12_0),
   .Cout(c1_13_0)
   );
   
   exact_FA FA_L1_C12_1 (
   .A(c1_12_0),
   .B(c1_12_1),
   .C(c1_12_2),
   .S(s1_12_1),
   .Cout(c1_13_1)
   );
   
   exact_HA HA_L1_C12_2 (
    .A(c2_12_0),
    .B(c2_12_1),
    .S(s1_12_2),
    .Cout(c1_13_2)
   );
   
   exact_FA FA_L2_C12_0 (
   .A(s1_12_0),
   .B(s1_12_1),
   .C(s1_12_2),
   .S(s2_12_0),
   .Cout(c2_13_0)
   );
   
   // Column 13
   exact_FA FA_L1_C13_0 (
   .A(pp[6][7]),
   .B(pp[7][6]),
   .C(c1_13_0),
   .S(s1_13_0),
   .Cout(c1_14_0)
   );
   
   exact_FA FA_L1_C13_1 (
   .A(c1_13_1),
   .B(c1_13_2),
   .C(c2_13_0),
   .S(s1_13_1),
   .Cout(c1_14_1)
   );
   
   // Column 14
   exact_FA FA_L1_C14_0 (
   .A(pp[7][7]),
   .B(c1_14_0),
   .C(c1_14_1),
   .S(s1_14_0),
   .Cout(c1_15_0)
   );
   
   // Row A and Row B
   assign rowA[0] = pp[0][0];
   assign rowB[0] = 1'b0;
   
   assign rowA[1] = s1_1_0;
   assign rowB[1] = 1'b0;
   
   assign rowA[2] = s1_2_0;
   assign rowB[2] = 1'b0;
   
   assign rowA[3] = s1_3_0;
   assign rowB[3] = s1_3_1;
   
   assign rowA[4] = s2_4_0;
   assign rowB[4] = 1'b0;
   
   assign rowA[5] = s2_5_0;
   assign rowB[5] = 1'b0;
   
   assign rowA[6] = s2_6_0;
   assign rowB[6] = s2_6_1;
   
   assign rowA[7] = s2_7_0;
   assign rowB[7] = s2_7_1;
   
   assign rowA[8] = s2_8_0;
   assign rowB[8] = s2_8_1;
   
   assign rowA[9] = s2_9_0;
   assign rowB[9] = s2_9_1;
   
   assign rowA[10] = s2_10_0;
   assign rowB[10] = s2_10_1;
   
   assign rowA[11] = s2_11_0;
   assign rowB[11] = s2_11_1;
   
   assign rowA[12] = s2_12_0;
   assign rowB[12] = 1'b0;
   
   assign rowA[13] = s1_13_0;
   assign rowB[13] = s1_13_1;
   
   assign rowA[14] = s1_14_0;
   assign rowB[14] = 1'b0;
   
   assign rowA[15] = c1_15_0;
   assign rowB[15] = 1'b0;
   
   // Final Product
   assign product = rowA + rowB;
   
   
endmodule
