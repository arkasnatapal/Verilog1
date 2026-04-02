`timescale 1ns/1ps
module  ANDTB;
reg A;
reg B;
wire Y;

AND uut(.A(A),
        .B(B),
        .Y(Y));

initial
    begin
        $dumpfile("and.vcd");
        $dumpvars(0,ANDTB);

    A=0;B=0;
    #10 A=0;B=1;
    #10 A=1;B=0;
    #10 A=1;B=1;
    #10 $finish;

    end

endmodule