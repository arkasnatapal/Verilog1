// construct a TFF using FSM (taking d flip flop)

module dff(input d, input clk, input rst , output reg q);
always @(posedge clk or posedge rst) begin
    if(rst) q<=0;
    else q<=d;
end
endmodule 

module tff_fsm(t,clk,rst,q);
input t,clk,rst;
output q;
wire ns,s;
dff d1(ns,clk,rst,s);
assign ns = t ^ s;
assign q = s;
endmodule

module test;
reg t,clk,rst;
wire q;
tff_fsm tf1(t,clk,rst,q);
initial begin 
    $dumpfile("TffFSM.vcd");
    $dumpvars(0,test);
end
initial begin 
    clk=0;
    for(integer i=0;i<20;i++) begin
        #10 clk = ~clk;
    end
end
initial begin
t=0;rst=1;
#10 rst=0;
#20 t=1;
#35 t=0;
#20 t=1;
#10 $finish;
end
endmodule 