module MUX_8(
    input [2:0]select,
    input [31:0]i0,
    input [31:0]i1,
    input [31:0]i2,
    input [31:0]i3,
    input [31:0]i4,
    input [31:0]i5,
    input [31:0]i6,
    input [31:0]i7,
    output reg [31:0]o
    );
    always@(*)
        begin
        case(select)
            3'b000:  o <=  i0;
            3'b001:  o <=  i1;
            3'b010:  o <=  i2;
            3'b011:  o <=  i3;
            3'b100:  o <=  i4;
            3'b101:  o <=  i5;
            3'b110:  o <=  i6;
            3'b111:  o <=  i7;
        endcase
        end
endmodule