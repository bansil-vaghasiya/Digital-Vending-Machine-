module vending_machine(p_in, clk, rst, d_in, pr_out, s1, s2, s3, s4, s5, s6);
input p_in;
input clk, rst;
input d_in;
output pr_out, s1, s2, s3, s4, s5, s6;

reg [2:0] cs;
wire [4:0] p_in;
wire[2:0] d_in; 
reg [2:0] d_ins;
reg pr_out;
reg clk1 = 1'b0;
reg [31:0] c_delay = 0;

parameter [2:0] reset = 3'b000;
parameter [2:0] product_select = 3'b001;
parameter [2:0] pr1 = 3'b010;
parameter [2:0] pr2 = 3'b011;
parameter [2:0] pr3 = 3'b100;
parameter [2:0] pr4 = 3'b101;
parameter [2:0] pr5 = 3'b110;

parameter [7:0] price1 = 8'b00011001;
parameter [7:0] price2 = 8'b00100011;
parameter [7:0] price3 = 8'b00110010;
parameter [7:0] price4 = 8'b01001011;
parameter [7:0] price5 = 8'b01010101;

parameter [7:0] product1 = 8'b00000001;
parameter [7:0] product2 = 8'b00000010;
parameter [7:0] product3 = 8'b00000100;
parameter [7:0] product4 = 8'b00001000;
parameter [7:0] product5 = 8'b00010000;

parameter [2:0] d_25 = 3'b001;
parameter [2:0] d_50 = 3'b010;
parameter [2:0] d_75 = 3'b100;

reg [31:0] counter; 
reg [7:0] price;
reg [7:0] pr_buff;
reg [7:0] pr_act;
reg [7:0] d_change;

wire [7:0] s1;
wire [7:0] s2;
wire [7:0] s3;
wire [7:0] s4;
wire [7:0] s5;
wire [7:0] s6;


initial begin
	cs = reset;
end

always @(posedge clk)
	begin
		if(counter == 100000)begin
			clk1 = ~clk1;
			counter = 0;
				end
				else
					begin
						counter = counter + 1;
					end
	end

