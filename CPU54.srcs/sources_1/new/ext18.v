`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2017 03:17:10 PM
// Design Name: 
// Module Name: ext18
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


module ext18(
    input [15:0]data_in,
    output [31:0]data_out
);
assign data_out = {data_in[15],data_in[15],
                data_in[15],data_in[15],
                data_in[15],data_in[15],
                data_in[15],data_in[15],
                data_in[15],data_in[15],
                data_in[15],data_in[15],
                data_in[15],data_in[15],
                data_in,2'b0};
endmodule
