`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/28/2017 11:57:41 AM
// Design Name: 
// Module Name: B_H_W_MUX
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


module LB_H_W_MUX(
    input sign,
    input [1:0]select,
    input [31:0]mem_data,
    input [31:0]mem_addr,
    output reg [31:0]data_out
    );
    always@(*)
    begin
        if(select == 3)
        begin
            data_out = mem_data;
        end
        if(select == 2)
        begin
             if(mem_addr[1] == 1)
                data_out[15:0] = mem_data[31:16];
             else
                data_out[15:0] = mem_data[15:0];
             data_out[31:16] ={ sign&data_out[15],sign&data_out[15],
             sign&data_out[15],sign&data_out[15],
             sign&data_out[15],sign&data_out[15],
             sign&data_out[15],sign&data_out[15],
             sign&data_out[15],sign&data_out[15],
             sign&data_out[15],sign&data_out[15],
             sign&data_out[15],sign&data_out[15],
             sign&data_out[15],sign&data_out[15]};

        end
        if(select == 1)
        begin
            case(mem_addr[1:0])
            2'b00:
            begin
                data_out[7:0] =  mem_data[7:0];
            end
            2'b01:
            begin
                data_out[7:0] =  mem_data[15:8];
            end
            2'b10:
            begin
                data_out[7:0] =  mem_data[23:16];
            end
            2'b11:
            begin
                data_out[7:0] =  mem_data[31:24];
            end
            endcase
            data_out[31:8] ={ 
            sign&data_out[7],sign&data_out[7],
            sign&data_out[7],sign&data_out[7],//2
            sign&data_out[7],sign&data_out[7],
            sign&data_out[7],sign&data_out[7],//4
            sign&data_out[7],sign&data_out[7],
            sign&data_out[7],sign&data_out[7],//6
            sign&data_out[7],sign&data_out[7],
            sign&data_out[7],sign&data_out[7],//8
            sign&data_out[7],sign&data_out[7],
            sign&data_out[7],sign&data_out[7],//10
            sign&data_out[7],sign&data_out[7],
            sign&data_out[7],sign&data_out[7]};
        end
    end
endmodule
