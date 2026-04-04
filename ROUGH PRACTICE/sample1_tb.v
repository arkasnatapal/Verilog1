`timescale 1ps/1ps

module sample1_tb;
reg A;
reg B;
reg D;
wire Y;

sample_1 uut(.a(A),
            .b(B),
            .d(D),
            .y(Y));

initial begin
    $dumpfile("sample1.vcd");
    $dumpvars(0,sample1_tb);

    A=0;B=0;D=0;
    #10 A=0;B=0;D=1;
    #10 A=0;B=1;D=0;
    #10 A=0;B=1;D=1;
    #10 A=1;B=0;D=0;
    #10 A=1;B=0;D=1;
    #10 A=1;B=1;D=0;
    #10 A=1;B=1;D=1;
    #10 $finish;
end

endmodule