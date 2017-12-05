`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2016 08:35:35 PM
// Design Name: 
// Module Name: selector41
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

module MUX_4(
					input [1:0]iS,
					input [31:0] iC0,   //四位输入信号 c0 
                    input [31:0] iC1,   //四位输入信号 c1 
                    input [31:0] iC2,   //四位输入信号 c2 
                    input [31:0] iC3,   //四位输入信号 c3 
                    output [31:0] oZ    //四位输出信号 z 
                    ); 
    assign oZ[0]=~iS[0]&&~iS[1]&&iC0[0] || iS[0]&&~iS[1]&&iC1[0] || ~iS[0]&&iS[1]&&iC2[0] || iS[0]&&iS[1]&&iC3[0];
    assign oZ[1]=~iS[0]&&~iS[1]&&iC0[1] || iS[0]&&~iS[1]&&iC1[1] || ~iS[0]&&iS[1]&&iC2[1] || iS[0]&&iS[1]&&iC3[1];
    assign oZ[2]=~iS[0]&&~iS[1]&&iC0[2] || iS[0]&&~iS[1]&&iC1[2] || ~iS[0]&&iS[1]&&iC2[2] || iS[0]&&iS[1]&&iC3[2];
    assign oZ[3]=~iS[0]&&~iS[1]&&iC0[3] || iS[0]&&~iS[1]&&iC1[3] || ~iS[0]&&iS[1]&&iC2[3] || iS[0]&&iS[1]&&iC3[3];
    assign oZ[4]=~iS[0]&&~iS[1]&&iC0[4] || iS[0]&&~iS[1]&&iC1[4] || ~iS[0]&&iS[1]&&iC2[4] || iS[0]&&iS[1]&&iC3[4];
    assign oZ[5]=~iS[0]&&~iS[1]&&iC0[5] || iS[0]&&~iS[1]&&iC1[5] || ~iS[0]&&iS[1]&&iC2[5] || iS[0]&&iS[1]&&iC3[5];
    assign oZ[6]=~iS[0]&&~iS[1]&&iC0[6] || iS[0]&&~iS[1]&&iC1[6] || ~iS[0]&&iS[1]&&iC2[6] || iS[0]&&iS[1]&&iC3[6];
    assign oZ[7]=~iS[0]&&~iS[1]&&iC0[7] || iS[0]&&~iS[1]&&iC1[7] || ~iS[0]&&iS[1]&&iC2[7] || iS[0]&&iS[1]&&iC3[7];
    assign oZ[8]=~iS[0]&&~iS[1]&&iC0[8] || iS[0]&&~iS[1]&&iC1[8] || ~iS[0]&&iS[1]&&iC2[8] || iS[0]&&iS[1]&&iC3[8];
    assign oZ[9]=~iS[0]&&~iS[1]&&iC0[9] || iS[0]&&~iS[1]&&iC1[9] || ~iS[0]&&iS[1]&&iC2[9] || iS[0]&&iS[1]&&iC3[9];
    assign oZ[10]=~iS[0]&&~iS[1]&&iC0[10] || iS[0]&&~iS[1]&&iC1[10] || ~iS[0]&&iS[1]&&iC2[10] || iS[0]&&iS[1]&&iC3[10];
    assign oZ[11]=~iS[0]&&~iS[1]&&iC0[11] || iS[0]&&~iS[1]&&iC1[11] || ~iS[0]&&iS[1]&&iC2[11] || iS[0]&&iS[1]&&iC3[11];
    assign oZ[12]=~iS[0]&&~iS[1]&&iC0[12] || iS[0]&&~iS[1]&&iC1[12] || ~iS[0]&&iS[1]&&iC2[12] || iS[0]&&iS[1]&&iC3[12];
    assign oZ[13]=~iS[0]&&~iS[1]&&iC0[13] || iS[0]&&~iS[1]&&iC1[13] || ~iS[0]&&iS[1]&&iC2[13] || iS[0]&&iS[1]&&iC3[13];
    assign oZ[14]=~iS[0]&&~iS[1]&&iC0[14] || iS[0]&&~iS[1]&&iC1[14] || ~iS[0]&&iS[1]&&iC2[14] || iS[0]&&iS[1]&&iC3[14];
    assign oZ[15]=~iS[0]&&~iS[1]&&iC0[15] || iS[0]&&~iS[1]&&iC1[15] || ~iS[0]&&iS[1]&&iC2[15] || iS[0]&&iS[1]&&iC3[15];
    assign oZ[16]=~iS[0]&&~iS[1]&&iC0[16] || iS[0]&&~iS[1]&&iC1[16] || ~iS[0]&&iS[1]&&iC2[16] || iS[0]&&iS[1]&&iC3[16];
    assign oZ[17]=~iS[0]&&~iS[1]&&iC0[17] || iS[0]&&~iS[1]&&iC1[17] || ~iS[0]&&iS[1]&&iC2[17] || iS[0]&&iS[1]&&iC3[17];
    assign oZ[18]=~iS[0]&&~iS[1]&&iC0[18] || iS[0]&&~iS[1]&&iC1[18] || ~iS[0]&&iS[1]&&iC2[18] || iS[0]&&iS[1]&&iC3[18];
    assign oZ[19]=~iS[0]&&~iS[1]&&iC0[19] || iS[0]&&~iS[1]&&iC1[19] || ~iS[0]&&iS[1]&&iC2[19] || iS[0]&&iS[1]&&iC3[19];
    assign oZ[20]=~iS[0]&&~iS[1]&&iC0[20] || iS[0]&&~iS[1]&&iC1[20] || ~iS[0]&&iS[1]&&iC2[20] || iS[0]&&iS[1]&&iC3[20];
    assign oZ[21]=~iS[0]&&~iS[1]&&iC0[21] || iS[0]&&~iS[1]&&iC1[21] || ~iS[0]&&iS[1]&&iC2[21] || iS[0]&&iS[1]&&iC3[21];
    assign oZ[22]=~iS[0]&&~iS[1]&&iC0[22] || iS[0]&&~iS[1]&&iC1[22] || ~iS[0]&&iS[1]&&iC2[22] || iS[0]&&iS[1]&&iC3[22];
    assign oZ[23]=~iS[0]&&~iS[1]&&iC0[23] || iS[0]&&~iS[1]&&iC1[23] || ~iS[0]&&iS[1]&&iC2[23] || iS[0]&&iS[1]&&iC3[23];
    assign oZ[24]=~iS[0]&&~iS[1]&&iC0[24] || iS[0]&&~iS[1]&&iC1[24] || ~iS[0]&&iS[1]&&iC2[24] || iS[0]&&iS[1]&&iC3[24];
    assign oZ[25]=~iS[0]&&~iS[1]&&iC0[25] || iS[0]&&~iS[1]&&iC1[25] || ~iS[0]&&iS[1]&&iC2[25] || iS[0]&&iS[1]&&iC3[25];
    assign oZ[26]=~iS[0]&&~iS[1]&&iC0[26] || iS[0]&&~iS[1]&&iC1[26] || ~iS[0]&&iS[1]&&iC2[26] || iS[0]&&iS[1]&&iC3[26];
    assign oZ[27]=~iS[0]&&~iS[1]&&iC0[27] || iS[0]&&~iS[1]&&iC1[27] || ~iS[0]&&iS[1]&&iC2[27] || iS[0]&&iS[1]&&iC3[27];
    assign oZ[28]=~iS[0]&&~iS[1]&&iC0[28] || iS[0]&&~iS[1]&&iC1[28] || ~iS[0]&&iS[1]&&iC2[28] || iS[0]&&iS[1]&&iC3[28];
    assign oZ[29]=~iS[0]&&~iS[1]&&iC0[29] || iS[0]&&~iS[1]&&iC1[29] || ~iS[0]&&iS[1]&&iC2[29] || iS[0]&&iS[1]&&iC3[29];
    assign oZ[30]=~iS[0]&&~iS[1]&&iC0[30] || iS[0]&&~iS[1]&&iC1[30] || ~iS[0]&&iS[1]&&iC2[30] || iS[0]&&iS[1]&&iC3[30];
    assign oZ[31]=~iS[0]&&~iS[1]&&iC0[31] || iS[0]&&~iS[1]&&iC1[31] || ~iS[0]&&iS[1]&&iC2[31] || iS[0]&&iS[1]&&iC3[31];


endmodule
