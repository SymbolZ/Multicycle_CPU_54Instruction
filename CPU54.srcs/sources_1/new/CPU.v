`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2017 02:38:19 PM
// Design Name: 
// Module Name: CPU
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


module CPU(
    (* MARK_DEBUG="true" *) input wire  [15:0]sw,
    (* MARK_DEBUG="true" *) input wire _clk,
    (* MARK_DEBUG="true" *) input wire  reset,
    (* MARK_DEBUG="true" *)output [7:0] o_seg,
    (* MARK_DEBUG="true" *)output [7:0] o_sel

    //output [31:0]cpu_out_inst,
    //output [31:0]cpu_out_pc,
    //output [31:0]cpu_out_alu,
    //output finish_instr

    //output [15:0]cpu_28
    );
  //wire finish_instr;
  wire [31:0]rt;
  wire mem_mux_select;
  wire seg7_cs;
  wire [31:0]alu_out;
  wire[31:0] mem_addr;    
  wire[31:0] rdata;    
  wire switch_cs;
  wire [31:0]mem_out;
  wire mem_r_w;

  io_sel io_mem(alu_out,  mem_mux_select ,mem_r_w,~mem_r_w,seg7_cs,switch_cs);
  
  //seg7x16 seg7(clk,reset,seg7_cs,rt,o_seg,o_sel);
  seg7x16 seg7(clk,reset,seg7_cs,bhw_out,o_seg,o_sel);

  sw_mem_sel sw_mem  (switch_cs,sw,mem_out,rdata);
  clk_2 CLK
     (
     // Clock in ports
      .clk_in1(_clk),      // input clk_in1
      // Clock out ports
      .clk_out1(clk),     // output clk_out1
      // Status and control signals
      .reset(reset)// input reset
    );  
    reg [31:0]ini_pc =  32'h00400000;  
    wire pcreg_ena;
    wire i_ram_ena;
    wire i_ram_wena;
    wire d_ram_ena;
    wire d_ram_wena;
    wire rf_we;
    wire [4:0]rf_waddr;
    wire [4:0]rf_raddr1;
    wire [4:0]rf_raddr2;
    wire [3:0]rf_wdata_mux;
    wire wext1;
    wire wext1_mode;
    wire wext5;
    wire wext5_mux;
    wire wext16;
    wire wext16_s_uns;
    wire wext18;
    wire AcatB;
    wire [3:0]alu_aluc;    
    wire [1:0]alu_a_mux;    
    wire [2:0]alu_b_mux;    
    wire [1:0]pc_mux;
    wire exception;

    wire [31:0]inst_addr;
    wire [5:0]instruction;
    wire [31:0]im_inst_out;
    wire mfc0;
    wire mtc0;
    wire erec;
    inst_decoder id(im_inst_out[31:26],im_inst_out[25:21],im_inst_out[20:16],im_inst_out[5:0],instruction,mfc0,mtc0,erec);
    
    wire alu_zero;
    wire alu_carry;
    wire alu_negative;
    wire alu_overflow;
    wire z_change;
    wire add_finish;

    wire ir_ena;
    wire alu_z_ena;
    wire clz_ena;
    wire Hiwena;
    wire [1:0]Hiselect;
    wire Lowena;
    wire [1:0]Loselect;
    wire div_start;
    wire [1:0]bhw_select;
    wire [1:0]lbhw_select;
    wire lbhw_sign;
    wire mulu_start;
    wire [4:0]CP0_ADDR;
    wire [3:0]cause;//??
    wire eret;
    CU cu(reset,im_inst_out,instruction,clk,
    alu_zero,alu_carry,alu_negative,alu_overflow,
    status[3:0],eret,exception,cause,
    lbhw_sign,lbhw_select,bhw_select,div_start,mul_start,mulu_start,
    Hiwena,Hiselect,Lowena,Loselect,
    clz_ena,alu_z_ena,ir_ena,mem_mux_select,pcreg_ena,mem_r_w,//mem_r_wΪ��д���� 
    rf_we,rf_waddr,rf_raddr1,rf_raddr2,rf_wdata_mux,
    wext1,wext1_mode,wext5,wext5_mux,wext16,wext16_s_uns,wext18,AcatB,
    alu_aluc,alu_a_mux,alu_b_mux,pc_mux,CP0_ADDR,finish_instr);
    
    wire [31:0]clz_out;
    wire [31:0]rs;
    CLZ clz(clk,clz_ena,rs,clz_out);
    
    wire[31:0]pc_out;
    wire ready;
    wire[31:0] mux_to_pc;
    PC pc(clk,reset,ini_pc,mux_to_pc,pcreg_ena,pc_out);
    
    wire [31:0]im_data;//�����ź�
    

    wire [31:0]alu_z_out;
    MUX_2_32 mem_mux(
    mem_mux_select,
    (pc_out-4194304)/4,
    alu_z_out/4+2048
    ,mem_addr);

    
    
    wire [31:0]bhw_out;

    B_H_W_MUX b_h_w_mux(
        bhw_select,
        rt,
        //rdata,
        mem_out,
        alu_z_out,
        bhw_out
    );
    
    wire mem_r_w_select;
    assign mem_r_w_select = mem_r_w && (mem_addr[31] == 0);//=1ʱ,дmem,���� vram
    mem MEM(      
    .clk(clk),   //存储器时钟信号，上升沿时�? ram 内部写入数据
    .wena(mem_r_w_select), //存储器读写有效信号，高电平为写有效，低电平为读有效，�? ena 同时有效时才可对存储器进行读�? 
    .addr(mem_addr),       //输入地址，指定数据读写的地址      
    .data_in(bhw_out),  //存储器写入的数据，在 clk 上升沿时被写�?      
    .data_out(mem_out) //存储器读出的数据�?  
            );
   /*dmem mem (
       .a(mem_addr),      // input wire [11 : 0] a
       .d(bhw_out),      // input wire [31 : 0] d
       .clk(clk),  // input wire clk
       .we(mem_r_w),    // input wire we
       .spo(mem_out)  // output wire [31 : 0] spo
        );   */
    ir IR(
    .clk(clk),
    .wean(ir_ena),
    .inst(mem_out),
    .ir_out(im_inst_out)
    );


    wire [31:0]AcatB_to_mux;
    wire [31:0]ext18_out;
    wire [31:0]ext16_out;
    wire [4:0]ext5_in;

    wire [31:0]ext5_out;
    ext18 e18(im_inst_out[15:0],ext18_out);
    ext16 e16(im_inst_out[15:0],wext16_s_uns,ext16_out);
   
    MUX_2 mux_ext5(wext5_mux,im_inst_out[25:21],im_inst_out[10:6],ext5_in);
    ext5 e5(ext5_in,ext5_out);
    
    AcatB acb(pc_out[31:28],im_inst_out[25:0],AcatB_to_mux);
    
    wire [31:0]exc_addr;//??
    MUX_4 mux_pc(
            pc_mux,//select
            rs,
            alu_z_out,
            AcatB_to_mux,
            exc_addr,//ʵ��ADDģ�鹦��
            mux_to_pc);//outXS
            
    wire [31:0]alu_a;
    wire [31:0]alu_b;
    MUX_4 alu_mux_a(
    alu_a_mux,//select
    ext5_out,
    rs,
    im_inst_out,
    pc_out,
    alu_a
    );
  
    MUX_8 alu_mux_b(
    alu_b_mux,//select
    rt,//1
    ext16_out,
    32'd4,//3
    ext18_out,
    32'h0,//5
    32'hz,
    32'hz,//7
    32'hz,
    alu_b
    );  
    

    wire [31:0]ext1_out;
    ext1 e1(
    alu_negative ,
    alu_carry,
    wext1_mode,
    ext1_out
    );
    
    wire [31:0]multu_hi;
    wire [31:0]multu_lo;
    MULTU multu(
    mulu_start,
    clk,
    reset,
    rs,
    rt,
    {multu_hi,multu_lo}
    );
    
    wire [31:0]mul_hi;
    wire [31:0]mul_lo;
    MULT mult(
    mul_start,
    clk,
    reset,
    rs,
    rt,
    {mul_hi,mul_lo}
    );
    
    
    wire div_busy;
    wire [31:0]divu_q;
    wire [31:0]div_q;
    wire [31:0]divu_r;
    wire [31:0]div_r;
    
    DIV div(
        rs,
        rt,
        div_start,
        clk,
        reset,
        div_q,
        div_r,
        div_busy
    );

    DIVU divu(
        rs,
        rt,
        div_start,
        clk,
        reset,
        divu_q,
        divu_r,
        divu_busy
    );
    wire [31:0]hi_out;
    wire [31:0]lo_out;
    LoHi hi(
    clk,
    Hiwena,
    Hiselect,
    divu_r,
    div_r,
    multu_hi,
    rs,
    hi_out
    );
    
    LoHi lo(
    clk,
    Lowena,
    Loselect,
    divu_q,
    div_q,
    multu_lo,
    rs,
    lo_out
    );
    wire [31:0]cp0_rdata;
    wire [31:0]status;//??
    CP0 cp0(
        clk,
        reset,
        mfc0,
        mtc0,
        pc_out-4,
        CP0_ADDR,
        rt,
        exception,
        eret,
        cause,
        cp0_rdata,
        status,
        exc_addr
    );
    wire [31:0]lbhwout;
    LB_H_W_MUX lb_h_w_mux(
    lbhw_sign,
    lbhw_select,
    rdata,
    //mem_out,
    alu_z_out,
    lbhwout
    );
    wire [31:0]rf_in;
    MUX_9 RFMUX(
    rf_wdata_mux,//select
    ext1_out,
    lbhwout,//im_inst_out
    alu_z_out,
    pc_out,
    clz_out,
    hi_out,
    lo_out,
    mul_lo,
    cp0_rdata,
    rf_in
    );
    
    wire rf_rst;

    Regfiles rf(
     clk,    //�Ĵ�����ʱ���źţ��½���д������      
     reset,    //reset �źţ��ߵ�ƽʱȫ���Ĵ�������      
     rf_we,     //�Ĵ�����д��Ч�źţ��ߵ�ƽʱ����Ĵ���д�����ݣ� �͵�ƽʱ����Ĵ�����������      
     rf_raddr1,  //�����ȡ�ļĴ����ĵ�ַ      
     rf_raddr2,  //�����ȡ�ļĴ����ĵ�ַ      
     rf_waddr,   //д�Ĵ����ĵ�ַ      
     rf_in, //д�Ĵ������ݣ������� clk �½���ʱ��д��      
     rs, //raddr1 ����Ӧ�Ĵ������������      
     rt,  //raddr2 ����Ӧ�Ĵ������������ 
     cpu_28
    );
    alu_z ALU_Z(
        .clk(clk),
        .ena(alu_z_ena),
        .alu_out(alu_out),
        .alu_z_out(alu_z_out)
        );
    alu ALU(   
        alu_a,    //32 λ���룬������ 1 
        alu_b,    //32 λ���룬������ 2 
        alu_aluc, //4 λ���룬���� alu �Ĳ��� 
        alu_out,   //32 λ������� a��b ���� aluc ָ���Ĳ������� 
        alu_zero,        //0 ��־λ 
        alu_carry,       // ��λ��־λ 
        alu_negative,   // ������־λ 
        alu_overflow  // �����־λ 
    );
    
    assign cpu_out_inst = im_inst_out;
    assign cpu_out_pc = pc_out;
    assign cpu_out_alu = alu_out;
endmodule
