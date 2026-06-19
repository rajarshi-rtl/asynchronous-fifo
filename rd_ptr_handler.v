module rd_ptr_handler #(parameter ADDR_WIDTH = 4) (
	input rd_clk, rd_en, rd_rst,
	input [ADDR_WIDTH:0] wr_ptr_rdclk,
	output reg [ADDR_WIDTH:0] rd_ptr_bin,
	output reg empty
);

wire [ADDR_WIDTH:0] rd_ptr_bin_nxt;
wire empty_nxt;

assign rd_ptr_bin_nxt = rd_ptr_bin + (!empty && rd_en);
assign empty_nxt = (rd_ptr_bin_nxt == wr_ptr_rdclk);

always @ (posedge rd_clk or negedge rd_rst) begin
	if (!rd_rst) begin
		rd_ptr_bin <= 0;
		empty <= 1;
	end
	else begin
		rd_ptr_bin <= rd_ptr_bin_nxt;
		empty <= empty_nxt;
	end
end

endmodule
