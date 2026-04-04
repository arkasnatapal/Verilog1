`timescale 1ns/1ps

module SFIFO_tb;

parameter DATA_WIDTH = 8;
parameter FIFO_DEPTH = 32;

// DUT signals
reg clk;
reg reset;
reg wr_en;
reg rd_en;
reg [DATA_WIDTH-1:0] data_in;
wire [DATA_WIDTH-1:0] data_out;
wire full;
wire empty;

// Instantiate DUT
SFIFO #(DATA_WIDTH, FIFO_DEPTH) uut (
    .data_out(data_out),
    .data_in(data_in),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .clk(clk),
    .reset(reset),
    .full(full),
    .empty(empty)
);

// Clock generation (10ns period)
always #5 clk = ~clk;

// Stimulus
initial begin
    // Initialize
    clk = 0;
    reset = 1;
    wr_en = 0;
    rd_en = 0;
    data_in = 0;

    // Dump waves
    $dumpfile("sfifo.vcd");
    $dumpvars(0, SFIFO_tb);

    // Reset
    #10;
    reset = 0;

    // WRITE data into FIFO
    $display("---- Writing Data ----");
    repeat(10) begin
        @(posedge clk);
        wr_en = 1;
        data_in = $random % 256;
    end

    @(posedge clk);
    wr_en = 0;

    // READ data from FIFO
    $display("---- Reading Data ----");
    repeat(10) begin
        @(posedge clk);
        rd_en = 1;
    end

    @(posedge clk);
    rd_en = 0;

    // Mixed operations
    $display("---- Mixed Read/Write ----");
    repeat(10) begin
        @(posedge clk);
        wr_en = $random % 2;
        rd_en = $random % 2;
        data_in = $random % 256;
    end

    #20;
    $finish;
end

endmodule