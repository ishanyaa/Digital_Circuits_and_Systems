//8 to 3 Priority Encoder 
module pe(input [7:0] in, output reg [2:0] out);

always @(*)
begin
if (in[7]) out = 3'b111;
else if (in[6]) out = 3'b110;
else if (in[5]) out = 3'b101;
else if (in[4]) out = 3'b100;
else if (in[3]) out = 3'b011;
else if (in[2]) out = 3'b010;
else if (in[1]) out = 3'b001;
else if (in[0]) out = 3'b000;
else out = 3'b000;

end
endmodule

module tb_pe;
reg [7:0] in;
wire [2:0] out;

pe uut(.in(in), .out(out));

initial begin

$dumpfile("pe.vcd");
$dumpvars(0, tb_pe);

$monitor("Time %t, in = %b, out = %b", $time, in, out);

#10; in = 8'b0000_0010;
#10; in = 8'b0000_0001;
#10; in = 8'b0000_0100;
#10; in = 8'b0000_1000;
#10; in = 8'b0010_0000;
#10; in = 8'b0100_0000;

$finish;
end

endmodule





