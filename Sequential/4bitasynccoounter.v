module tff(input t, input clk, output reg q, input rst);
    always @(posedge rst or posedge clk) begin
        if(rst) begin
            q<=0;
        end
        else if (~rst) begin
            if(t) q<=~q;
            else q<=q;
        end
    end
endmodule


module ripplecounter4bit(clk,t,q,rst);
input clk;
input t;
output [3:0] q;
input rst;

tff t1(t,clk,q[0],rst);
tff t2(t,~q[0],q[1],rst);
tff t3(t,~q[1],q[2],rst);
tff t4(t,~q[2],q[3],rst);

endmodule

module test;
reg clk1,t1,rst1;
wire [3:0]q1;

ripplecounter4bit rcb1(.clk(clk1),
                        .t(t1),
                        .q(q1),
                        .rst(rst1));

initial begin 
    $dumpfile("RCC4.vcd");
    $dumpvars(0,test);
end


always begin
    #10 clk1=~clk1;
end

initial begin 
    clk1=0;rst1=0;t1=1;
    #10 rst1=1;
    #10 rst1=0;
    #185 rst1=1;
    #10 rst1=0;
    #10 $finish;

end
endmodule