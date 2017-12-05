`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/13/2017 12:59:19 PM
// Design Name: 
// Module Name: MULT
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


module MULTU(
	input start,
    input clk, // 乘法器 时钟信号 时钟信号
    input reset,
    input [31:0] a, // 输入 a(被乘数 被乘数 )
    input [31:0] b, // 输入 b(乘数 )
    output [63:0] z, // 乘积输出 z
	output reg busy
) ;

reg [5:0]counter =0;
reg [63:0]rz;
assign z = rz;
always@(clk)
    begin
    if(reset)
        begin
        rz=0;
        end
    else if(start)
        begin
        rz=0;
        rz[31:0] = a;
        busy = 1;
        end
	else if(busy)
		begin
        //if(rz[0])
		//	rz[63:32]= rz[63:32]+b;
        //rz={rz[31],rz[31:1]};
		counter = counter + 1;
		if(counter == 15)//32次
		    begin
		    busy = 0;
		    rz = a*b;
		    end
		end
    end
endmodule
