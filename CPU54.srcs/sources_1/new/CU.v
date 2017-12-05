	`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2017 11:20:36 AM
// Design Name: 
// Module Name: CU
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


module CU(
    input rst,
    input [31:0]instruction,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
    input [5:0]inst,
    input clk,
    input z,
    input c,
    input n,
    input o,
    input [3:0]break_off_status,
    output reg eret,
    output reg exception,
    output reg [3:0]cause,
    output reg lbhw_sign,

    output reg[1:0]lbhw_select,

    output reg[1:0]bhw_select,
    output reg div_start,
    output reg mul_start,
    output reg mulu_start,
    output reg Hiwena,
    output reg [1:0]Hiselect,
    output reg Lowena,
    output reg [1:0]Loselect,
    output reg clz_ena,
    output reg alu_z_ena,
    output reg ir_ena,
    output reg mem_mux,
    output reg pcreg_ena,
    output reg ram_wena = 0,//1w 0r
    output reg rf_we,
    output reg[4:0]rf_waddr,
    output reg[4:0]rf_raddr1,
    output reg [4:0]rf_raddr2,
    output reg [3:0]rf_wdata_mux,
    output reg ext1,
    output reg ext1_mode,
    output reg ext5,
    output reg ext5_mux,
    output reg ext16,
    output reg ext16_s_uns,
    output reg ext18,
    output reg AcatB,
    output reg [3:0]alu_aluc,    
    output reg [1:0]alu_a_mux,    
    output reg [2:0]alu_b_mux,    
    output reg [1:0]pc_mux,
    output reg [4:0]CP0_ADDR,

    output reg finish_instr = 0
    );
    
    localparam _ADDI = 1;  
    localparam _ADDIU = 2;  
    localparam _ANDI = 3;  
    localparam _ORI = 4;  
    localparam _SLTIU = 5;  
    localparam _LUI = 6;  
    localparam _XORI = 7;  
    localparam _SLTI = 8;  
    localparam _ADDU = 9;  
    localparam _AND = 10;  
    localparam _BEQ = 11;  
    localparam _BNE = 12;  
    localparam _J = 13;  
    localparam _JAL = 14;  
    localparam _JR = 15;  
    localparam _LW = 16;  
    localparam _XOR = 17;  
    localparam _NOR = 18;  
    localparam _OR = 19; 
    localparam _SLL = 20;  
    localparam _SLLV = 21;  
    localparam _SLTU = 22;  
    localparam _SRA = 23;  
    localparam _SRL = 24;  
    localparam _SUBU = 25;  
    localparam _SW = 26;  
    localparam _ADD = 27;  
    localparam _SUB = 28;  
    localparam _SLT = 29;  
    localparam _SRLV = 30;  
    localparam _SRAV = 31;  
    localparam _CLZ = 32;  
    localparam _DIVU = 33;  
    localparam _ERET = 34;  
    localparam _JALR = 35;  
    localparam _LB = 36;  
    localparam _LBU = 37;  
    localparam _LHU = 38;  
    localparam _SB = 39;  
    localparam _SH = 40;  
    localparam _LH = 41;  
    localparam _MFC0 = 42;  
    localparam _MFHI = 43;  
    localparam _MFLO = 44;  
    localparam _MTC0 = 45;  
    localparam _MTHI = 46;  
    localparam _MTLO = 47;  
    localparam _MUL = 48;  
    localparam _MULTU = 49;  
    localparam _SYSCALL = 50;  
    localparam _TEQ = 51;  
    localparam _BGEZ = 52;  
    localparam _BREAK = 53;  
    localparam _DIV = 54;  
    
    localparam INSTRUCTION_FETCH = 4'b0000;
    localparam DECODER_REGISTER_FETCH = 4'b0001;
    localparam SW_lW_CAL_ADDR= 4'b0010;
    localparam MEM_READ = 4'b0011;
    localparam MEM_WRITE_REG = 4'b0100;
    localparam WRITE_MEM = 4'b0101;
    localparam R_TYPE = 4'b0110;
    localparam R_TYPE_WRITE_REG = 4'b0111;
    localparam B_TYPE = 4'b1000;
    localparam J_TYPE = 4'b1001;
    localparam LOOP = 4'B1010;
    localparam BREAK_OFF= 4'B1011;

    reg [4:0]state;
    reg [5:0]loop_counter;
    reg [5:0]target_num;
    
    always@(posedge clk)
        begin
        if(rst)
            begin
            eret = 0;
            exception = 0;
            ir_ena = 1;
            state = 0;
            mem_mux = 0;
            alu_a_mux = 2'b11;
            alu_b_mux = 3'b010;
            pc_mux = 2'b01;
            pcreg_ena = 1'b0;
            ram_wena = 1'b0;
            alu_aluc=4'b0010;     
            rf_we = 0;
            alu_z_ena = 1;
            end
        else
            begin
            case(state)
                
                INSTRUCTION_FETCH://0
                    begin
                    finish_instr = ~finish_instr;
                    //OPERATION
                    //PC++
                    eret = 0;
                    Hiwena = 0;
                    Lowena = 0;
                    div_start = 0;
                    mul_start = 0;//+
                    mulu_start = 0; //+'
                    clz_ena = 0;
                    pc_mux = 2'b01;
                    rf_we = 0;
                    alu_z_ena = 1;
                    rf_we = 0;
                    ir_ena = 0;
                    mem_mux = 0;
                    alu_a_mux = 2'b11;
                    alu_b_mux = 3'b010;
                    alu_aluc=4'b0010;     
                    pcreg_ena = 1'b1;
                    ram_wena = 1'b0;
                    state = DECODER_REGISTER_FETCH;
                    end
                    
                DECODER_REGISTER_FETCH://1
                    begin
                    //OPERATION
                    alu_z_ena = 1;
                    pcreg_ena = 1'b0;
                    
                    
                    rf_we = 0;
                    ext18 = 1;
                    
                    
                    rf_raddr1=instruction[25:21];
                    rf_raddr2=instruction[20:16];
                    
                    alu_a_mux=2'b01;
                    if(inst == _BGEZ)
                       alu_b_mux = 3'b100;
                    else
                       alu_b_mux = 3'b000;
                    alu_aluc=4'b0011;     
                    if(inst == _BREAK || inst == _SYSCALL || inst == _ERET)
                        state = BREAK_OFF;
                    if(inst == _ERET)
                       begin
                       exception = 1'b0;
                       eret = 1'b1;
                       pc_mux = 2'b11;
                       end
                    if(inst == _ADD || inst == _ADDI || inst == _SLL
                    || inst == _ADDIU || inst == _ANDI || inst == _ORI
                    || inst == _SLTIU || inst == _LUI || inst == _XORI
                    || inst == _SLTI  || inst == _ADDU || inst == _AND
                    || inst == _XOR   || inst == _NOR  || inst == _OR
                    || inst == _SLL || inst == _SLLV || inst == _SLTU
                    || inst == _SRA || inst == _SRL || inst == _SUBU
                    || inst == _ADD || inst == _SUB || inst == _SLT
                    || inst == _SRLV || inst == _SRAV)
                        state = R_TYPE;
                    if(inst == _LW || inst == _SW || inst == _LB 
                    || inst == _SB || inst == _LH || inst == _SH 
                    || inst == _LHU || inst == _LBU)
                        state = SW_lW_CAL_ADDR;
                    if(inst == _BEQ || inst == _BNE || inst == _BGEZ || inst == _TEQ )
                        state = B_TYPE;
                    if(inst == _J || inst == _JAL || inst  == _JR)
                        begin
                        rf_wdata_mux = 4'b0011;
                        state = J_TYPE;
                        end
                    if(inst == _JALR)
                        begin
                            rf_waddr = instruction[15:11];
                            rf_wdata_mux = 4'b0011;
                            rf_we = 1;//PROBLEM
                            state = J_TYPE;
                        end
                    if(inst == _CLZ)
                        begin
                        clz_ena = 1;
                        loop_counter = 0;
                        target_num = 17;
                        state = LOOP;
                        end
                    if(inst == _DIVU || inst == _DIV)
                        begin
                        div_start = 1;
                        loop_counter = 0;
                        target_num = 33;
                        state = LOOP;
                        end
                    if(inst ==  _MUL)
                       begin
                       mul_start = 1;
                       loop_counter = 0;
                       target_num = 33;
                       state = LOOP;
                       end
                    if(inst ==  _MULTU)
                       begin
                       mulu_start = 1;
                       loop_counter = 0;
                       target_num = 33;
                       state = LOOP;
                       end
                    if(inst == _MFHI || inst == _MFLO)
                       begin
                       state  = R_TYPE_WRITE_REG;
                       end
                    if(inst == _MFC0)
                        begin
                        CP0_ADDR = instruction[15:11];
                        state  = R_TYPE_WRITE_REG;
                        end
                    if(inst == _MTHI || inst == _MTLO)
                       begin
                       state  = R_TYPE_WRITE_REG;
                       end
                    if(inst == _MTC0)
                        begin
                        CP0_ADDR = instruction[15:11];
                        state  = R_TYPE_WRITE_REG;
                        end
                    end

                LOOP://10
                    begin
                    div_start = 0;
                    mul_start = 0;
                    mulu_start = 0;
                    if(loop_counter == target_num)
                        begin
                        if(inst == _CLZ)
                            state = R_TYPE_WRITE_REG;
                        if(inst == _DIVU)
                            begin
                            Hiselect = 2'b00;
                            Loselect = 2'b00;
                            Hiwena = 1;
                            Lowena = 1;
                            ir_ena = 1;
                            state = INSTRUCTION_FETCH;
                            end
                        if(inst == _DIV)
                            begin
                            Hiselect = 2'b01;
                            Loselect = 2'b01;
                            Hiwena = 1;
                            Lowena = 1;
                            ir_ena = 1;
                            state = INSTRUCTION_FETCH;
                            end
                            
                        if(inst == _MUL)
                            begin

                            state = R_TYPE_WRITE_REG;
                            end
                        if(inst == _MULTU)
                            begin
                            Hiselect = 2'b10;
                            Loselect = 2'b10;
                            Hiwena = 1;
                            Lowena = 1;
                            ir_ena = 1;
                            state = INSTRUCTION_FETCH;
                            end
                        end
                        
                        
                    loop_counter = loop_counter +1;

                    end
                
                R_TYPE: //6
                    begin
                    if(inst == _ADDI)
                       begin
                       ext16=1;             
                       ext16_s_uns=1'b1;
                       alu_a_mux = 2'b01;
                       alu_b_mux = 3'b001;
                       alu_aluc=4'b0010;
                       alu_z_ena = 1'b1;
                       end
                    if(inst == _ADDIU)
                          begin
                          ext16=1;             
                          ext16_s_uns=1'b1;
                          alu_a_mux = 2'b01;
                          alu_b_mux = 3'b001;
                          alu_aluc=4'b0000;
                          alu_z_ena = 1'b1;
                          end
                    if(inst == _ANDI)
                          begin
                          ext16=1;             
                          ext16_s_uns=1'b0;
                          alu_a_mux = 2'b01;
                          alu_b_mux = 3'b001;
                          alu_aluc=4'b0100;     
                          alu_z_ena = 1'b1;
                          end
                    if(inst == _ORI)
                          begin
                          ext16=1;             
                          ext16_s_uns=1'b0;
                          alu_a_mux = 2'b01;
                          alu_b_mux = 3'b001;
                          alu_aluc=4'b0101;     
                          alu_z_ena = 1'b1;
                          end
                    if(inst == _LUI)
                          begin
                          ext16=1;             
                          ext16_s_uns=1'b0;
                          alu_a_mux = 2'b01;
                          alu_b_mux = 3'b001;
                          alu_aluc=4'b1001;     
                          alu_z_ena = 1'b1;
                          end
                    if(inst == _SLTIU)
                          begin
                          ext16=1;             
                          ext16_s_uns=1'b0;
                          alu_a_mux = 2'b01;
                          alu_b_mux = 3'b001;
                          alu_aluc=4'b1010;    
                          end
                    if(inst == _XORI)
                          begin
                          ext16=1;             
                          ext16_s_uns=1'b0;
                          alu_a_mux = 2'b01;
                          alu_b_mux = 3'b001;
                          alu_aluc=4'b0110;  
                          alu_z_ena = 1'b1;
                          end
                    if(inst == _SLTI)
                          begin
                          ext16=1;             
                          ext16_s_uns=1'b1;
                          alu_a_mux = 2'b01;
                          alu_b_mux = 3'b001;
                          alu_aluc=4'b1011;   
                          end
                    if(inst == _ADDU)
                          begin
                          alu_a_mux = 2'b01;
                          alu_b_mux = 3'b000;
                          alu_aluc=4'b0000; 
                          alu_z_ena = 1'b1;
                          end
                    if(inst == _AND)
                          begin
                          alu_a_mux = 2'b01;
                          alu_b_mux = 3'b000;
                          alu_aluc=4'b0100; 
                          alu_z_ena = 1'b1;
                          end
                    if(inst == _XOR)
                          begin
                          alu_a_mux=2'b01;
                          alu_aluc=4'b0110;     
                          alu_b_mux = 3'b000;
                          alu_z_ena = 1'b1;
                          end
                    if(inst == _NOR)
                          begin
                          alu_a_mux=2'b01;
                          alu_aluc=4'b0111;     
                          alu_b_mux = 3'b000;
                          alu_z_ena = 1'b1;
                          end
                    if(inst == _OR)
                          begin
                          alu_a_mux=2'b01;
                          alu_aluc=4'b0101;     
                          alu_b_mux = 3'b000;
                          alu_z_ena = 1'b1;
                          end
                    if(inst == _SLL)
                          begin
                          ext5=1;   
                          ext5_mux = 1;
                          rf_raddr2=instruction[20:16];
                          alu_a_mux=2'b00;
                          alu_b_mux = 3'b000;
                          alu_aluc=4'b1111;  
                          alu_z_ena = 1'b1;

                          end
                    if(inst == _SLLV)
                            begin
                            alu_a_mux=2'b01;
                            alu_aluc=4'b1111;
                            alu_b_mux = 3'b000;
                            alu_z_ena = 1'b1;

                            end
                    if(inst == _SLTU)
                        begin
                        alu_a_mux=2'b01;
                        alu_aluc=4'b1010;     
                        alu_b_mux = 3'b000;
                        ext1 = 1;
                        ext1_mode = 0;
                        alu_z_ena = 1'b1;
                        end
                    if(inst == _SRA)
                        begin
                        ext5=1;             
                        ext5_mux = 1;
                        alu_a_mux=2'b00;
                        alu_b_mux = 3'b000;
                        alu_aluc=4'b1100;   
                        alu_z_ena = 1'b1;

                        end
                    if(inst == _SRL)
                        begin
                        alu_a_mux=2'b00;
                        ext5=1;             
                        ext5_mux = 1;
                        alu_b_mux = 3'b000;
                        alu_aluc=4'b1101;  
                        alu_z_ena = 1'b1;
                        end
                    if(inst == _SUBU)
                        begin
                        alu_a_mux=2'b01;
                        alu_aluc=4'b0001;     
                        alu_b_mux = 3'b000;
                        alu_z_ena = 1'b1;
                        end
                    if(inst == _ADD)
                        begin
                        alu_a_mux=2'b01;
                        alu_aluc=4'b0010;  
                        alu_b_mux = 3'b000;
                        alu_z_ena = 1'b1;
                        end
                    if(inst == _SUB)
                        begin
                        alu_a_mux=2'b01;
                        alu_aluc=4'b0011;     
                        alu_b_mux = 3'b000;
                        alu_z_ena = 1'b1;

                        end
                    if(inst == _SLT)
                        begin
                        alu_a_mux=2'b01;
                        alu_aluc=4'b1011;     
                        alu_b_mux = 3'b000;
                        alu_z_ena = 1'b1;
                        end
                    if(inst == _SRLV)
                        begin
                        alu_a_mux=2'b01;
                        alu_aluc=4'b1101;
                        alu_b_mux = 3'b000;
                        alu_z_ena = 1'b1;
                        end
                    if(inst == _SRAV)
                        begin
                        
                        alu_a_mux=2'b01;
                        alu_aluc=4'b1100;
                        alu_b_mux = 3'b000;
                        alu_z_ena = 1'b1;
                        
                        end
                    //OPERATION
                    state=R_TYPE_WRITE_REG;
                    end
                    
                R_TYPE_WRITE_REG: //7
                    begin
                    alu_z_ena = 0;
                    ir_ena = 1;
                    if(inst == _MTHI)
                    begin
                        Hiselect = 2'b11;
                        Hiwena = 1'b1;
                    end
                    else if(inst == _MTLO)
                    begin
                        Loselect = 2'b11;
                        Lowena = 1'b1;
                    end
                    else if(inst == _MTC0)
                       begin
                       //do nothing
                       end
                    else if(inst == _MFC0)
                        begin
                        rf_wdata_mux = 4'b1000;
                        rf_waddr = instruction[20:16];
                        rf_we = 1;
                        end
                    else if(inst == _CLZ)
                       begin
                       rf_wdata_mux = 4'b0100;
                       rf_waddr = instruction[15:11];
                       rf_we = 1;
                       end
                    else if(inst == _MFHI)
                       begin
                           rf_wdata_mux = 4'b0101;
                           rf_waddr = instruction[15:11];
                           rf_we = 1;
                       end
                    else if(inst == _MFLO)
                         begin
                          rf_wdata_mux = 4'b0110;
                          rf_waddr = instruction[15:11];
                          rf_we = 1;
                          end
                    else if(inst == _SLTIU)
                        begin
                        rf_wdata_mux = 4'b0000;
                        rf_waddr = instruction[20:16];
                        ext1 = 1;
                        ext1_mode = 0;
                        rf_we = 1;
                        end
                    else if(inst == _SLTI)
                        begin
                        rf_wdata_mux = 4'b0000;
                        rf_waddr = instruction[20:16];
                        ext1 = 1;
                        ext1_mode = 1;
                        rf_we = 1;
                        end
                    else if(inst == _SLT)
                        begin
                        rf_wdata_mux = 4'b0000;
                        rf_waddr = instruction[15:11];
                        ext1 = 1;
                        ext1_mode = 1;
                        rf_we = 1;
                        end
                    else if(inst == _MUL)
                       begin
                       
                       rf_wdata_mux = 4'b0111;
                       rf_waddr = instruction[15:11];
                       rf_we = 1;
                       end

                    else if(inst == _ADDU || inst == _AND || inst == _XOR
                            || inst == _NOR || inst == _OR || inst == _SLL 
                            || inst == _SLLV || inst == _SLTU || inst == _SRA
                            || inst == _SRL||inst == _SUBU || inst == _ADD
                            || inst == _SUB || inst == _SRLV || inst == _SRAV)
                        begin
                        rf_wdata_mux = 4'b0010;
                        rf_waddr = instruction[15:11];
                        rf_we = 1;
                        end
                    else
                        begin
                        rf_wdata_mux = 4'b0010;
                        rf_waddr = instruction[20:16];
                        rf_we = 1;
                        end
                    state =INSTRUCTION_FETCH;
                    end
                    
                SW_lW_CAL_ADDR: //2
                    begin
                    //OPERATION
                    mem_mux = 1;
                    ext16=1;             
                    ext16_s_uns=1'b1;
                    
                    rf_raddr1=instruction[25:21];
                    rf_waddr=instruction[20:16];
                    
                    alu_a_mux=2'b01;
                    alu_aluc=4'b0010;     
                    alu_b_mux = 3'b001;
                    alu_z_ena = 1;
                    if(inst == _LH )
                        begin
                        lbhw_sign = 1;
                        lbhw_select = 2;
                        state = MEM_READ;
                        end
                    if(inst == _LHU )
                        begin
                        lbhw_sign = 0;
                        lbhw_select = 2;
                        state = MEM_READ;
                        end
                    if(inst == _LW )
                        begin
                        lbhw_select = 3;
                        state = MEM_READ;
                        end
                    if(inst == _LB )
                        begin
                        lbhw_select = 1;
                        lbhw_sign = 1;
                        state = MEM_READ;
                        end
                    if(inst == _LH )
                        begin
                        lbhw_select = 2;
                        lbhw_sign = 1;
                        state = MEM_READ;
                        end
                    if(inst == _LBU )
                        begin
                        lbhw_select = 1;
                        lbhw_sign = 0;
                        state = MEM_READ;
                        end
                    if(inst == _SB)
                        begin
                        lbhw_select = 3;//读取原字符
                        bhw_select = 1;
                        state = WRITE_MEM;
                        end
                    if(inst == _SH)
                        begin
                        lbhw_select = 3;//读取原字符
                        bhw_select = 2;
                        state = WRITE_MEM;
                        end
                    if(inst == _SW)
                        begin
                        bhw_select = 3;
                        state = WRITE_MEM;
                        end
                    end
                
                MEM_READ://3
                    begin
                    //OPERATION
                    
                    //write back
                    rf_wdata_mux = 4'b0001;
                    rf_we = 1;
                    ir_ena = 1;
                    if(inst == _LW || inst == _LH ||inst == _LHU || inst == _LB || inst == _LBU  )
                       state = MEM_WRITE_REG;

                    end
                
                MEM_WRITE_REG://4
                    begin
                    //OPERATION
                    //change mode of MEM
                    rf_we = 0;
                    ram_wena = 0;
                    mem_mux = 0;
                    state = INSTRUCTION_FETCH;
                    end
                
                WRITE_MEM://5
                    begin
                    //OPERATION
                    ram_wena = 1;
                    ir_ena = 1;
                    state = MEM_WRITE_REG;
                    end
                
                B_TYPE://8
                    begin
                    //OPERATION
                    ir_ena = 1;
                    if(inst == _BGEZ && (n == 0 || z == 1))
                    begin
                       pcreg_ena = 1'b1;
                       alu_z_ena = 1'b1;
                       ext18=1;
                       alu_a_mux = 2'b11;
                       alu_b_mux = 3'b011;
                       alu_aluc=4'b0010;
                       rf_raddr1=instruction[25:21];
                       rf_raddr2=instruction[20:16];
                    end

                    if( (inst == _BEQ && z == 1) || (inst == _BNE && z == 0) )
                        begin
                            pcreg_ena = 1'b1;
                            alu_z_ena = 1'b1;
                            
                            ext18=1;
                            
                            alu_a_mux = 2'b11;
                            alu_b_mux = 3'b011;
                            alu_aluc=4'b0010;
                            
                            //alu_out = pc+(sign-extend18)
                            rf_raddr1=instruction[25:21];
                            rf_raddr2=instruction[20:16];
                        
                        end

                    if(inst == _TEQ && z == 1)
                        state = BREAK_OFF;
                    else
                       state =INSTRUCTION_FETCH;
                    end
                    
                J_TYPE://9
                    begin
                    //OPERATION
                    if(inst == _JAL)
                        begin
                        alu_z_ena = 0;
                        rf_waddr=5'b11111;
                        pc_mux = 2'b10;
                        rf_we = 1;
                        end
                    else if(inst == _JALR)
                        begin
                        rf_we = 0;
                        pc_mux = 2'b00;
                        end
                    else if(inst == _J)
                        begin
                        rf_we = 0;
                        pc_mux = 2'b10;
                        end
                    else if(inst == _JR)
                        begin
                        rf_raddr1=instruction[25:21];
                        rf_we = 0;
                        pc_mux = 2'b00;
                        end
                    AcatB = 1;
                    ir_ena = 1;
                    pcreg_ena = 1;
                    state =INSTRUCTION_FETCH;
                    end
                BREAK_OFF://10
                    begin
                    if(inst == _SYSCALL && break_off_status[0] == 1
                                        && break_off_status[1] == 1)
                    begin
                        exception = 1'b1;
                        cause = 4'b1000;
                        pc_mux = 2'b11;
                    end             
                    if(inst == _BREAK && break_off_status[0] == 1
                    && break_off_status[2] == 1)
                    begin
                        exception = 1'b1;
                        cause = 4'b1001;
                        pc_mux = 2'b11;
                    end
                    
                    
                    if(inst == _TEQ && break_off_status[0] == 1
                    && break_off_status[3] == 1)//已经判断符合条件才到这一步
                    begin
                        exception = 1'b1;
                        cause = 4'b1101;
                        pc_mux = 2'b11;
                    end
                    
                    if(inst == _ERET)
                    begin
                        //do nothing
                    end
                    
                    ir_ena = 1;
                    pcreg_ena = 1;
                    state =INSTRUCTION_FETCH;
                    end
                endcase
            end//else
        end//always
endmodule
