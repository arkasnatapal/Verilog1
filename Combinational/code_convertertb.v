module test;
reg [3:0]in;
wire [3:0] w;

bcd_ex3 b1(.A(in[3]),
           .B(in[2]),
           .C(in[1]),
           .D(in[0]),
           .x(w[2]),
           .y(w[1]),
           .w(w[3]),
           .z(w[0]));

reg clk,reset;
initial 
begin
    reset=1;
    clk=0;
    #20;
    reset=0;
 end
    always begin
        #10 clk = ~clk ;
end

reg[3:0]i;
always @(posedge clk, posedge reset) begin
    if(reset) begin
        i=0;
    end
    else begin
        in=i;
        i=i+1;
        if(i==8)$finish; 
    end
    $monitor("%d : BCD = %b, Excess3= %b",$time , in, w);
end

endmodule