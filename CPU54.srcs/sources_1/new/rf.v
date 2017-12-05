`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2017 08:59:35 AM
// Design Name: 
// Module Name: Regfiles
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


module Regfiles(
    input clk,    //寄存器组时钟信号，下降沿写入数据
    input rst,      //reset 信号，高电平时全部寄存器置零
    input we,        //写有效信号，高电平时寄存器才能被写入
    input [4:0] raddr1,    //所需读取的寄存器的地址
    input [4:0] raddr2,    //所需读取的寄存器的地址
    input [4:0] waddr,    //写寄存器的地址
    input [31:0] wdata, //写寄存器数据
    output [31:0] rdata1, //raddr1 所对应寄存器的输出数据，
    //只要有 raddr1 的输入即输出相应数据
    output [31:0] rdata2,    //raddr2 所对应寄存器的输出数据
    //只要有 raddr2 的输入即输出相应数据
    output [15:0] r28
);
    reg [31:0] mem [31:0]; 
    integer k;
    always @ (posedge rst,negedge clk)
    begin
        if(rst)
            begin
                for(k=0;k<32;k=k+1)
                    mem[k]<=32'h00000000;
                end
                          //以上三行可换成$readmemh("D://init.txt",mem);
        else
            begin
                if(we && waddr!=0)
                    begin
                        mem[waddr]<=wdata;
                    end
            end
    end
    assign r28 = mem[28][15:0];
    assign rdata1=mem[raddr1];
    assign rdata2=mem[raddr2];
endmodule