// Modules to be instantiated
`include "fifo_mem.v"
`include "wr_ptr_handler.v"
`include "rd_ptr_handler.v"
`include "dual_flop_synchronizer.v"
`include "bin_to_gray.v"
`include "gray_to_bin.v"

module asynchronous_fifo #(parameter DATA_WIDTH=8, parameter ADDR_WIDTH=4) (
	input wr_clk, rd_clk, wr_rst, rd_rst, wr_en, rd_en,
	input [DATA_WIDTH-1:0] wr_data,
	output [DATA_WIDTH-1:0] rd_data,
	output empty, full
);

// additional wire declarations;
wire [ADDR_WIDTH:0] rd_ptr_wrclk, wr_ptr_bin, wr_ptr_rdclk, rd_ptr_bin, wr_ptr_gray, rd_ptr_gray;
wire [ADDR_WIDTH:0] wr_ptr_gray_rdclk, rd_ptr_gray_wrclk;

// Write Pointer Handler
wr_ptr_handler #(.ADDR_WIDTH(ADDR_WIDTH)) wr_ptr_handler_inst (
	.wr_clk(wr_clk), .wr_rst(wr_rst), .wr_en(wr_en),
	.rd_ptr_wrclk(rd_ptr_wrclk), .wr_ptr_bin(wr_ptr_bin), .full(full)
);

// Read Pointer Handler
rd_ptr_handler #(.ADDR_WIDTH(ADDR_WIDTH)) rd_ptr_handler_inst (
	.rd_clk(rd_clk), .rd_rst(rd_rst), .rd_en(rd_en), 
	.wr_ptr_rdclk(wr_ptr_rdclk), .rd_ptr_bin(rd_ptr_bin),.empty(empty)
);

// Converts binary write pointer to gray write pointer
bin_to_gray #(.ADDR_WIDTH(ADDR_WIDTH)) bin_to_gray_wr (
	.bin(wr_ptr_bin), .gray(wr_ptr_gray)
);

// Converts binary read pointer to gray read pointer
bin_to_gray #(.ADDR_WIDTH(ADDR_WIDTH)) bin_to_gray_rd (
	.bin(rd_ptr_bin), .gray(rd_ptr_gray)
);

// Gray write pointer synchronization with Read clock domain
dual_flop_synchronizer #(.ADDR_WIDTH(ADDR_WIDTH)) sync_wr_to_rd (
	.data_in(wr_ptr_gray), .clk(rd_clk), .rst(rd_rst), .sync_ff2(wr_ptr_gray_rdclk)
);

// Gray read pointer synchronization with Write clock domain
dual_flop_synchronizer #(.ADDR_WIDTH(ADDR_WIDTH)) sync_rd_to_wr (
	.data_in(rd_ptr_gray), .clk(wr_clk), .rst(wr_rst), .sync_ff2(rd_ptr_gray_wrclk)
);

// Converts gray write pointers in read clock domain to binary write pointer
gray_to_bin #(.ADDR_WIDTH(ADDR_WIDTH)) gray_to_bin_wr (
	.gray(wr_ptr_gray_rdclk), .bin(wr_ptr_rdclk)
);

// Converts gray read pointer in write clock domain to binary read pointer
gray_to_bin #(.ADDR_WIDTH(ADDR_WIDTH)) gray_to_bin_rd (
	.gray(rd_ptr_gray_wrclk), .bin(rd_ptr_wrclk)
);

// FIFO Memory
fifo_mem #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) fifo_mem_inst (
	.wr_clk(wr_clk), .rd_clk(rd_clk), .wr_en(wr_en && !full), .rd_en(rd_en && !empty), .wr_data(wr_data),
	.rd_data(rd_data), .wr_ptr(wr_ptr_bin), . rd_ptr(rd_ptr_bin)
);

endmodule
