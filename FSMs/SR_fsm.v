//implementing SR FF using FSM (via DFF)

module dff(input d, input rst, input clk , output reg q);
always @(posedge clk or posedge rst) begin
    if(rst) q<=0;
    else if(~rst) begin
        q<=d;
    end
end
endmodule

module srfsm(input si, input r , input clk, input rst, output q);
wire ns,s,s1;
dff d1(ns,rst,clk,s);
assign ns = s1|si;
assign q = s;
assign s1 = ~r & s;
endmodule

module test;
reg si,r,clk,rst;
wire q;

srfsm sr1(si,r,clk,rst,q);
initial begin
    clk=0;
    $dumpfile("srfsm.vcd");
    $dumpvars(0,test);
end
initial begin
    for (integer i=0;i<20;i++) begin
    #10 clk =~clk;
    end
end
initial begin 
    si=0;r=0;rst=1;
    #10 rst=0;
    #20 si=0;r=1;
    #20 si=1;r=0;
    #20 si=1;r=1;
    #40 $finish;
end
endmodule