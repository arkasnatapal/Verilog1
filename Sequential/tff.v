module tff(input t, input clk, output q);
reg q;
always @ (posedge clk)
begin
q<=(t ? ~q : q);  /*
if q=0 t=1 then qn+1 = 1 so when t is high its basically ~q 
    and if q=1 t=0 then qn+1 = 0 so when t is low its basically q */
end
endmodule


module tfftb;
reg clk1,t1;
wire q1;

tff uut(.clk(clk1),
        .t(t1),
        .q(q1));

initial begin
    $dumpfile("tff.vcd");
    $dumpvars(0,tfftb);
end
always begin
    #10 clk1=~clk1;
end
initial
begin
    clk1 = 0;
    t1 = 0;
    #20 t1 = 1;   // enable toggle
    #60 t1 = 0;   // stop toggle
    #20 $finish;
end
endmodule
