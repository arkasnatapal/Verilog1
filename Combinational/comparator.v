//4 BITS COMPARATOR

module comparator(
    input[3:0]A,
    input[3:0]B,
    output AgreaterthanB,
    output AlessthanB,
    output AequalsB);

wire x0,x1,x2,x3;

// ASSIGNING THE FUNCTION Xi=Ai.Bi + Ai'.Bi'

assign x0 = (A[0]&B[0]) | (~A[0]&~B[0]);
assign x1 = (A[1]&B[1]) | (~A[1]&~B[1]);
assign x2 = (A[2]&B[2]) | (~A[2]&~B[2]);
assign x3 = (A[3]&B[3]) | (~A[3]&~B[3]);

assign AequalsB = x0&x1&x2&x3;
assign AgreaterthanB= (A[3]&~B[3]) | (x3&A[2]&~B[2]) | (x3&x2&A[1]&~B[1]) | (x3&x2&x1&A[0]&~B[0]);
assign AlessthanB= (~A[3]&B[3]) | (x3&~A[2]&B[2]) | (x3&x2&~A[1]&B[1]) | (x3&x2&x1&~A[0]&B[0]);

endmodule