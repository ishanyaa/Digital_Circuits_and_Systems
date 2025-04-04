//Full Subtractor
module fs(input a, b, c, output bo, d);
wire na;
wire x, y, z;

not g0(na, a);

xor g1(d, a, b, c);

//borrow

or g2(x, c, b);
and g3(y, na, x);

and g4(z, c, b);

or g5(bo, y, z);

endmodule 


module tb_fs;
reg a, b, c;
wire bo, d;

fs uut (.a(a), .b(b), .c(c), .d(d), .bo(bo)); 

initial begin

$dumpfile("fs.vcd");
$dumpvars(0, tb_fs);

$monitor("Time %t, a = %b, b = %b, c = %b, bo = %b, d = %b", $time, a, b, c, bo, d);

#1; a = 0; b = 0; c = 0;
#10; a = 0; b = 0; c = 1;
#1; a = 0; b = 1; c = 0;
#1; a = 0; b = 1; c = 1;
#1; a = 1; b = 0; c = 0;

$finish;
end 
endmodule

