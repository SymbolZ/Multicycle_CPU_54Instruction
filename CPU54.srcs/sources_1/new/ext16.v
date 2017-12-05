`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2017 03:07:31 PM
// Design Name: 
// Module Name: ext16
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


module ext16(
    input [15:0]data_in,
    input s,//signed or not
    output [31:0]data_out
);
    assign data_out = {s&data_in[15],
    s&data_in[15],s&data_in[15],
    s&data_in[15],s&data_in[15],
    s&data_in[15],s&data_in[15],
    s&data_in[15],s&data_in[15],
    s&data_in[15],s&data_in[15],
    s&data_in[15],s&data_in[15],
    s&data_in[15],s&data_in[15],
    s&data_in[15],data_in};
endmodule
