`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2017 03:35:30 PM
// Design Name: 
// Module Name: PC
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


module PC(
    input clk,
    input rst,
    input [31:0]ini_addr,
    input [31:0]addr,
    input wena,
    output [31:0]o_addr
    );
    reg [31:0]proc = 32'h00400000;  
    assign o_addr = proc;
    always@(negedge clk)
        begin
        if(rst)
            proc <=ini_addr;
        else
        begin
            if(wena)
                proc <= addr;
        end
        end
endmodule
