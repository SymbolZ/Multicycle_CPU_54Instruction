`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2017 02:58:05 PM
// Design Name: 
// Module Name: ext1
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


module ext1(
    input negative,
    input carry,
    input mode,
    output [31:0]data_out
    );
    assign data_out = {31'b0,(negative&mode) | (carry&~mode) };
endmodule
