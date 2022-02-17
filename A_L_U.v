module alu(ALU_out,Carry_out,A,B,ALU_sel,clk);
parameter n=32;
input [n-1:0] A,B;
input [2:0] ALU_sel;
input clk;
output [n-1:0] ALU_out;
output Carry_out;
reg [n-1:0] ALU_result;
wire [n:0] temp,prod;

assign ALU_out = ALU_result;
assign temp = {1'b0,A}+{1'b0,B};
assign Carry_out = temp[n];

always @(*)
begin
    case(ALU_sel)
    3'b000: ALU_result = A + B;
    3'b001: ALU_result = A - B;
    3'b010: ALU_result = prod;
    3'b011: ALU_result = A / B;
    3'b100: ALU_result = A << B;
    3'b101: ALU_result = A >> B;
    3'b110: ALU_result = A & B;
    3'b111: ALU_result = A | B;
    default: ALU_result = A + B;
    endcase
end
booth_multiplier mul(prod,A,B,clk,(ALU_sel==3'b010));
endmodule
    
    
module booth_multiplier(ans, m, q, clk, start);
    parameter n = 16;
    input[n-1:0] m, q;
    output reg [2*n-1:0] ans;
    input clk, start;
    reg[2:0] state;
    reg[5:0] cnt;
    reg[n-1:0] ab, qb;
    reg qm1;
    parameter s0 = 3'b000, s1 = 3'b001, s2 = 3'b010, s3 = 3'b011, s4 = 3'b100, s5 = 3'b101;
    always @(posedge clk)
        begin
            case(state)
            s0 : if (start) state = s1;
            s1 : begin
                     ab = 0; cnt = n; qb = q; qm1 = 0;
                     state = s2;
                 end
            s2 : begin
                    if ({qb[0],qm1} == 2'b10)
                    begin
                        ab = ab - m;
                        state = s3;
                    end
                    else if({qb[0],qm1} == 2'b01)
                    begin
                        ab = ab + m;
                        state = s3;
                    end
                    else 
                    begin
                        state = s3;
                    end
                 end 
            s3 : begin
                     {ab,qb,qm1} = {qb[0],ab,qb};
                     cnt = cnt - 1;
                     if (|cnt) state = s2;
                     else state = s4;
                 end
            s4 : begin
                     ans = {ab, qb};
                     state = s5;
                 end
            s5 : state = s5; 
            default : state = s0;
               
            endcase
        end
 endmodule
