module mux2(input d0, d1, input s, output y);

wire ns, y1, y2; //Internal Signals

not g1(ns, s);
and g2(y1, d0, ns);
and g3(y2, d1, s);
or g4(y, y1, y2);

endmodule



module tb_mux2;
reg d0, d1, s;
wire y;

mux2 uut( .d0(d0), .d1(d1), .s(s), .y(y));

initial begin 

$dumpfile("mux2.vcd");
$dumpvars(0, tb_mux2);

d0 = 0; d1 = 0; #10;
$display("Test 1: d0=%b, d1=%b, s=%b => y=%b", d0, d1, s, y);

d0 = 0; d1 = 1; #10;
$display("Test 2: d0=%b, d1=%b, s=%b => y=%b", d0, d1, s, y);

d0 = 1; d1 = 0; #10;
$display("Test 3: d0=%b, d1=%b, s=%b => y=%b", d0, d1, s, y);

d0 = 1; d1 = 1; #10;
$display("Test 4: d0=%b, d1=%b, s=%b => y=%b", d0, d1, s, y);

$finish;

end 

endmodule