always @ (posedge clk1 or posedge rst)
	begin 
		if(rst == 1) 
			begin  cs = reset; end
		else begin
		case(cs)
		
		reset: begin 
				 price = 0;
				 pr_out = 0;
				 pr_act = 0;
				 d_change = 0;
				 cs = product_select;
				 end
				 
		product_select: begin
								case(p_in)
								product1: begin
												price <= price1;
												pr_act <= price1;
												cs = pr1;
											 end
								product2: begin
												price <= price2;
												pr_act <= price2;
												cs = pr2;
											 end
								product3: begin
												price <= price3;
												pr_act <= price3;
												cs = pr3;
											 end
								product4: begin
												price <= price4;
												pr_act <= price4;
												cs = pr4;
											 end
								product5: begin
												price <= price5;
												pr_act <= price5;
												cs = pr5;
											 end
								default: cs = product_select;
								endcase 
							end
							
		pr1: begin
			  case(d_ins)
				
				d_25: begin
							if(d_in == d_25)
							begin
								if(price >= 8'b00011001) 
									price = price - 8'b00011001;
								else 
								begin
									d_change = 8'b00011001 - price;
									price = 8'b0;
								end
							end
							else begin
								cs = pr1;
							end
							
							if(price == 8'b0) 
							pr_out = 1;
							
							if(d_in == d_50) d_ins = d_50;
							else if (d_in == d_75) d_ins = d_75; 
							else if (pr_out == 1) 
								begin 
									if(c_delay == 5000000)
										begin
										c_delay = 0;
										cs = reset;
										end
									else 
										begin
										c_delay = c_delay + 1;
										d_change = 8'b0;
										//cs = d_25;
										end
								end
						end
		
				d_50: begin
							if(d_in == d_50)
							begin
								if(price >= 8'b00011001) 
									price = price - 8'b00011001;
								else begin
									d_change = 8'b00011001 - price;
									price = 8'b0;
									end
							end
							else begin
								cs = pr1;
							end
							
							if(price == 8'b0) 
							pr_out = 1;
							
							if(d_in == d_25) d_ins = d_25;
							else if (d_in == d_75) d_ins = d_75; 
							else if (pr_out == 1) 
								begin 
									if(c_delay == 5000000)
										begin
										c_delay = 0;
										cs = reset;
										end
									else 
										begin
										c_delay = c_delay + 1;
										cs = d_50;
										end
								end
						end
						
				d_75: begin
							if(d_in == d_75)
							begin
								if(price >= 8'b00011001) 
									price = price - 8'b00011001;
								else begin
									d_change = 8'b00011001 - price;
									price = 8'b0;
									end
							end
							else begin
								cs = pr1;
							end
							
							if(price == 8'b0) 
							pr_out = 1;
							
							if(d_in == d_25) d_ins = d_25;
							else if (d_in == d_50) d_ins = d_50; 
							else if (pr_out == 1) 
								begin 
									if(c_delay == 5000000)
										begin
										c_delay = 0;
										cs = reset;
										end
									else 
										begin
										c_delay = c_delay + 1;
										cs = d_75;
										end
								end
						end
				endcase
				end
				
		pr2: begin
			  case(d_ins)
				
				d_25: begin
							if(d_in == d_25)
							begin
								if(price >= 8'b00011001) 
								begin
									price = price - 8'b00011001;
									pr_buff = price;
								end
								else begin
									d_change = 8'b00011001 - price;
									price = 8'b0;
									end
							end
							else begin
								cs = pr2;
							end
							
							if(price == 8'b0) 
							pr_out = 1;
							
							if(d_in == d_50) d_ins = d_50;
							else if (d_in == d_75) d_ins = d_75; 
							
							if (pr_out == 1) 
								begin 
									if(c_delay == 5000000)
										begin
										c_delay = 0;
										cs = reset;
										end
									else 
										begin
										c_delay = c_delay + 1;
										d_change = 8'b00011001 - pr_buff;
										end
								end
						end
		
				d_50: begin
							if(d_in == d_50)
							begin
								price = pr_act;
								if(price >= 8'b00110010) 
									price = price - 8'b00110010;
								else begin
									d_change = 8'b00110010 - price;
									price = 8'b0;
									end
							end
							else begin
								cs = pr2;
							end
							
							if(price == 8'b0) 
							pr_out = 1;
							
							if(d_in == d_25) d_ins = d_25;
							else if (d_in == d_75) d_ins = d_75; 
							else if (pr_out == 1) 
								begin 
									if(c_delay == 5000000)
										begin
										c_delay = 0;
										cs = reset;
										end
									else 
										begin
										c_delay = c_delay + 1;
										end
								end
						end
						
				d_75: begin
							if(d_in == d_75)
							begin
							price = pr_act;
								if(price >= 8'b01001011) 
									price = price - 8'b01001011;
								else begin
									d_change = 8'b01001011 - price;
									price = 8'b0;
									end
							end
							else begin
								cs = pr2;
							end
							
							if(price == 8'b0) 
							pr_out = 1;
							
							if(d_in == d_25) d_ins = d_25;
							else if (d_in == d_50) d_ins = d_50; 
							else if (pr_out == 1) 
								begin 
									if(c_delay == 5000000)
										begin
										c_delay = 0;
										cs = reset;
										end
									else 
										begin
										c_delay = c_delay + 1;
										end
								end
						end
				endcase
				end
				
		pr3: begin
			  case(d_ins)
				
				d_25: begin
							if(d_in == d_25)
							begin
								if(price >= 8'b00011001) 
									price = price - 8'b00011001;
								else begin
									d_change = 8'b00011001 - price;
									price = 8'b0;
									end
							end
							else begin
								cs = pr3;
							end
							
							if(price == 8'b0) 
							pr_out = 1;
							
							if(d_in == d_50) d_ins = d_50;
							else if (d_in == d_75) d_ins = d_75; 
							else if (pr_out == 1) 
								begin 
									if(c_delay == 5000000)
										begin
										c_delay = 0;
										cs = reset;
										end
									else 
										begin
										c_delay = c_delay + 1;
										d_change = 8'b0;
										end
								end
						end
		
				d_50: begin
							if(d_in == d_50)
							begin
								if(price > 8'b00110010) 
									price = price - 8'b00110010;
								else begin
									d_change = 8'b00110010 - price;
									price = 8'b0;
									end
							end
							else begin
								cs = pr3;
							end
							
							if(price == 8'b0) 
							pr_out = 1;
							
							if(d_in == d_25) d_ins = d_25;
							else if (d_in == d_75) d_ins = d_75; 
							else if (pr_out == 1) 
								begin 
									if(c_delay == 5000000)
										begin
										c_delay = 0;
										cs = reset;
										end
									else 
										begin
										c_delay = c_delay + 1;
										d_change = 8'b0;
										end
								end
						end
						
				d_75: begin
							if(d_in == d_75)
							begin
							price = pr_act;
								if(price >= 8'b01001011) 
									price = price - 8'b01001011;
								else begin
									d_change = 8'b01001011 - price;
									price = 8'b0;
									end
							end
							else begin
								cs = pr3;
							end
							
							if(price == 8'b0) 
							pr_out = 1;
							
							if(d_in == d_25) d_ins = d_25;
							else if (d_in == d_50) d_ins = d_50; 
							else if (pr_out == 1) 
								begin 
									if(c_delay == 5000000)
										begin
										c_delay = 0;
										cs = reset;
										end
									else 
										begin
										c_delay = c_delay + 1;
										end
								end
						end
				endcase
				end
				
		pr4: begin
			  case(d_ins)
				
				d_25: begin
							if(d_in == d_25)
							begin
								if(price >= 8'b00011001) 
									price = price - 8'b00011001;
								else begin
									d_change = 8'b00011001 - price;
									price = 8'b0;
									end
							end
							else begin
								cs = pr4;
							end
							
							if(price == 8'b0) 
							pr_out = 1;
							
							if(d_in == d_50) d_ins = d_50;
							else if (d_in == d_75) d_ins = d_75; 
							else if (pr_out == 1) 
								begin 
									if(c_delay == 5000000)
										begin
										c_delay = 0;
										cs = reset;
										end
									else 
										begin
										c_delay = c_delay + 1;
										d_change = 8'b0;
										end
								end
						end
		
				d_50: begin
							if(d_in == d_50)
							begin
								if(price >= 8'b00110010) 
									price = price - 8'b00110010;
								else begin
									d_change = 8'b00110010 - price;
									price = 8'b0;
									end
							end
							else begin
								cs = pr4;
							end
							
							if(price == 8'b0) 
							pr_out = 1;
							
							if(d_in == d_25) d_ins = d_25;
							else if (d_in == d_75) d_ins = d_75; 
							else if (pr_out == 1) 
								begin 
									if(c_delay == 5000000)
										begin
										c_delay = 0;
										cs = reset;
										end
									else 
										begin
										c_delay = c_delay + 1;
										cs = d_50;
										end
								end
						end
						
				d_75: begin
							if(d_in == d_75)
							begin
								if(price > 8'b01001011) 
									price = price - 8'b01001011;
								else begin
									d_change = 8'b01001011 - price;
									price = 8'b0;
									end
							end
							else begin
								cs = pr4;
							end
							
							if(price == 8'b0) 
							pr_out = 1;
							
							if(d_in == d_25) d_ins = d_25;
							else if (d_in == d_50) d_ins = d_50; 
							else if (pr_out == 1) 
								begin 
									if(c_delay == 5000000)
										begin
										c_delay = 0;
										cs = reset;
										end
									else 
										begin
										c_delay = c_delay + 1;
										d_change = 8'b0;
										end
								end
						end
				endcase
				end
				
		pr5: begin
			  case(d_ins)
				
				d_25: begin
							if(d_in == d_25)
							begin
								if(price >= 8'b00011001) 
								begin
									price = price - 8'b00011001;
									pr_buff = price;
								end
								else begin
									d_change = 8'b00011001 - price;
									price = 8'b0;
									end
							end
							else begin
								cs = pr5;
							end
							
							if(price == 8'b0) 
							pr_out = 1;
							
							if(d_in == d_50) d_ins = d_50;
							else if (d_in == d_75) d_ins = d_75; 
							else if (pr_out == 1) 
								begin 
									if(c_delay == 5000000)
										begin
										c_delay = 0;
										cs = reset;
										end
									else 
										begin
										c_delay = c_delay + 1;
										d_change = 8'b00011001 - pr_buff;
										end
								end
						end
		
				d_50: begin
							if(d_in == d_50)
							begin
								if(price >= 8'b00110010) 
								begin
									price = price - 8'b00110010;
									pr_buff = price;
								end
								else begin
									d_change = 8'b00110010 - price;
									price = 8'b0;
									end
							end
							else begin
								cs = pr5;
							end
							
							if(price == 8'b0) 
							pr_out = 1;
							
							if(d_in == d_25) d_ins = d_25;
							else if (d_in == d_75) d_ins = d_75; 
							else if (pr_out == 1) 
								begin 
									if(c_delay == 5000000)
										begin
										c_delay = 0;
										cs = reset;
										end
									else 
										begin
										c_delay = c_delay + 1;
										d_change = 8'b00110010 - pr_buff;
										end
								end
						end
						
				d_75: begin
							if(d_in == d_75)
							begin
								if(price >= 8'b01001011) 
								begin
									price = price - 8'b01001011;
									pr_buff = price;
								end
								else begin
									d_change = 8'b01001011 - price;
									price = 8'b0;
									end
							end
							else begin
								cs = pr5;
							end
							
							if(price == 8'b0) 
							pr_out = 1;
							
							if(d_in == d_25) d_ins = d_25;
							else if (d_in == d_50) d_ins = d_50; 
							else if (pr_out == 1) 
								begin 
									if(c_delay == 5000000)
										begin
										c_delay = 0;
										cs = reset;
										end
									else 
										begin
										c_delay = c_delay + 1;
										d_change = 8'b01001011 - pr_buff;
										end
								end
						end
				endcase
				end
				
			endcase
			end
	end

division g0 (pr_act, s1, s2, clk);
division g1 (price, s3, s4, clk);
division g2 (d_change, s5, s6, clk);

endmodule
		
			
						


						
							
									
				 
	
	





