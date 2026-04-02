module test;
reg s,r;
wire q,qb;

sr_latch sr1(.s(s),
             .r(r),
             .q(q),
             .qb(qb));
             
initial begin
    $dumpfile("srl.vcd");
    $dumpvars(0,test);
    
    s=0;r=0;
    #10 s=0;r=1;
    #10 s=1;r=0;
    #10 s=1;r=1;
    #10 $finish;
end
endmodule