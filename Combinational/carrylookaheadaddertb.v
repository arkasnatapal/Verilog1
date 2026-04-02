module test;
reg[3:0]a,b;
reg cin;
wire cout;
wire [3:0]sum;
//instantiate 
CLA c1(.a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout));



//clock and reset
                    reg clk,reset;

initial begin
    $dumpfile("cla.vcd");
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
    cin<=$random%2;
    #20;
    i=i+1;
    if(i==10)$finish;
    end
    $monitor("%d : a=%b b=%b cin=%b sum=%b cout=%b",$time,a,b,cin,sum,cout);
end
endmodule