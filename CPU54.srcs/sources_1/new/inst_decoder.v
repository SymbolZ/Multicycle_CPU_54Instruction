`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2017 09:59:02 AM
// Design Name: 
// Module Name: inst_decoder
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


module inst_decoder(
    input [5:0]op,
    input [4:0]M,//25 21
    input [4:0]B,//20 16
    input [5:0]func,
	output reg [5:0]inst,
	output reg MFC0,
	output reg MTC0,
	output reg erec
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
	
    always@(*)
        begin
        
        if(op == 6'b010000 && func == 5'b011000 && M[4] == 1)
        begin
            inst = _ERET;
        end
        
        if(op == 6'b000001 && B == 5'b00001)
        begin
            inst = _BGEZ;
        end
        if(op ==6'b010000 && M == 5'b00100)
        begin
            inst = _MTC0;
            MTC0 = 1;
        end
        else
            MTC0 =  0;
        
        if(op ==6'b010000 && M == 5'b00000)
        begin
            inst = _MFC0;
            MFC0 = 1;
        end
        else
            MFC0 =  0;
            
        case(op)
        
            6'b000000://ADD,SUB,AND,OR,SUBU,ADDU,SLT,SLL,SRL,SLLV
                begin
				if(func==6'b000000)//SLL
					begin
					inst = _SLL;
					end
				if(func==6'b000010)//SRL
					begin
					inst = _SRL;
					end
				if(func==6'b000100)//SLLV
					begin
					inst = _SLLV;
					end
				if(func==6'b000110)//SRLV
					begin
					inst = _SRLV;
					end
				if(func==6'b000111)//SRAV
					begin
					inst = _SRAV;
					end
				if(func==6'b000011)//SRA
					begin
					inst = _SRA;
					end
				if(func==6'b100000)//ADD
					begin
					inst = _ADD;
					end
				if(func==6'b100001)//ADDU
					begin
					inst = _ADDU;
					end
				if(func==6'b100010)//SUB
					begin
					inst = _SUB;
					end
				if(func==6'b100011)//SUBU
					begin
					inst = _SUBU;
					end
				if(func==6'b100100)//AND
					begin
					inst = _AND;
					end
				if(func==6'b100101)//OR
					begin
					inst = _OR;
					end
				if(func==6'b100110)//XOR
					begin
					inst = _XOR;
					end
				if(func==6'b100111)//NOR
					begin
					inst = _NOR;
					end
				if(func==6'b101010)//SLT
					begin
					inst = _SLT;
					end
				if(func==6'b101011)//SLTU
					begin
					inst = _SLTU;
					end
				if(func==6'b001000)//JR
					begin
					inst = _JR;
					end
				if(func==6'b011010)//DIV
                    begin
                    inst = _DIV;
                    end
				if(func==6'b011011)//DIVU
                    begin
                    inst = _DIVU;
                    end
				if(func==6'b011001)//_MULTU
                    begin
                    inst = _MULTU;
                    end
				if(func==6'b010000)//_MFHI
                    begin
                    inst = _MFHI;
                    end
				if(func==6'b010001)//_MTHI
                    begin
                    inst = _MTHI;
                    end
				if(func==6'b010010)//_MFLO
                    begin
                    inst = _MFLO;
                    end
				if(func==6'b010011)//_MTLO
                    begin
                    inst = _MTLO;
                    end
                if(func==6'b001101)//BREAK
                    begin
                    inst = _BREAK;
                    end
                if(func == 6'b001100)
                    begin
                    inst = _SYSCALL;
                    end
                if(func == 6'b110100)
                    begin
                    inst = _TEQ;
                    end
                if(func == 6'b001001)
                    begin
                    inst = _JALR;
                    end
                end

			
			
            6'b000010://J
                begin
				inst = _J;
                end
			
            6'b000011://JAL
                begin
				inst = _JAL;
                end
				
            6'b001000://ADDI
                begin
				inst = _ADDI;
                end
				
            6'b001001://ADDIU
                begin
				inst = _ADDIU;
                end
				
            6'b001100://ANDI
                begin
				inst = _ANDI;
                end
			
            6'b001101://ORI
                begin
				inst = _ORI;
                end
				
            6'b001110://XORI
                begin
				inst = _XORI;
                end
				
            6'b101011://SW
                begin
				inst = _SW;
                end
				
            6'b100011://LW
                begin
				inst = _LW;
                end
				
            6'b000100://BEQ
                begin
				inst = _BEQ;
                end
				
            6'b000101://BNE
                begin
				inst = _BNE;
                end
				
            6'b001010://SLTI
                begin
				inst = _SLTI;
                end
				
            6'b001011://SLTIU
                begin
				inst = _SLTIU;
                end
            6'b001111://LUI
                begin
				inst = _LUI;
                end
            6'b011100:
                begin
                if(func==6'b100000)
                    inst = _CLZ;
                if(func==6'b00010)
                    inst = _MUL;
                end
            6'b101001:
                begin
                inst = _SH;
                end
            6'b100000:
                begin
                inst = _LB;
                end
            6'b101000:
                begin
                inst = _SB;
                end
            6'b100100:
                begin
                inst = _LBU;
                end
            6'b100001:
                begin
                inst = _LH;
                end
            6'b100101:
                begin
                inst = _LHU;
                end

        endcase
        
        end
endmodule
