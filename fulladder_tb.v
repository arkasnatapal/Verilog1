`timescale 1ps/1ps
module FATB;
reg A;
reg B;
reg Z;
wire S;
wire C;

FA uut(.A(A),
        .B(B),
        .Z(Z),
        .S(S),
        .C(C));

initial begin
   $dumpfile("FA.vcd");
   $dumpvars(0,FATB);
   
   Z=0;A=0;B=0;
   #10 Z=0;A=0;B=1;
   #10 Z=0;A=1;B=0;
   #10 Z=0;A=1;B=1;

   #10 Z=1;A=0;B=0;
   #10 Z=1;A=0;B=1;
   #10 Z=1;A=1;B=0;
   #10 Z=1;A=1;B=1;
   
end

endmodule