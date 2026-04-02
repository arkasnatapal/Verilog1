module test;
reg [7:0]p;
wire [2:0]z;

priority pr1(.p0(p[0]),
             .p1(p[1]),
             .p2(p[2]),
             .p3(p[3]),
             .p4(p[4]),
             .p5(p[5]),
             .p6(p[6]),
             .p7(p[7]),
             .z1(z[0]),
             .z2(z[1]),
             .z4(z[2])
             );

//initial values of clk and reset
        reg clk,reset;
        initial begin
            reset=1;
            clk=0;
            #20;
            reset=0;
        end
        //clock generator 
        always  begin
            #10 clk= ~clk;
        end
//Test bench
        reg[3:0]i;
        always @(posedge clk , posedge reset) begin
            if(reset) begin
                i=0;
            end
            else begin
                p=$random%256;
                #20;
                i=i+1;
                if(i==10) $finish;
            end
            $monitor("%d: input=%b output=%b",$time,p,z);
        end
endmodule 