`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/21/2017 07:07:08 PM
// Design Name: 
// Module Name: alu_z
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


module alu_z(
    input clk,
    input ena,
    input [31:0]alu_out,
    output reg [31:0]alu_z_out
    );
    always@(*)
        begin
        if(ena)
            alu_z_out<=alu_out;
        end
endmodule
