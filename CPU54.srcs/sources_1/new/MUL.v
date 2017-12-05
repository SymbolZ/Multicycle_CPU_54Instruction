

`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/13/2017 11:05:37 AM
// Design Name: 
// Module Name: MULTU
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

module MULT(
    input start,                //�����˷�����
    input clk, // �˷��� ʱ���ź� ʱ���ź�
    input reset,
    input [31:0] a, // ���� a(������ ������ )
    input [31:0] b, // ���� b(���� )
    output [63:0] z, // �˻���� z
    output reg busy = 0               //������æ��־λ

);
    parameter n_bits =32;
    reg [5:0]counter =0;

//��������a b
    reg [63:0]rz = 0;
    reg flag = 0;
    always@(posedge clk)
        begin
            if(reset)
                begin
                rz<=0;
                end
            else if(start)
				begin
                rz[63:32]=0;
                rz[31:0]=b;
                flag = 0;
				busy = 1;
				counter = 0;
				end
			else if(busy)
                begin
                    
                        case({rz[0],flag})
                            2'b00:
                                begin
                                //do nothing
                                end
                            2'b11:
                               begin
                               //do nothing
                               end
                            2'b01:
                              begin
                               rz[63:32]=  rz[63:32] + a;
                              end
                            2'b10:
                              begin
                               rz[63:32]=  rz[63:32] - a ;
                              end
                       endcase
                       
                       //��������
                       flag = rz[0];
                       rz = {rz[63],rz[63:1]};
						counter = counter +1;
						if(counter == 32)//32��
							busy = 0;
                end
        end
    assign z = rz;
endmodule
