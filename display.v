
module display(digit, seg_pins, clk);
input clk;
input [7:0] digit;
output [7:0] seg_pins;
reg [7:0] seg_pins;

always @ (posedge clk)
	begin 
	case(digit)
	 	0 :	seg_pins = 8'hc0;	// 1100 0000
		1 :	seg_pins = 8'hf9;	// 1111 1001
		2 :	seg_pins = 8'ha4;	// 1010 0100
		3 : 	seg_pins = 8'hb0;	// 1011 0000
		4 :	seg_pins = 8'h99;	// 1001 1001
		5 :	seg_pins = 8'h92;	// 1001 0010
		6 :	seg_pins = 8'h82;	// 1000 0010
		7 :	seg_pins = 8'hf8;	// 1111 1000
		8 :	seg_pins = 8'h80;	// 1000 0000
		9 :	seg_pins = 8'h90;	// 1001 0000
	 endcase
	 end
	 
endmodule 

