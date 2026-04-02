module halfadder(s,c,a,b);
output s,c;
input a,b;

assign s=a^b;
assign c=a&b;
endmodule

module fulladder(s,c,a,b,z);
input a,b,z;
output s,c;
wire s1,c1,c2;

halfadder h1(s1,c1,a,b);
halfadder h2(s,c2,s1,z);
or o1(c,c1,c2);

endmodule

module ripplecarryadder(s,a,b,c4,c0);
output [3:0]s;
input [3:0]a,b;
input c0;
output c4;
wire c1,c2,c3;

fulladder fa1(s[0],c1,a[0],b[0],c0);
fulladder fa2(s[1],c2,a[1],b[1],c1);
fulladder fa3(s[2],c3,a[2],b[2],c2);
fulladder fa4(s[3],c4,a[3],b[3],c3);

endmodule