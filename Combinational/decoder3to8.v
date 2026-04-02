module decode(d0,d1,d2,d3,d4,d5,d6,d7,x,y,z);
input x,y,z;
output d0,d1,d2,d3,d4,d5,d6,d7;

assign d0= ~x&~y&~z;
assign d1= ~x&~y&z;
assign d2= ~x&y&~z;
assign d3= ~x&y&z;
assign d4= x&~y&~z;
assign d5= x&~y&z;
assign d6= x&y&~z;
assign d7= x&y&z;

endmodule