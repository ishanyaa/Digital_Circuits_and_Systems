module q4(input a, b, c, d, output p, div);

assign p = ~a & ~b & c & ~d | ~a & ~b & c & d | ~a & b & ~c & d | ~a & b & c & d | a & ~b & c & d | a & b & ~c & d;

assign div = ~a & ~b & ~c & ~d | ~a & ~b & c & d | ~a & b & c & ~d | a & ~b & ~c & d | a & b & ~c & ~d | a & b & c & d ; 

endmodule

module tb_q4;
reg a, b, c, d;
wire p, div ;

q4 uut (.a(a), .b(b), .c(c), .d(d), .p(p), .div(div));

initial begin

$dumpfile("q4.vcd");
$dumpvars(0, tb_q4);
$monitor("Time %t, a = %b, b = %b, c = %b, d = %b, p = %b, div = %b", $time, a, b, c, d, p , div);
#10; a = 0; b = 0; c = 0; d = 0;
#10; a = 0; b = 0; c = 0; d = 1;
#10; a = 0; b = 0; c = 1; d = 0;
#10; a = 0; b = 0; c = 1; d = 1;
#10; a = 0; b = 1; c = 1; d = 0;
#10; a = 0; b = 1; c = 1; d = 1;
#10; a = 0; b = 1; c = 0; d = 0;

$finish;

end

endmodule
 