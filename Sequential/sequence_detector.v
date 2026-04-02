module dff(q,d,clk);
input clk,d;
output reg q;

always @(posedge clk)
begin
    q<=d;
end
endmodule

module sequence_detector(x,y,clk);
input x,clk;
output y;
wire da,db,qa,qb;

dff a(.q(qa),
      .d(da),
      .clk(clk));

dff b(.q(qb),
      .d(db),
      .clk(clk));

assign db=((~qb)|qa) & x;
assign da=(qa | qb) & x;
assign y = qa&x;


endmodule