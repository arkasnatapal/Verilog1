`timescale 1ns/1ps
module test;
reg x;
reg clk;
wire y;

sequence_detector sd1(.x(x),
                      .y(y),
                      .clk(clk));

initial begin
    $dumpfile("sd.vcd");
    $dumpvars(0,test);
    clk=0;
end

always begin
    #10 clk=~clk;
end

initial begin
    x=0;
    #10 x=0;
    #10 x=1;
    #10 x=1;
    #10 x=1;
    #10 x=0;
    #10 x=1;
    #10 x=1;
    #10 x=1;
    #10 x=1;
    #10 x=0;
    #10 $finish;


end
endmodule