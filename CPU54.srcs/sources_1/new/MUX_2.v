`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2017 03:32:00 PM
// Design Name: 
// Module Name: MUX_2
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


module MUX_2(
    input select,
    input [4:0]i1,
    input [4:0]i2,
    output reg [4:0]o
    );
    always@(*)
        begin
        case(select)
            1'b0:  o <=  i1;
            1'b1:  o <=  i2;
        endcase
        end
endmodule