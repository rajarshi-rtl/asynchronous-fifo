module bin_to_gray #(parameter ADDR_WIDTH = 4) (
	input [ADDR_WIDTH:0] bin,
	output reg [ADDR_WIDTH:0] gray
);

integer i;

always@(*) begin
	gray[ADDR_WIDTH] = bin[ADDR_WIDTH];

	for(i=ADDR_WIDTH-1; i>=0; i=i-1)
		gray[i] = bin[i+1] ^ bin[i];
end

endmodule
