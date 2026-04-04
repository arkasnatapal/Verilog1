//implementing JK FF using FSM (via DFF)

module dff(input d, input rst, input clk , output reg q);
always @(posedge clk or posedge rst) begin
    if(rst) q<=0;
    else if(~rst) begin
        q<=d;
    end
end
endmodule

module jkfsm(input j, input k , input clk, input rst, output q);
wire ns,s,s1,s2;
dff d1(ns,rst,clk,s);
assign ns = s1|s2;
assign q = s;
assign s1 = j & ~s;
assign s2 = ~k & s;
endmodule

module test;
reg j,k,clk,rst;
wire q;

jkfsm jfs1(j,k,clk,rst,q);
initial begin
    clk=0;
    $dumpfile("jkfsm.vcd");
    $dumpvars(0,test);
end
initial begin
    for (integer i=0;i<20;i++) begin
    #10 clk =~clk;
    end
end
initial begin 
    j=0;k=0;rst=1;
    #10 rst=0;
    #20 j=0;k=1;
    #20 j=1;k=1;
    #20 j=1;k=1;
    #20 $finish;
end
endmodule