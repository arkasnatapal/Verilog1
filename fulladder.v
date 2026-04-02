module HalfAdder(S,C,A,B);
input A,B;
output C,S;
and a1(C,A,B);
xor x1(S,A,B);
endmodule

//Now implementing the Fulladder using this halfadder module
module FA(Z,A,B,C,S);
input Z,A,B;
output C,S;
wire S1,C1,C2;

HalfAdder H1(S1,C1,A,B);
HalfAdder H2(S,C2,S1,Z);

or O1(C,C1,C2);

endmodule