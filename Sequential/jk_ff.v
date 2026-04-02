// in this file i have done the coding as well as the tb so please see the file syntax carefully



module jk_ff(input j, input k, input clk, output q);
reg q;
always @(posedge clk)
    case ({j,k})
        2'b00: q<=q;
        2'b01: q<=0;
        2'b10: q<=1;
        2'b11: q<=~q;
    endcase
endmodule

module jkfftb;
reg j1,k1,clk1;
wire q1;
integer i;

jk_ff jf1(j1,k1,clk1,q1);

initial begin
    clk1=0;
    for (i=0;i<10 ;i++) begin
            #10 clk1= ~clk1;
            $display("clk1 = %b , J = %b ,K=%b", clk1,j1,k1);
    end
end


initial begin 
    $dumpfile("jkff.vcd");
    $dumpvars(0,jkfftb);
         	j1 <= 0;  k1<= 0;    
  #5 	j1 <= 0;  k1 <= 1;  
  #20 	j1 <= 1;  k1 <= 0;  
  #20   j1 <= 1;  k1 <= 1;  
  #20   $finish;  
end


endmodule 