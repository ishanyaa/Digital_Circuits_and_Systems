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
$dumpvars(0, tb_mux8);

$monitor("Time %t, data = %b, sel = %b, out = %b", $time, data, sel, out);

        #10 data = 8'b0000_0001; sel = 3'b000;  // Select d0
        #10 data = 8'b0000_0010; sel = 3'b001;  // Select d1
        #10 data = 8'b0000_0100; sel = 3'b010;  // Select d2
        #10 data = 8'b0000_1000; sel = 3'b011;  // Select d3
        #10 data = 8'b0001_0000; sel = 3'b100;  // Select d4
        #10 data = 8'b0010_0000; sel = 3'b101;  // Select d5
        #10 data = 8'b0100_0000; sel = 3'b110;  // Select d6
        #10 data = 8'b1000_0000; sel = 3'b111;  // Select d7
#10;

$finish;
end

endmodule
