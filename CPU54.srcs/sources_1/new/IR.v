`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/21/2017 06:09:48 PM
// Design Name: 
// Module Name: IR
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


module ir(
    input clk,
    input wean,
    input [31:0]inst,
    output [31:0]ir_out
    );
    reg [31:0]register;
    always@(posedge clk)
        begin
        if(wean)
            begin
            register = inst;
            end
        end
    assign ir_out = register;
endmodule
