module test;
    reg i0,i1,i2,i3;
    reg[1:0] s;
    wire y;

    //instantiation of mux 
    Mux4x1 m1(.in1(i0),
              .in2(i1),
              .in3(i2),
              .in4(i3),
              .s(s),
              .y(y));

    //assigning inputs 
    initial begin
        $dumpfile("mux.vcd");
        $dumpvars(0,test);
        i0=1'b0;
        i1=1'b0;
        i2=1'b1;
        i3=1'b0;
        s=2'b00;


        #2 i1=1'b1;
        #2 s=2'b01;
        #2 i3=1'b1;
        #2 s=2'b11;
        #2 $finish;
    
    end
    initial begin
         $monitor("time=%d : i0=%b i1=%b i2=%b i3=%b s=%b y=%b",$time,i0,i1,i2,i3,s,y);
    end
endmodule