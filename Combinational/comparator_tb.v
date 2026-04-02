`timescale 10ns/10ps

module ctb();
//Connecting inputs and outputs 
 reg [3:0] A,B;
 wire E,G,L;

 comparator C1(.A(A),
               .B(B),
               .AequalsB(E),
               .AgreaterthanB(G),
               .AlessthanB(L));

 //clk and reset
  reg clk, reset;
 //initial values 
  initial begin 
     $dumpfile("comp.vcd");
    $dumpvars(0,ctb);
    reset=1;
    clk=0;
    #20;
    reset=0;
  end 
 //clock generator
  always begin
    #10 clk = ~clk;
  end
 //Test Sequence;
  reg[3:0]i;
  always @(posedge clk,posedge reset)
  begin
    if(reset) begin
        i=0;
    end
    else begin
        //assigning random numbers for comparison 
        A<=$random%16;
        B<=$random%16;
        #20;
        i = i+1;
        if(i==10)$finish;
    end
   
    $monitor("%d:A=%b , B=%b, E=%b, G=%b, L=%b",$time,A,B,E,G,L);
  end
endmodule;