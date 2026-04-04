module sample_1 (a,b,d,y);
    input a,b,d;
    output y;
    wire w1,w2;

    assign w1=a&b;
    assign w2=a&d;
    assign y=w1|w2;

endmodule