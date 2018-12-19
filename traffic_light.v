module traffic_light_controller(input clk,rst,Ta,Tb,
						 output Ra,Ya,Ga,Rb,Gb,Yb);
	reg [1:0] state,n_state,c_state;//Typedef gives an error of syntax hence I used this.
	parameter s0 = 2'b00;
	parameter s1 = 2'b01;
	parameter s2 = 2'b10;
	parameter s3 = 2'b11;
	always@(posedge clk,posedge rst)
		if(rst) state <= s0;
		else 
			begin
				c_state <= state;//current state.
				state   <= n_state;//next state.
			end
	reg Ra1,Ya1,Ga1,Rb1,Yb1,Gb1;
	always@(*)
			begin
				case(state)
				 s0:begin
					 if(Ta) n_state = s0;
					 else   n_state = s1;
					end
				 s1:begin
					 n_state = s2;
				 end
				 s2:begin
					 if(Tb) n_state = s2;
					 else   n_state = s3;
				 end				  
				 s3:begin
					 n_state = s0;
				 end
			 endcase
		 end
		 always@(*)
				begin
					case(c_state)
					s0:begin
					 	Ra1 = 0;
					 	Ya1 = 0;
					 	Ga1 = 1;
					 	Rb1 = 1;
					 	Yb1 = 0;
					 	Gb1 = 0;
					end
					s1:begin
					 Ra1 = 0;
					 Ya1 = 1;
					 Ga1 = 0;
					 Rb1 = 1;
					 Yb1 = 0;
					 Gb1 = 0;
				  end
					s2:begin
					 Ra1 = 1;
					 Ya1 = 0;
					 Ga1 = 0;
					 Rb1 = 0;
					 Yb1 = 0;
					 Gb1 = 1;
				  end
					s3:begin
					 Ra1 = 1;
					 Ya1 = 0;
					 Ga1 = 0;
					 Rb1 = 0;
					 Yb1 = 1;
					 Gb1 = 0;
				  end
				endcase
			end
		 assign Ra = Ra1;
		 assign Rb = Rb1;
		 assign Ya = Ya1;
		 assign Yb = Yb1;
		 assign Ga = Ga1;
		 assign Gb = Gb1;
endmodule
