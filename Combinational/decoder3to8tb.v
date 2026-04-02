module test;
wire [7:0] d;
reg [2:0] in;

decode dec(.x(in[2]),
           .y(in[1]),
           .z(in[0]),
           .d0(d[7]),
           .d1(d[6]),
           .d2(d[5]),
           .d3(d[4]),
           .d4(d[3]),
           .d5(d[2]),
           .d6(d[1]),
           .d7(d[0]));

//clk and reset
           reg clk , reset;
           initial begin
            reset=1;
            clk=0;
            #20;
            reset=0;
           end
           //clk generator
           always begin
            #10 clk=~clk;
           end
//Test benches
           reg[3:0]i;
           always @(posedge clk , posedge reset) begin
            if(reset) begin
                i=0;
            end
            else begin
                in = i;
                #20;
                i=i+1;
                if(i==8) $finish;
            end
            $monitor ("%d : Input = %b , Output = %b ", $time,in,d);
           end

endmodule