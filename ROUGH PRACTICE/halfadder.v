module HA(A,B,C,S);
input A,B;
output C,S;

assign C=A&B; //Carry is A and B
assign S=A^B;  //Sum is A Xor B 

endmodule