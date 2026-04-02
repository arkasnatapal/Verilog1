//Master Slave D FF 

module dff(input d,input clk, output q);
 assign q= d;
endmodule

module masterslavedff(d,clk,qm,qs);
input d,clk;
output qm,qs;
wire w1;
assign w1=qm;
dff dm(d,clk,qm);
dff ds(w1,~clk,qs);
endmodule

module testtb;
reg d1,clk1;
wire qm1,qs1;

masterslavedff ms1(.d(d1),
                    .clk(clk1),
                    .qm(qm1),
                    .qs(qs1));
initial begin
    $dumpfile("msdff.vcd");
    $dumpvars(0,testtb);
end
always begin
    #10 clk1=~clk1;
end
initial begin
    clk1=0;
    d1=0;
    #10 d1=1;
    #20 d1=0;
    #20 d1=1;
end
endmodule 