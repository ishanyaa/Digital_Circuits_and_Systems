module mux8(input [7:0] data, input [2:0] sel, output reg out);

always @(*)
begin

case(sel)

3'b000: out = data[0];
3'b001: out = data[1];
3'b010: out = data[2];
3'b011: out = data[3];
3'b100: out = data[4];
3'b101: out = data[5];
3'b110: out = data[6];
3'b111: out = data[7];
default: out = data[0];

endcase
end
endmodule

module tb_mux8;
reg [7:0] data;
reg [2:0] sel;
wire out;

mux8 uut (.data(data), .sel(sel), .out(out));

initial begin

$dumpfile("mux8.vcd");
$dumpvars('0, tb_mux8.v);

$monitor("Time %t, data = %b, sel = %b, out = %b", $time, data, sel, out);

#10; data[0] = 8'b0000_0001; sel = 3'b000;
#10; data[0] = 8'b0000_0010; sel = 3'b100;

$finish;

endmodule
