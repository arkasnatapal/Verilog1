// BCD TO EXCESS-3 converter

module bcd_ex3(A,B,C,D,w,x,y,z);
input A,B,C,D;
output x,y,w,z;

assign w = A | (B&C) | (B&D);
assign x =(~B&C) | (~B&D) | (B&~C&~D);
assign y = (C&D) | (~C&~D);
assign z = ~D;

endmodule