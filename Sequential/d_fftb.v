`timescale 1ps/1ps
module test;
reg clk;
reg d;
wire q;

dff uut(.clk(clk),
        .d(d),
        .q(q));

initial begin
    $dumpfile("dff.vcd");
    $dumpvars(0,test);
end

always begin
    #10 clk= ~clk;
end

initial begin
    clk=0;
    d=0;
    #10 d=1;
    #10 $finish;
end

endmodule