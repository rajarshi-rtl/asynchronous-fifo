module gray_to_bin #(parameter ADDR_WIDTH = 4) (
	input [ADDR_WIDTH:0] gray,
	output reg [ADDR_WIDTH:0] bin
);

integer i;

always @(*) begin
	bin[ADDR_WIDTH] = gray[ADDR_WIDTH];

	for (i=ADDR_WIDTH-1; i>=0; i=i-1)
		bin[i] = bin[i+1] ^ gray[i];
end

endmodule
