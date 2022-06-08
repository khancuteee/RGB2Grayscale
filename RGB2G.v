module RGB2G(
	input clk,
	input signed[31:0]pixel,
	input [7:0] data_0, data_1, data_2,
	output done,
	output reg[7:0]result);

  parameter row = 2048, col = 1153;
  reg	[7:0]val;
  always@(posedge clk)
  begin
    val = data_0 + data_1 + data_2;
    result = val / 8'h03;
  end
  assign done = (pixel >= row*col-1)?1:0;
endmodule
 
	     	
