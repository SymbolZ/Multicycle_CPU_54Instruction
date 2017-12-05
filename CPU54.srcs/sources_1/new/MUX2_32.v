`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/21/2017 04:18:19 PM
// Design Name: 
// Module Name: MUX2_32
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


module MUX_2_32(
    input select,
    input [31:0]i1,
    input [31:0]i2,
    output reg [31:0]o
    );
    always@(*)
        begin
        case(select)
            1'b0:  o <=  i1;
            1'b1:  o <=  i2;
        endcase
        end
endmodule
