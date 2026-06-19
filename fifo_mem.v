module fifo_mem #(parameter DATA_WIDTH = 8, parameter ADDR_WIDTH = 4) (
	input wr_clk, wr_en, rd_clk, rd_en,
	input [DATA_WIDTH-1:0] wr_data,
	input [ADDR_WIDTH:0] wr_ptr, rd_ptr,
	output reg [DATA_WIDTH-1:0] rd_data
);

localparam DEPTH = (1 << ADDR_WIDTH);
reg [DATA_WIDTH-1:0] memory [0:DEPTH-1];

always @ (posedge wr_clk) begin
	if (wr_en)
		memory[wr_ptr[ADDR_WIDTH-1:0]] <= wr_data;
end

always @ (posedge rd_clk) begin
	if (rd_en)
		rd_data <= memory[rd_ptr[ADDR_WIDTH-1:0]];
end

endmodule
