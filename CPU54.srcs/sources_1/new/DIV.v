`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/24/2017 06:36:51 PM
// Design Name: 
// Module Name: DIV
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
// Create Date: 03/21/2017 09:32:33 PM
// Design Name: 
// Module Name: DIV
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


module DIV( 
    input [31:0]dividend,        //������
    input [31:0]divisor,          //����
    input start,                //������������
    input clock,      
    input reset,      
    output [31:0]q,             //��
    output [31:0]r,             //����
    output reg busy = 0               //������æ��־λ
); 
    reg [63:0]temp_a;
    reg [31:0]r_divisor;
    reg [5:0]counter =0;
    reg q_sign;//�̵ķ��ű�־��0Ϊ����1Ϊ��
    
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
            if(divisor[31] == 0 && dividend[31] == 0)
                begin
                r_divisor = divisor;
                temp_a[31:0] = dividend;
                q_sign = 0;
                end
            else if(divisor[31] == 0 && dividend[31] == 1)
                begin
                r_divisor = divisor;
                temp_a[31:0] = -dividend;
                q_sign = 1;
                end
            else if(divisor[31] == 1 && dividend[31] == 0)
                begin
                r_divisor = -divisor;
                temp_a[31:0] = dividend;
                q_sign = 1;
                end
            else
                begin
                r_divisor = -divisor;
                temp_a[31:0] = -dividend;
                q_sign = 0;
                end
            temp_a[63:32] = 0;
            end
        else if(busy)
            begin
            temp_a = temp_a<<1;
            if(temp_a[63:32]>=r_divisor)
                begin
                temp_a[63:32] = temp_a[63:32] - r_divisor;
                temp_a[31:0] = temp_a[31:0] + 1;
                end
            counter = counter +1;
            if(counter ==32)//32��
                begin
                busy = 0;
                if(q_sign)
                    temp_a[31:0] = -temp_a[31:0];
                if(dividend[31]==1)
                    temp_a[63:32] = - temp_a[63:32];
                end
            end
        end
    end
endmodule