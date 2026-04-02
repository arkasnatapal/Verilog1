module Mux4x1(in1,in2,in3,in4,y,s);
input in1,in2,in3,in4;
output y;
input[1:0] s;

assign y = (~s[0]&~s[1]&in1) | (s[0]&~s[1]&in2) | (~s[0]&s[1]&in3) | (s[0]&s[1]&in4);

endmodule