module MUX_9(
    input [3:0]select,
    input [31:0]i0,
    input [31:0]i1,
    input [31:0]i2,
    input [31:0]i3,
    input [31:0]i4,
    input [31:0]i5,
    input [31:0]i6,
    input [31:0]i7,
    input [31:0]i8,
    output reg [31:0]o
    );
    always@(*)
        begin
        case(select)
            4'b0000:  o <=  i0;
            4'b0001:  o <=  i1;
            4'b0010:  o <=  i2;
            4'b0011:  o <=  i3;
            4'b0100:  o <=  i4;
            4'b0101:  o <=  i5;
            4'b0110:  o <=  i6;
            4'b0111:  o <=  i7;
            4'b1000:  o <=  i8;
        endcase
        end
endmodule