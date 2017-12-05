module CP0(
input clk,
input rst,
input mfc0, // CPU instruction is Mfc0
input mtc0, // CPU instruction is Mtc0
input [31:0]pc,
input [4:0] addr, // Specifies Cp0 register
input [31:0] data, // Data from GP register to replace CP0 register
input exception,
input eret, // Instruction is ERET (Exception Return)
input [3:0]cause,
output reg [31:0] rdata, // Data from CP0 register for GP register
output reg [31:0] status,
output reg [31:0]exc_addr // Address for PC at the beginning of an exception
);
	reg [31:0]cause_r = 0;
	reg [31:0]EPC;
	reg flag = 0;
	always@(negedge clk)
	begin
		if(rst)
		begin
			rdata = 0;
			exc_addr = 32'h400004;
			status = 32'h0000000f;
		end
		else
		begin
			if(mfc0)
			begin
			
				case(addr)
				
					5'd12:
					begin
						rdata = status;
					end
					5'd13:
					begin
						rdata = cause_r;
					end
					5'd14:
					begin
						rdata = EPC;
					end
				
				endcase
			end
			if(mtc0)
			begin
				
				case(addr)
				
				5'd12:
				begin
					status = data;
				end
				5'd13:
				begin
					cause_r = data;
				end
				5'd14:
				begin
					EPC = data;
				end
				
				endcase
			end
			if(exception & ~flag)
			begin
				status = status<<5;
				EPC = pc;
				cause_r[5:2] = cause;
				flag = 1;
				exc_addr = 32'h400004;//+
			end
			if(eret & flag)
			begin
				status = status>>5;
				exc_addr = EPC;
				flag = 0;
			end
			else
			 exc_addr = 32'h400004;
		
		end
	end

endmodule