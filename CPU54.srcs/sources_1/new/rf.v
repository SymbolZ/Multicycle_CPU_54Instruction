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
    input clk,    //�Ĵ�����ʱ���źţ��½���д������
    input rst,      //reset �źţ��ߵ�ƽʱȫ���Ĵ�������
    input we,        //д��Ч�źţ��ߵ�ƽʱ�Ĵ������ܱ�д��
    input [4:0] raddr1,    //�����ȡ�ļĴ����ĵ�ַ
    input [4:0] raddr2,    //�����ȡ�ļĴ����ĵ�ַ
    input [4:0] waddr,    //д�Ĵ����ĵ�ַ
    input [31:0] wdata, //д�Ĵ�������
    output [31:0] rdata1, //raddr1 ����Ӧ�Ĵ�����������ݣ�
    //ֻҪ�� raddr1 �����뼴�����Ӧ����
    output [31:0] rdata2,    //raddr2 ����Ӧ�Ĵ������������
    //ֻҪ�� raddr2 �����뼴�����Ӧ����
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
                          //�������пɻ���$readmemh("D://init.txt",mem);
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