module wr_ptr_handler #(parameter ADDR_WIDTH = 4)(
	input wr_clk, wr_rst, wr_en,
	input [ADDR_WIDTH:0] rd_ptr_wrclk,
	output reg [ADDR_WIDTH:0] wr_ptr_bin,
	output reg full
);

wire [ADDR_WIDTH:0] wr_ptr_bin_nxt;
wire full_next;

assign wr_ptr_bin_nxt = wr_ptr_bin + (!full && wr_en);
assign full_next = ({~wr_ptr_bin_nxt[ADDR_WIDTH], wr_ptr_bin_nxt[ADDR_WIDTH-1:0]} == rd_ptr_wrclk);

always @ (posedge wr_clk or negedge wr_rst) begin
	if (!wr_rst) begin
		wr_ptr_bin <= 0;
		full <= 0;
	end
	else begin 
		wr_ptr_bin <= wr_ptr_bin_nxt;
		full <= full_next;
	end
end

endmodule
