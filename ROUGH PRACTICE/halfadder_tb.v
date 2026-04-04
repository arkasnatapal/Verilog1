`timescale 1ns/1ps
module HA_TB;
reg A;
reg B;
wire C;
wire S;

HA uut(.A(A),
    .B(B),
    .C(C),
    .S(S));

initial begin
    $dumpfile("HA.vcd");
    $dumpvars(0,HA_TB);

    A=0;B=0;
    #10 A=0;B=1;
    #10 A=1;B=0;
    #10 A=1;B=1;
    #10 $finish;
end
endmodule
