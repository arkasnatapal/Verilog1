module universalreg(
    input wire [1:0] sel,
    input wire [3:0] data_input,
    input wire clk,
    input wire left_in, input wire right_in,
     output reg [3:0] data_output
);

reg [3:0] reg_data; //REGISTER FOR STORING DATA 
always @(posedge clk) 
begin
    case (sel)
        2'b00: reg_data <= data_input;
        2'b01: reg_data <= {reg_data[2:0],left_in}; /*{a,b} this operator means a followed by b*/
        2'b10: reg_data <= {right_in,reg_data[3:1]};
        2'b11: reg_data <= reg_data;
    endcase
end

always @(posedge clk) begin
    data_output <= reg_data;
end
endmodule 


module test;
reg [1:0] sel1;
reg [3:0] d_i;
wire [3:0] d_o;
reg clk1;
reg left_in1;
reg right_in1;

universalreg uut(.sel(sel1),
                .data_input(d_i),
                .clk(clk1),
                .left_in(left_in1),
                .right_in(right_in1),
                .data_output(d_o));


initial begin
    $dumpfile("ur.vcd");
    $dumpvars(0,test);
end
always begin
    #10 clk1= ~clk1;
end
initial begin 
    clk1=0;
    
    // initial values
    sel1 = 2'b00;
    d_i = 4'b1011;
    left_in1 = 0;
    right_in1 = 0;


    // Parallel load
    #20 sel1 = 2'b00;


    // Left shift
    #20 left_in1 = 1;
        sel1 = 2'b01;

    #20 left_in1 = 0;
        sel1 = 2'b01;


    // Right shift
    #20 right_in1 = 1;
        sel1 = 2'b10;

    #20 right_in1 = 0;
        sel1 = 2'b10;


    // Hold
    #20 sel1 = 2'b11;


    #100 $finish;
end


endmodule