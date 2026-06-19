module dual_flop_synchronizer #(parameter ADDR_WIDTH = 4) (
	input [ADDR_WIDTH:0] data_in,
	input clk, rst,
	output reg [ADDR_WIDTH:0] sync_ff2
);

reg [ADDR_WIDTH:0] sync_ff1;

always @ (posedge clk or negedge rst) begin
	if (!rst) begin
		sync_ff1 <= 0;
		sync_ff2 <= 0;
	end
	else begin
		sync_ff1 <= data_in;
		sync_ff2 <= sync_ff1;
	end
end

endmodule
