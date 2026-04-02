`timescale 1ps/1ps
module test;

reg s,r,clk;
wire q,qb;

// instantiate SR flip-flop
sr_ff uut(
    .s(s),
    .r(r),
    .clk(clk),
    .q(q),
    .qb(qb)
);

// dump file
initial
begin
    $dumpfile("srff.vcd");
    $dumpvars(0,test);
end

// clock generation
always
begin
    #10 clk = ~clk;
end

// stimulus
initial
begin
    clk = 0;

    s = 0; r = 0;
    #10 s = 0; r = 1;
    #10 s = 1; r = 0;
    #10 s = 1; r = 1;

    #10 $finish;
end

endmodule