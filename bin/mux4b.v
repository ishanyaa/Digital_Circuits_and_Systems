module mux4b( input [3:0] d0, d1, d2, d3,
		input [1:0] s,
		output [3:0] y);

assign y = s[1] ? (s[0] ? d3 : d2)
		: (s[0] ? d1 : d0);

endmodule

module tb_mux4b;
reg [3:0] d0, d1, d2, d3;
reg [1:0] s;
wire [3:0] y;

mux4b uut( .d0(d0), .d1(d1), .d2(d2), .d3(d3), .s(s), .y(y));

initial begin

$dumpfile("mux4b.vcd");
$dumpvars(0, tb_mux4b);

$monitor("Time %t, d0 = %b, d1 = %b, d2 = %b, d3 = %b, y = %b", $time, d0, d1, d2, d3, s, y);

# 10; d0 = 4'b0000; d1 = 4'b0001; d2 = 4'b0010; d3 = 4'b0011; s = 2'b00;
# 10; d0 = 4'b0000; d1 = 4'b0001; d2 = 4'b0010; d3 = 4'b0011; s = 2'b01;
# 10; d0 = 4'b0000; d1 = 4'b0001; d2 = 4'b0010; d3 = 4'b0011; s = 2'b10;
# 10; d0 = 4'b0000; d1 = 4'b0001; d2 = 4'b0010; d3 = 4'b0011; s = 2'b11;

$finish;

end
endmodule

  
 