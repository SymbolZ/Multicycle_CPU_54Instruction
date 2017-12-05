`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/21/2017 04:06:09 PM
// Design Name: 
// Module Name: mem
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
// Create Date: 11/22/2016 07:54:56 PM
// Design Name: 
// Module Name: ram
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


module mem (      
      input clk,   //存储器时钟信号，上升沿时�? ram 内部写入数据
      input wena, //存储器读写有效信号，高电平为写有效，低电平为读有效，�? ena 同时有效时才可对存储器进行读�? 
      input [11:0] addr,       //输入地址，指定数据读写的地址      
      input [31:0] data_in,  //存储器写入的数据，在 clk 上升沿时被写�?      
      output reg [31:0] data_out //存储器读出的数据�?  
);
    integer i ;
    reg [31:0]r[0:4096];
    initial 
        begin


        for(i = 0;i<4096; i = i+1)
        begin
            r[i] = 0;
        end
        /*r[1500] = 32'h2000ffff;
        r[1501] = 32'h2000ffff;
        r[1502] = 32'h2000ffff;
        r[1503] = 32'h2000ffff;
        r[1504] = 32'h42000018;*/
        $readmemh("C:/VivadoProject/mips_54_mars_switch_student.txt",r);

        end
    always @(negedge clk)
    begin
        if(wena)
            r[addr] <= data_in ;            
    end
    always @(*)
    begin
        if( ~wena)
            data_out<=r[addr];
    end
endmodule

