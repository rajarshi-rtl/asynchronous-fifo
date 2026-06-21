`timescale 1ns/1ps

module asynchronous_fifo_tb();

localparam DATA_WIDTH = 8, ADDR_WIDTH = 4;
reg wr_clk, rd_clk, wr_rst, rd_rst, wr_en, rd_en;
reg [DATA_WIDTH-1:0] wr_data;
wire [DATA_WIDTH-1:0] rd_data;
wire empty, full;

asynchronous_fifo #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) dut (
	.wr_clk(wr_clk), .rd_clk(rd_clk), .wr_rst(wr_rst), .rd_rst(rd_rst), .wr_en(wr_en),
	.rd_en(rd_en), .wr_data(wr_data),
	.rd_data(rd_data), .empty(empty), .full(full)
);

integer i;

initial begin
	{rd_clk,wr_clk,wr_rst,rd_rst,wr_en,rd_en} = 6'b000000;
	wr_data = 8'h00;
end

always #5 wr_clk = ~wr_clk;
always #10 rd_clk = ~rd_clk;

initial begin
	$dumpfile("wav_asynchronous_fifo.vcd");
	$dumpvars(0,asynchronous_fifo_tb);
	#5 wr_rst = 1'b1; rd_rst = 1'b1; 
	
	wr_en = 1'b1;
	#10;
	repeat(18) @(negedge wr_clk) wr_data = wr_data + 1;
	wr_en = 1'b0;

	#20;
	rd_en = 1'b1;
	repeat(18) @ (posedge rd_clk);
	rd_en = 1'b0;

	#20 $finish;
end

always @(posedge wr_clk) 
	if (wr_en) $display("Time=%0t, WR_EN=%b, wptr=%b, wdata=%b",$time,wr_en,dut.wr_ptr_bin,wr_data);

endmodule
