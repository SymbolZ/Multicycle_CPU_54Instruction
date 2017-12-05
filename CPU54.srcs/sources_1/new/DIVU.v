`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/24/2017 06:38:45 PM
// Design Name: 
// Module Name: DIVU
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

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/19/2017 10:19:51 PM
// Design Name: 
// Module Name: DIVU
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

module DIVU( 
    input [31:0]dividend,        //������
    input [31:0]divisor,          //����
    input start,                //������������
    input clock,      
    input reset,      
    output  [31:0]q,             //��      
    output  [31:0]r,             //����         
    output reg busy               //������æ��־λ      
    ); 
    reg [63:0]temp_a;
    reg [5:0]counter =0;
    assign q = temp_a[31:0];
    assign r = temp_a[63:32];
    always@(posedge clock)
        begin
        if(reset)
            begin
            temp_a = 0;
            busy = 0;
            end
        else
            begin
            if(start)//��ʼ��
                begin
                temp_a  = 0;
                busy = 1;
                counter = 0;
                temp_a[31:0] = dividend;
                temp_a[63:32] = 0;
                end
            else if(busy)
                begin
                temp_a = temp_a<<1;
                if(temp_a[63:32]>=divisor)
                    begin
                    temp_a[63:32] = temp_a[63:32] - divisor;
                    temp_a[31:0] = temp_a[31:0] + 1;
                    end
                counter = counter +1;
                if(counter ==32)//32��
                    busy = 0;
                end
            end
        end
endmodule 

