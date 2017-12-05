`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2017 03:54:21 PM
// Design Name: 
// Module Name: IMEM
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


module IMEM(
    input [31:0]addr,
    input [31:0]r_mem_data,
    input ena,
    input wena,
    output reg [31:0]inst_o,
    output reg [31:0]mem_addr
    );
    reg [31:0]inst;
    always@(*)
        begin
        if(ena)
            begin
            if(wena)    
                begin
                mem_addr = addr;
                inst=r_mem_data;
                end
            inst_o = inst;
            end
        else
            inst_o=32'bz;
        end

endmodule
