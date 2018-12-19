module LFSR(out,clk,rst);
output reg [4:0] out;
input clk,rst;
wire feedback;
assign feedback = ~(out[2]^out[4]);
always@(posedge clk,posedge rst)
	begin
		if(rst) 
			out = 5'b0;
		else
			out = {out[3:0],feedback};
	end
endmodule
module test_TLC;
reg clk,rst,Ta,Tb;
wire Ra,Rb,Ga,Gb,Ya,Yb;
wire A_sensor;
wire B_sensor;
wire [4:0] out;
integer i;
traffic_light_controller dut(clk,rst,Ta,Tb,Ra,Ya,Ga,Rb,Gb,Yb);
LFSR shift_rgstr(out,clk,rst);
assign A_sensor = shift_rgstr.out[0];
assign B_sensor = shift_rgstr.out[1];
initial
begin
	rst = 1;
	#5
	rst = 0;
end
initial 
begin	
	$dumpfile ("dump.vcd");//For gtk waveform.
	$dumpvars (0,dut);
	$display("                                                            RaYaGa             RbYbGb ");
	for(i = 0; i <= 15;i = i+1)
	begin
		Ta = A_sensor;
		Tb = B_sensor;
		#2 clk = 1;
		#2 clk = 0;
		$display("State = ",dut.c_state," Next State = ",dut.state," Inpt A = ",Ta," Inpt B = ",Tb," light at A = ",Ra," ",Ya," ",Ga," light at B = ",Rb," ",Yb," ",Gb);//Red,Yellow,Green inorder.
	end
	$finish;
end
endmodule
