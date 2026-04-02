module SFIFO #(
    parameter DATA_WIDTH=8,
    parameter FIFO_DEPTH = 32
) ( data_out,data_in,wr_en,rd_en,clk,reset,full,empty);

input [DATA_WIDTH-1:0] data_in;
input wr_en,rd_en,clk,reset;
output reg[DATA_WIDTH-1:0] data_out;
output reg full,empty;

// FIXED pointer sizes
reg [4:0] rd_ptr,wr_ptr;     // since depth = 32 → 5 bits
reg [5:0] depth_cnt;         // can count up to 32

reg [DATA_WIDTH-1:0] memory[FIFO_DEPTH-1:0];

// PUSH
always @(posedge clk)
begin
     if(reset) begin
        wr_ptr <= 0;
     end
     else begin
        if(wr_en && !full) begin
            memory[wr_ptr] <= data_in;
            wr_ptr <= wr_ptr + 1;
        end
     end
end

// POP
always @(posedge clk)
begin 
    if(reset) begin
        rd_ptr <= 0;
        data_out <= 0;
    end
    else begin
        if(rd_en && !empty) begin
            data_out <= memory[rd_ptr];
            rd_ptr <= rd_ptr + 1;
        end
    end
end

// depth counter
always @(posedge clk)
begin
    if(reset) begin
        depth_cnt <= 0;
    end
    else begin
        if(wr_en && !full && !(rd_en && !empty))
            depth_cnt <= depth_cnt + 1;
        else if(rd_en && !empty && !(wr_en && !full))
            depth_cnt <= depth_cnt - 1;
    end
end

// full & empty
always @(*)
begin
    if(depth_cnt == FIFO_DEPTH)
        full = 1;
    else
        full = 0;

    if(depth_cnt == 0)
        empty = 1;
    else
        empty = 0;
end
    
endmodule