`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2017 03:42:49 PM
// Design Name: 
// Module Name: AcatB
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


module AcatB(
    input [3:0]addr,
    input [25:0]IM_25_0,
    output [31:0]addr_o
    );
    assign addr_o = {addr,IM_25_0,2'b0};

endmodule
