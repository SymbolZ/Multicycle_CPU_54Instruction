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


module B_H_W_MUX(
    input [1:0]select,
    input [31:0]rt,
    input [31:0]mem_data,
    input [31:0]mem_addr,
    output reg [31:0]data_out
    );
    always@(*)
    begin
        if(select == 3)
        begin
            data_out = rt;
        end
        if(select == 2)
        begin
            if(mem_addr[1] == 1)
                 data_out ={ rt[15:0],mem_data[15:0]};
            if(mem_addr[1] == 0)
                 data_out ={ mem_data[31:16],rt[15:0]};
        end
        if(select == 1)
        begin
           if(mem_addr[1:0] == 0)
              data_out ={ mem_data[31:8],rt[7:0]};
         if(mem_addr[1:0] == 1)
              data_out ={ mem_data[31:15],rt[7:0],mem_data[7:0]};
         if(mem_addr[1:0] == 2)
              data_out ={ mem_data[31:24],rt[7:0],mem_data[15:0]};
         if(mem_addr[1:0] == 3)
              data_out ={ rt[7:0],mem_data[23:0]};
        end
    end
endmodule
