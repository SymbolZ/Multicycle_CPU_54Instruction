module alu( 
    input [31:0] a,    //32 位输入，操作数 1 
    input [31:0] b,    //32 位输入，操作数 2 
    input [3:0] aluc, //4 位输入，控制 alu 的操作 
    output reg[31:0] r,   //32 位输出，由 a、b 经过 aluc 指定的操作生成 
    output reg zero,        //0 标志位 
    output reg carry,       // 进位标志位 
    output reg negative,   // 负数标志位 
    output reg overflow   // 溢出标志位
);
reg temp;
reg [32:0]_r;
always@(*)
begin
	case(aluc)
		4'b0000://Addu
		begin
            r = a+b;
            _r = a+b;
            if(_r[32])
              carry = 1;
            else
              carry = 0;
              
            if(r == 0)
                zero = 1;
            else
                zero = 0;
            
            if( _r[31]== 0)
                negative = 1'b0;
            else
                 negative = 1'b1;   

		end
		
		4'b0010://Add
		begin
            r = a+b;
            
            if( (a[31] && b[31] && ~r[31]) ||
            ~a[31] && ~b[31] && r[31])
            begin
              overflow = 1'b1;
            end
            else
              overflow = 1'b0;

            if(r == 0)
                zero = 1'b1;
            else
                zero = 1'b0;
            
            if(r[31] == 1)
                negative = 1'b1;
            else
                negative=1'b0;
		end
	
		4'b0001://Subu
		begin
		
            r = a-b;
            _r = a-b;
            if(_r[32])
              carry = 1;
            else
              carry = 0;
                
            if(r == 0)
                  zero = 1;
             else
                  zero = 0;
            if( _r[31]== 1)
                  negative = 1;
             else
                  negative = 0;   

		end
		
		4'b0011://Sub
		begin
         r = a-b;
          
          if( (a[31] && ~b[31] && ~r[31]) ||
          (~a[31] && b[31] && r[31]) )
          begin
            overflow = 1;
          end
          else
            overflow = 0;

          if(r == 0)
              begin
              zero = 1;
              end
          else
              begin
              zero = 0;
              end
          if(r[31] == 1)
              negative = 1'b1;
          else
              negative=1'b0;
		end
		
		4'b0100://And
		begin
		  r = a & b;
		  
		  if(r[31] == 1)
			negative = 1'b1;
		  else
			negative = 1'b0;
			
		  if(r == 0)
			zero = 1;
		  else 
			zero = 0;

		end
		
		4'b0101://Or
		begin
		  r = a | b;
		  
		  if(r[31] == 1)
			negative = 1;
		  else
			negative = 0;
			
		  if(r == 0)
			zero = 1;
		  else 
			zero = 0;

		end
		
		4'b0110://Xor
		begin
		  r = a ^ b;
		  
		  if(r[31] == 1)
			negative = 1;
		  else
			negative = 0;
			
		  if(r == 0)
			zero = 1;
		  else 
			zero = 0;

		end
		
		4'b0111://Nor
		begin
		  r = ~(a|b);
		  
		  if(r[31] == 1)
			negative = 1;
		  else
			negative = 0;
			
		  if(r == 0)
			zero = 1;
		  else 
			zero = 0;

		end
		
		4'b1000,//Lui
		4'b1001://Lui
		begin
		  r={b[15:0],16'b0};
		  
		  if(r[31] == 1)
			negative = 1;
		  else
			negative = 0;
			
		  if(r == 0)
			zero = 1;
		  else 
			zero = 0;

		end
		
		4'b1011://Slt
		begin
            if(a[31] && b[31])
            begin
              r= (a<b) ?1:0;
              negative= (a<b) ?1:0;
            end
            else if(~a[31] && b[31])
            begin
              r=0;
              negative =0;
            end
            else if(a[31] && ~b[31])
            begin
              r=1;
              negative =1;
            end
            else
            begin
                r=(a<b)?1:0;
                negative=(a<b)?1:0;
			end
			
		    if(a == b)
			  zero = 1;
		    else 
			  zero = 0;

		end
		
		4'b1010: //Sltu
		begin
		  r=(a<b)?1:0;
		  carry=(a<b)?1:0;

		  if(a == b)
			zero = 1;
		  else 
			zero = 0;
		  
		  negative = 1'b0;

		end
		
		4'b1100,//Sra
		4'b1111,
		4'b1110,//sll/slr
		4'b1101://Srl
		begin
		
            if(aluc[1]==1)
            //左移
            begin
                _r[31:0] = b;
                carry = _r[32-a];
                r = _r<< a[4:0];
            end
            //逻辑右移
            else if (aluc[1]==0 && aluc[0] == 1)
            begin
                _r[31:0]  = b;
                carry = _r[a[4:0]-1'b1];
                r  = _r[31:0]>>a[4:0];
            end
            //算术右移
            else //else 1100
            begin
                if(b[31])
                begin
                    _r[31:0]  = ~b;
                    carry = b[a[4:0]-1];
                    
                    r  = ~(_r[31:0]>>a[4:0] );
                end
                else
                begin
                    _r[31:0]  = b;
                    carry = b[a[4:0]-1];
                    r  = _r[31:0]>>a[4:0];
                end
            end
            if(r == 0)
                zero = 1;
            else 
                zero = 0;
            if(a == 0)
                carry = 0;
            if(r[31] == 1)
                negative = 1;
            else
                negative = 0;

 		end
 	default:
 	begin
         r=32'h00000000;
 	 end
	endcase
end
endmodule