// D Flip-Flop with asynchronous reset
module dff(
    input d,
    input rst,
    input clk,
    output reg q
);

always @(posedge clk or posedge rst)
begin
    if (rst)
        q <= 0;
    else
        q <= d;
end

endmodule



// 4-bit SISO Shift Register
module siso(
    input din,
    input rst,
    input clk,
    output dout
);

wire q3, q2, q1;

dff d3(din, rst, clk, q3);
dff d2(q3, rst, clk, q2);
dff d1(q2, rst, clk, q1);
dff d0(q1, rst, clk, dout);

endmodule



// Testbench
module test;

reg din1;
reg clk1;
reg rst1;

wire dout1;

siso s1(
    .din(din1),
    .rst(rst1),
    .clk(clk1),
    .dout(dout1)
);


// Generate waveform file
initial
begin
    $dumpfile("siso.vcd");
    $dumpvars(0, test);

    $monitor("time=%0t clk=%b rst=%b din=%b dout=%b",
              $time, clk1, rst1, din1, dout1);
end


// Clock generator
initial clk1 = 0;
always #10 clk1 = ~clk1;


// Stimulus
initial
begin
    rst1 = 1;
    din1 = 0;

    #5 rst1 = 0;

    #10 din1 = 1;
    #10 din1 = 1;
    #10 din1 = 1;
    #10 din1 = 0;

    #100 $finish;
end

endmodule