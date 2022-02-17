`timescale 1ns/1ps

module ALU_test;
parameter n=32;
reg [n-1:0] A,B;
reg [2:0] ALU_sel;
reg clk,start;
wire [n-1:0] ALU_out;
wire Carry_out;

//integer i;

alu test_unit(ALU_out,Carry_out,A,B,ALU_sel,clk);
always #5 clk=~clk;
initial begin
    clk=0; start=0;
    #1 start=1;
    A=8'b1100; B=8'b0100; ALU_sel=3'b000;
    
//    for(i=0;i<=7;i=i+1)
//    begin
//        ALU_sel = ALU_sel + 3'b001;
//        #10;
//    end;
    
    #20 A=8'h0A; B=4'h02; ALU_sel=3'b000;
    #20 A=8'hF6; B=8'h0A; ALU_sel=3'b000;
//    #20 A=8'hE4; B=8'h79; ALU_sel=3'b010;
    #20 A=8'h0A; B=4'h02; ALU_sel=3'b001;
    #20 A=8'h0A; B=4'h02; ALU_sel=3'b011;
    #20 A=8'h0A; B=4'h02; ALU_sel=3'b100;
    #20 A=8'h0A; B=4'h02; ALU_sel=3'b101;
    #20 A=8'h0A; B=4'h02; ALU_sel=3'b110;
    #20 A=8'h0A; B=4'h02; ALU_sel=3'b111;
    #20 A=8'h0A; B=4'h02; ALU_sel=3'b010;
    #700 A=4'b1111; B=4'b0101; ALU_sel=3'b010;
    
         
end
initial begin
    $monitor($time,"A=%d,B=%d,Ans=%d",A,B,ALU_out);
    $dumpfile("dump.vcd"); $dumpvars(0,ALU_test);
    #700 $finish;
    end
endmodule