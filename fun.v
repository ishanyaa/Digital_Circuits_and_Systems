/* Midsem Q5 */

module fun(input a, b, c, output y);

assign y = a & ~b | ~b & ~c | ~a & b & c;

endmodule

module tb_fun;
reg a, b, c;
wire y;
fun uut (.a(a), .b(b), .c(c), .y(y));

initial begin
$dumpfile("func.vcd");
$dumpvars(0, tb_fun);

$monitor("Time %t, a = %b, b = %b, c = %b, y = %b", $time, a, b, c, y);


#10; a = 0; b = 0; c = 0;
#10; a = 0; b = 0; c = 1;
#10; a = 0; b = 1; c = 0;
#10; a = 1; b = 0; c = 1;
#10; a = 1; b = 0; c = 1;
#10; a = 1; b = 1; c = 0;
#10; a = 1; b = 1; c = 1;
#10; a = 1; b = 1; c = 1;

$finish;
end

endmodule

