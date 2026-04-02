module test;
reg[3:0]a,b;
reg c0;
wire cout;
wire [3:0]s;

//instantiate 
ripplecarryadder r1(.s(s),
                    .a(a),
                    .b(b),
                    .c4(cout),
                    .c0(c0));


//clock and reset
                    reg clk,reset;

initial begin
    $dumpfile("rca.vcd");
    $dumpvars(0,test);
    reset=1;
    clk=0;
    #20;
    reset=0;
end
    always begin
        #10 clk = ~clk;
    end           

reg[3:0]i;
always @(posedge clk, posedge reset) 
begin
    if(reset) begin
        i=0;
    end
    else begin
    a<=$random%16;
    b<=$random%16;
    c0<=$random%2;
    #20;
    i=i+1;
    if(i==10)$finish;
    end
    $monitor("%d : a=%b b=%b cin=%b sum=%b cout=%b",$time,a,b,c0,s,cout);
end
endmodule