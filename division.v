
// two digit division //

module division(disp, d1, d2, clk);
input disp, clk;
output d1, d2;


wire [7:0] disp;
wire [7:0] d1;
wire [7:0] d2;

reg [7:0] ds1;
reg [7:0] ds2;


always @ (posedge clk)
	begin 
		ds1 = disp % 10;
		ds2 = disp/10;
	end

display f0 (ds2, d1, clk);
display f1 (ds1, d2, clk);

endmodule 
